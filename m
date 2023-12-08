Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB654405
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 03:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA42341989
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 03:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA42341989
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MjKkWqYjh7cs
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 03:28:14 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6192A41928
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 03:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6192A41928
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rBRX6-008IE0-47; Fri, 08 Dec 2023 11:28:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Dec 2023 11:28:17 +0800
Date: Fri, 8 Dec 2023 11:28:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	wangyangxin <wangyangxin1@huawei.com>,
	Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] crypto: virtio-crypto: Handle dataq logic  with
 tasklet
Message-ID: <ZXKNUdXNV7G3ED3P@gondor.apana.org.au>
References: <ad8c946eb2294a7bb9eef26066c06b72@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad8c946eb2294a7bb9eef26066c06b72@huawei.com>

On Wed, Dec 06, 2023 at 11:52:51AM +0000, Gonglei (Arei) wrote:
> Doing ipsec produces a spinlock recursion warning.
> This is due to crypto_finalize_request() being called in the upper half.
> Move virtual data queue processing of virtio-crypto driver to tasklet.
> 
> Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
> Reported-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
>  v2: calling tasklet_kill() in virtcrypto_remove(), thanks for MST.
> 
>  drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
>  drivers/crypto/virtio/virtio_crypto_core.c   | 26 ++++++++++++++++----------
>  2 files changed, 18 insertions(+), 10 deletions(-)

Your patch has already been merged.  So please send this as
an incremental patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
