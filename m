From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] Add 'serial' attribute to virtio-blk
	devices
Date: Mon, 21 Jun 2010 14:44:47 +0200
Message-ID: <20100621124447.GA8166@lst.de>
References: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1276886283-1571-1-git-send-email-ryanh@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryan Harper <ryanh@us.ibm.com>
Cc: john cooper <john.cooper@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 18, 2010 at 01:38:02PM -0500, Ryan Harper wrote:
> Create a new attribute for virtio-blk devices that will fetch the serial number
> of the block device.  This attribute can be used by udev to create disk/by-id
> symlinks for devices that don't have a UUID (filesystem) associated with them.
> 
> ATA_IDENTIFY strings are special in that they can be up to 20 chars long
> and aren't required to be NULL-terminated.  The buffer is also zero-padded
> meaning that if the serial is 19 chars or less that we get a NULL terminated
> string.  When copying this value into a string buffer, we must be careful to
> copy up to the NULL (if it present) and only 20 if it is longer and not to
> attempt to NULL terminate; this isn't needed.

Why is this virtio-blk specific?  In a later mail you mention you want
to use it for udev.  So please export this from scsi/libata as well and
we have one proper interface that we can use for all devices.
