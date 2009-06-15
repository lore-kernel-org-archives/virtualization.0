From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 08:45:28 -0500
Message-ID: <4A365078.5080209__38129.2568556548$1245073890$gmane$org@codemonkey.ws>
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
	<4A364E32.4010808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A364E32.4010808@redhat.com>
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
> On 06/15/2009 04:20 PM, Anthony Liguori wrote:
>> It's not at all that simple.   SCSI has a hierarchical address 
>> mechanism with 0-7 targets but then potentially multiple LUNs per 
>> target.  Today, we always emulate a single LUN per target but if we 
>> ever wanted to support more than 7 disks on a SCSI controller, we 
>> would have to add multiple LUN support too.  So the current linear 
>> unit= parameter is actually pretty broken for SCSI.
>
> Well, another level in the hierarchy, but I don't think it materially 
> changes things.

Depends on whether you expect to say index=0,lun=3 or index=3.  If you 
mean the later, then it's quite conceivable that each target supports 
less than the maximum number of LUNs.  This makes things pretty 
confusing to the user because they have to know that in the current 
implementation, index=0 is valid, index=1 isn't, but index=8 is.

>> No, I meant drive file=foo.img,bus=3.  If that doesn't seem obvious 
>> what it should do to you that's because it isn't at all obvious :-)  
>> It ends up skipping a predefined number of locations in the drive 
>> table.  This is pretty broken fundamentally because it assumes 
>> controllers always support a fixed number of devices.  Nothing really 
>> respects bus_id though so in practice, I assume it's almost 
>> universally broken.
>
> Isn't the drive table something totally internal?  And how does bus= 
> relate to it?

The reality of unit=X,bus=Y,if=Z is that they expand to:

drive_table_index=Y*max_devs[Z] + X

Whereas max_devs = {"ide":4, "scsi": 7, *:0}

How drive_table_index is interpreted is "if" specific.  For if=scsi, 
each lsi device gets a base drive table index that starts at bus_index * 
7.  For virtio, the first empty spot in drive_table results in no more 
drives being created.

It's broken by design.

Regards,

Anthony Liguori
