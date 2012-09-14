From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/5] vhost-scsi: Add support for host virtualized target
Date: Fri, 14 Sep 2012 10:21:05 +0200
Message-ID: <5052E8F1.8060401@redhat.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<504EBFD5.6050203@redhat.com>
	<1347567129.7359.14.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347567129.7359.14.camel@haakon2.linux-iscsi.org>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 13/09/2012 22:12, Nicholas A. Bellinger ha scritto:
>> > Are you still seeing the performance degradation discussed in the thread
>> > 
>> >  "vhost-scsi port to v1.1.0 + MSI-X performance regression"
>> > 
> So the performance regression reported here with QEMU v1.2-rc +
> virtio-scsi ended up being related to virtio interrupts being delivered
> across multiple CPUs.
> 
> After explicitly setting the IRQ affinity of the virtio0-request MSI-X
> vector to a specific CPU, the small block (4k) mixed random I/O
> performance jumped back up to the expected ~100K IOPs for a single LUN.

Have you tried setting rq_affinity to 2?  Benchmarking this against
multiqueue virtio-scsi is on my todo list.

Paolo

> FYI, I just tried this again with the most recent QEMU v1.2.50 (v1.3-rc)
> code, and both cases appear to be performing as expected once again
> regardless of the explicit IRQ affinity setting.
