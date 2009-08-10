From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Mon, 10 Aug 2009 17:28:15 +0200
Message-ID: <200908101728.15649.arnd__21315.8488194042$1249918936$gmane$org@arndb.de>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>
	<4A7EB0AC.2030104@Voltaire.com> <20090810082037.17b352c2@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090810082037.17b352c2@nehalam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, "evb@yahoogroups.com" <evb@yahoogroups.com>, anna.fischer@hp.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, adobriyan@gmail.com, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Monday 10 August 2009, Stephen Hemminger wrote:
> On Sun, 09 Aug 2009 14:19:08 +0300, Or Gerlitz <ogerlitz@voltaire.com> wrote:
> > Looking in macvlan_set_multicast_list() it acts in a similar manner to
> > macvlan_set_mac_address() in the sense that it calls dev_mc_sync(). I
> > assume what's left is to add macvlan_hash_xxx multicast logic to
> > map/unmap multicast groups to what macvlan devices want to receive them
> > and this way the flooding can be removed, correct?
> 
> The device can just flood all multicast packets, since the filtering
> is done on the receive path anyway.

But we'd still have to copy the frames to user space (for both
macvtap and raw packet sockets) and exit from the guest to inject
it into its stack, right?

I guess for multicast heavy workloads, we could save a lot of cycles
by throwing the frames away as early as possible. How common are those
setups in virtual servers though?

	Arnd <><
