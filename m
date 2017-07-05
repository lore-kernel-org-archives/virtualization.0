From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: add DISCARD support to virtio-blk driver
Date: Wed, 5 Jul 2017 15:56:00 +0300
Message-ID: <20170705155404-mutt-send-email-mst@kernel.org>
References: <1499244279-3484-1-git-send-email-changpeng.liu@intel.com>
	<01542f21-6fa3-c406-65e1-a37d04130fb7@redhat.com>
	<FF7FC980937D6342B9D289F5F3C7C2625B595B29@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B595B29@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "hch@lst.de" <hch@lst.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 05, 2017 at 07:57:07AM +0000, Liu, Changpeng wrote:
> 
> 
> > -----Original Message-----
> > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > Sent: Tuesday, July 4, 2017 5:24 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>; virtualization@lists.linux-
> > foundation.org
> > Cc: stefanha@gmail.com; hch@lst.de; mst@redhat.com
> > Subject: Re: [PATCH v2] virtio-blk: add DISCARD support to virtio-blk driver
> > 
> > 
> > 
> > On 05/07/2017 10:44, Changpeng Liu wrote:
> > > Currently virtio-blk driver does not provide discard feature flag, so the
> > > filesystems which built on top of the block device will not send discard
> > > command. This is okay for HDD backend, but it will impact the performance
> > > for SSD backend.
> > >
> > > Add a feature flag VIRTIO_BLK_F_DISCARD and command
> > VIRTIO_BLK_T_DISCARD
> > > to extend exist virtio-blk protocol, define 16 bytes discard descriptor
> > > for each discard segment, the discard segment defination aligns with
> > > SCSI or NVM Express protocols, virtio-blk driver will support multi-range
> > > discard request as well.
> > >
> > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > 
> > Please include a patch for the specification.  Since we are at it, I
> Thanks Paolo, do you mean include a text file which describe the changes for the specification?

Paolo answered that. But please also CC code patch to virtio-comment@lists.oasis-open.org
.
This is a subscriber-only list so pls subscribe beforehand:
https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback


-- 
MST
