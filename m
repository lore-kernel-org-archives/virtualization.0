Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F267CC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 15:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 811D160B98;
	Wed, 23 Mar 2022 15:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVkMu_J2sWWL; Wed, 23 Mar 2022 15:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 162B4605BE;
	Wed, 23 Mar 2022 15:38:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1BF8C001A;
	Wed, 23 Mar 2022 15:38:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2654C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8399F60B98
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1AezPy9K1Zrm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:38:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E4A2605BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648049911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=52OyT4hNZgnDakpoSYVZAqnZ+3Oak7O7fHORDYjy2eA=;
 b=bI/hO3vmx6kdRaJ+tj4BCs3350N5CVVq8nLdEkXfyjKjAjS4xIx+DgQeahrb0fYJkBEAfz
 LvTmiuhMlYZ5DUz6jGMcVIE9+rEwTMLDnypFvxqKMhOcQyN6YcNB5vPGqPw1Y84UQ9WDTO
 IKm35xu0Kf0VYjczglEhdFMvZY5wJ/Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-spB1Q2qaM_GCIH9FixBKRw-1; Wed, 23 Mar 2022 11:38:26 -0400
X-MC-Unique: spB1Q2qaM_GCIH9FixBKRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCBAE2800F6B;
 Wed, 23 Mar 2022 15:38:25 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 299AD140241B;
 Wed, 23 Mar 2022 15:38:24 +0000 (UTC)
Date: Wed, 23 Mar 2022 15:38:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v3 1/6] virtio-crypto: header update
Message-ID: <Yjs+7TYdumci1Q9h@redhat.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <20220323024912.249789-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220323024912.249789-2-pizhenwei@bytedance.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: herbert@gondor.apana.org.au, mst@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 lei he <helei.sig11@bytedance.com>
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 23, 2022 at 10:49:07AM +0800, zhenwei pi wrote:
> Update header from linux, support akcipher service.

I'm assuming this is updated for *non-merged* Linux headers, since
I don't see these changes present in current linux.git 

> 
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../standard-headers/linux/virtio_crypto.h    | 82 ++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
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
>  #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
>  	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
> +#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
> +	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
> +#define VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
> +	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x05)
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

Do we really need to be adding support for all these obsolete
hash functions. Maybe SHA1 is borderline acceptable, but all
those obsolete MD* functions too ??

> +#define VIRTIO_CRYPTO_RSA_SHA256    6
> +#define VIRTIO_CRYPTO_RSA_SHA384    7
> +#define VIRTIO_CRYPTO_RSA_SHA512    8
> +#define VIRTIO_CRYPTO_RSA_SHA224    9
> +	uint32_t hash_algo;
> +};
> +
> +struct virtio_crypto_ecdsa_session_para {
> +#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
> +#define VIRTIO_CRYPTO_CURVE_NIST_P192 1
> +#define VIRTIO_CRYPTO_CURVE_NIST_P224 2
> +#define VIRTIO_CRYPTO_CURVE_NIST_P256 3
> +#define VIRTIO_CRYPTO_CURVE_NIST_P384 4
> +#define VIRTIO_CRYPTO_CURVE_NIST_P521 5
> +	uint32_t curve_id;
> +	uint32_t padding;
> +};
> +
> +struct virtio_crypto_akcipher_session_para {
> +#define VIRTIO_CRYPTO_NO_AKCIPHER    0
> +#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
> +#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
> +#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3

Here we have RSA, DSA and ECDSA, but the corresponding QEMU
qapi/crypto.json doesn't define DSA at all. Is that a mistake
on the QEMU side, or is the DSA support redundant ?

> +	uint32_t algo;
> +
> +#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
> +#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
> +	uint32_t keytype;
> +	uint32_t keylen;
> +
> +	union {
> +		struct virtio_crypto_rsa_session_para rsa;
> +		struct virtio_crypto_ecdsa_session_para ecdsa;
> +	} u;
> +};


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
