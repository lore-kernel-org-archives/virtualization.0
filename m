From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Tue, 16 Dec 2008 13:55:42 +1100
Message-ID: <E1LCQ62-0001oT-2b__29969.1063621596$1229396360$gmane$org@gondolin.me.apana.org.au>
References: <4946E597.6070308@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4946E597.6070308@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, davem@davemloft.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori <anthony@codemonkey.ws> wrote:
> 
> If we used TCP, we don't have a useful TCP/IP stack in QEMU, so we'd 
> have to inject that traffic into the host Linux instance, and then 
> receive the traffic in QEMU.  Besides being indirect, it has some nasty 
> security implications that I outlined in my response to Jeremy's last note.

When combined with namespaces I don't see why using the kernel TCP
stack would create any security problems that wouldn't otherwise
exist.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
