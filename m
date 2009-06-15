From: Dor Laor <dlaor@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 17:06:18 +0300
Message-ID: <4A36555A.4090303__11401.1826961816$1245075100$gmane$org@redhat.com>
References: <1244821292.30522.56.camel@blaa>
	<4A327E4A.7010300@codemonkey.ws>	<1244825303.26769.19.camel@blaa>
	<20090614095016.GA7560@redhat.com>	<1245056916.6891.31.camel@blaa>
	<4A3613EC.6030608@redhat.com>	<20090615103249.GB6351@redhat.com>
	<4A363012.8050409@redhat.com>	<20090615114858.GG6351@redhat.com>
	<4A3636FA.1040609@redhat.com>	<20090615124101.GH6351@redhat.com>
	<4A364381.401@redhat.com>	<4A364401.6010500@codemonkey.ws>
	<4A3647FB.9010808@redhat.com>	<4A364B53.9080007@codemonkey.ws>
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>
Reply-To: dlaor@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3651EB.3070204@codemonkey.ws>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Avi Kivity wrote:
>> On 06/15/2009 04:23 PM, Anthony Liguori wrote:
>>
>> How would qemu know which slots to optimize for?
>>
>> In practice, I don't see that as a real problem.  We should (a) add 
>> an ioapic and four more pci links (b) recommend that slots be 
>> assigned in ascending order, and everything works.
>>
>> I don't see your concern about libvirt allocating slots.  If a human 
>> can plug a card into a slot, so can libvirt.  Doing an interactive 
>> back-and-forth (equivalent to plugging a card while blindfolded, then 
>> looking to see which slot we hit) is certainly more difficult.
>
> Let's take a concrete example because I think you missed my point.  
> For the r2d board, if you have 1 on-board NIC, it has to go in slot 
> 2.  Additional NICs can go in any slot, but the primary on-board NIC 
> is expected to live in slot 2.  It's possible to not have that 
> on-board NIC.
Libvirt does not support r2d. I hope it won't start to support it.
We can have default values for these types of devices or something like 
pci_addr=auto.

>
> If you let QEMU allocate which PCI slot a device goes in, we can hide 
> this detail from libvirt.  If you have libvirt do PCI slot allocation 
> by default, it has to know about this restriction in the r2d board 
> unless you have a clever way to express this sort of information.
>
> Once QEMU has allocated a device to a slot, libvirt can do a good job 
> maintaining that relationship.
>

The end user should have a mechanism to control device slot positioning. 
For example, if you have several pci devices, some
get high rate of interrupts and some not, if you want to optimize you 
guest you should isolate the high rate 'interesting' devices.
This is something the user will need to do. I agree that the default 
behavior might be 'auto'

Also, while moving from one qemu version to another, you'll need to 
represent the older behavior. -qemu-0.10 is not good enough
since there will be multiple versions in the future with multiple 
distributions setting their defaults.

> Regards,
>
> Anthony Liguori
>
>
