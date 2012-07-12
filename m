From: James Bottomley <jbottomley@parallels.com>
Subject: Re: [PATCH-v2] virtio-scsi: Add vdrv->scan for post
	VIRTIO_CONFIG_S_DRIVER_OK LUN scanning
Date: Thu, 12 Jul 2012 07:23:50 +0000
Message-ID: <1342077828.3021.1.camel__5400.00239057026$1342460699$gmane$org@dabdike.int.hansenpartnership.com>
References: <1342041736-30043-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342041736-30043-1-git-send-email-nab@linux-iscsi.org>
Content-Language: en-US
Content-ID: <70DBEFFB34AC3441A72A54E8983784BA@sw.swsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-07-11 at 21:22 +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> This patch changes virtio-scsi to use a new virtio_driver->scan() callback
> so that scsi_scan_host() can be properly invoked once virtio_dev_probe() has
> set add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK) to signal active virtio-ring
> operation, instead of from within virtscsi_probe().
> 
> This fixes a bug where SCSI LUN scanning for both virtio-scsi-raw and
> virtio-scsi/tcm_vhost setups was happening before VIRTIO_CONFIG_S_DRIVER_OK
> had been set, causing VIRTIO_SCSI_S_BAD_TARGET to occur.  This fixes a bug
> with virtio-scsi/tcm_vhost where LUN scan was not detecting LUNs.
> 
> Tested with virtio-scsi-raw + virtio-scsi/tcm_vhost w/ IBLOCK on 3.5-rc2 code.
> 
> (nab: Fix up minor apply fuzz against scsi.git/misc)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> Cc: Zhi Yong Wu <wuzhy@cn.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: James Bottomley <JBottomley@Parallels.com>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>

Was the change so great that it needs re acking?

I assume it also now no longer applies to stable because it will reject?

James
