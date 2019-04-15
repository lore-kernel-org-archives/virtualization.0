From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 00/15] Share TTM code among framebuffer drivers
Date: Mon, 15 Apr 2019 17:54:30 +0200
Message-ID: <20190415155430.GB2665@phenom.ffwll.local>
References: <20190408092144.4548-1-tzimmermann@suse.de>
	<d69e0b34-c586-2338-b063-fb758b6465d8@amd.com>
	<096a70a7-ed24-2161-29e9-1907221b8a64@suse.de>
	<20190409071249.ngzarvjlztx4jwbh@sirius.home.kraxel.org>
	<a2f778c3-904b-5ee2-215e-df534f14b928@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a2f778c3-904b-5ee2-215e-df534f14b928@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "airlied@linux.ie" <airlied@linux.ie>, "puck.chen@hisilicon.com" <puck.chen@hisilicon.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "z.liuxinliang@hisilicon.com" <z.liuxinliang@hisilicon.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>, "kong.kongxinwei@hisilicon.com" <kong.kongxinwei@hisilicon.com>, "Huang, Ray" <Ray.Huang@amd.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "zourongrong@gmail.com" <zourongrong@gmail.com>, "Zhang,
	Jerry" <Jerry.Zhang@amd.com>, "Koenig,
	Christian" <Christian.Koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 09, 2019 at 09:50:40AM +0200, Thomas Zimmermann wrote:
> Hi
> =

> Am 09.04.19 um 09:12 schrieb kraxel@redhat.com:
> >   Hi,
> > =

> >> If not for TTM, what would be the alternative? One VMA manager per
> >> memory region per device?
> > =

> > Depends pretty much on the device.
> > =

> > The cirrus is a display device with only 4 MB of vram.  You can't fit
> > much in there.  A single 1024x768 @ 24bpp framebuffer needs more 50%
> > of the video memory already.  Which is why the cirrus driver (before the
> > rewrite) had to migrate buffers from/to vram on every page flip[1].  Wh=
ich
> > is one[2] of the reasons why cirrus (after rewrite) doesn't ttm-manage =
the
> > vram any more.  gem objects are managed with the shmem helpers instead
> > and the active framebuffer is blitted to vram.
> > =

> > The qemu stdvga (bochs driver) has 16 MB vram by default and can be
> > configured to have up to 256 MB.  Plenty of room even for multiple 4k
> > framebuffers if needed.  So for the bochs driver all the ttm bo
> > migration logic is not needed, it could just store everything in vram.
> > =

> > A set of drm_gem_vram_* helpers would do the job for bochs.
> =

> Thanks for clarifying. drm_gem_vram_* (and drm_vram_mm for Simple TTM)
> is probably a better name for the data structures.

+1 on drm_gem_vram_* naming convention - we want to describe what it's
for, not how it's implemented.

> > I'd expect the same applies to the vbox driver.
> > =

> > Dunno about the other drm drivers and the fbdev drivers you plan to
> > migrate over.
> =

> The AST HW can support up to 512 MiB, but 32-64 MiB seems more realistic
> for a server. It's similar with mgag200 HW. The old fbdev-supported
> device are all somewhere in the range between cirrus and bochs. Some
> drivers would probably benefit from the cirrus approach, some could use
> VRAM directly.

I think for dumb scanout with vram all we need is:
- pin framebuffers, which potentially moves the underlying bo into vram
- unpin framebuffers (which is just accounting, we don't want to move the
  bo on every flip!)
- if a pin doesn't find enough space, move one of the unpinned bo still
  resident in vram out
- no pipelining, no support for dma engines (it's all cpu copies anway)
- a simple drm_mm should be good enough to manage the vram, no need for
  the ttm style abstraction over how memory is manged
- also just bake in the lru eviction list and algorithm
- probably good to have built-in support for redirecting the mmap between
  shmem and iomem.
- anything that needs pipelining or copy engines would be out of scope for
  these helpers

I think for starting points we can go with a copypasted version of the
various ttm implementations we already have, and then simplify from there
as needed. Or just start fresh if that's too complicated, due to the issue
Christian highlighted.
-Daniel

> Best regards
> Thomas
> =

> > =

> > cheers,
> >   Gerd
> > =

> > [1] Note: The page-flip migration logic is present in some of the other
> >     drivers too, not sure whenever they actually need that due to being=
 low
> >     on vram too or whenever they just copied the old cirrus code ...
> > =

> > [2] The other reason is that this allow to convert formats at blit time,
> >     which helps to deal with some cirrus hardware limitations.
> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> GF: Felix Imend=F6rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N=FCrnberg)
> =





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
