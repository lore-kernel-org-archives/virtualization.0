From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC PATCH] virt_mmio: fix signature checking for BE guests
Date: Wed, 13 Feb 2013 16:40:36 +0000
Message-ID: <511BC204.7060006@arm.com>
References: <1360765538-18097-1-git-send-email-marc.zyngier@arm.com>
	<1360768102.4045.107.camel@hornet> <511BB134.30003@arm.com>
	<1360770379.4045.115.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1360770379.4045.115.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <Pawel.Moll@arm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 13/02/13 15:46, Pawel Moll wrote:
> On Wed, 2013-02-13 at 15:28 +0000, Marc Zyngier wrote:
>>>> Fix it by encoding the magic as an integer instead of a string.
>>>> So I'm not completely sure this is the right fix, 
>>>
>>> It seems right, however...
>>>
>>>> - Using __raw_readl() instead. Is that a generic enough API?
>>>>
>>> ... this implies that either the spec is wrong (as it should say: the
>>> device registers are always LE, in the PCI spirit) or all readl()s & co.
>>> should be replaced with __raw equivalents.
>>
>> Well, the spec clearly says that the registers reflect the endianess of
>> the guest, and it makes sense: when performing the MMIO access, KVM
>> needs to convert between host and guest endianess.
> 
> The virtio-mmio spec says so because it seemed like a good idea at the
> time ;-) after reading the PCI device spec. But - as I said - I missed
> the fact that the readl()-like accessors will always do le32_to_cpu().
> Apparently ioread32() does the same (there's a separate ioread32be()).

Maybe. There's so much byte swapping at every possible level that my
head spins... ;-)

> So I'm not sure that the spec is correct in this aspect any more. Maybe
> it should specify the registers as LE always, similarly to PCI? This
> problem is already covered by "2.3.1 A Note on Virtqueue Endianness" in
> the spec...

This section basically covers shared memory, and there is not much we
can do about it. When it comes to the registers (that actually trap into
the hypervisor), it probably makes sense to declare them as LE indeed.

>>> Having said that, does the change make everything else work with a BE
>>> guest? (I assume we're talking about the guest being BE, right? ;-) If
>>> so it means that the host is not following the current spec and it
>>> treats all the registers as LE.
>>
>> Yes, I only care about a BE guest. And no, not much is actually working
>> (kvmtool is not happy about the guest addresses it finds in the
>> virtio-ring). Need to dive into it and understand what needs to be fixed...
> 
> Do the other registers like queuenum make sense? Could it be that the
> page number of the ring you're getting has wrong endianness?

The addresses are definitely wrong. kvmtool is spitting things like:
Warning: unable to translate guest address 0xe8fd828f00000000 to host

which tends to indicate that yes, page numbers are the other way around.
Cross-endianness shared memory fun.

	M.
-- 
Jazz is not dead. It just smells funny...
