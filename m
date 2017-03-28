From: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: RE: [PATCH] virtio-blk: add DISCARD support to virtio-blk driver
Date: Tue, 28 Mar 2017 01:43:53 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B567044@SHSMSX103.ccr.corp.intel.com>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
	<20170327145625.GA24952@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170327145625.GA24952@lst.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Monday, March 27, 2017 10:56 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundation.org; linux-
> kernel@vger.kernel.org; hch@lst.de; qemu-devel@nongnu.org
> Subject: Re: [PATCH] virtio-blk: add DISCARD support to virtio-blk driver
> 
> On Tue, Mar 28, 2017 at 04:39:25PM +0800, Changpeng Liu wrote:
> > Currently virtio-blk driver does not provide discard feature flag, so the
> > filesystems which built on top of the block device will not send discard
> > command. This is okay for HDD backend, but it will impact the performance
> > for SSD backend.
> >
> > Add a feature flag VIRTIO_BLK_F_DISCARD and command
> VIRTIO_BLK_T_DISCARD
> > to extend exist virtio-blk protocol. virtio-blk protocol uses a single
> > 8 bytes descriptor containing type,reserved and sector, currently Linux
> > uses the reserved field as IO priority, here we also re-use the reserved
> > field as number of discard sectors.
> 
> Do you have a link to the specification for this feature?  At least
> virtio-v1.0 does not seem to specify a discard feature.
Not yet, patch goes first, there are uses who don't want to migrate from virtio-blk to virtio-scsi,
so this feature seems reasonable, the question is that how we should define the specification to
support this feature.
> 
> Note that Linux 4.11 and later have support for multi-range discard
> ala ATA TRIM, SCSI UNMAP and NVMe deallocate which might be useful
> here, too.
For support multi-range discard features, the DISCARD command must have data_in buffer, similar with
SCSI UNMAP and NVMe DEALLOCATE commands, maybe 16 bytes aligned descriptors are required for each
DISCARD command.
> 
> > +		q->limits.discard_zeroes_data = 0;
> 
> No need to clear this.  Also hopefully this field goes away for 4.12
> 
> > +		blk_queue_max_discard_segments(q, 1);
> 
> No need to set this.
