Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB3C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 11:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D76E940306;
	Mon, 14 Nov 2022 11:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D76E940306
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRzIS6mk_S8Q; Mon, 14 Nov 2022 11:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0BA98402A1;
	Mon, 14 Nov 2022 11:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BA98402A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D69B3C0032;
	Mon, 14 Nov 2022 11:18:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFEEC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 11:18:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 512F460C20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 11:18:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 512F460C20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTRvbLVQ62OR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 11:18:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A63EC60C0C
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A63EC60C0C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 11:18:40 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9myJ6GFTz15Mc6;
 Mon, 14 Nov 2022 19:18:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 19:18:35 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.031;
 Mon, 14 Nov 2022 19:18:35 +0800
To: Wei Yongjun <weiyongjun@huaweicloud.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: RE: [PATCH] virtio-crypto: fix memory leak in
 virtio_crypto_alg_skcipher_close_session()
Thread-Topic: [PATCH] virtio-crypto: fix memory leak in
 virtio_crypto_alg_skcipher_close_session()
Thread-Index: AQHY+Bk7XRuE0LikA0eoAQIv/q8hvK4+RQHw
Date: Mon, 14 Nov 2022 11:18:35 +0000
Message-ID: <06d31ec507ef441abc4dc56f2c9be8ac@huawei.com>
References: <20221114110740.537276-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20221114110740.537276-1-weiyongjun@huaweicloud.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "weiyongjun \(A\)" <weiyongjun1@huawei.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
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
> From: Wei Yongjun [mailto:weiyongjun@huaweicloud.com]
> Sent: Monday, November 14, 2022 7:08 PM
> To: Michael S. Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>; Gonglei (Arei) <arei.gonglei@huawei.com>;
> Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller
> <davem@davemloft.net>; zhenwei pi <pizhenwei@bytedance.com>
> Cc: weiyongjun (A) <weiyongjun1@huawei.com>;
> virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org
> Subject: [PATCH] virtio-crypto: fix memory leak in
> virtio_crypto_alg_skcipher_close_session()
> 
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> 'vc_ctrl_req' is alloced in virtio_crypto_alg_skcipher_close_session(),
> and should be freed in the invalid ctrl_status->status error handling case.
> Otherwise there is a memory leak.
> 
> Fixes: 0756ad15b1fe ("virtio-crypto: use private buffer for control request")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
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
Good catch.

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei

>  	err = 0;
> --
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
