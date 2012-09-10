From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/5] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Mon, 10 Sep 2012 08:16:54 +0200
Message-ID: <504D85D6.2090703@redhat.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<1347000499-28701-5-git-send-email-nab@linux-iscsi.org>
	<504A1A32.5050705@redhat.com> <20120908224032.GC20588@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120908224032.GC20588@redhat.com>
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

Il 09/09/2012 00:40, Michael S. Tsirkin ha scritto:
> On Fri, Sep 07, 2012 at 06:00:50PM +0200, Paolo Bonzini wrote:
>> Il 07/09/2012 08:48, Nicholas A. Bellinger ha scritto:
>>> Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
>>> Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
>>> ---
>>>  hw/virtio-pci.c  |    2 ++
>>>  hw/virtio-scsi.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>  hw/virtio-scsi.h |    1 +
>>>  3 files changed, 52 insertions(+), 0 deletions(-)
>>
>> Please create a completely separate device vhost-scsi-pci instead (or
>> virtio-scsi-tcm-pci, or something like that).  It is used completely
>> differently from virtio-scsi-pci, it does not make sense to conflate the
>> two.
> 
> Ideally the name would say how it is different, not what backend it
> uses. Any good suggestions?

I chose the backend name because, ideally, there would be no other
difference.  QEMU _could_ implement all the goodies in vhost-scsi (such
as reservations or ALUA), it just doesn't do that yet.

Paolo
