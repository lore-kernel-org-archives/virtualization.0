From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/8] vhost: Reset batched descriptors on
 SET_VRING_BASE call
Date: Tue, 31 Mar 2020 15:51:09 -0400
Message-ID: <20200331155049-mutt-send-email-mst@kernel.org>
References: <20200331192804.6019-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200331192804.6019-1-eperezma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kvm list <kvm@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 31, 2020 at 09:27:56PM +0200, Eugenio Pérez wrote:
> Vhost did not reset properly the batched descriptors on SET_VRING_BASE
> event. Because of that, is possible to return an invalid descriptor to
> the guest.
> 
> This series ammend this, resetting them every time backend changes, and
> creates a test to assert correct behavior. To do that, they need to
> expose a new function in virtio_ring, virtqueue_reset_free_head, only
> on test code.
> 
> Another useful thing would be to check if mutex is properly get in
> vq private_data accessors. Not sure if mutex debug code allow that,
> similar to C++ unique lock::owns_lock. Not acquiring in the function
> because caller code holds the mutex in order to perform more actions.

I pushed vhost branch with patch 1, pls send patches on top of that!

> v3:
> * Rename accesors functions.
> * Make scsi and test use the accesors too.
> 
> v2:
> * Squashed commits.
> * Create vq private_data accesors (mst).
> 
> This is meant to be applied on top of
> c4f1c41a6094582903c75c0dcfacb453c959d457 in
> git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git.
> 
> Eugenio Pérez (5):
>   vhost: Create accessors for virtqueues private_data
>   tools/virtio: Add --batch option
>   tools/virtio: Add --batch=random option
>   tools/virtio: Add --reset=random
>   tools/virtio: Make --reset reset ring idx
> 
> Michael S. Tsirkin (3):
>   vhost: option to fetch descriptors through an independent struct
>   vhost: use batched version by default
>   vhost: batching fetches
> 
>  drivers/vhost/net.c          |  28 ++--
>  drivers/vhost/scsi.c         |  14 +-
>  drivers/vhost/test.c         |  69 ++++++++-
>  drivers/vhost/test.h         |   1 +
>  drivers/vhost/vhost.c        | 271 +++++++++++++++++++++++------------
>  drivers/vhost/vhost.h        |  44 +++++-
>  drivers/vhost/vsock.c        |  14 +-
>  drivers/virtio/virtio_ring.c |  29 ++++
>  tools/virtio/linux/virtio.h  |   2 +
>  tools/virtio/virtio_test.c   | 123 ++++++++++++++--
>  10 files changed, 456 insertions(+), 139 deletions(-)
> 
> -- 
> 2.18.1
