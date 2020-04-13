From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 0/8] tools/vhost: Reset virtqueue on tests
Date: Mon, 13 Apr 2020 16:50:06 +0200
Message-ID: <CAJaqyWcOmzxfOodudSjrZa1SeYDZKiO3MFMy_w44cL_eaBhYDA@mail.gmail.com>
References: <20200403165119.5030-1-eperezma@redhat.com> <20200413071044-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413071044-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm list <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 13, 2020 at 1:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Apr 03, 2020 at 06:51:11PM +0200, Eugenio P=C3=A9rez wrote:
> > This series add the tests used to validate the "vhost: Reset batched
> > descriptors on SET_VRING_BASE call" series, with a small change on the
> > reset code (delete an extra unneded reset on VHOST_SET_VRING_BASE).
> >
> > They are based on the tests sent back them, the ones that were not
> > included (reasons in that thread). This series changes:
> >
> > * Delete need to export the ugly function in virtio_ring, now all the
> > code is added in tools/virtio (except the one line fix).
> > * Add forgotten uses of vhost_vq_set_backend. Fix bad usage order in
> > vhost_test_set_backend.
> > * Drop random reset, not really needed.
> > * Minor changes updating tests code.
> >
> > This serie is meant to be applied on top of
> > 5de4e0b7068337cf0d4ca48a4011746410115aae in
> > git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
>
> Is this still needed?

("tools/virtio: fix virtio_test.c") indentation is actually cosmetic.
("vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl")
just avoid to clean batches descriptors for a third time (they are
cleaned on backend removal and addition).

("vhost: Fix bad order in vhost_test_set_backend at enable") is
actually a fix, the test does not work properly without it. And
("tools/virtio: Reset index in virtio_test --reset.") Makes the test
work more similar than the actual VM does in a reset.

("tools/virtio: Use __vring_new_virtqueue in virtio_test.c") and
("tools/virtio: Extract virtqueue initialization in vq_reset") are
convenience commits to reach the previous two.

Lastly, ("tools/virtio: Use tools/include/list.h instead of stubs")
just removes stub code, I did it when I try to test vdpa code and it
seems to me a nice to have, but we can drop it from the patchset if
you don't see that way.

> The patches lack Signed-off-by and
> commit log descriptions, reference commit Ids without subject.
> See Documentation/process/submitting-patches.rst
>

Sorry, I will try to keep an eye on that from now on. I will send a v2
with Signed-off-by and extended descriptions if you see it ok.

Thanks!

> > Eugenio P=C3=A9rez (8):
> >   tools/virtio: fix virtio_test.c indentation
> >   vhost: Not cleaning batched descs in VHOST_SET_VRING_BASE ioctl
> >   vhost: Replace vq->private_data access by backend accesors
> >   vhost: Fix bad order in vhost_test_set_backend at enable
> >   tools/virtio: Use __vring_new_virtqueue in virtio_test.c
> >   tools/virtio: Extract virtqueue initialization in vq_reset
> >   tools/virtio: Reset index in virtio_test --reset.
> >   tools/virtio: Use tools/include/list.h instead of stubs
> >
> >  drivers/vhost/test.c        |  8 ++---
> >  drivers/vhost/vhost.c       |  1 -
> >  tools/virtio/linux/kernel.h |  7 +----
> >  tools/virtio/linux/virtio.h |  5 ++--
> >  tools/virtio/virtio_test.c  | 58 +++++++++++++++++++++++++++----------
> >  tools/virtio/vringh_test.c  |  2 ++
> >  6 files changed, 51 insertions(+), 30 deletions(-)
> >
> > --
> > 2.18.1
>
