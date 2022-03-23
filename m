Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0873C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 13:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8034760B4E;
	Wed, 23 Mar 2022 13:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XNlFx56ZelhW; Wed, 23 Mar 2022 13:08:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7CCA36137A;
	Wed, 23 Mar 2022 13:08:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DC46C0012;
	Wed, 23 Mar 2022 13:08:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26427C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1887940C0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJxvwOJZ6WOI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:08:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C10AE400FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648040905;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=70BVFp/ay2GtzV9l/8pyutFT6h5mVJO5vmRO+wXGVxo=;
 b=A+2wORLWua9ujo08E2gKeVTN37PQzvbcV31/Ke/d4iIn3aY2ZQGqqbQUTxATpaWDukZ1uJ
 A6souul3uiqnW4o/ujjEcBPcg/nKvN4FLzQ/1Z8tDPx6wedQYObHodQ+0006rj4V3uLTRV
 iRbgmBnOELyvKEgovlWuOQWqgM69Rmc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-NABzQSV7NqqciiVi62vQng-1; Wed, 23 Mar 2022 09:08:22 -0400
X-MC-Unique: NABzQSV7NqqciiVi62vQng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8FAD29ABA29;
 Wed, 23 Mar 2022 13:08:21 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A93B1400E70;
 Wed, 23 Mar 2022 13:08:19 +0000 (UTC)
Date: Wed, 23 Mar 2022 13:08:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v3 2/6] crypto-akcipher: Introduce akcipher types to qapi
Message-ID: <YjsbwNhayhkVJ9G0@redhat.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <20220323024912.249789-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220323024912.249789-3-pizhenwei@bytedance.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: herbert@gondor.apana.org.au, mst@redhat.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 Lei He <helei.sig11@bytedance.com>
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

On Wed, Mar 23, 2022 at 10:49:08AM +0800, zhenwei pi wrote:
> From: Lei He <helei.sig11@bytedance.com>
> 
> Introduce akcipher types, also include RSA & ECDSA related types.
> 
> Signed-off-by: Lei He <helei.sig11@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  qapi/crypto.json | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 1ec54c15ca..d44c38e3b1 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -540,3 +540,89 @@
>    'data': { '*loaded': { 'type': 'bool', 'features': ['deprecated'] },
>              '*sanity-check': 'bool',
>              '*passwordid': 'str' } }
> +##
> +# @QCryptoAkcipherAlgorithm:

Should be named  QCryptoAkCipherAlgorithm

> +#
> +# The supported algorithms for asymmetric encryption ciphers
> +#
> +# @rsa: RSA algorithm
> +# @ecdsa: ECDSA algorithm
> +#
> +# Since: 7.0
> +##
> +{ 'enum': 'QCryptoAkcipherAlgorithm',
> +  'prefix': 'QCRYPTO_AKCIPHER_ALG',
> +  'data': ['rsa', 'ecdsa']}
> +
> +##
> +# @QCryptoAkcipherKeyType:

Should be named  QCryptoAkCipherKeyType

> +#
> +# The type of asymmetric keys.
> +#
> +# Since: 7.0
> +##
> +{ 'enum': 'QCryptoAkcipherKeyType',
> +  'prefix': 'QCRYPTO_AKCIPHER_KEY_TYPE',
> +  'data': ['public', 'private']}
> +
> +##
> +# @QCryptoRsaHashAlgorithm:
> +#
> +# The hash algorithm for RSA pkcs1 padding algothrim
> +#
> +# Since: 7.0
> +##
> +{ 'enum': 'QCryptoRsaHashAlgorithm',
> +  'prefix': 'QCRYPTO_RSA_HASH_ALG',
> +  'data': [ 'md2', 'md3', 'md4', 'md5', 'sha1', 'sha256', 'sha384', 'sha512', 'sha224' ]}

We already have QCryptoHashAlgorithm and I don't see the
benefit in duplicating it here.

We don't have md2, md3, and md4 in QCryptoHashAlgorithm, but
that doesn't look like a real negative as I can't imagine
those should be used today.

> +##
> +# @QCryptoRsaPaddingAlgorithm:
> +#
> +# The padding algorithm for RSA.
> +#
> +# @raw: no padding used
> +# @pkcs1: pkcs1#v1.5
> +#
> +# Since: 7.0
> +##
> +{ 'enum': 'QCryptoRsaPaddingAlgorithm',
> +  'prefix': 'QCRYPTO_RSA_PADDING_ALG',
> +  'data': ['raw', 'pkcs1']}
> +
> +##
> +# @QCryptoCurveId:

Should be named  QCryptoCurveID

> +#
> +# The well-known curves, referenced from https://csrc.nist.gov/csrc/media/publications/fips/186/3/archive/2009-06-25/documents/fips_186-3.pdf
> +#
> +# Since: 7.0
> +##
> +{ 'enum': 'QCryptoCurveId',
> +  'prefix': 'QCRYPTO_CURVE_ID',
> +  'data': ['nist-p192', 'nist-p224', 'nist-p256', 'nist-p384', 'nist-p521']}


> +
> +##
> +# @QCryptoRsaOptions:

This should be named  QCryptoAkCipherOptionsRSA

> +#
> +# Specific parameters for RSA algorithm.
> +#
> +# @hash-algo: QCryptoRsaHashAlgorithm
> +# @padding-algo: QCryptoRsaPaddingAlgorithm
> +#
> +# Since: 7.0
> +##
> +{ 'struct': 'QCryptoRsaOptions',
> +  'data': { 'hash-algo':'QCryptoRsaHashAlgorithm',
> +            'padding-algo': 'QCryptoRsaPaddingAlgorithm'}}

Our naming convention is  'XXX-alg' rather than 'XXX-algo'.

> +
> +##
> +# @QCryptoEcdsaOptions:

This should be named  QCryptoAkCipherOptionsECDSA

> +#
> +# Specific parameter for ECDSA algorithm.
> +#
> +# @curve-id: QCryptoCurveId
> +#
> +# Since: 7.0
> +##
> +{ 'struct': 'QCryptoEcdsaOptions',
> +  'data': { 'curve-id': 'QCryptoCurveId' }}

Having these two structs standalone looks wrong to me. I suspect that
callers will need to be able to conditionally pass in either one, and
so require the API to use a discriminated union

  { 'union': 'QCryptoAkCipherOptions'
    'base': { 'algorithm': 'QCryptoAkCipherAlgorithm' },
    'discriminator': 'algorithm',
    'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' ,
              'ecdsa': 'QCryptoAkCipherOptionsECDSA' } }


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
