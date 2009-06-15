From: Avi Kivity <avi@redhat.com>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 16:03:20 +0300
Message-ID: <4A364698.1090402__29143.1602011018$1245071200$gmane$org@redhat.com>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa> <4A326B5C.5010501@codemonkey.ws>
	<1244821292.30522.56.camel@blaa> <4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa> <20090614095016.GA7560@redhat.com>
	<4A3617D4.5090405@redhat.com> <4A36424D.3080901@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A36424D.3080901@codemonkey.ws>
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

On 06/15/2009 03:45 PM, Anthony Liguori wrote:
>>> This last option makes sense to me: in a real world the user has
>>> control over where he places the device on the bus, so why
>>> not with qemu?
>>
>> Yes, the user build the machine using the command line and monitor 
>> (or, in 2017, the machine configuration file),
>
>
> Considering pbrook just posted a machine config for arm, I think it 
> would be rather sad if pc wasn't converted to it by 2017...

I'd be sad too, but not surprised.

>> then turns on the power.  Command line options are the parts lying 
>> around when we start.
>>
>> btw, -drive needs to be separated:
>>
>>   -controller type=lsi1234,pci_addr=foobar,name=blah
>>   -drive file=foo.img,controller=blah,index=0
>>   -drive file=bar.img,controller=blah,index=1
>>
>> Drives to not have pci addresses.
>
> Drivers don't have indexes and buses but we specify it on the -drive 
> line. 

Drives do have indexes.  On old parallel scsi drives you set the index 
by clicking a button on the back of the drive to cycle through scsi 
addresses 0-7.  An IDE drive's index is determined by the cable 
(master/slave).  A SATA drive's index is determined by which header on 
the motherboard the drive connects to.

If by bus you mean the if= parameter, then drives certainly do have 
buses.  Just try connecting the scsi drive from the previous paragraph 
to a USB port.

> -drive is convenient syntax.  It stops being convenient when you force 
> it to be two options.

controller= defaults to some builtin thing which autoinstantiates when 
necessary, so the old -drive syntax works.

-- 
error compiling committee.c: too many arguments to function
