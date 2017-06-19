From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC] virtio-mem: paravirtualized memory
Date: Mon, 19 Jun 2017 12:26:52 +0200
Message-ID: <4cec825b-d92e-832e-3a76-103767032528__34972.1825951294$1497868032$gmane$org@redhat.com>
References: <547865a9-d6c2-7140-47e2-5af01e7d761d@redhat.com>
	<20170619100813.GB17304@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170619100813.GB17304@stefanha-x1.localdomain>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

On 19.06.2017 12:08, Stefan Hajnoczi wrote:
> On Fri, Jun 16, 2017 at 04:20:02PM +0200, David Hildenbrand wrote:
>> Important restrictions of this concept:
>> - Guests without a virtio-mem guest driver can't see that memory.
>> - We will always require some boot memory that cannot get unplugged.
>>   Also, virtio-mem memory (as all other hotplugged memory) cannot become
>>   DMA memory under Linux. So the boot memory also defines the amount of
>>   DMA memory.
> 
> I didn't know that hotplug memory cannot become DMA memory.
> 
> Ouch.  Zero-copy disk I/O with O_DIRECT and network I/O with virtio-net
> won't be possible.
> 
> When running an application that uses O_DIRECT file I/O this probably
> means we now have 2 copies of pages in memory: 1. in the application and
> 2. in the kernel page cache.
> 
> So this increases pressure on the page cache and reduces performance :(.
> 
> Stefan
> 

arch/x86/mm/init_64.c:

/*
 * Memory is added always to NORMAL zone. This means you will never get
 * additional DMA/DMA32 memory.
 */
int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
{

The is for sure something to work on in the future. Until then, base
memory of 3.X GB should be sufficient, right?

-- 

Thanks,

David
