From: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE call
Date: Mon, 30 Mar 2020 09:18:22 +0200
Message-ID: <CAJaqyWePfMcXhYEPxKYV22J3cYtO=DUXCj1Yf=7XH+khXHop9A@mail.gmail.com>
References: <20200329113359.30960-1-eperezma@redhat.com> <bb95e827-f219-32fd-0046-41046eec058b@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb95e827-f219-32fd-0046-41046eec058b@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 30, 2020 at 9:14 AM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 29.03.20 13:33, Eugenio P=C3=A9rez wrote:
> > Vhost did not reset properly the batched descriptors on SET_VRING_BASE =
event. Because of that, is possible to return an invalid descriptor to the =
guest.
>
> I guess this could explain my problems that I have seen during reset?
>

Yes, I think so. The series has a test that should reproduce more or
less what you are seeing. However, it would be useful to reproduce on
your system and to know what causes qemu to send the reset :).

Thanks!

> >
> > This series ammend this, and creates a test to assert correct behavior.=
 To do that, they need to expose a new function in virtio_ring, virtqueue_r=
eset_free_head. Not sure if this can be avoided.
> >
> > Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, =
that avoids to update a variable in a loop where it can be updated once.
> >
> > This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e=
34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some =
commits should be squashed with that series.
> >
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
>
