From: "Fischer, Anna" <anna.fischer@hp.com>
Subject: RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Mon, 10 Aug 2009 13:16:00 +0000
Message-ID: <0199E0D51A61344794750DC57738F58E6D6AE99743__46862.470979295$1249910636$gmane$org@GVW1118EXC.americas.hpqcorp.net>
References: <0199E0D51A61344794750DC57738F58E67D2DCECBB@GVW1118EXC.americas.hpqcorp.net>
	<20090806210002.75beb7c6@nehalam> <004e01ca1790$fec36c30$fc4a4490$@edu>
	<200908081149.27409.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908081149.27409.arnd@arndb.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Fischer, Anna" <anna.fischer@hp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "evb@yahoogroups.com" <evb@yahoogroups.com>, 'Stephen Hemminger' <shemminger@linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> Subject: Re: [PATCH][RFC] net/bridge: add basic VEPA support
> 
> On Friday 07 August 2009, Paul Congdon (UC Davis) wrote:
> > As I understand the macvlan code, it currently doesn't allow two VMs
> on the
> > same machine to communicate with one another.
> 
> There are patches to do that. I think if we add that, there should be
> a way to choose the behavior between either bridging between the
> guests or VEPA.

If you implement this direct bridging capability between local VMs for 
macvlan, then would this not break existing applications that currently
use it? It would be quite a significant change to how macvlan works 
today. I guess, ideally, you would want to have macvlan work in 
separate modes, e.g. traditional macvlan, bridging, and VEPA.

 
> > I could imagine a hairpin mode on the adjacent bridge making this
> > possible, but the macvlan code would need to be updated to filter
> > reflected frames so a source did not receive his own packet.
> 
> Right, I missed this point so far. I'll follow up with a patch
> to do that.

Can you maybe point me to the missing patches for macvlan that you
have mentioned in other emails, and the one you mention above? 
E.g. enabling multicast distribution and allowing local bridging etc.
I could not find any of those in the archives. Thanks.

 
> > I could imagine this being done as well, but to also
> > support selective multicast usage, something similar to the bridge
> > forwarding table would be needed.  I think putting VEPA into a new
> driver
> > would cause you to implement many things the bridge code already
> supports.
> > Given that we expect the bridge standard to ultimately include VEPA,
> and the
> > new functions are basic forwarding operations, it seems to make most
> sense
> > to keep this consistent with the bridge module.
> 
> This is the interesting part of the discussion. The bridge and macvlan
> drivers certainly have an overlap in functionality and you can argue
> that you only need one. Then again, the bridge code is a little crufty
> and we might not want to add much more to it for functionality that can
> be implemented in a much simpler way elsewhere. My preferred way would
> be to use bridge when you really need 802.1d MAC learning, netfilter-
> bridge
> and STP, while we put the optimizations for stuff like VMDq, zero-copy
> and multiqueue guest adapters only into the macvlan code.

I can see this being a possible solution. 

My concern with putting VEPA into macvlan instead of the bridging code
is that there will be more work required to make it usable for other
virtualization solution as macvtap will only work for KVM type setups. 
Basically, VEPA capabilities would rely on someone developing further
drivers to connect macvlan to different backend interfaces, e.g. one for
KVM (macvtap), one for Xen PV drivers, one for virtio, and whatever else
is out there, or will be there in the future. The bridging code is
already very generic in that respect, and all virtualization layers
can deal with connecting interfaces to a bridge. 

Our extensions to the bridging code to enable VEPA for the Linux kernel
are only very minimal code changes and would allow to make VEPA available
to most virtualization solutions today.

Anna
