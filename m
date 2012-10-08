From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Mon, 08 Oct 2012 22:13:37 +0200
Message-ID: <507333F1.1060000@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
	<5072EA14.30809@redhat.com> <87k3v1gfw1.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3v1gfw1.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

>> So we could have for virtio something like this:
>>
>>         Capabilities: [??] virtio-regs:
>>                 legacy: BAR=0 offset=0
>>                 virtio-pci: BAR=1 offset=1000
>>                 virtio-cfg: BAR=1 offset=1800
> 
> This would be a vendor specific PCI capability so lspci wouldn't
> automatically know how to parse it.

Sure, would need a patch to actually parse+print the cap,
/me was just trying to make my point clear in a simple way.

>>>> 2) ISTR an argument about mapping the ISR register separately, for
>>>>    performance, but I can't find a reference to it.
>>>
>>> I think the rationale is that ISR really needs to be PIO but everything
>>> else doesn't.  PIO is much faster on x86 because it doesn't require
>>> walking page tables or instruction emulation to handle the exit.
>>
>> Is this still a pressing issue?  With MSI-X enabled ISR isn't needed,
>> correct?  Which would imply that pretty much only old guests without
>> MSI-X support need this, and we don't need to worry that much when
>> designing something new ...
> 
> It wasn't that long ago that MSI-X wasn't supported..  I think we should
> continue to keep ISR as PIO as it is a fast path.

No problem if we allow to have both legacy layout and new layout at the
same time.  Guests can continue to use ISR @ BAR0 in PIO space for
existing virtio devices, even in case they want use mmio for other
registers -> all fine.

New virtio devices can support MSI-X from day one and decide to not
expose a legacy layout PIO bar.

cheers,
  Gerd
