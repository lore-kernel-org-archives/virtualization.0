From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 6/6] virtio ring helper
Date: Fri, 21 Sep 2007 12:04:11 +1000
Message-ID: <1190340251.19451.36.camel__7423.92191100425$1190374853$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
	<1190290761.7262.242.camel@localhost.localdomain>
	<1190291234.7262.246.camel@localhost.localdomain>
	<46F26AF6.60904@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F26AF6.60904@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-09-20 at 14:43 +0200, Avi Kivity wrote:
> Rusty Russell wrote:
> > These helper routines supply most of the virtqueue_ops for hypervisors
> > which want to use a ring for virtio.  Unlike the previous lguest
> > implementation:
> >
> > 3) The page numbers are always 64 bit (PAE anyone?)
> >   
> 
> 32 bits of page numbers give 44 bits of physical address on x86.  That's 
> 16TB per guest.  Admittedly it's smaller on a VAX.

I like to feel that I make these mistakes to ensure others are paying
attention.  However, it does mean that I can just put an address in
there and increase the length field to 32 bits.  Much rejoicing.

Will fix and resend tomorrow (Friday is in-office-away-from-test-machine
day).

> I don't like the chaining and would prefer the descriptor to refer to an 
> array of page descriptors.  However I can't complain since this isn't 
> common code.

The intent is for kvm to use it.  I'll certainly consider your patches,
although I suspect that managing descriptor pages will make things ugly
enough to cause you to reconsider.

Thanks!
Rusty.
