From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v2 7/8] tools/virtio: Reset index in virtio_test --reset.
Date: Fri, 17 Apr 2020 09:04:04 +0200
Message-ID: <CAJaqyWcBTnXvkzaqfSOWODK=+jddeVpee-4ZuqfWc+zj0UsZLA@mail.gmail.com>
References: <20200416075643.27330-1-eperezma@redhat.com> <20200416075643.27330-8-eperezma@redhat.com>
 <20200416183324-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200416183324-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 17, 2020 at 12:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Apr 16, 2020 at 09:56:42AM +0200, Eugenio P=C3=A9rez wrote:
> > This way behavior for vhost is more like a VM.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> I dropped --reset from 5.7 since Linus felt it's unappropriate.
> I guess I should squash this in with --reset?
>

Yes please.

If you prefer I can do it using the base you want, so all commits
messages are right.

Thanks!

> > ---
> >  tools/virtio/virtio_test.c | 33 ++++++++++++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > index 18d5347003eb..dca64d36a882 100644
> > --- a/tools/virtio/virtio_test.c
> > +++ b/tools/virtio/virtio_test.c
> > @@ -20,7 +20,6 @@
> >  #include "../../drivers/vhost/test.h"
> >
> >  #define RANDOM_BATCH -1
> > -#define RANDOM_RESET -1
> >
> >  /* Unused */
> >  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> > @@ -49,6 +48,7 @@ struct vdev_info {
> >
> >  static const struct vhost_vring_file no_backend =3D { .fd =3D -1 },
> >                                    backend =3D { .fd =3D 1 };
> > +static const struct vhost_vring_state null_state =3D {};
> >
> >  bool vq_notify(struct virtqueue *vq)
> >  {
> > @@ -174,14 +174,19 @@ static void run_test(struct vdev_info *dev, struc=
t vq_info *vq,
> >       unsigned len;
> >       long long spurious =3D 0;
> >       const bool random_batch =3D batch =3D=3D RANDOM_BATCH;
> > +
> >       r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
> >       assert(r >=3D 0);
> > +     if (!reset_n) {
> > +             next_reset =3D INT_MAX;
> > +     }
> > +
> >       for (;;) {
> >               virtqueue_disable_cb(vq->vq);
> >               completed_before =3D completed;
> >               started_before =3D started;
> >               do {
> > -                     const bool reset =3D reset_n && completed > next_=
reset;
> > +                     const bool reset =3D completed > next_reset;
> >                       if (random_batch)
> >                               batch =3D (random() % vq->vring.num) + 1;
> >
> > @@ -224,10 +229,24 @@ static void run_test(struct vdev_info *dev, struc=
t vq_info *vq,
> >                       }
> >
> >                       if (reset) {
> > +                             struct vhost_vring_state s =3D { .index =
=3D 0 };
> > +
> > +                             vq_reset(vq, vq->vring.num, &dev->vdev);
> > +
> > +                             r =3D ioctl(dev->control, VHOST_GET_VRING=
_BASE,
> > +                                       &s);
> > +                             assert(!r);
> > +
> > +                             s.num =3D 0;
> > +                             r =3D ioctl(dev->control, VHOST_SET_VRING=
_BASE,
> > +                                       &null_state);
> > +                             assert(!r);
> > +
> >                               r =3D ioctl(dev->control, VHOST_TEST_SET_=
BACKEND,
> >                                         &backend);
> >                               assert(!r);
> >
> > +                             started =3D completed;
> >                               while (completed > next_reset)
> >                                       next_reset +=3D completed;
> >                       }
> > @@ -249,7 +268,9 @@ static void run_test(struct vdev_info *dev, struct =
vq_info *vq,
> >       test =3D 0;
> >       r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
> >       assert(r >=3D 0);
> > -     fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
> > +     fprintf(stderr,
> > +             "spurious wakeups: 0x%llx started=3D0x%lx completed=3D0x%=
lx\n",
> > +             spurious, started, completed);
> >  }
> >
> >  const char optstring[] =3D "h";
> > @@ -312,7 +333,7 @@ static void help(void)
> >               " [--no-virtio-1]"
> >               " [--delayed-interrupt]"
> >               " [--batch=3Drandom/N]"
> > -             " [--reset=3Drandom/N]"
> > +             " [--reset=3DN]"
> >               "\n");
> >  }
> >
> > @@ -360,11 +381,9 @@ int main(int argc, char **argv)
> >               case 'r':
> >                       if (!optarg) {
> >                               reset =3D 1;
> > -                     } else if (0 =3D=3D strcmp(optarg, "random")) {
> > -                             reset =3D RANDOM_RESET;
> >                       } else {
> >                               reset =3D strtol(optarg, NULL, 10);
> > -                             assert(reset >=3D 0);
> > +                             assert(reset > 0);
> >                               assert(reset < (long)INT_MAX + 1);
> >                       }
> >                       break;
> > --
> > 2.18.1
>
