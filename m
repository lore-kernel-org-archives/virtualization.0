From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [Qemu-devel] Re: Configuration vs. compat hints
Date: Mon, 15 Jun 2009 14:41:21 +0200
Message-ID: <87prd54qku.fsf__32536.0541035936$1245069922$gmane$org@pike.pond.sub.org>
References: <20090610150129.GC28601@redhat.com>
	<200906101624.30659.paul@codesourcery.com>
	<20090610174301.GC7416@shareable.org>
	<20090610182227.GN28601@redhat.com>
	<20090610192702.GH7416@shareable.org> <1244796209.16425.20.camel@blaa>
	<4A326B5C.5010501@codemonkey.ws> <1244821292.30522.56.camel@blaa>
	<4A327E4A.7010300@codemonkey.ws> <1244825303.26769.19.camel@blaa>
	<20090614095016.GA7560@redhat.com> <1245056916.6891.31.camel@blaa>
	<4A3613EC.6030608@redhat.com> <87ocsp687t.fsf@pike.pond.sub.org>
	<4A3633FD.4010208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A3633FD.4010208@redhat.com> (Avi Kivity's message of "Mon\,
	15 Jun 2009 14\:43\:57 +0300")
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
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Carsten Otte <cotte@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity <avi@redhat.com> writes:

> (adding cc)
>
> On 06/15/2009 02:35 PM, Markus Armbruster wrote:
>> Not really.  QEMU gives just the host bridge a fixed slot[*].  All the
>> other slots are available.
>>    
>
> qemu needs to export these two bits of information: the first free
> slot and the number of slots.
>
> More generally, which slots are open.  We can assume 1:31, but that's
> unlovely.

Point.

>> The real problem is devices that get implicitly added, like the SCSI
>> controller.  Those devices get their slots auto-assigned, which can
>> interfere with slot numbers chosen by the user.  We need a way to avoid
>> that, as you suggested elsewhere in this thread.
>>    
>
> Paul/Anthony, can we have -vga pci_addr=, -usb-controller pci_addr=,
> and -drive pci_addr= (and later, -disk-controller)?  Stalling while
> waiting for the ultimate config file is only generating pain and
> out-of-tree patches.

Yup.

I got bit-rotten patches for pci_addr=, and I can unrot them if they're
wanted.

> (I'd be quite happy constructing the entire machine config on the
> command line, but I realize it's just me)

Ha, .bash_history as config file...
