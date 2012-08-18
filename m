From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC-v2 6/6] virtio-scsi: Fix incorrect VirtIOSCSI->cmd_vqs[0]
	definition
Date: Sat, 18 Aug 2012 20:52:56 +0200
Message-ID: <502FE488.3000303@redhat.com>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
	<1344846917-7411-7-git-send-email-nab@linux-iscsi.org>
	<20120813090259.GJ14081@redhat.com>
	<1344975625.22433.88.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1344975625.22433.88.camel@haakon2.linux-iscsi.org>
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

Il 14/08/2012 22:20, Nicholas A. Bellinger ha scritto:
>>> > > Since virtio_scsi currently assumes a single vqs for data, this patch
>>> > > simply changes ->cmd_vqs[1] to handle the single VirtQueue.

Wrong, multiqueue works just fine. :)  It's just the kernel driver that
doesn't support it yet.

>>> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> > > Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
>>> > > Cc: Michael S. Tsirkin <mst@redhat.com>
>>> > > Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
>> > 
>> > This is a bugfix we need even without vhost, right?
>> > 
> I believe so, as it appears to be stomping past the end of memory for
> every virtio-scsi initialization regardless of vhost usage.. 

You just did a wrong merge.  When commit d2ad7dd (virtio-scsi: add
multiqueue capability, 2012-04-06) changed cmd_vq from pointer to array
of pointers, you should have moved the following fields to the middle of
the struct, just like that commit did.

Paolo
