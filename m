From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 7/8] tools/virtio: Reset index in virtio_test --reset.
Date: Fri, 17 Apr 2020 04:28:46 -0400
Message-ID: <20200417042551-mutt-send-email-mst@kernel.org>
References: <20200416075643.27330-1-eperezma@redhat.com>
 <20200416075643.27330-8-eperezma@redhat.com>
 <20200416183324-mutt-send-email-mst@kernel.org>
 <CAJaqyWcBTnXvkzaqfSOWODK=+jddeVpee-4ZuqfWc+zj0UsZLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJaqyWcBTnXvkzaqfSOWODK=+jddeVpee-4ZuqfWc+zj0UsZLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 17, 2020 at 09:04:04AM +0200, Eugenio Perez Martin wrote:
> On Fri, Apr 17, 2020 at 12:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 16, 2020 at 09:56:42AM +0200, Eugenio Pérez wrote:
> > > This way behavior for vhost is more like a VM.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> >
> > I dropped --reset from 5.7 since Linus felt it's unappropriate.
> > I guess I should squash this in with --reset?
> >
> 
> Yes please.
> 
> If you prefer I can do it using the base you want, so all commits
> messages are right.
> 
> Thanks!

OK so I dropped new tests from vhost for now, pls rebased on
top of that.

Thanks!

> > > ---
> > >  tools/virtio/virtio_test.c | 33 ++++++++++++++++++++++++++-------
> > >  1 file changed, 26 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > > index 18d5347003eb..dca64d36a882 100644
> > > --- a/tools/virtio/virtio_test.c
> > > +++ b/tools/virtio/virtio_test.c
> > > @@ -20,7 +20,6 @@
> > >  #include "../../drivers/vhost/test.h"
> > >
> > >  #define RANDOM_BATCH -1
> > > -#define RANDOM_RESET -1
> > >
> > >  /* Unused */
> > >  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> > > @@ -49,6 +48,7 @@ struct vdev_info {
> > >
> > >  static const struct vhost_vring_file no_backend = { .fd = -1 },
> > >                                    backend = { .fd = 1 };
> > > +static const struct vhost_vring_state null_state = {};
> > >
> > >  bool vq_notify(struct virtqueue *vq)
> > >  {
> > > @@ -174,14 +174,19 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >       unsigned len;
> > >       long long spurious = 0;
> > >       const bool random_batch = batch == RANDOM_BATCH;
> > > +
> > >       r = ioctl(dev->control, VHOST_TEST_RUN, &test);
> > >       assert(r >= 0);
> > > +     if (!reset_n) {
> > > +             next_reset = INT_MAX;
> > > +     }
> > > +
> > >       for (;;) {
> > >               virtqueue_disable_cb(vq->vq);
> > >               completed_before = completed;
> > >               started_before = started;
> > >               do {
> > > -                     const bool reset = reset_n && completed > next_reset;
> > > +                     const bool reset = completed > next_reset;
> > >                       if (random_batch)
> > >                               batch = (random() % vq->vring.num) + 1;
> > >
> > > @@ -224,10 +229,24 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >                       }
> > >
> > >                       if (reset) {
> > > +                             struct vhost_vring_state s = { .index = 0 };
> > > +
> > > +                             vq_reset(vq, vq->vring.num, &dev->vdev);
> > > +
> > > +                             r = ioctl(dev->control, VHOST_GET_VRING_BASE,
> > > +                                       &s);
> > > +                             assert(!r);
> > > +
> > > +                             s.num = 0;
> > > +                             r = ioctl(dev->control, VHOST_SET_VRING_BASE,
> > > +                                       &null_state);
> > > +                             assert(!r);
> > > +
> > >                               r = ioctl(dev->control, VHOST_TEST_SET_BACKEND,
> > >                                         &backend);
> > >                               assert(!r);
> > >
> > > +                             started = completed;
> > >                               while (completed > next_reset)
> > >                                       next_reset += completed;
> > >                       }
> > > @@ -249,7 +268,9 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >       test = 0;
> > >       r = ioctl(dev->control, VHOST_TEST_RUN, &test);
> > >       assert(r >= 0);
> > > -     fprintf(stderr, "spurious wakeups: 0x%llx\n", spurious);
> > > +     fprintf(stderr,
> > > +             "spurious wakeups: 0x%llx started=0x%lx completed=0x%lx\n",
> > > +             spurious, started, completed);
> > >  }
> > >
> > >  const char optstring[] = "h";
> > > @@ -312,7 +333,7 @@ static void help(void)
> > >               " [--no-virtio-1]"
> > >               " [--delayed-interrupt]"
> > >               " [--batch=random/N]"
> > > -             " [--reset=random/N]"
> > > +             " [--reset=N]"
> > >               "\n");
> > >  }
> > >
> > > @@ -360,11 +381,9 @@ int main(int argc, char **argv)
> > >               case 'r':
> > >                       if (!optarg) {
> > >                               reset = 1;
> > > -                     } else if (0 == strcmp(optarg, "random")) {
> > > -                             reset = RANDOM_RESET;
> > >                       } else {
> > >                               reset = strtol(optarg, NULL, 10);
> > > -                             assert(reset >= 0);
> > > +                             assert(reset > 0);
> > >                               assert(reset < (long)INT_MAX + 1);
> > >                       }
> > >                       break;
> > > --
> > > 2.18.1
> >
