From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Date: Wed, 9 Jan 2019 22:45:36 +0100
Message-ID: <CAKMK7uGK2NBqbeMVfpmdyA4qVA2RLLjwJLEQWfAQeOwhVrEoeg__4590.0959441953$1547070227$gmane$org@mail.gmail.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
	<20190108112519.27473-16-kraxel@redhat.com>
	<20190109101044.GS21184@phenom.ffwll.local>
	<20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
	<CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ@mail.gmail.com>
	<20190109205158.qx7a2gfyprbvpok5@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190109205158.qx7a2gfyprbvpok5@sirius.home.kraxel.org>
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
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 9, 2019 at 9:52 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > If I understand things correctly it is valid to set all import/export
> > > callbacks (prime_handle_to_fd, prime_fd_to_handle,
> > > gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
> > > supporting dma-buf import/export and still advertise DRIVER_PRIME to
> > > indicate the other prime callbacks are supported (so generic fbdev
> > > emulation can use gem_prime_vmap etc).  Is that correct?
> >
> > I'm not sure how much that's a good idea ... Never thought about it
> > tbh. All the fbdev/dma-buf stuff has plenty of hacks and
> > inconsistencies still, so I guess we can't make it much worse really.
>
> Setting prime_handle_to_fd + prime_fd_to_handle to NULL has the effect
> that drm stops advertising DRM_PRIME_CAP_{IMPORT,EXPORT} to userspace.
>
> Which looks better to me than telling userspace we support it then throw
> errors unconditionally when userspace tries to use that.
>
> > > Is it possible to export TTM_PL_VRAM objects (with backing storage being
> > > a pci memory bar)?  If so, how?
> >
> > Not really in general. amdgpu upcasts to amdgpu_bo (if it's amgpu BO)
> > and then knows the internals so it can do a proper pci peer2peer
> > mapping. Or at least there's been lots of patches floating around to
> > make that happen.
>
> That is limited to bo sharing between two amdgpu devices, correct?
>
> > I think other drivers migrate the bo out of VRAM.
>
> Well, that doesn't look too useful.  bochs and qxl virtual hardware
> can't access buffers outside VRAM.  So, while I could migrate the
> buffers to RAM (via memcpy) when exporting they would at the same time
> become unusable for the GPU ...
>
> > > On importing:
> > >
> > > Importing into TTM_PL_TT object looks easy again, at least when the
> > > object is actually stored in RAM.  What if not?
> >
> > They are all supposed to be stored in RAM. Note that all current ttm
> > importers totally break the abstraction, by taking the sg list,
> > throwing the dma mapping away and assuming there's a struct page
> > backing it. Would be good if we could stop spreading that abuse - the
> > dma-buf interfaces have been modelled after the ttm bo interfaces, so
> > shouldn't be too hard to wire this up correctly.
>
> Ok.  With virtio-gpu (where objects are backed by RAM pages anyway)
> wiring this up should be easy.
>
> But given there is no correct sample code I can look at it would be cool
> if you could give some more hints how this is supposed to work.  The
> gem_prime_import_sg_table() callback gets a sg list passed in after all,
> so I probably would have tried to take the sg list too ...

I'm not a fan of that helper either, that's really the broken part
imo. i915 doesn't use it. It's a midlayer so that the nvidia blob can
avoid directly touching the EXPORT_SYMBOL_GPL dma-buf symbols, afaiui
there's really no other solid reason for it. What the new gem cma
helpers does is imo much better (it still uses the import_sg_table
midlayer, but oh well).

For ttm you'd need to make sure that all the various ttm cpu side
access functions also all go through the relevant dma-buf interfaces,
and not through the struct page list fished out of the sgt. That was
at least the idea, long ago.

> > > Importing into TTM_PL_VRAM:  Impossible I think, without copying over
> > > the data.  Should that be done?  If so, how?  Or is it better to just
> > > not support import then?
> >
> > Hm, since you ask about TTM concepts and not what this means in terms
> > of dma-buf:
>
> Ok, more details on the quesion:
>
> dma-buf: whatever the driver gets passed into the
> gem_prime_import_sg_table() callback.
>
> import into TTM_PL_VRAM: qemu driver which supports VRAM storage only
> (bochs, qxl), so the buffer has to be stored there if we want do
> something with it (like scanning out to a crtc).
>
> > As long as you upcast to the ttm_bo you can do whatever
> > you want to really.
>
> Well, if the dma-buf comes from another device (say export vgem bo, then
> try import into bochs/qxl/virtio) I can't upcast.

In that case you'll in practice only get system RAM, and you're not
allowed to move it (dma-buf is meant to be zero-copy after all). If
your hw can't scan these out directly, then userspace needs to arrange
for a buffer copy into a native buffer somehow (that's how Xorg prime
works at least I think). No idea whether your virtual gpus can make
use of that directly. You might also get some pci peer2peer range in
the future, but it's strictly opt-in (because there's too many dma-buf
importers that just blindly assume there's a struct page behind the
sgt).

> When the dma-buf comes from the same device drm_gem_prime_import_dev()
> will notice and take a shortcut (skip import, just increase refcount
> instead), so I don't have to worry about that case in the
> gem_prime_import_sg_table() callback.

You can also upcast if it's from the same driver, not just same device.
-Daniel

> > But with plain dma-buf this doesn't work right now
> > (least because ttm assumes it gets system RAM on import, in theory you
> > could put the peer2peer dma mapping into the sg list and it should
> > work).
>
> Well, qemu display devices don't have peer2peer dma support.
> So I guess the answer is "doesn't work".
>
> cheers,
>   Gerd
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
