From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 08:31:39 +0200
Message-ID: <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ__30423.6379730114$1554359523$gmane$org@mail.gmail.com>
References: <20190403072318.31507-1-kraxel@redhat.com>
	<CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
	<20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 4, 2019 at 7:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Apr 04, 2019 at 12:58:09PM +1000, David Airlie wrote:
> > On Wed, Apr 3, 2019 at 5:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Time to kill some bad sample code people are copying from ;)
> > >
> > > This is a complete rewrite of the cirrus driver.  The cirrus_mode_set()
> > > function is pretty much the only function which is carried over largely
> > > unmodified.  Everything else is upside down.
> > >
> > > It is a single monster patch.  But given that it does some pretty
> > > fundamental changes to the drivers workflow and also reduces the code
> > > size by roughly 70% I think it'll still be alot easier to review than a
> > > longish baby-step patch series.
> > >
> > > Changes summary:
> > >  - Given the small amout of video memory (4 MB) the cirrus device has
> > >    the rewritten driver doesn't try to manage buffers there.  Instead
> > >    it will blit (memcpy) the active framebuffer to video memory.
> >
> > Does it get any slower, with TTM I just wrote it to migrate just the
> > frontbuffer in/out of VRAM on modeset, won't we end up with more
> > copies now?
>
> I didn't benchmark it, but if you care about performance you should not
> be using cirrus anyway ...
>
> For fbcon it probably doesn't make much of a difference, fbcon used a
> shadow framebuffer before (for fbdev mmap and dirty tracking).
>
> xorg probably ends up with more copying.
>
> Anything doing display updates with page flips (i.e wayland) should end
> up with less copying, because you have one copy (blit) instead of two
> copies (migrate old frontbuffer out of vram, migrate new frontbuffer
> into vram) on pageflip.
>
> Speaking of wayland:  Seems at least gnome-shell insists on using XR24.

Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
convert XR24 to other formats, for display not supporting anything
else. Because userspace.

> > >  - Only DRM_FORMAT_RGB565 (depth 16) is supported.  The old driver does
> > >    that too by default.  There was a module parameter which enables 24/32
> > >    bpp support and disables higher resolutions (due to cirrus hardware
> > >    constrains).  That parameter wasn't reimplemented.
>
> > This might be the big sticking point, this is a userspace regression
> > for a feature that was explicitly added a few years ago, can we really
> > get away without it?
>
> Well, I can reintroduce the module option.  I don't see any other
> reasonable way to support 32bpp.  If the driver reports XR24 as
> supported and also adds the higher resolutions (which work with RG16
> only) to the mode list userspace will of course try the higher
> resolutions with XR24 and struggle ...

Maybe atomic userspace is better (it should be, it can do TEST_ONLY),
but I'm not so sure that exposing all modes for atomic clients would
work. Also, currently not possible with our probe helpers (we don't
refilter the list per client).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
