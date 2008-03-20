From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 0/4] Inter-guest virtio I/O example with lguest
Date: Thu, 20 Mar 2008 16:59:14 +1100
Message-ID: <200803201659.14344.rusty__27906.2241818339$1205992894$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

   Just finished my prototype of inter-guest virtio, using networking as an 
example.  Each guest mmaps the other's address space and uses a FIFO for 
notifications.

   There are two issues with this approach.  The first is that neither guest 
can change its mappings.  See patch 1.  The second is that our feature 
configuration is "host presents, guest chooses" which breaks down when we 
don't know the capabilities of each guest.  In particular, TSO capability for 
networking.

   There are three possible solutions:
1) Just offer the lowest common denominator to both sides (ie. no features). 
   This is what I do with lguest in these patches.
2) Offer something and handle the case where one Guest accepts and another
   doesn't by emulating it.  ie. de-TSO the packets manually.
3) "Hot unplug" the device from the guest which asks for the greater features,
   then re-add it offering less features.  Requires hotplug in the guest OS.

I haven't tuned or even benchmarked these patches, but it pings!
Rusty.
