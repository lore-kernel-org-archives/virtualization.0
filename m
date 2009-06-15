From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 18:05:44 +0300
Message-ID: <4A366348.1030202__45409.9132716239$1245078623$gmane$org@redhat.com>
References: <1244821292.30522.56.camel@blaa>
	<4A327E4A.7010300@codemonkey.ws>	<1244825303.26769.19.camel@blaa>
	<20090614095016.GA7560@redhat.com>	<1245056916.6891.31.camel@blaa>
	<4A3613EC.6030608@redhat.com>	<20090615103249.GB6351@redhat.com>
	<4A363012.8050409@redhat.com>	<20090615114858.GG6351@redhat.com>
	<4A3636FA.1040609@redhat.com>	<20090615124101.GH6351@redhat.com>
	<4A364381.401@redhat.com>	<4A364401.6010500@codemonkey.ws>
	<4A3647FB.9010808@redhat.com>	<4A364B53.9080007@codemonkey.ws>
	<4A364FE0.40204@redhat.com> <4A3651EB.3070204@codemonkey.ws>
	<4A36555A.4090303@redhat.com> <4A3659A0.3050108@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3659A0.3050108@codemonkey.ws>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

On 06/15/2009 05:24 PM, Anthony Liguori wrote:
> Dor Laor wrote:
>> Libvirt does not support r2d. I hope it won't start to support it.
>
> It supports mips, sparc, and ppc machines now.  I don't see why it 
> wouldn't support r2d.  For ppcemb, I expect this same problem to 
> occur.  This sort of restriction is going to be common with embedded 
> boards.

I expect these restrictions will have to be known by the management 
application.  Otherwise the users will try invalid configurations only 
to receive errors when they launch them.  GUIs exist to guide users, not 
as an inefficient means of trial-and-error.

>
>> We can have default values for these types of devices or something 
>> like pci_addr=auto.
>
> Why wouldn't libvirt always use pci_addr=auto?  If the only argument 
> for having libvirt do pci slot allocation is error messages, can't we 
> find a nice way to allow libvirt to create friendly error messages 
> when QEMU fails?

Error messages are not the only argument for pushing slot allocation to 
management.  See my previous messages on the topic.

>>> If you let QEMU allocate which PCI slot a device goes in, we can 
>>> hide this detail from libvirt.  If you have libvirt do PCI slot 
>>> allocation by default, it has to know about this restriction in the 
>>> r2d board unless you have a clever way to express this sort of 
>>> information.
>>>
>>> Once QEMU has allocated a device to a slot, libvirt can do a good 
>>> job maintaining that relationship.
>>>
>>
>> The end user should have a mechanism to control device slot 
>> positioning. For example, if you have several pci devices, some
>> get high rate of interrupts and some not, if you want to optimize you 
>> guest you should isolate the high rate 'interesting' devices.
>> This is something the user will need to do. I agree that the default 
>> behavior might be 'auto'
>
> I'm not at all arguing against pci_addr.  I'm arguing about how 
> libvirt should use it with respect to the "genesis" use-case where 
> libvirt has no specific reason to choose one PCI slot over another.  
> In that case, I'm merely advocating that we want to let QEMU make the 
> decision.


However this may end up, isn't it offtopic?  Whatever we do we have to 
support both pci_addr= and default placement, so we can push this 
discussion to livirt-devel and bid them godspeed.

-- 
error compiling committee.c: too many arguments to function
