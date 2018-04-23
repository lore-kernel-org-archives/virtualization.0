From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC V3 PATCH 0/8] Packed ring for vhost
Date: Mon, 23 Apr 2018 16:11:51 -0400
Message-ID: <20180423201151.GD5215@char.us.oracle.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
	<20180423193120.GD30033@char.us.oracle.com>
	<20180423224715-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180423224715-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 23, 2018 at 10:59:43PM +0300, Michael S. Tsirkin wrote:
> On Mon, Apr 23, 2018 at 03:31:20PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Apr 23, 2018 at 01:34:52PM +0800, Jason Wang wrote:
> > > Hi all:
> > > 
> > > This RFC implement packed ring layout. The code were tested with
> > > Tiwei's RFC V2 a thttps://lkml.org/lkml/2018/4/1/48. Some fixups and
> > > tweaks were needed on top of Tiwei's code to make it run. TCP stream
> > > and pktgen does not show obvious difference compared with split ring.
> > 
> > I have to ask then - what is the benefit of this?
> 
> You can use this with dpdk within guest.
> The DPDK version did see a performance improvement so hopefully with

Is there a link to this performance improvement document?

> future versions this will too.
> 
> > > 
> > > Changes from V2:
> > > - do not use & in checking desc_event_flags
> > > - off should be most significant bit
> > > - remove the workaround of mergeable buffer for dpdk prototype
> > > - id should be in the last descriptor in the chain
> > > - keep _F_WRITE for write descriptor when adding used
> > > - device flags updating should use ADDR_USED type
> > > - return error on unexpected unavail descriptor in a chain
> > > - return false in vhost_ve_avail_empty is descriptor is available
> > > - track last seen avail_wrap_counter
> > > - correctly examine available descriptor in get_indirect_packed()
> > > - vhost_idx_diff should return u16 instead of bool
> > > 
> > > Changes from V1:
> > > 
> > > - Refactor vhost used elem code to avoid open coding on used elem
> > > - Event suppression support (compile test only).
> > > - Indirect descriptor support (compile test only).
> > > - Zerocopy support.
> > > - vIOMMU support.
> > > - SCSI/VSOCK support (compile test only).
> > > - Fix several bugs
> > > 
> > > For simplicity, I don't implement batching or other optimizations.
> > > 
> > > Please review.
> > > 
> > > Jason Wang (8):
> > >   vhost: move get_rx_bufs to vhost.c
> > >   vhost: hide used ring layout from device
> > >   vhost: do not use vring_used_elem
> > >   vhost_net: do not explicitly manipulate vhost_used_elem
> > >   vhost: vhost_put_user() can accept metadata type
> > >   virtio: introduce packed ring defines
> > >   vhost: packed ring support
> > >   vhost: event suppression for packed ring
> > > 
> > >  drivers/vhost/net.c                | 136 ++----
> > >  drivers/vhost/scsi.c               |  62 +--
> > >  drivers/vhost/vhost.c              | 824 ++++++++++++++++++++++++++++++++++---
> > >  drivers/vhost/vhost.h              |  47 ++-
> > >  drivers/vhost/vsock.c              |  42 +-
> > >  include/uapi/linux/virtio_config.h |   9 +
> > >  include/uapi/linux/virtio_ring.h   |  32 ++
> > >  7 files changed, 926 insertions(+), 226 deletions(-)
> > > 
> > > -- 
> > > 2.7.4
> > > 
