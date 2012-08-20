From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC-v2 4/6] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Mon, 20 Aug 2012 12:31:01 +0100
Message-ID: <CAJSP0QUPX2CiNrBAxD=vvEcV_32Qf-=Ed3=Ck5c+wKsSDZ4heQ__12479.8102923252$1345462276$gmane$org@mail.gmail.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-5-git-send-email-nab@linux-iscsi.org>
	<5031FD9E.9080204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5031FD9E.9080204@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 20, 2012 at 10:04 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 13/08/2012 10:35, Nicholas A. Bellinger ha scritto:
>> From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
>>
>> This patch starts and stops vhost as the virtio device transitions
>> through its status phases.  Vhost can only be started once the guest
>> reports its driver has successfully initialized, which means the
>> virtqueues have been set up by the guest.
>>
>> v2: - Squash virtio-scsi: use the vhost-scsi host device from stefan (nab)
>>     - Fix up virtio_scsi_properties[] conflict w/ upstream qemu (nab)
>>     - Drop usage of to_virtio_scsi() in virtio_scsi_set_status()
>>       (reported by paolo)
>>     - Use modern VirtIOSCSIConf define in virtio-scsi.h (reported by paolo)
>>     - Use s->conf->vhost_scsi instead of proxyconf->vhost_scsi in
>>       virtio_scsi_init() (reported by paolo)
>>     - Only register QEMU SCSI bus is vhost-scsi is not active (reported
>>       by paolo)
>
> How much of the functionality of virtio-scsi.[ch] is still in use at
> this point?  Would it make more sense to use a separate vhost-scsi-pci
> device instead?

Since the SCSI target lives in the kernel, almost everything is driven
from tcm_vhost.ko.  tcm_vhost.ko basically implements the full device
so I see the argument for -device vhost-scsi-pci.

> Especially since advertising VIRTIO_SCSI_F_HOTPLUG and
> VIRTIO_SCSI_F_CHANGE is probably wrong for vhost-scsi...

vhost participates in feature bit negotiation, see
VHOST_GET_FEATURES/VHOST_SET_FEATURES ioctls.

Stefan
