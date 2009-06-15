From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 10:07:50 -0500
Message-ID: <4A3663C6.3070801__7753.07810768044$1245078776$gmane$org@codemonkey.ws>
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
	<4A364E32.4010808@redhat.com> <4A365078.5080209@codemonkey.ws>
	<4A36529D.4060200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4A36529D.4060200@redhat.com>
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
>
> I'd object to any implicit addressing rules.  If we have to say 
> target=2,lun=7,street=8,city=9,state=99,zip=12345 instead of 
> index=8345345235 so be it.

The next observation is that while we expand the SCSI addressing, the 
current propose flattens the PCI hierarchy (i.e. pci_addr=00:01.0).

An alternative would be to either always expand or always flatten 
addressing.  I think the later has a lot of merit.  Consider:

-controller type=lsi1234,addr=00:01,name=blah
-controller-disk controller=blah,addr=00:01,name=sda

-controller type=ide,addr=00.02,name=ide
-controller-disk controller=ide,addr=3,name=hdd

-drive file=foo.img,controller-disk=sda
-drive file=bar.img,controller-disk=hdd

This means that addr's format depends on the parent device node which is 
a bit less explicit than the previous example.  However, it is much more 
consistent and easier to implement.  Basically, when adding a device to 
it's parent, you hand the parent the "addr" field and that lets you say 
where you want to sit on the bus.

Regards,

Anthony Liguori
