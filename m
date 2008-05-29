From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [3/6] [TUN]: Fix GSO mapping
Date: Thu, 29 May 2008 11:32:51 +0100
Message-ID: <1212057171.21998.2.camel@muff>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
	<20080418031554.GA18071@gondor.apana.org.au>
	<20080418031722.GB18071@gondor.apana.org.au>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080418031722.GB18071@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-04-18 at 11:17 +0800, Herbert Xu wrote:
> This patch avoids the correctness issue on the user-space mapping
> by just copying the memory.
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 4c15dc4..d75cfd2 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

> +			virt = kmap_atomic(f->page, KM_USER0);
> +			err = memcpy_fromiovec(virt + f->size, iv, copy);
> +			kunmap_atomic(virt, KM_USER0);

Seeing an oops from this; fix below.

Cheers,
Mark.

Subject: [PATCH 1/1] tun: Do not use kmap_atomic() since memcpy_fromiovec() can sleep

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
---
 drivers/net/tun.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 151b409..aff338e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -322,9 +322,9 @@ static int get_user_skb_frags(struct iovec *iv, size_t count,
 			if (copy > len)
 				copy = len;
 
-			virt = kmap_atomic(f->page, KM_USER0);
+			virt = kmap(f->page);
 			err = memcpy_fromiovec(virt + f->size, iv, copy);
-			kunmap_atomic(virt, KM_USER0);
+			kunmap(f->page);
 
 			if (err)
 				return err;
