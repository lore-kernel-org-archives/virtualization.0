From: Or Gerlitz <ogerlitz@voltaire.com>
Subject: Re: [evb] RE: [PATCH][RFC] net/bridge: add basic VEPA support
Date: Sun, 09 Aug 2009 14:19:08 +0300
Message-ID: <4A7EB0AC.2030104__9434.43051442063$1249817149$gmane$org@Voltaire.com>
References: <D2E118A1E7268F449C469EA2F301D92902BC39B2@exil.voltaire.com>	<000001ca17a3$03f841f0$0be8c5d0$@edu>
	<20090807143652.1659ac57@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807143652.1659ac57@nehalam>
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
> I have a patch that forwards all multicast packets, and another that does proper forwarding. It should have worked that way in original macvlan, the current behavior is really a bug.
>   
Looking in macvlan_set_multicast_list() it acts in a similar manner to
macvlan_set_mac_address() in the sense that it calls dev_mc_sync(). I
assume what's left is to add macvlan_hash_xxx multicast logic to
map/unmap multicast groups to what macvlan devices want to receive them
and this way the flooding can be removed, correct?


Or.
