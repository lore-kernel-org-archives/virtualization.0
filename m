From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Sat, 8 Aug 2009 11:49:27 +0200
Message-ID: <200908081149.27409.arnd__49520.1566293419$1249725020$gmane$org@arndb.de>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<20090806210002.75beb7c6@nehalam>
	<004e01ca1790$fec36c30$fc4a4490$@edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <004e01ca1790$fec36c30$fc4a4490$@edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>
Cc: "'Fischer, Anna'" <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, adobriyan@gmail.com, evb@yahoogroups.com, 'Stephen Hemminger' <shemminger@linux-foundation.org>, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Friday 07 August 2009, Paul Congdon (UC Davis) wrote:
> As I understand the macvlan code, it currently doesn't allow two VMs on the
> same machine to communicate with one another. 

There are patches to do that. I think if we add that, there should be
a way to choose the behavior between either bridging between the
guests or VEPA.

> I could imagine a hairpin mode on the adjacent bridge making this
> possible, but the macvlan code would need to be updated to filter
> reflected frames so a source did not receive his own packet.

Right, I missed this point so far. I'll follow up with a patch
to do that.

> I could imagine this being done as well, but to also
> support selective multicast usage, something similar to the bridge
> forwarding table would be needed.  I think putting VEPA into a new driver
> would cause you to implement many things the bridge code already supports.
> Given that we expect the bridge standard to ultimately include VEPA, and the
> new functions are basic forwarding operations, it seems to make most sense
> to keep this consistent with the bridge module.

This is the interesting part of the discussion. The bridge and macvlan
drivers certainly have an overlap in functionality and you can argue
that you only need one. Then again, the bridge code is a little crufty
and we might not want to add much more to it for functionality that can
be implemented in a much simpler way elsewhere. My preferred way would
be to use bridge when you really need 802.1d MAC learning, netfilter-bridge
and STP, while we put the optimizations for stuff like VMDq, zero-copy
and multiqueue guest adapters only into the macvlan code.

	Arnd <><
