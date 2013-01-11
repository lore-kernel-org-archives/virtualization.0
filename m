From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] virtio: suppress kmemleak false positive
Date: Fri, 11 Jan 2013 14:47:19 +0000
Message-ID: <20130111144719.GE31281@arm.com>
References: <1357912303-17026-1-git-send-email-alex.mihai.c@gmail.com>
	<20130111140231.GA31281@arm.com>
	<CAEnQRZCvNZ_1OF7Jc43Oo10ADQEMVgqdTJZG7KG7m9yNoQDBfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAEnQRZCvNZ_1OF7Jc43Oo10ADQEMVgqdTJZG7KG7m9yNoQDBfg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 11, 2013 at 02:32:12PM +0000, Daniel Baluta wrote:
> On Fri, Jan 11, 2013 at 4:02 PM, Catalin Marinas <catalin.marinas@arm.com>
> wrote:
> > On Fri, Jan 11, 2013 at 01:51:43PM +0000, Alexandru Copot wrote:
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -23,6 +23,7 @@
> > > =A0#include <linux/slab.h>
> > > =A0#include <linux/module.h>
> > > =A0#include <linux/hrtimer.h>
> > > +#include <linux/kmemleak.h>
> > >
> > > =A0/* virtio guest is communicating with a virtual "device" that actu=
ally runs on
> > > =A0 * a host processor. =A0Memory barriers are used to control SMP ef=
fects. */
> > > @@ -140,6 +141,7 @@ static int vring_add_indirect(struct vring_virtqu=
eue *vq,
> > > =A0 =A0 =A0 desc =3D kmalloc((out + in) * sizeof(struct vring_desc), =
gfp);
> > > =A0 =A0 =A0 if (!desc)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > > + =A0 =A0 kmemleak_not_leak(desc);
> >
> > Please add a comment above this call in case people later wonder why
> > this annotation is needed.
> =

> So, kememleak cannot handle this kind of pointer aliases?

No. Basically it stores the allocated object start/end in an rb-tree and
cannot cope with overlapping blocks. If we allow aliases, we could have
some overlapping.

I think there was a patch in the past to add a separate rb-tree for
aliases but I didn't particularly like it because it affected the
performance.

> Also, I wonder if phys_to_virt(virt_to_phys(x)) =3D=3D x holds true all t=
he time.

It should as long as x is a valid kernel virtual address in the logical
(linear) mapping.

-- =

Catalin
