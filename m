From: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 1/4] veth: move loopback logic to common location
Date: Tue, 24 Nov 2009 19:38:28 +0100
Message-ID: <4B0C2824.5010502__40516.6648947217$1259087985$gmane$org@trash.net>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>	<200911241002.20904.arnd@arndb.de>
	<4B0BB2A7.5040707@trash.net>	<200911241034.43961.arnd@arndb.de>
	<4B0BB818.6090509@trash.net>	<m1aaybc1s5.fsf@fess.ebiederm.org>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Patrick McHardy <kaber@trash.net> writes:
> 
>> In the layered case (macvlan -> eth0) its common behaviour to
>> keep the mark however. But in case of different namespaces,
>> I think macvlan should also clear the mark on the dev_queue_xmit()
>> path since this is just a shortcut to looping the packets
>> through veth. In fact probably both of them should also clear
>> skb->priority so other namespaces don't accidentally misclassify
>> packets.
> 
> That is why I pushed for what is becoming dev_forward_skb.  So that
> we have one place where we can make all of those tweaks.  It seems
> like in every review we find another field that should be cleared/handled
> specially.
> 
> I don't quite follow what you intend with dev_queue_xmit when the macvlan
> is in one namespace and the real physical device is in another.  Are
> you mentioning that the packet classifier runs in the namespace where
> the primary device lives with packets from a different namespace?

Exactly. And I think we should make sure that the namespace of
the macvlan device can't (deliberately or accidentally) cause
misclassification.
