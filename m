From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH V2 0/8] Packed ring for vhost
Date: Mon, 26 Mar 2018 15:01:30 -0400
Message-ID: <20180326190130.GE6928__45963.265191722$1522090853$gmane$org@char.us.oracle.com>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 26, 2018 at 11:38:45AM +0800, Jason Wang wrote:
> Hi all:
> 
> This RFC implement packed ring layout. The code were tested with pmd
> implement by Jens at
> http://dpdk.org/ml/archives/dev/2018-January/089417.html. Minor change
> was needed for pmd codes to kick virtqueue since it assumes a busy
> polling backend.
> 
> Test were done between localhost and guest. Testpmd (rxonly) in guest
> reports 2.4Mpps. Testpmd (txonly) repots about 2.1Mpps.

And how does it compare to older ring layout?

> 
> Notes: The event suppression /indirect descriptor support is complied
>        test only because of lacked driver support.
> 
> Changes from V1:
> 
> - Refactor vhost used elem code to avoid open coding on used elem
> - Event suppression support (compile test only).
> - Indirect descriptor support (compile test only).
> - Zerocopy support.
> - vIOMMU support.
> - SCSI/VSOCK support (compile test only).
> - Fix several bugs
> 
> For simplicity, I don't implement batching or other optimizations.
> 
> Please review.
> 
> Thanks
> 
> Jason Wang (8):
>   vhost: move get_rx_bufs to vhost.c
>   vhost: hide used ring layout from device
>   vhost: do not use vring_used_elem
>   vhost_net: do not explicitly manipulate vhost_used_elem
>   vhost: vhost_put_user() can accept metadata type
>   virtio: introduce packed ring defines
>   vhost: packed ring support
>   vhost: event suppression for packed ring
> 
>  drivers/vhost/net.c                | 138 ++-----
>  drivers/vhost/scsi.c               |  62 +--
>  drivers/vhost/vhost.c              | 818 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h              |  46 ++-
>  drivers/vhost/vsock.c              |  42 +-
>  include/uapi/linux/virtio_config.h |   9 +
>  include/uapi/linux/virtio_ring.h   |  32 ++
>  7 files changed, 921 insertions(+), 226 deletions(-)
> 
> -- 
> 2.7.4
> 
