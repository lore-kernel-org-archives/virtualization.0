From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Fri, 21 Mar 2008 09:14:05 +1100
Message-ID: <200803210914.05476.rusty__22331.785146571$1206051499$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E20A35.2000600@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E20A35.2000600@qumranet.com>
Content-Disposition: inline
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 20 March 2008 17:54:45 Avi Kivity wrote:
> Rusty Russell wrote:
> > Hi all,
> >
> >    Just finished my prototype of inter-guest virtio, using networking as
> > an example.  Each guest mmaps the other's address space and uses a FIFO
> > for notifications.
>
> Isn't that a security hole (hole? chasm)?  If the two guests can access
> each other's memory, they might as well be just one guest, and
> communicate internally.

Sorry, sloppy language on my part.  Each launcher process maps the other 
guest's memory as well: ie. copying occurs in the host.

> My feeling is that the host needs to copy the data, using dma if
> available.  Another option is to have one guest map the other's memory
> for read and write, while the other guest is unprivileged.  This allows
> one privileged guest to provide services for other, unprivileged guests,
> like domain 0 or driver domains in Xen.

One having privilege is possible, even trivial with the current patch (it's 
actually doing a completely generic inter-virtio-ring shuffle).  I chose the 
symmetrical approach for this demo for no particularly good reason.

Cheers,
Rusty.
