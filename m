From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Mon, 10 Sep 2012 08:42:15 +0200
Message-ID: <504D8BC7.8070900__30263.1040256985$1347259367$gmane$org@redhat.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<1347000499-28701-5-git-send-email-nab@linux-iscsi.org>
	<504A1A32.5050705@redhat.com> <20120908224032.GC20588@redhat.com>
	<504D85D6.2090703@redhat.com> <20120910062437.GD16819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120910062437.GD16819@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 10/09/2012 08:24, Michael S. Tsirkin ha scritto:
>> > I chose the backend name because, ideally, there would be no other
>> > difference.  QEMU _could_ implement all the goodies in vhost-scsi (such
>> > as reservations or ALUA), it just doesn't do that yet.
>> > 
>> > Paolo
> Then why do you say "It is used completely differently from
> virtio-scsi-pci"?

It is configured differently (and I haven't seen a proposal yet for how
to bridge the two), it does not interoperate, it has right now a
different set of features.

The "does not interoperate" bit is particularly important.  Say QEMU
were to implement persistent reservations (right now only a vhost-scsi
feature).  Then QEMU and vhost-scsi PR would not be interchangeable, a
reservation made by QEMU would not be visible in vhost and vice versa.

> Isn't it just a different backend?
> 
> If yes then it should be a backend option, like it is
> for virtio-net.

You mean a -drive option?  That would mean adding the logic to configure
vhost-scsi to the QEMU block layer, that's a completely different project...

Paolo
