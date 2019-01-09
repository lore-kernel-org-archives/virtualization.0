From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Date: Wed, 9 Jan 2019 18:35:47 +0100
Message-ID: <CAKMK7uG0HCNso9rE9TivP2cVKMD1rNPC2wJH_+yu+CWGEh9XdQ__32607.0776711733$1547055245$gmane$org@mail.gmail.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
	<20190108112519.27473-16-kraxel@redhat.com>
	<20190109101044.GS21184@phenom.ffwll.local>
	<20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190109145443.l5yus2pgvxcl4zbt@sirius.home.kraxel.org>
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

On Wed, Jan 9, 2019 at 3:54 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jan 09, 2019 at 11:10:44AM +0100, Daniel Vetter wrote:
> > On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> > > The buffer object must be reserved before calling
> > > ttm_bo_validate for pinning/unpinning.
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Seems a bit a bisect fumble in your series here: legacy kms code reserved
> > the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
> > think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
> > avoid bisect fail I think you need to have these temporarily in your
> > cleanup/prepare_plane functions too.
>
> I think I've sorted that.  Have some other changes too, will probably
> send v3 tomorrow.
>
> > Looked through the entire series, this here is the only issue I think
> > should be fixed before merging (making atomic_enable optional can be done
> > as a follow-up if you feel like it). With that addressed on the series:
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> Thanks.
>
> While being at it:  I'm also looking at dma-buf export and import
> support for the qemu drivers.
>
> Right now both qxl and virtio have gem_prime_get_sg_table and
> gem_prime_import_sg_table handlers which throw a WARN_ONCE() and return
> an error.
>
> If I understand things correctly it is valid to set all import/export
> callbacks (prime_handle_to_fd, prime_fd_to_handle,
> gem_prime_get_sg_table, gem_prime_import_sg_table) to NULL when not
> supporting dma-buf import/export and still advertise DRIVER_PRIME to
> indicate the other prime callbacks are supported (so generic fbdev
> emulation can use gem_prime_vmap etc).  Is that correct?

I'm not sure how much that's a good idea ... Never thought about it
tbh. All the fbdev/dma-buf stuff has plenty of hacks and
inconsistencies still, so I guess we can't make it much worse really.

> On exporting:
>
> TTM_PL_TT should be easy, just pin the buffer, grab the pages list and
> feed that into drm_prime_pages_to_sg.  Didn't try yet though.  Is that
> approach correct?
>
> Is it possible to export TTM_PL_VRAM objects (with backing storage being
> a pci memory bar)?  If so, how?

Not really in general. amdgpu upcasts to amdgpu_bo (if it's amgpu BO)
and then knows the internals so it can do a proper pci peer2peer
mapping. Or at least there's been lots of patches floating around to
make that happen.

I think other drivers migrate the bo out of VRAM.

> On importing:
>
> Importing into TTM_PL_TT object looks easy again, at least when the
> object is actually stored in RAM.  What if not?

They are all supposed to be stored in RAM. Note that all current ttm
importers totally break the abstraction, by taking the sg list,
throwing the dma mapping away and assuming there's a struct page
backing it. Would be good if we could stop spreading that abuse - the
dma-buf interfaces have been modelled after the ttm bo interfaces, so
shouldn't be too hard to wire this up correctly.

> Importing into TTM_PL_VRAM:  Impossible I think, without copying over
> the data.  Should that be done?  If so, how?  Or is it better to just
> not support import then?

Hm, since you ask about TTM concepts and not what this means in terms
of dma-buf: As long as you upcast to the ttm_bo you can do whatever
you want to really. But with plain dma-buf this doesn't work right now
(least because ttm assumes it gets system RAM on import, in theory you
could put the peer2peer dma mapping into the sg list and it should
work).
-Daniel

>
> thanks,
>   Gerd
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
