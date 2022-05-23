Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EBC433F5
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 03:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44E2A60B1D;
	Mon, 23 May 2022 03:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j6hlVKjkGOeG; Mon, 23 May 2022 03:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C340860AFB;
	Mon, 23 May 2022 03:30:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99D92C0039;
	Mon, 23 May 2022 03:30:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1398C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B96D3832DB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:30:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QBZpAdwiUDNz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64253832D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:30:17 +0000 (UTC)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L62qK06nBzgY9k;
 Mon, 23 May 2022 11:28:44 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 11:30:12 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Mon, 23 May 2022 11:30:12 +0800
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: RE: [PATCH] virtio-crypto: Fix an error handling path in
 virtio_crypto_alg_skcipher_close_session()
Thread-Topic: [PATCH] virtio-crypto: Fix an error handling path in
 virtio_crypto_alg_skcipher_close_session()
Thread-Index: AQHYbdzohrRhPI6eNU6IurU5BTsS/K0rzrHw
Date: Mon, 23 May 2022 03:30:12 +0000
Message-ID: <544dc03a02ff46dbb62587f3343ffd72@huawei.com>
References: <068d2824cf592748cbd9b75cf4cb6c29600e213c.1653224817.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <068d2824cf592748cbd9b75cf4cb6c29600e213c.1653224817.git.christophe.jaillet@wanadoo.fr>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
> From: Christophe JAILLET [mailto:christophe.jaillet@wanadoo.fr]
> Sent: Sunday, May 22, 2022 9:07 PM
> To: dan.carpenter@oracle.com; Gonglei (Arei) <arei.gonglei@huawei.com>;
> Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller
> <davem@davemloft.net>; zhenwei pi <pizhenwei@bytedance.com>
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>;
> virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org
> Subject: [PATCH] virtio-crypto: Fix an error handling path in
> virtio_crypto_alg_skcipher_close_session()
> 
> Now that a private buffer is allocated (see commit in the Fixes tag), it must be
> released in all error handling paths.
> 
> Add the missing goto to avoid a leak in the error handling path.
> 
> Fixes: 42e6ac99e417 ("virtio-crypto: use private buffer for control request")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei

> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index e553ccadbcbc..e5876286828b 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -239,7 +239,8 @@ static int virtio_crypto_alg_skcipher_close_session(
>  		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
>  			ctrl_status->status, destroy_session->session_id);
> 
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>  	}
> 
>  	err = 0;
> --
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
