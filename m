From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 3/5] virtio net: Add ethtool ops for SG/GSO
Date: Tue, 15 Jul 2008 11:49:19 +0800
Message-ID: <20080715034919.GA2657__14937.6636058607$1216093883$gmane$org@gondor.apana.org.au>
References: <200807151340.49604.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807151340.49604.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 14, 2008 at 10:40:49PM -0500, Rusty Russell wrote:
> From: Herbert Xu <herbert@gondor.apana.org.au>
> 
> This patch adds some basic ethtool operations to virtio_net so
> I could test SG without GSO (which was really useful because TSO
> turned out to be buggy :)
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (remove MTU setting)

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
