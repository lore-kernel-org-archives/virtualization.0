Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35C168DF
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 10:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE40984417
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 10:10:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE40984417
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5zwJijNhTOkL
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Dec 2023 10:10:42 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 525678440F
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Dec 2023 10:10:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 525678440F
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r90Th-005hiX-2F; Fri, 01 Dec 2023 18:10:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 18:10:42 +0800
Date: Fri, 1 Dec 2023 18:10:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gonglei Arei <arei.gonglei@huawei.com>
Cc: linux-crypto@vger.kernel.org, pasic@linux.ibm.com, mst@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, wangyangxin1@huawei.com,
	arei.gonglei@huawei.com
Subject: Re: [PATCH] crypto: virtio-crypto: Handle dataq logic  with tasklet
Message-ID: <ZWmxInHyFboXMWZ6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fe5c6a60984a9e91bd9dea419c5154@huawei.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.virtualization

Gonglei Arei <arei.gonglei@huawei.com> wrote:
> Doing ipsec produces a spinlock recursion warning.
> This is due to crypto_finalize_request() being called in the upper half.
> Move virtual data queue processing of virtio-crypto driver to tasklet.
> 
> Fixes: dbaf0624ffa57 ("crypto: add virtio-crypto driver")
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
> drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
> drivers/crypto/virtio/virtio_crypto_core.c   | 23 +++++++++++++----------
> 2 files changed, 15 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
