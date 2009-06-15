From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 07:45:01 -0500
Message-ID: <4A36424D.3080901__23549.8263188221$1245069993$gmane$org@codemonkey.ws>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa> <4A326B5C.5010501@codemonkey.ws>
	<1244821292.30522.56.camel@blaa> <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<4A3617D4.5090405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3617D4.5090405@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>, Glauber Costa <glommer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> On 06/14/2009 12:50 PM, Michael S. Tsirkin wrote:
>> On Fri, Jun 12, 2009 at 05:48:23PM +0100, Mark McLoughlin wrote:
>>   
>>> However, in order to retain compat for that SCSI device (e.g. ensuring
>>> the PCI address doesn't change as other devices are added an removed),
>>> we're back to the same problem ... either:
>>>
>>>    1) Use '-drive file=foo.img,if=scsi,pci_addr=foo'; in order to 
>>> figure
>>>       out what address to use, libvirt would need to query qemu for 
>>> what
>>>       address was originally allocated to device or it would do all the
>>>       PCI address allocation itself ...
>>>      
>>
>> This last option makes sense to me: in a real world the user has
>> control over where he places the device on the bus, so why
>> not with qemu?
>>    
>
> Yes, the user build the machine using the command line and monitor 
> (or, in 2017, the machine configuration file),

Considering pbrook just posted a machine config for arm, I think it 
would be rather sad if pc wasn't converted to it by 2017...

> then turns on the power.  Command line options are the parts lying 
> around when we start.
>
> btw, -drive needs to be separated:
>
>   -controller type=lsi1234,pci_addr=foobar,name=blah
>   -drive file=foo.img,controller=blah,index=0
>   -drive file=bar.img,controller=blah,index=1
>
> Drives to not have pci addresses.

Drivers don't have indexes and buses but we specify it on the -drive 
line.  -drive is convenient syntax.  It stops being convenient when you 
force it to be two options.

Regards,

Anthony Liguori
