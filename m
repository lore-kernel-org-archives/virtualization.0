Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 12:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18898833CA;
	Thu, 17 Feb 2022 12:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3i0WW2JwkECQ; Thu, 17 Feb 2022 12:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A685833AE;
	Thu, 17 Feb 2022 12:09:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63FC2C0021;
	Thu, 17 Feb 2022 12:09:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AB6CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 12:09:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9A3A4017B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 12:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjJyktnbdYpA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 12:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56B7540160
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 12:09:24 +0000 (UTC)
Received: from dggeme709-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jztmp3WFFz1FDJW;
 Thu, 17 Feb 2022 20:04:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeme709-chm.china.huawei.com (10.1.199.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 17 Feb 2022 20:09:21 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.021;
 Thu, 17 Feb 2022 20:09:21 +0800
To: zhenwei pi <pizhenwei@bytedance.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v2 1/3] virtio-crypto: header update
Thread-Topic: [PATCH v2 1/3] virtio-crypto: header update
Thread-Index: AQHYHyOv4Ow7dlLIq02ovelfF5jSS6yXr/+A
Date: Thu, 17 Feb 2022 12:09:21 +0000
Message-ID: <67a8975b0ed54f5a92b5032793a176f8@huawei.com>
References: <20220211084335.1254281-1-pizhenwei@bytedance.com>
 <20220211084335.1254281-2-pizhenwei@bytedance.com>
In-Reply-To: <20220211084335.1254281-2-pizhenwei@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
> Sent: Friday, February 11, 2022 4:44 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; qemu-devel@nongnu.org;
> helei.sig11@bytedance.com; herbert@gondor.apana.org.au; zhenwei pi
> <pizhenwei@bytedance.com>
> Subject: [PATCH v2 1/3] virtio-crypto: header update
> 
> Update header from linux, support akcipher service.
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../standard-headers/linux/virtio_crypto.h    | 82 ++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>


> diff --git a/include/standard-headers/linux/virtio_crypto.h
> b/include/standard-headers/linux/virtio_crypto.h
> index 5ff0b4ee59..68066dafb6 100644
> --- a/include/standard-headers/linux/virtio_crypto.h
> +++ b/include/standard-headers/linux/virtio_crypto.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_CRYPTO_SERVICE_HASH   1
>  #define VIRTIO_CRYPTO_SERVICE_MAC    2
>  #define VIRTIO_CRYPTO_SERVICE_AEAD   3
> +#define VIRTIO_CRYPTO_SERVICE_AKCIPHER 4
> 
>  #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
> 
> @@ -57,6 +58,10 @@ struct virtio_crypto_ctrl_header {
>  	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
> #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
>  	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
> +#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
> +	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
> #define
> +VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
> +	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER,
> 0x05)
>  	uint32_t opcode;
>  	uint32_t algo;
>  	uint32_t flag;
> @@ -180,6 +185,58 @@ struct virtio_crypto_aead_create_session_req {
>  	uint8_t padding[32];
>  };
> 
> +struct virtio_crypto_rsa_session_para {
> +#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
> +#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
> +	uint32_t padding_algo;
> +
> +#define VIRTIO_CRYPTO_RSA_NO_HASH   0
> +#define VIRTIO_CRYPTO_RSA_MD2       1
> +#define VIRTIO_CRYPTO_RSA_MD3       2
> +#define VIRTIO_CRYPTO_RSA_MD4       3
> +#define VIRTIO_CRYPTO_RSA_MD5       4
> +#define VIRTIO_CRYPTO_RSA_SHA1      5
> +#define VIRTIO_CRYPTO_RSA_SHA256    6
> +#define VIRTIO_CRYPTO_RSA_SHA384    7
> +#define VIRTIO_CRYPTO_RSA_SHA512    8
> +#define VIRTIO_CRYPTO_RSA_SHA224    9
> +	uint32_t hash_algo;
> +};
> +
> +struct virtio_crypto_ecdsa_session_para {
> +#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
> +#define VIRTIO_CRYPTO_CURVE_NIST_P192 1 #define
> +VIRTIO_CRYPTO_CURVE_NIST_P224 2 #define
> VIRTIO_CRYPTO_CURVE_NIST_P256 3
> +#define VIRTIO_CRYPTO_CURVE_NIST_P384 4 #define
> +VIRTIO_CRYPTO_CURVE_NIST_P521 5
> +	uint32_t curve_id;
> +	uint32_t padding;
> +};
> +
> +struct virtio_crypto_akcipher_session_para {
> +#define VIRTIO_CRYPTO_NO_AKCIPHER    0
> +#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
> +#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
> +#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3
> +	uint32_t algo;
> +
> +#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1 #define
> +VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
> +	uint32_t keytype;
> +	uint32_t keylen;
> +
> +	union {
> +		struct virtio_crypto_rsa_session_para rsa;
> +		struct virtio_crypto_ecdsa_session_para ecdsa;
> +	} u;
> +};
> +
> +struct virtio_crypto_akcipher_create_session_req {
> +	struct virtio_crypto_akcipher_session_para para;
> +	uint8_t padding[36];
> +};
> +
>  struct virtio_crypto_alg_chain_session_para {  #define
> VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
> #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
> @@ -247,6 +304,8 @@ struct virtio_crypto_op_ctrl_req {
>  			mac_create_session;
>  		struct virtio_crypto_aead_create_session_req
>  			aead_create_session;
> +		struct virtio_crypto_akcipher_create_session_req
> +			akcipher_create_session;
>  		struct virtio_crypto_destroy_session_req
>  			destroy_session;
>  		uint8_t padding[56];
> @@ -266,6 +325,14 @@ struct virtio_crypto_op_header {
>  	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
> #define VIRTIO_CRYPTO_AEAD_DECRYPT \
>  	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
> +#define VIRTIO_CRYPTO_AKCIPHER_ENCRYPT \
> +	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
> #define
> +VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
> +	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
> #define
> +VIRTIO_CRYPTO_AKCIPHER_SIGN \
> +	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
> #define
> +VIRTIO_CRYPTO_AKCIPHER_VERIFY \
> +	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x03)
>  	uint32_t opcode;
>  	/* algo should be service-specific algorithms */
>  	uint32_t algo;
> @@ -390,6 +457,16 @@ struct virtio_crypto_aead_data_req {
>  	uint8_t padding[32];
>  };
> 
> +struct virtio_crypto_akcipher_para {
> +	uint32_t src_data_len;
> +	uint32_t dst_data_len;
> +};
> +
> +struct virtio_crypto_akcipher_data_req {
> +	struct virtio_crypto_akcipher_para para;
> +	uint8_t padding[40];
> +};
> +
>  /* The request of the data virtqueue's packet */  struct
> virtio_crypto_op_data_req {
>  	struct virtio_crypto_op_header header; @@ -399,6 +476,7 @@ struct
> virtio_crypto_op_data_req {
>  		struct virtio_crypto_hash_data_req hash_req;
>  		struct virtio_crypto_mac_data_req mac_req;
>  		struct virtio_crypto_aead_data_req aead_req;
> +		struct virtio_crypto_akcipher_data_req akcipher_req;
>  		uint8_t padding[48];
>  	} u;
>  };
> @@ -408,6 +486,8 @@ struct virtio_crypto_op_data_req {
>  #define VIRTIO_CRYPTO_BADMSG    2
>  #define VIRTIO_CRYPTO_NOTSUPP   3
>  #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
> +#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
> +#define VIRTIO_CRYPTO_KEY_REJECTED 6 /* Signature verification failed
> +*/
> 
>  /* The accelerator hardware is ready */  #define
> VIRTIO_CRYPTO_S_HW_READY  (1 << 0) @@ -438,7 +518,7 @@ struct
> virtio_crypto_config {
>  	uint32_t max_cipher_key_len;
>  	/* Maximum length of authenticated key */
>  	uint32_t max_auth_key_len;
> -	uint32_t reserve;
> +	uint32_t akcipher_algo;
>  	/* Maximum size of each crypto request's content */
>  	uint64_t max_size;
>  };
> --
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
