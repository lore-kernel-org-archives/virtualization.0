From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] veth: move loopback logic to common location
Date: Tue, 24 Nov 2009 19:28:58 +0100
Message-ID: <200911241928.59456.arnd__14940.8964011402$1259087517$gmane$org@arndb.de>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<4B0C1031.4050803@trash.net> <m1aayb6bfg.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1aayb6bfg.fsf@fess.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, David Miller <davem@davemloft.net>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 24 November 2009, Eric W. Biederman wrote:
> I don't quite follow what you intend with dev_queue_xmit when the macvlan
> is in one namespace and the real physical device is in another.  Are
> you mentioning that the packet classifier runs in the namespace where
> the primary device lives with packets from a different namespace?

I treat internal and external delivery very differently, the three
cases are:

1. skb from real device to macvlan (macvlan_handle_frame): basically
unchanged from before, except avoiding duplicate broadcasts. All
skbs end up in netif_rx(vlan->dev) without clearing any data.
We catch the frame in netif_receive_skb before it interacts with the
namespace of the real device.

2. skb to external device (macvlan_start_xmit): if the destination
is external, we just end up in dev_queue_xmit, with skb->dev set to
the external device but no other changes. The data is already on the
way out at this stage, so the namespace should not matter any more.

3. internal delivery: an skb from one macvlan to another gets always
sent through dev_forward_skb, which is supposed to clear anything
that must not leave the namespace.

Does this make sense?

	Arnd <><
