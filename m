From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC-v2 4/6] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Mon, 20 Aug 2012 14:00:36 +0200
Message-ID: <503226E4.1050206@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-5-git-send-email-nab@linux-iscsi.org>
	<5031FD9E.9080204@redhat.com>
	<CAJSP0QUPX2CiNrBAxD=vvEcV_32Qf-=Ed3=Ck5c+wKsSDZ4heQ@mail.gmail.com>
	<20120820115704.GA3580@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120820115704.GA3580@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 20/08/2012 13:57, Michael S. Tsirkin ha scritto:
>>> > > How much of the functionality of virtio-scsi.[ch] is still in use at
>>> > > this point?  Would it make more sense to use a separate vhost-scsi-pci
>>> > > device instead?
>> > 
>> > Since the SCSI target lives in the kernel, almost everything is driven
>> > from tcm_vhost.ko.  tcm_vhost.ko basically implements the full device
>> > so I see the argument for -device vhost-scsi-pci.
> A bit unhappy that there is no virtio in the name since it is
> implementing virtio protocol.
> 

Yeah, but vhost \subseteq virtio...

Paolo
