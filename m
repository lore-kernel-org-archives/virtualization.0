From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE
 call
Date: Mon, 30 Mar 2020 09:13:57 +0200
Message-ID: <bb95e827-f219-32fd-0046-41046eec058b@de.ibm.com>
References: <20200329113359.30960-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200329113359.30960-1-eperezma@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


On 29.03.20 13:33, Eugenio Pérez wrote:
> Vhost did not reset properly the batched descriptors on SET_VRING_BASE event. Because of that, is possible to return an invalid descriptor to the guest.

I guess this could explain my problems that I have seen during reset?

> 
> This series ammend this, and creates a test to assert correct behavior. To do that, they need to expose a new function in virtio_ring, virtqueue_reset_free_head. Not sure if this can be avoided.
> 
> Also, change from https://lkml.org/lkml/2020/3/27/108 is not included, that avoids to update a variable in a loop where it can be updated once.
> 
> This is meant to be applied on top of eccb852f1fe6bede630e2e4f1a121a81e34354ab in git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git, and some commits should be squashed with that series.
> 
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
