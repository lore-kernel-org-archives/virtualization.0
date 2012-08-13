From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC-v2 0/6] vhost-scsi: Add support for host virtualized target
Date: Mon, 13 Aug 2012 12:04:00 +0300
Message-ID: <20120813090400.GK14081@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 13, 2012 at 08:35:11AM +0000, Nicholas A. Bellinger wrote:
> From: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> Hi Paolo, Stefan, & QEMU folks,
> 
> The following is the second RFC series for vhost-scsi patches against mainline
> QEMU v1.1.0.  The series is available from the following working branch:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/nab/qemu-kvm.git vhost-scsi-merge
> 
> Apologies for the delayed follow-up on this series.  The changes detailed below
> addresses Paolo's original comments on vhost-scsi code from the last weeks.

Looks good overall. I sent some comments on list.
Thanks!

> As of this evening the tcm_vhost driver has now been merged into the mainline
> kernel for 3.6-rc2 here:
> 
>   tcm_vhost: Initial merge for vhost level target fabric driver    
>   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=057cbf49a1f08297877
> 
> Also, after following up on the qemu-kvm IRQ injection changes (from Jan) that
> caused a performance regerssion with QEMU 1.1.0 code originally reported here:
> 
>   vhost-scsi port to v1.1.0 + MSI-X performance regression
>   http://comments.gmane.org/gmane.linux.scsi.target.devel/2277
> 
> It turns out that setting explict virtio-queue IRQ affinity within guest appears
> to bring small block random IOPs performance back up to the pre IRQ injection
> conversion levels.  I'm not sure why this ended up making so much of a difference
> post IRQ injection conversion, but setting virtio-queue affinity is now getting
> us back to pre IQN injection conversion levels.
> 
> Changes from v1 -> v2:
> 
>  - Expose ABI version via VHOST_SCSI_GET_ABI_VERSION + use Rev 0 as
>    starting point for v3.6-rc code (Stefan + ALiguori + nab)
>  - Fix upstream qemu conflict in hw/qdev-properties.c
>  - Make GET_ABI_VERSION use int (nab + mst)
>  - Drop unnecessary event-notifier changes (nab)
>  - Fix vhost-scsi case lables in configure (reported by paolo)
>  - Convert qdev_prop_vhost_scsi to use ->get() + ->set() following
>    qdev_prop_netdev (reported by paolo)
>  - Fix typo in qemu-options.hx definition of vhost-scsi (reported by paolo)
>  - Squash virtio-scsi: use the vhost-scsi host device from stefan (nab)
>  - Fix up virtio_scsi_properties[] conflict w/ upstream qemu (nab)
>  - Drop usage of to_virtio_scsi() in virtio_scsi_set_status()
>       (reported by paolo)
>  - Use modern VirtIOSCSIConf define in virtio-scsi.h (reported by paolo)
>  - Use s->conf->vhost_scsi instead of proxyconf->vhost_scsi in
>    virtio_scsi_init() (reported by paolo)
>  - Only register QEMU SCSI bus is vhost-scsi is not active (reported by paolo)
>  - Fix incorrect VirtIOSCSI->cmd_vqs[0] definition (nab)
> 
> Please have another look, and let me know if anything else needs to be
> addressed.
> 
> Thanks!
> 
> --nab
> 
> Nicholas Bellinger (3):
>   msix: Work-around for vhost-scsi with KVM in-kernel MSI injection
>   virtio-scsi: Set max_target=0 during vhost-scsi operation
>   virtio-scsi: Fix incorrect VirtIOSCSI->cmd_vqs[0] definition
> 
> Stefan Hajnoczi (3):
>   vhost: Pass device path to vhost_dev_init()
>   vhost-scsi: add -vhost-scsi host device for use with tcm-vhost
>   virtio-scsi: Add start/stop functionality for vhost-scsi
> 
>  configure            |   10 +++
>  hw/Makefile.objs     |    1 +
>  hw/msix.c            |    3 +
>  hw/qdev-properties.c |   40 ++++++++++++
>  hw/qdev.h            |    3 +
>  hw/vhost-scsi.c      |  170 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vhost-scsi.h      |   50 +++++++++++++++
>  hw/vhost.c           |    5 +-
>  hw/vhost.h           |    3 +-
>  hw/vhost_net.c       |    2 +-
>  hw/virtio-pci.c      |    1 +
>  hw/virtio-scsi.c     |   56 ++++++++++++++++-
>  hw/virtio-scsi.h     |    1 +
>  qemu-common.h        |    1 +
>  qemu-config.c        |   16 +++++
>  qemu-options.hx      |    4 +
>  vl.c                 |   18 +++++
>  17 files changed, 378 insertions(+), 6 deletions(-)
>  create mode 100644 hw/vhost-scsi.c
>  create mode 100644 hw/vhost-scsi.h
> 
> -- 
> 1.7.2.5
