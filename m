Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE24C4332F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 01:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47B736102D;
	Wed, 23 Nov 2022 01:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47B736102D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LGpuSvERHPhW; Wed, 23 Nov 2022 01:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BEEB960B19;
	Wed, 23 Nov 2022 01:11:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEEB960B19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D492C0032;
	Wed, 23 Nov 2022 01:11:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 623AAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BC0141927
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BC0141927
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfa_1Ic7G-oI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:11:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68B2D41924
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68B2D41924
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:11:55 +0000 (UTC)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH33r3KPDzRpGP;
 Wed, 23 Nov 2022 09:11:20 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 09:11:49 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.031;
 Wed, 23 Nov 2022 09:11:49 +0800
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Linux Crypto Mailing List
 <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH] crypto: virtio - Use helper to set reqsize
Thread-Topic: [PATCH] crypto: virtio - Use helper to set reqsize
Thread-Index: AQHY/lbIB4UAwZ8czkmWEcxmrx9Xl65LtBLQ
Date: Wed, 23 Nov 2022 01:11:49 +0000
Message-ID: <7d7face1123d4b2585ad706a7bc772ee@huawei.com>
References: <Y3yZgn/ffk21bGaM@gondor.apana.org.au>
In-Reply-To: <Y3yZgn/ffk21bGaM@gondor.apana.org.au>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: "Gonglei \(Arei\) via Virtualization"
 <virtualization@lists.linux-foundation.org>
Reply-To: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> -----Original Message-----
> From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
> Sent: Tuesday, November 22, 2022 5:42 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>;
> virtualization@lists.linux-foundation.org; Linux Crypto Mailing List
> <linux-crypto@vger.kernel.org>
> Subject: [PATCH] crypto: virtio - Use helper to set reqsize
> 
> The value of reqsize must only be changed through the helper.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 168195672e2e..b2979be613b8 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -479,6 +479,9 @@ static int virtio_crypto_rsa_init_tfm(struct
> crypto_akcipher *tfm)
>  	ctx->enginectx.op.prepare_request = NULL;
>  	ctx->enginectx.op.unprepare_request = NULL;
> 
> +	akcipher_set_reqsize(tfm,
> +			     sizeof(struct virtio_crypto_akcipher_request));
> +
>  	return 0;
>  }
> 
> @@ -505,7 +508,6 @@ static struct virtio_crypto_akcipher_algo
> virtio_crypto_akcipher_algs[] = {
>  			.max_size = virtio_crypto_rsa_max_size,
>  			.init = virtio_crypto_rsa_init_tfm,
>  			.exit = virtio_crypto_rsa_exit_tfm,
> -			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
>  			.base = {
>  				.cra_name = "rsa",
>  				.cra_driver_name = "virtio-crypto-rsa", @@ -528,7
> +530,6 @@ static struct virtio_crypto_akcipher_algo
> virtio_crypto_akcipher_algs[] = {
>  			.max_size = virtio_crypto_rsa_max_size,
>  			.init = virtio_crypto_rsa_init_tfm,
>  			.exit = virtio_crypto_rsa_exit_tfm,
> -			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
>  			.base = {
>  				.cra_name = "pkcs1pad(rsa,sha1)",
>  				.cra_driver_name = "virtio-pkcs1-rsa-with-sha1",
> --

Acked-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
