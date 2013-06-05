From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 05 Jun 2013 15:45:09 -0500
Message-ID: <87hahcqobu.fsf@codemonkey.ws>
References: <87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com> <871u8g67d6.fsf@codemonkey.ws>
	<20130605140936.GB10604@redhat.com> <87ehcgr3wq.fsf@codemonkey.ws>
	<20130605151953.GA25987@redhat.com> <87bo7ktvaw.fsf@codemonkey.ws>
	<20130605162029.GB26561@redhat.com> <87li6obd2r.fsf@codemonkey.ws>
	<20130605194317.GA30923@redhat.com>
	<20130605195216.GA31172@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130605195216.GA31172@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Jun 05, 2013 at 10:43:17PM +0300, Michael S. Tsirkin wrote:
>> On Wed, Jun 05, 2013 at 01:57:16PM -0500, Anthony Liguori wrote:
>> > "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > 
>> > > On Wed, Jun 05, 2013 at 10:46:15AM -0500, Anthony Liguori wrote:
>> > >> Look, it's very simple.
>> > > We only need to do it if we do a change that breaks guests.
>> > >
>> > > Please find a guest that is broken by the patches. You won't find any.
>> > 
>> > I think the problem in this whole discussion is that we're talking past
>> > each other.
>> > 
>> > Here is my understanding:
>> > 
>> > 1) PCI-e says that you must be able to disable IO bars and still have a
>> > functioning device.
>> > 
>> > 2) It says (1) because you must size IO bars to 4096 which means that
>> > practically speaking, once you enable a dozen or so PIO bars, you run
>> > out of PIO space (16 * 4k == 64k and not all that space can be used).
>> 
>> 
>> Let me add 3 other issues which I mentioned and you seem to miss:
>> 
>> 3) architectures which don't have fast access to IO ports, exist
>>    virtio does not work there ATM
>> 
>> 4) setups with many PCI bridges exist and have the same issue
>>    as PCI express. virtio does not work there ATM
>> 
>> 5) On x86, even with nested page tables, firmware only decodes
>>    the page address on an invalid PTE, not the data. You need to
>>    emulate the guest to get at the data. Without
>>    nested page tables, we have to do page table walk and emulate
>>    to get both address and data. Since this is how MMIO
>>    is implemented in kvm on x86, MMIO is much slower than PIO
>>    (with nested page tables by a factor of >2, did not test without).
>
> Oh I forgot:
>
> 6) access to MMIO BARs is painful in the BIOS environment
>    so BIOS would typically need to enable IO for the boot device.

But if you want to boot from the 16th device, the BIOS needs to solve
this problem anyway.

Regards,

Anthony Liguori
