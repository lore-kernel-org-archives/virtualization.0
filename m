From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE
 call
Date: Sun, 29 Mar 2020 07:49:23 -0400
Message-ID: <20200329074023-mutt-send-email-mst@kernel.org>
References: <20200329113359.30960-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200329113359.30960-1-eperezma@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 29, 2020 at 01:33:53PM +0200, Eugenio Pérez wrote:
> Vhost did not reset properly the batched descriptors on SET_VRING_BASE event. Because of that, is possible to return an invalid descriptor to the guest.
> This series ammend this, and creates a test to assert correct behavior. To do that, they need to expose a new function in virtio_ring, virtqueue_reset_free_head. Not sure if this can be avoided.

Question: why not reset the batch when private_data changes?
At the moment both net and scsi poke at private data directly,
if they do this through a wrapper we can use that to
1. check that vq mutex is taken properly
2. reset batching

This seems like a slightly better API

> 
> Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, that avoids to update a variable in a loop where it can be updated once.
> 
> This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some commits should be squashed with that series.

Thanks a lot! I'll apply this for now so Christian can start testing,
but I'd like the comment above addressed before I push this to Linus.

> Eugenio Pérez (6):
>   tools/virtio: Add --batch option
>   tools/virtio: Add --batch=random option
>   tools/virtio: Add --reset=random
>   tools/virtio: Make --reset reset ring idx
>   vhost: Delete virtqueue batch_descs member
>   fixup! vhost: batching fetches
> 
>  drivers/vhost/test.c         |  57 ++++++++++++++++
>  drivers/vhost/test.h         |   1 +
>  drivers/vhost/vhost.c        |  12 +++-
>  drivers/vhost/vhost.h        |   1 -
>  drivers/virtio/virtio_ring.c |  18 +++++
>  include/linux/virtio.h       |   2 +
>  tools/virtio/linux/virtio.h  |   2 +
>  tools/virtio/virtio_test.c   | 123 +++++++++++++++++++++++++++++++----
>  8 files changed, 201 insertions(+), 15 deletions(-)
> 
> -- 
> 2.18.1
