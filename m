From: Or Gerlitz <ogerlitz@voltaire.com>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Thu, 27 Aug 2009 15:35:55 +0300
Message-ID: <4A967DAB.2010209__21744.4559246816$1251377035$gmane$org@voltaire.com>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>	<000001ca17a3$03f841f0$0be8c5d0$@edu>
	<20090807143652.1659ac57@nehalam>	<4A7EB0AC.2030104@Voltaire.com>
	<20090810082037.17b352c2@nehalam>
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
Cc: "evb@yahoogroups.com" <evb@yahoogroups.com>, arnd@arndb.de, anna.fischer@hp.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, adobriyan@gmail.com, "Paul Congdon (UC Davis)" <ptcongdon@ucdavis.edu>, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Stephen Hemminger wrote:
> Or Gerlitz <ogerlitz@voltaire.com> wrote:
>> Looking in macvlan_set_multicast_list() it acts in a similar manner to macvlan_set_mac_address() in the sense that it calls dev_mc_sync(). I assume what's left is to add macvlan_hash_xxx multicast logic to map/unmap multicast groups to what macvlan devices want to receive them and this way the flooding can be removed, correct?
> The device can just flood all multicast packets, since the filtering is done on the receive path anyway.
for each multicast packet, macvlan_broadcast is invoked and calls 
skb_clone/ netif_rx for each device, now a smart scheme that takes into 
account (hash) the multicast list of the different macvlan  devices 
would save the skb_clone call, isn't it?

Or.
