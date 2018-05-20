From: Wei Xu <wexu@redhat.com>
Subject: Re: [RFC V4 PATCH 0/8] Packed ring layout for vhost
Date: Mon, 21 May 2018 00:25:14 +0800
Message-ID: <20180520162514.GA21958__45733.8062501096$1526833423$gmane$org@wei-ubt>
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 16, 2018 at 08:32:13PM +0800, Jason Wang wrote:
> Hi all:
> 
> This RFC implement packed ring layout. The code were tested with
> Tiwei's RFC V3 ahttps://lkml.org/lkml/2018/4/25/34. Some fixups and
> tweaks were needed on top of Tiwei's code to make it run for event
> index.

Could you please show the change based on Tiwei's code to easy other's
test?

> 
> Pktgen reports about 20% improvement on PPS (event index is off). More
> testing is ongoing.
> 
> Notes for tester:
> 
> - Start from this version, vhost need qemu co-operation to work
>   correctly. Or you can comment out the packed specific code for
>   GET/SET_VRING_BASE.

Do you mean the code in vhost_virtqueue_start/stop? Both Tiwei's and your v3
work fortunately correctly which should be avoided since the ring should be
definitely different.

Wei

> 
> Changes from V3:
> - Fix math on event idx checking
> - Sync last avail wrap counter through GET/SET_VRING_BASE
> - remove desc_event prefix in the driver/device structure
> 
> Changes from V2:
> - do not use & in checking desc_event_flags
> - off should be most significant bit
> - remove the workaround of mergeable buffer for dpdk prototype
> - id should be in the last descriptor in the chain
> - keep _F_WRITE for write descriptor when adding used
> - device flags updating should use ADDR_USED type
> - return error on unexpected unavail descriptor in a chain
> - return false in vhost_ve_avail_empty is descriptor is available
> - track last seen avail_wrap_counter
> - correctly examine available descriptor in get_indirect_packed()
> - vhost_idx_diff should return u16 instead of bool
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
>  drivers/vhost/net.c                | 136 ++----
>  drivers/vhost/scsi.c               |  62 +--
>  drivers/vhost/vhost.c              | 861 ++++++++++++++++++++++++++++++++-----
>  drivers/vhost/vhost.h              |  47 +-
>  drivers/vhost/vsock.c              |  42 +-
>  include/uapi/linux/virtio_config.h |   9 +
>  include/uapi/linux/virtio_ring.h   |  32 ++
>  7 files changed, 928 insertions(+), 261 deletions(-)
> 
> -- 
> 2.7.4
> 
