From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v2 5/8] tools/virtio: Use __vring_new_virtqueue in virtio_test.c
Date: Fri, 17 Apr 2020 14:24:31 +0200
Message-ID: <CAJaqyWcuxG03+J+BW=fPb=JFKLPi0h5sRGv9cjWv63eyspS4Qg@mail.gmail.com>
References: <20200416075643.27330-1-eperezma@redhat.com> <20200416075643.27330-6-eperezma@redhat.com>
 <20200416183244-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200416183244-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 17, 2020 at 12:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 16, 2020 at 09:56:40AM +0200, Eugenio P=C3=A9rez wrote:
> > As updated in ("2a2d1382fe9d virtio: Add improved queue allocation API"=
)
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Pls add motivation for these changes.
>

The original motivation was to make code as close as possible to
virtio_net. Also, it skips a (probably not expensive) initialization
in vring_new_virtqueue.

With the recent events, I think that this could be useful to test when
userspace and kernel use different struct layout, maybe with some
sanitizer. I can drop it if you don't see it the same way (or if I
didn't understand the problem and this does not help).

Thanks!

> > ---
> >  tools/virtio/virtio_test.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > index 1d5144590df6..d9827b640c21 100644
> > --- a/tools/virtio/virtio_test.c
> > +++ b/tools/virtio/virtio_test.c
> > @@ -106,10 +106,9 @@ static void vq_info_add(struct vdev_info *dev, int=
 num)
> >       assert(r >=3D 0);
> >       memset(info->ring, 0, vring_legacy_size(num, 4096));
> >       vring_legacy_init(&info->vring, num, info->ring, 4096);
> > -     info->vq =3D vring_new_virtqueue(info->idx,
> > -                                    info->vring.num, 4096, &dev->vdev,
> > -                                    true, false, info->ring,
> > -                                    vq_notify, vq_callback, "test");
> > +     info->vq =3D
> > +             __vring_new_virtqueue(info->idx, info->vring, &dev->vdev,=
 true,
> > +                                   false, vq_notify, vq_callback, "tes=
t");
> >       assert(info->vq);
> >       info->vq->priv =3D info;
> >       vhost_vq_setup(dev, info);
> > --
> > 2.18.1
>
