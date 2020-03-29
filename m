From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE call
Date: Sun, 29 Mar 2020 14:19:55 +0200
Message-ID: <CAJaqyWdO8CHuWFJv+TRgYJ7a3Cb06Ln3prnQZs69L1PPw4Rj1Q@mail.gmail.com>
References: <20200329113359.30960-1-eperezma@redhat.com> <20200329074023-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200329074023-mutt-send-email-mst@kernel.org>
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 29, 2020 at 1:49 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Mar 29, 2020 at 01:33:53PM +0200, Eugenio P=C3=A9rez wrote:
> > Vhost did not reset properly the batched descriptors on SET_VRING_BASE =
event. Because of that, is possible to return an invalid descriptor to the =
guest.
> > This series ammend this, and creates a test to assert correct behavior.=
 To do that, they need to expose a new function in virtio_ring, virtqueue_r=
eset_free_head. Not sure if this can be avoided.
>
> Question: why not reset the batch when private_data changes?
> At the moment both net and scsi poke at private data directly,
> if they do this through a wrapper we can use that to
> 1. check that vq mutex is taken properly
> 2. reset batching
>
> This seems like a slightly better API
>

I didn't do that way because qemu could just SET_BACKEND to -1 and
SET_BACKEND to the same one, with no call to SET_VRING. In this case,
I think that qemu should not change the descriptors already pushed. I
do agree with the interface to modify private_data properly (regarding
the mutex).

However, I can see how your proposal is safer, so we don't even need
to check if private_data is !=3D NULL when we have descriptors in the
batch_descs array. Also, this ioctls should not be in the hot path, so
we can change to that mode anyway.

> >
> > Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, =
that avoids to update a variable in a loop where it can be updated once.
> >
> > This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e=
34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some =
commits should be squashed with that series.
>
> Thanks a lot! I'll apply this for now so Christian can start testing,
> but I'd like the comment above addressed before I push this to Linus.
>
> > Eugenio P=C3=A9rez (6):
> >   tools/virtio: Add --batch option
> >   tools/virtio: Add --batch=3Drandom option
> >   tools/virtio: Add --reset=3Drandom
> >   tools/virtio: Make --reset reset ring idx
> >   vhost: Delete virtqueue batch_descs member
> >   fixup! vhost: batching fetches
> >
> >  drivers/vhost/test.c         |  57 ++++++++++++++++
> >  drivers/vhost/test.h         |   1 +
> >  drivers/vhost/vhost.c        |  12 +++-
> >  drivers/vhost/vhost.h        |   1 -
> >  drivers/virtio/virtio_ring.c |  18 +++++
> >  include/linux/virtio.h       |   2 +
> >  tools/virtio/linux/virtio.h  |   2 +
> >  tools/virtio/virtio_test.c   | 123 +++++++++++++++++++++++++++++++----
> >  8 files changed, 201 insertions(+), 15 deletions(-)
> >
> > --
> > 2.18.1
>
