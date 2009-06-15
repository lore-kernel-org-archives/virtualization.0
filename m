From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 16:35:46 +0300
Message-ID: <4A364E32.4010808__14493.862403515$1245073194$gmane$org@redhat.com>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa> <4A326B5C.5010501@codemonkey.ws>
	<1244821292.30522.56.camel@blaa> <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<4A3617D4.5090405@redhat.com> <4A36424D.3080901@codemonkey.ws>
	<4A364698.1090402@redhat.com> <4A364A9B.9070001@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A364A9B.9070001@codemonkey.ws>
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

On 06/15/2009 04:20 PM, Anthony Liguori wrote:
>>
>>>> then turns on the power.  Command line options are the parts lying 
>>>> around when we start.
>>>>
>>>> btw, -drive needs to be separated:
>>>>
>>>>   -controller type=lsi1234,pci_addr=foobar,name=blah
>>>>   -drive file=foo.img,controller=blah,index=0
>>>>   -drive file=bar.img,controller=blah,index=1
>>>>
>>>> Drives to not have pci addresses.
>>>
>>> Drivers don't have indexes and buses but we specify it on the -drive 
>>> line. 
>>
>> Drives do have indexes.  On old parallel scsi drives you set the 
>> index by clicking a button on the back of the drive to cycle through 
>> scsi addresses 0-7.  An IDE drive's index is determined by the cable 
>> (master/slave).  A SATA drive's index is determined by which header 
>> on the motherboard the drive connects to.
>
>
> It's not at all that simple.   SCSI has a hierarchical address 
> mechanism with 0-7 targets but then potentially multiple LUNs per 
> target.  Today, we always emulate a single LUN per target but if we 
> ever wanted to support more than 7 disks on a SCSI controller, we 
> would have to add multiple LUN support too.  So the current linear 
> unit= parameter is actually pretty broken for SCSI.

Well, another level in the hierarchy, but I don't think it materially 
changes things.

>
> For IDE, it's a combination of bus, slot, and master/slave.  For 
> virtio, it's just a PCI address.  What we really need is something 
> that is more opaque and controller specific. 

virtio also has a bus (did you mean the pci bus for IDE?), master/slave 
is the index.  virtio doesn't have index, but IMO that was a mistake and 
we should have designed it as a disk controller in the first place.

> For instance, if we were going to do controllers...
>
> -controller type=lsi1234,pci_addr=foobar,name=blah
> -controller-disk controller=blah,target=0,lun=1,name=sda
>
> -controller type=ide,pci_addr=barfoo,name=ide
> -controller-disk controller=ide,slot=secondary,cable=slave,name=hdd
>
> -drive file=foo.img,controller-disk=sda
> -drive file=bar.img,controller-disk=hdd
>
> And having "-hdd file=foo.img" be short-hand for "-drive 
> file=%s,controller-disk=%s".

Yeah.

>>
>>
>> If by bus you mean the if= parameter, then drives certainly do have 
>> buses.  Just try connecting the scsi drive from the previous 
>> paragraph to a USB port.
>
> No, I meant drive file=foo.img,bus=3.  If that doesn't seem obvious 
> what it should do to you that's because it isn't at all obvious :-)  
> It ends up skipping a predefined number of locations in the drive 
> table.  This is pretty broken fundamentally because it assumes 
> controllers always support a fixed number of devices.  Nothing really 
> respects bus_id though so in practice, I assume it's almost 
> universally broken.

Isn't the drive table something totally internal?  And how does bus= 
relate to it?

Confused.


-- 
error compiling committee.c: too many arguments to function
