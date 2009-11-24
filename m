From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/4] veth: move loopback logic to common location
Date: Tue, 24 Nov 2009 14:13:09 +0100
Message-ID: <200911241413.09214.arnd__31677.9455323287$1259068832$gmane$org@arndb.de>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<200911241034.43961.arnd@arndb.de> <4B0BB818.6090509@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4B0BB818.6090509@trash.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Patrick McHardy <kaber@trash.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 24 November 2009, Patrick McHardy wrote:
> I don't think its necessary, we bypass outgoing queuing anyways.
> But if you'd want to add it, just keeping the skb->mark clearing
> in veth should work from what I can tell.

Ok, I won't bother with it for now then.

	Arnd <><
