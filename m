From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC PATCH 0/4] Inter-guest virtio I/O example with
	lguest
Date: Thu, 20 Mar 2008 09:11:35 -0500
Message-ID: <47E27097.7070302__39695.7445810132$1206022575$gmane$org@codemonkey.ws>
References: <200803201659.14344.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201659.14344.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Hi all,
>
>    Just finished my prototype of inter-guest virtio, using networking as an 
> example.  Each guest mmaps the other's address space and uses a FIFO for 
> notifications.
>
>    There are two issues with this approach.  The first is that neither guest 
> can change its mappings.  See patch 1.

Avi mentioned that with MMU notifiers, it may be possible to introduce a 
new kernel mechanism whereas you could map an arbitrary region of one 
process's memory into another process.  This would address this problem 
quite nicely.

>   The second is that our feature 
> configuration is "host presents, guest chooses" which breaks down when we 
> don't know the capabilities of each guest.  In particular, TSO capability for 
> networking.
>    There are three possible solutions:
> 1) Just offer the lowest common denominator to both sides (ie. no features). 
>    This is what I do with lguest in these patches.
> 2) Offer something and handle the case where one Guest accepts and another
>    doesn't by emulating it.  ie. de-TSO the packets manually.
> 3) "Hot unplug" the device from the guest which asks for the greater features,
>    then re-add it offering less features.  Requires hotplug in the guest OS.
>   
4) Add a feature negotiation feature.  The feature that gets set is the 
"feature negotiate" feature.  If a guest doesn't support feature 
negotiation, you end up with the least-common denominator (no 
features).  If both guests support feature negotiation, you can then add 
something new to determine the true common subset.

> I haven't tuned or even benchmarked these patches, but it pings!
>   

Very nice!  It's particularly cool that it was possible entirely in 
userspace.

Regards,

Anthony Liguori

> Rusty.
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>   
