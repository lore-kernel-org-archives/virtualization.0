From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 4/5] virtio-scsi: Add start/stop functionality for
	vhost-scsi
Date: Tue, 11 Sep 2012 08:46:34 -0500
Message-ID: <504F40BA.7020800__28822.6401935846$1347371246$gmane$org@us.ibm.com>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
	<1347000499-28701-5-git-send-email-nab@linux-iscsi.org>
	<504A1A32.5050705@redhat.com> <20120908224032.GC20588@redhat.com>
	<504D85D6.2090703@redhat.com> <20120910062437.GD16819@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 09/10/2012 01:24 AM, Michael S. Tsirkin wrote:
> On Mon, Sep 10, 2012 at 08:16:54AM +0200, Paolo Bonzini wrote:
>> Il 09/09/2012 00:40, Michael S. Tsirkin ha scritto:
>>> On Fri, Sep 07, 2012 at 06:00:50PM +0200, Paolo Bonzini wrote:
>>>> Il 07/09/2012 08:48, Nicholas A. Bellinger ha scritto:
>>>>> Cc: Stefan Hajnoczi<stefanha@linux.vnet.ibm.com>
>>>>> Cc: Zhi Yong Wu<wuzhy@linux.vnet.ibm.com>
>>>>> Cc: Michael S. Tsirkin<mst@redhat.com>
>>>>> Cc: Paolo Bonzini<pbonzini@redhat.com>
>>>>> Signed-off-by: Nicholas Bellinger<nab@linux-iscsi.org>
>>>>> ---
>>>>>   hw/virtio-pci.c  |    2 ++
>>>>>   hw/virtio-scsi.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>   hw/virtio-scsi.h |    1 +
>>>>>   3 files changed, 52 insertions(+), 0 deletions(-)
>>>>
>>>> Please create a completely separate device vhost-scsi-pci instead (or
>>>> virtio-scsi-tcm-pci, or something like that).  It is used completely
>>>> differently from virtio-scsi-pci, it does not make sense to conflate the
>>>> two.
>>>
>>> Ideally the name would say how it is different, not what backend it
>>> uses. Any good suggestions?
>>
>> I chose the backend name because, ideally, there would be no other
>> difference.  QEMU _could_ implement all the goodies in vhost-scsi (such
>> as reservations or ALUA), it just doesn't do that yet.
>>
>> Paolo
>
> Then why do you say "It is used completely differently from
> virtio-scsi-pci"?  Isn't it just a different backend?
>
> If yes then it should be a backend option, like it is
> for virtio-net.

I don't mean to bike shed here so don't take this as a nack on making it a 
backend option, but in retrospect, the way we did vhost-net was a mistake even 
though I strongly advocated for it to be a backend option.

The code to do it is really, really ugly.  I think it would have made a lot more 
sense to just make it a device and then have it not use a netdev backend or any 
other kind of backend split.

For instance:

qemu -device vhost-net-pci,tapfd=X

I know this breaks the model of separate backends and frontends but since 
vhost-net absolutely requires a tap fd, I think it's better in the long run to 
not abuse the netdev backend to prevent user confusion.  Having a dedicated 
backend type that only has one possible option and can only be used by one 
device is a bit silly too.

So I would be in favor of dropping/squashing 3/5 and radically simplifying how 
this was exposed to the user.

I would just take qemu_vhost_scsi_opts and make them device properties.

Regards,

Anthony Liguori

>
