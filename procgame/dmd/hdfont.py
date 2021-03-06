import os
from procgame.dmd import Animation, Frame
from procgame import config
from procgame import util
import pygame

# Anchor values are used by Font.draw_in_rect():
AnchorN = 1
AnchorW = 2
AnchorE = 4
AnchorS = 8
AnchorNE = AnchorN | AnchorE
AnchorNW = AnchorN | AnchorW
AnchorSE = AnchorS | AnchorE
AnchorSW = AnchorS | AnchorW
AnchorCenter = 0



class HDFont(object):
	"""Object wrapper for a PyGame font.
	
	Fonts can be loaded manually, using :meth:`load`, or with the :func:`font_named` utility function
	which supports searching a font path."""
	
	char_widths = None
	"""Array of dot widths for each character, 0-indexed from <space>.  
	This array is populated by :meth:`load`.  You may alter this array
	in order to update the font and then :meth:`save` it."""
	
	tracking = 0
	"""Number of dots to adjust the horizontal position between characters, in addition to the last character's width."""
	
	composite_op = 'copy'
	"""Composite operation used by :meth:`draw` when calling :meth:`~pinproc.DMDBuffer.copy_rect`."""
	
	pygFont = None


	def __init__(self, fontname, size):
		super(HDFont, self).__init__()
		# init pyg

		pygame.font.init()
		p = pygame.font.match_font(fontname)
		if(p==None):
			raise ValueError, "Specific font could not be found on your system.  Please install '" + fontname + "'."
		self.pygFont = pygame.font.Font(p,size)

		self.char_widths = []
		for i in range(96):
			self.char_widths += [ self.pygFont.size(str(chr(i+32)))[0] ]
		self.char_size = self.pygFont.get_height()


	def textHollow(self, message, col_line, col_interior, line_width, col_bg):
		base = self.pygFont.render(message, False, col_line, col_bg)
		size = (base.get_width() + line_width, base.get_height() + line_width)
		
		img = pygame.Surface(size, 16)

		img.fill(col_bg)
		base.set_colorkey(0)

		if(line_width>0):
			img.blit(base, (0, 0))
			img.blit(base, (line_width, 0))
			img.blit(base, (0, line_width))
			img.blit(base, (line_width, line_width))
		base.set_colorkey(0)
		base.set_palette_at(1, col_interior)
		img.blit(base, (line_width/2, line_width/2))
		img.set_colorkey(None)
		return img.convert()


	def drawHD(self, frame, text, x, y, line_color, line_width, interior_color, fill_color):
		"""Uses this font's characters to draw the given string at the given position."""
		#t = self.pygFont.render(text,False,(255,0,255),(0,0,0))
		#surf = self.pygFont.render(text,False,self.color,(0,0,0))
		if(text == ""):
			return x

		if(fill_color==None):
			fill_color=(0,0,0)

		surf = self.textHollow(text,line_color, interior_color, 2*line_width, fill_color)
		(w,h) = surf.get_size()

		tmp = Frame(w,h)
		tmp.pySurface = surf
		Frame.copy_rect(dst=frame, dst_x=x, dst_y=y, src=tmp, src_x=0, src_y=0, width=w, height=h, op=self.composite_op)

		#Frame.copy_rect(dst=frame, dst_x=x, dst_y=y, src=self.bitmap, src_x=char_x, src_y=char_y, width=width, height=self.char_size, op=self.composite_op)
			
		return x


	def draw(self, frame, text, x, y, color = None):
		"""Uses this font's characters to draw the given string at the given position."""
		#t = self.pygFont.render(text,False,(255,0,255),(0,0,0))
		if(color is None):
			color=(255,255,255)

		surf = self.pygFont.render(text,False,color,(0,0,0))
		(w,h) = surf.get_size()
		
		#surf = pygame.surface.Surface((w, h))
		#surf.blit(t,(0,0))
		#surf.blit(t2,(2,2))
		
		tmp = Frame(w,h)
		tmp.pySurface = surf
		tmp.composite_op = "blacksrc"
		Frame.copy_rect(dst=frame, dst_x=x, dst_y=y, src=tmp, src_x=0, src_y=0, width=w, height=h, op=self.composite_op)
		#Frame.copy_rect(dst=frame, dst_x=x, dst_y=y, src=self.bitmap, src_x=char_x, src_y=char_y, width=width, height=self.char_size, op=self.composite_op)
		return x
	
	def size(self, text):
		"""Returns a tuple of the width and height of this text as rendered with this font."""
		return self.pygFont.size(text)
	
	def draw_in_rect(self, frame, text, rect=(0,0,128,32), anchor=AnchorCenter):
		"""Draw *text* on *frame* within the given *rect*, aligned in accordance with *anchor*.
		
		*rect* is a tuple of length 4: (origin_x, origin_y, height, width). 0,0 is in the upper left (NW) corner.
		
		*anchor* is one of:
		:attr:`~procgame.dmd.AnchorN`,
		:attr:`~procgame.dmd.AnchorE`,
		:attr:`~procgame.dmd.AnchorS`,
		:attr:`~procgame.dmd.AnchorW`,
		:attr:`~procgame.dmd.AnchorNE`,
		:attr:`~procgame.dmd.AnchorNW`,
		:attr:`~procgame.dmd.AnchorSE`,
		:attr:`~procgame.dmd.AnchorSW`, or
		:attr:`~procgame.dmd.AnchorCenter` (the default).
		"""
		origin_x, origin_y, width, height = rect
		text_width, text_height = self.size(text)
		x = 0
		y = 0
		
		# print "Size: %d x %d" % (text_height)
		
		if anchor & AnchorN:
			y = origin_y
		elif anchor & AnchorS:
			y = origin_y + (height - text_height)
		else:
			y = origin_y + (height/2.0 - text_height/2.0)
		
		if anchor & AnchorW:
			x = origin_x
		elif anchor & AnchorE:
			x = origin_x + (width - text_width)
		else:
			x = origin_x + (width/2.0 - text_width/2.0)
		
		self.draw(frame=frame, text=text, x=x, y=y)

hdfont_path = []
"""Array of paths that will be searched by :meth:`~procgame.dmd.font_named` to locate fonts.

When this module is initialized the pyprocgame global configuration (:attr:`procgame.config.values`)
``font_path`` key path is used to initialize this array."""

def init_hdfont_path():
    global hdfont_path
    try:
        value = config.value_for_key_path('hdfont_path')
        if issubclass(type(value), list):
            hdfont_path.extend(map(os.path.expanduser, value))
        elif issubclass(type(value), str):
            hdfont_path.append(os.path.expanduser(value))
        elif value == None:
            print('WARNING no font_path set in %s!' % (config.path))
        else:
            print('ERROR loading font_path from %s; type is %s but should be list or str.' % (config.path, type(value)))
            sys.exit(1)
    except ValueError, e:
        #print e
        pass

init_hdfont_path()


__hdfont_cache = {}
def hdfont_named(name, size):
	"""Searches the :attr:`font_path` for a font file of the given name and returns an instance of :class:`Font` if it exists."""
	cname = name + str(size)
	if cname in __hdfont_cache:
		return __hdfont_cache[cname]

	import dmd # have to do this to get dmd.Font to work below... odd.
	font = HDFont(name,size)
	__hdfont_cache[cname] = font
	return font


