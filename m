From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Sun, 23 Mar 2008 23:05:37 +1100
Message-ID: <200803232305.38027.rusty__49117.2535381795$1206274160$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<47E27097.7070302@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47E27097.7070302@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 March 2008 01:11:35 Anthony Liguori wrote:
> Rusty Russell wrote:
> >    There are three possible solutions:
> > 1) Just offer the lowest common denominator to both sides (ie. no
> > features). This is what I do with lguest in these patches.
> > 2) Offer something and handle the case where one Guest accepts and
> > another doesn't by emulating it.  ie. de-TSO the packets manually.
> > 3) "Hot unplug" the device from the guest which asks for the greater
> > features, then re-add it offering less features.  Requires hotplug in the
> > guest OS.
>
> 4) Add a feature negotiation feature.  The feature that gets set is the
> "feature negotiate" feature.  If a guest doesn't support feature
> negotiation, you end up with the least-common denominator (no
> features).  If both guests support feature negotiation, you can then add
> something new to determine the true common subset.

Hmm, I discarded that out of hand as too icky, but we might end up there.  
Analyse features like normal, accept feature negotiation, set DRIVER_OK, wait 
for config change, if feature negotiation is still set then go around again 
(presumably some features have been removed).

I'll prototype it and see how we go.

Thanks,
Rusty.
