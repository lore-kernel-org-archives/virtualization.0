From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 16:42:56 +0300
Message-ID: <4A364FE0.40204__5394.96740461818$1245073625$gmane$org@redhat.com>
References: <1244821292.30522.56.camel@blaa> <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<1245056916.6891.31.camel@blaa> <4A3613EC.6030608@redhat.com>
	<20090615103249.GB6351@redhat.com> <4A363012.8050409@redhat.com>
	<20090615114858.GG6351@redhat.com> <4A3636FA.1040609@redhat.com>
	<20090615124101.GH6351@redhat.com> <4A364381.401@redhat.com>
	<4A364401.6010500@codemonkey.ws> <4A3647FB.9010808@redhat.com>
	<4A364B53.9080007@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A364B53.9080007@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/15/2009 04:23 PM, Anthony Liguori wrote:
> Avi Kivity wrote:
>> On 06/15/2009 03:52 PM, Anthony Liguori wrote:
>>> Avi Kivity wrote:
>>>> On 06/15/2009 03:41 PM, Michael S. Tsirkin wrote:
>>>>> We should just tell the user which slots are open.
>>>>>   This might be tricky if the config is passed in with the command 
>>>>> line
>>>>> flags.
>>>>
>>>> qemu -show-available-pci-slots
>>>
>>> Why does the user care?
>>>
>>> Let QEMU allocate the PCI slot, then query it to see what slot it 
>>> assigned and remember that.
>>
>> It's a roundabout way of doing things.
>
> Having libvirt do PCI slot allocation scares me.  It assumes we can 
> return a whitelist of available slots, and then let libvirt just 
> randomly assign things.  There's knowledge though in slot assignment 
> that's board-specific.  For instance, depending on how many LNK lines 
> you have, you may want to put things in slots in such a way to 
> optimize interrupt balancing or something like that.

How would qemu know which slots to optimize for?

In practice, I don't see that as a real problem.  We should (a) add an 
ioapic and four more pci links (b) recommend that slots be assigned in 
ascending order, and everything works.

I don't see your concern about libvirt allocating slots.  If a human can 
plug a card into a slot, so can libvirt.  Doing an interactive 
back-and-forth (equivalent to plugging a card while blindfolded, then 
looking to see which slot we hit) is certainly more difficult.

> Some platforms have quirks about expecting a particular slot to have a 
> particular device.  It's still an optimal device but it has to be in 
> that slot.  You can't really express that via an available slot list.

I'll be surprised if we ever measure different dma speeds on different 
slots in the qemu virtual pci bus.  If we do, we'll find a way to 
express them:

   $ qemu -print-pci
   slot 0:01: available 33MHz
   slot 0:02: available 33MHz
   slot 0:03: available 66MHz

I feel a little silly typing this.

-- 
error compiling committee.c: too many arguments to function
