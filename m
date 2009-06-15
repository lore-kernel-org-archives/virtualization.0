From: Markus Armbruster <armbru@redhat.com>
Subject: Re: Configuration vs. compat hints
Date: Mon, 15 Jun 2009 13:35:02 +0200
Message-ID: <87ocsp687t.fsf__29508.9737781838$1245066158$gmane$org@pike.pond.sub.org>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<4A326B5C.5010501@codemonkey.ws> <1244821292.30522.56.camel@blaa>
	<4A327E4A.7010300@codemonkey.ws> <1244825303.26769.19.camel@blaa>
	<20090614095016.GA7560@redhat.com> <1245056916.6891.31.camel@blaa>
	<4A3613EC.6030608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3613EC.6030608@redhat.com> (Avi Kivity's message of "Mon\,
	15 Jun 2009 12\:27\:08 +0300")
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
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Carsten Otte <cotte@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity <avi@redhat.com> writes:

> On 06/15/2009 12:08 PM, Mark McLoughlin wrote:
>>> This last option makes sense to me: in a real world the user has
>>> control over where he places the device on the bus, so why
>>> not with qemu?
>>>      
>>
>> Yep, most people seem to agree that it makes sense to allow this, but
>> some believe it should only be via a machine description file, not the
>> command line.
>>    
>
> I don't understand this opposition.  It's clear a machine config file
> is a long way in our future.  It's also clear lack of stable PCI
> addresses hurts us now.

Correct.

>> However, the first problem is that it isn't a solution to the guest ABI
>> problem more generally.
>>    
>
> pci_addr was never meant to bring world peace, just stable PCI
> addresses.  The other issues should be addressed separately.
>
>> And the second problem is that for e.g. libvirt to use it, it would have
>> to be possible to query qemu for what PCI slots were assigned to the
>> devices - libvirt would need to be able to parse 'info pci' and match
>> the devices listed with the devices specified on the command line.
>>    
>
> If all devices (including vga, ide) are set up with pci_addr, then
> this is unneeded.  You do need to export available slot numbers from
> qemu.

Not really.  QEMU gives just the host bridge a fixed slot[*].  All the
other slots are available.

The real problem is devices that get implicitly added, like the SCSI
controller.  Those devices get their slots auto-assigned, which can
interfere with slot numbers chosen by the user.  We need a way to avoid
that, as you suggested elsewhere in this thread.


[*] There's an exception or two for oddball targets.
