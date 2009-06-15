From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] Re: Configuration vs. compat hints
Date: Mon, 15 Jun 2009 07:50:53 -0500
Message-ID: <4A3643AD.8030508__37226.8821731724$1245070344$gmane$org@codemonkey.ws>
References: <20090610150129.GC28601@redhat.com>	<200906101624.30659.paul@codesourcery.com>	<20090610174301.GC7416@shareable.org>	<20090610182227.GN28601@redhat.com>	<20090610192702.GH7416@shareable.org>
	<1244796209.16425.20.camel@blaa>	<4A326B5C.5010501@codemonkey.ws>
	<1244821292.30522.56.camel@blaa>	<4A327E4A.7010300@codemonkey.ws>
	<1244825303.26769.19.camel@blaa>	<20090614095016.GA7560@redhat.com>
	<1245056916.6891.31.camel@blaa>	<4A3613EC.6030608@redhat.com>
	<87ocsp687t.fsf@pike.pond.sub.org>	<4A3633FD.4010208@redhat.com>
	<87prd54qku.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87prd54qku.fsf@pike.pond.sub.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Markus Armbruster <armbru@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Glauber Costa <glommer@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Markus Armbruster wrote:
> Avi Kivity <avi@redhat.com> writes:
>
>   
>> Paul/Anthony, can we have -vga pci_addr=, -usb-controller pci_addr=,
>> and -drive pci_addr= (and later, -disk-controller)?  Stalling while
>> waiting for the ultimate config file is only generating pain and
>> out-of-tree patches.
>>     
>
> Yup.
>
> I got bit-rotten patches for pci_addr=, and I can unrot them if they're
> wanted.
>   

Yes, would be good to have patches on the list to discuss.  In 
principle, I have no objection to this.

Regards,

Anthony Liguori
