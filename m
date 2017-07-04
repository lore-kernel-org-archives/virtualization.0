From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: add DISCARD support to virtio-blk driver
Date: Wed, 5 Jul 2017 00:35:12 +0300
Message-ID: <20170705003308-mutt-send-email-mst@kernel.org>
References: <1499244279-3484-1-git-send-email-changpeng.liu@intel.com>
	<01542f21-6fa3-c406-65e1-a37d04130fb7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <01542f21-6fa3-c406-65e1-a37d04130fb7@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, hch@lst.de, Changpeng Liu <changpeng.liu@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 04, 2017 at 11:24:01AM +0200, Paolo Bonzini wrote:
> 
> 
> On 05/07/2017 10:44, Changpeng Liu wrote:
> > Currently virtio-blk driver does not provide discard feature flag, so the
> > filesystems which built on top of the block device will not send discard
> > command. This is okay for HDD backend, but it will impact the performance
> > for SSD backend.
> > 
> > Add a feature flag VIRTIO_BLK_F_DISCARD and command VIRTIO_BLK_T_DISCARD
> > to extend exist virtio-blk protocol, define 16 bytes discard descriptor
> > for each discard segment, the discard segment defination aligns with
> > SCSI or NVM Express protocols, virtio-blk driver will support multi-range
> > discard request as well.
> > 
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> 
> Please include a patch for the specification.


Most importantly, please remember to copy virtio-dev@lists.oasis-open.org
on anything that changes the host/guest interface.

> Since we are at it, I
> would like to have three operations defined using the same descriptor:
> 
> - discard (SCSI UNMAP)
> 
> - write zeroes (SCSI WRITE SAME without UNMAP flag)
> 
> - write zeroes and possibly discard (SCSI WRITE SAME with UNMAP flag)
> 
> The last two can use the same command VIRTIO_BLK_T_WRITE_ZEROES, using
> the reserved field as a flags field.
> 
> Paolo

> > ---
> >  drivers/block/virtio_blk.c      | 76 +++++++++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/virtio_blk.h | 19 +++++++++++
> >  2 files changed, 92 insertions(+), 3 deletions(-)
