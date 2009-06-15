From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: Configuration vs. compat hints [was Re: [Qemu-devel] [PATCHv3
	03/13] qemu: add routines to manage PCI capabilities]
Date: Mon, 15 Jun 2009 10:11:00 -0500
Message-ID: <4A366484.7070602__5381.04507509178$1245080023$gmane$org@codemonkey.ws>
References: <4A326C7E.3020309@codemonkey.ws> <1244822007.30522.68.camel@blaa>
	<4A327E87.6080005@codemonkey.ws>
	<1244825333.26769.20.camel@blaa> <4A34ADA9.80709@redhat.com>
	<1245056955.6891.33.camel@blaa> <4A36314A.8040206@redhat.com>
	<4A364316.5070402@codemonkey.ws> <1245074447.3222.53.camel@blaa>
	<4A365890.1050106@codemonkey.ws>
	<20090615143406.GA14405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090615143406.GA14405@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>, Glauber Costa <glommer@redhat.com>, Jamie Lokier <jamie@shareable.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Paul Brook <paul@codesourcery.com>
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> And then pc-virtio-class-other-with-balloon-without-usb? Wouldn't it be
> more straightforward to have capability bits which can be switched on
> and off independently rather than trying to fit unrelated features into
> a machine type?  IMO it only seems more work at first, and QA gets a bit
> nervious that they can't exhaustively test all options. But in the long
> run it simplifies things as you don't have to set policy and invent
> silly names.
>   

We're strictly talking about default machine configs.  That has nothing 
to do with capabilities.  You still need to know what the default set of 
enabled capabilities were and keep track of that.  All that I'm 
suggesting is that we use the machine name to collapse the default set 
of capabilities into something that libvirt can track.

The advantage of using something more opaque like that is that it 
simplifies things for management tools as they don't have to keep track 
of "capabilities" that we're adding.  Heck, you could even do:

pc-00000034

Where "pc-%08x" % (capabilities) :-)

Regards,

Anthony Liguori
