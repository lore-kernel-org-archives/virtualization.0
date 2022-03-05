Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C0CC433EF
	for <virtualization@archiver.kernel.org>; Sat,  5 Mar 2022 07:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD7DF60C2C;
	Sat,  5 Mar 2022 07:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpahK_rI4mm0; Sat,  5 Mar 2022 07:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5BF0860BB5;
	Sat,  5 Mar 2022 07:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2721CC001D;
	Sat,  5 Mar 2022 07:12:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 997C1C000B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 07:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 799D960C2C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 07:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79n1amb5ZfFk
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 07:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54C4660BB5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 07:12:48 +0000 (UTC)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K9bQn3HShzbdy5;
 Sat,  5 Mar 2022 15:08:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 15:12:44 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.021;
 Sat, 5 Mar 2022 15:12:44 +0800
To: zhenwei pi <pizhenwei@bytedance.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v3 4/4] virtio-crypto: rename skcipher algs
Thread-Topic: [PATCH v3 4/4] virtio-crypto: rename skcipher algs
Thread-Index: AQHYLeeTmt6j+2AYWUelmv+/IKlM8KywZOmg
Date: Sat, 5 Mar 2022 07:12:44 +0000
Message-ID: <7be43c7ef9414be98346af8f0b20f2d5@huawei.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <20220302033917.1295334-5-pizhenwei@bytedance.com>
In-Reply-To: <20220302033917.1295334-5-pizhenwei@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
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
> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> Sent: Wednesday, March 2, 2022 11:39 AM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org;
> herbert@gondor.apana.org.au; helei.sig11@bytedance.com; zhenwei pi
> <pizhenwei@bytedance.com>
> Subject: [PATCH v3 4/4] virtio-crypto: rename skcipher algs
> 
> Suggested by Gonglei, rename virtio_crypto_algs.c to
> virtio_crypto_skcipher_algs.c. Also minor changes for function name.
> Thus the function of source files get clear: skcipher services in
> virtio_crypto_skcipher_algs.c and akcipher services in
> virtio_crypto_akcipher_algs.c.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/crypto/virtio/Makefile                            | 2 +-
>  drivers/crypto/virtio/virtio_crypto_common.h              | 4 ++--
>  drivers/crypto/virtio/virtio_crypto_mgr.c                 | 8 ++++----
>  ...virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)  rename
> drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c}
> (99%)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei


> diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile index
> f2b839473d61..bfa6cbae342e 100644
> --- a/drivers/crypto/virtio/Makefile
> +++ b/drivers/crypto/virtio/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o  virtio_crypto-objs :=
> \
> -	virtio_crypto_algs.o \
> +	virtio_crypto_skcipher_algs.o \
>  	virtio_crypto_akcipher_algs.o \
>  	virtio_crypto_mgr.o \
>  	virtio_crypto_core.o
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
> b/drivers/crypto/virtio/virtio_crypto_common.h
> index 214f9a6fcf84..e693d4ee83a6 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -130,8 +130,8 @@ static inline int virtio_crypto_get_current_node(void)
>  	return node;
>  }
> 
> -int virtio_crypto_algs_register(struct virtio_crypto *vcrypto); -void
> virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto);
> +int virtio_crypto_skcipher_algs_register(struct virtio_crypto
> +*vcrypto); void virtio_crypto_skcipher_algs_unregister(struct
> +virtio_crypto *vcrypto);
>  int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);  void
> virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c
> b/drivers/crypto/virtio/virtio_crypto_mgr.c
> index 1cb92418b321..70e778aac0f2 100644
> --- a/drivers/crypto/virtio/virtio_crypto_mgr.c
> +++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
> @@ -237,14 +237,14 @@ struct virtio_crypto *virtcrypto_get_dev_node(int
> node, uint32_t service,
>   */
>  int virtcrypto_dev_start(struct virtio_crypto *vcrypto)  {
> -	if (virtio_crypto_algs_register(vcrypto)) {
> -		pr_err("virtio_crypto: Failed to register crypto algs\n");
> +	if (virtio_crypto_skcipher_algs_register(vcrypto)) {
> +		pr_err("virtio_crypto: Failed to register crypto skcipher algs\n");
>  		return -EFAULT;
>  	}
> 
>  	if (virtio_crypto_akcipher_algs_register(vcrypto)) {
>  		pr_err("virtio_crypto: Failed to register crypto akcipher algs\n");
> -		virtio_crypto_algs_unregister(vcrypto);
> +		virtio_crypto_skcipher_algs_unregister(vcrypto);
>  		return -EFAULT;
>  	}
> 
> @@ -263,7 +263,7 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
>   */
>  void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)  {
> -	virtio_crypto_algs_unregister(vcrypto);
> +	virtio_crypto_skcipher_algs_unregister(vcrypto);
>  	virtio_crypto_akcipher_algs_unregister(vcrypto);
>  }
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c
> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> similarity index 99%
> rename from drivers/crypto/virtio/virtio_crypto_algs.c
> rename to drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index 583c0b535d13..a618c46a52b8 100644
> --- a/drivers/crypto/virtio/virtio_crypto_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -613,7 +613,7 @@ static struct virtio_crypto_algo virtio_crypto_algs[] =
> { {
>  	},
>  } };
> 
> -int virtio_crypto_algs_register(struct virtio_crypto *vcrypto)
> +int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto)
>  {
>  	int ret = 0;
>  	int i = 0;
> @@ -644,7 +644,7 @@ int virtio_crypto_algs_register(struct virtio_crypto
> *vcrypto)
>  	return ret;
>  }
> 
> -void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto)
> +void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto
> +*vcrypto)
>  {
>  	int i = 0;
> 
> --
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
