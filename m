From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] macvlan: Reflect macvlan packets meant for other
	macvlan devices
Date: Wed, 18 Nov 2009 15:44:24 +0100
Message-ID: <200911181544.24275.arnd__11542.3062853099$1258555738$gmane$org@arndb.de>
References: <1258497551-25959-1-git-send-email-arnd@arndb.de>
	<200911181047.07974.arnd@arndb.de>
	<m1pr7fdhkx.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1pr7fdhkx.fsf@fess.ebiederm.org>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 18 November 2009, Eric W. Biederman wrote:
> Please copy and ideally share code with the veth driver for recycling a skb.
> There are bunch of little things you have to do to get it right.  As I recally
> I was missing a few details in my original patch.

Ok, thanks for the hint!

	Arnd <><
