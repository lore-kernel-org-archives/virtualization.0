From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Fri, 14 Sep 2012 08:45:11 +0200
Message-ID: <5052D277.7010900@redhat.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<1347000499-28701-5-git-send-email-nab@linux-iscsi.org>
	<504A1A32.5050705@redhat.com> <20120908224032.GC20588@redhat.com>
	<504D85D6.2090703@redhat.com> <20120910062437.GD16819@redhat.com>
	<504F40BA.7020800@us.ibm.com> <20120911150757.GA26666@redhat.com>
	<1347575263.7359.76.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347575263.7359.76.camel@haakon2.linux-iscsi.org>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 14/09/2012 00:27, Nicholas A. Bellinger ha scritto:
> *) Keep vhost-scsi as a backend to virtio-scsi-pci
> 
>   - Reduces duplicated code amongst multiple virtio-scsi backends.
>   
>   - Follows the split for what existing vhost-net code already does.
> 
> So that said, two quick questions for Paolo & Co..
> 
> For the standalone vhost-scsi-pci device case, can you give a brief idea
> as to what extent you'd like to see virtio-scsi.c code/defs duplicated
> and/or shared amongst a new vhost-scsi-pci device..?

Not much, in the end, would be shared; it could end up being just
parts of virtio_scsi_init and virtio_scsi_exit, and virtio_scsi_get_config.

Almost all the other code is to implement the SCSI bus interface,
which you do not need.

I don't remember if and how vhost handles configuration changes.  If you
need any struct in virtio-scsi.c, either move it to virtio-scsi.h or
add the new device in the same file.

> Also to help me along, can you give an example based on the current
> usage below how the QEMU command line arguments would change with a
> standalone vhost-scsi-pci device..?
> 
> ./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -smp 4 -m 2048 \
>     -hda /usr/src/qemu-vhost.git/debian_squeeze_amd64_standard-old.qcow2 \
>     -vhost-scsi id=vhost-scsi0,wwpn=naa.600140579ad21088,tpgt=1 \
>     -device virtio-scsi-pci,vhost-scsi=vhost-scsi0,event_idx=off

Two possibilities.  Either simply do s/virtio-scsi-pci/vhost-scsi-pci/ or do

./x86_64-softmmu/qemu-system-x86_64 -enable-kvm -smp 4 -m 2048 \
    -hda /usr/src/qemu-vhost.git/debian_squeeze_amd64_standard-old.qcow2 \
    -device virtio-scsi-pci,wwpn=naa.600140579ad21088,tpgt=1,event_idx=off
