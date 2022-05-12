Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9764C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 09:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 389AB40092;
	Thu, 12 May 2022 09:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrTjADMcae4B; Thu, 12 May 2022 09:46:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2723B4004A;
	Thu, 12 May 2022 09:46:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6A1BC0039;
	Thu, 12 May 2022 09:46:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0833C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A02D3419AD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVwAQZOpFAwc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:46:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E8A5419A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652348811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z3DCHxCc1W7wV9sOESsYGyuIRr3xoZq2O3IVeKMznC8=;
 b=dbid0zkbrNl6x10SMkTZcPdmQHzfPd2Vf2UG9Dj/GX2W1XqVFNUSApGkQRJOpaFlW3NRJt
 DjjicLAllNz1qfLOqPAaK1/PBg5HzZIdRJ1zZ57TLAsPNOM6ddId7esow5EUzWo2faazJ8
 +Wj2XRlGMfs/uOV54yh6bRRU0mIQg1U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-Bo3L2KwPPAuu7ErKgSKZtg-1; Thu, 12 May 2022 05:46:48 -0400
X-MC-Unique: Bo3L2KwPPAuu7ErKgSKZtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECBAF38349BC;
 Thu, 12 May 2022 09:46:47 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DB04112131E;
 Thu, 12 May 2022 09:46:35 +0000 (UTC)
Date: Thu, 12 May 2022 10:46:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v5 4/9] crypto: add ASN.1 DER decoder
Message-ID: <YnzXefo1tcJ9wbJ9@redhat.com>
References: <20220428135943.178254-1-pizhenwei@bytedance.com>
 <20220428135943.178254-5-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220428135943.178254-5-pizhenwei@bytedance.com>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: helei.sig11@bytedance.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org
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

On Thu, Apr 28, 2022 at 09:59:38PM +0800, zhenwei pi wrote:
> From: Lei He <helei.sig11@bytedance.com>
> 
> Add an ANS.1 DER decoder which is used to parse asymmetric
> cipher keys
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> Signed-off-by: lei he <helei.sig11@bytedance.com>
> ---
>  crypto/der.c                 | 190 +++++++++++++++++++++++
>  crypto/der.h                 |  82 ++++++++++
>  crypto/meson.build           |   1 +
>  tests/unit/meson.build       |   1 +
>  tests/unit/test-crypto-der.c | 290 +++++++++++++++++++++++++++++++++++
>  5 files changed, 564 insertions(+)
>  create mode 100644 crypto/der.c
>  create mode 100644 crypto/der.h
>  create mode 100644 tests/unit/test-crypto-der.c
> 
> diff --git a/crypto/der.c b/crypto/der.c
> new file mode 100644
> index 0000000000..7907bcfd51
> --- /dev/null
> +++ b/crypto/der.c
> @@ -0,0 +1,190 @@
> +/*
> + * QEMU Crypto ASN.1 DER decoder
> + *
> + * Copyright (c) 2022 Bytedance
> + * Author: lei he <helei.sig11@bytedance.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include <stdint.h>
> +#include <stddef.h>

These should both be replaced by

  #include "qemu/osdep.h"

otherwise this fails to build for Mingw targets


> +static int qcrypto_der_invoke_callback(DERDecodeCb cb, void *ctx,
> +                                       const uint8_t *value, size_t vlen,
> +                                       Error **errp)
> +{
> +    if (!cb) {
> +        return 0;
> +    }
> +
> +    return cb(ctx, value, vlen, errp);
> +}
> +
> +static int qcrypto_der_extract_definite_data(const uint8_t **data, size_t *dlen,
> +                                             DERDecodeCb cb, void *ctx,
> +                                             Error **errp)
> +{
> +    const uint8_t *value;
> +    size_t vlen = 0;
> +    uint8_t byte_count = qcrypto_der_cut_byte(data, dlen);
> +
> +    /* short format of definite-length */
> +    if (!(byte_count & QCRYPTO_DER_SHORT_LEN_MASK)) {
> +        if (byte_count > *dlen) {
> +            error_setg(errp, "Invalid content length: %u", byte_count);
> +            return -1;
> +        }
> +
> +        value = *data;
> +        vlen = byte_count;
> +        qcrypto_der_cut_nbytes(data, dlen, vlen);
> +
> +        if (qcrypto_der_invoke_callback(cb, ctx, value, vlen, errp) != 0) {
> +            return -1;
> +        }
> +        return vlen;
> +    }
> +
> +    /* Ignore highest bit */
> +    byte_count &= ~QCRYPTO_DER_SHORT_LEN_MASK;
> +
> +    /*
> +     * size_t is enough to store the value of length, although the DER
> +     * encoding standard supports larger length.
> +     */
> +    if (byte_count > sizeof(size_t)) {
> +        error_setg(errp, "Invalid byte count of content length: %u",
> +                   byte_count);
> +        return -1;
> +    }

> +
> +    if (*dlen < byte_count) {

Can you flip this to   'byte_count > *dlen' so that the ordering
is consistent with the rest of the checks in this method.


> +        error_setg(errp, "Invalid content length: %u", byte_count);
> +        return -1;
> +    }
> +    while (byte_count--) {
> +        vlen <<= 8;
> +        vlen += qcrypto_der_cut_byte(data, dlen);
> +    }
> +
> +    if (vlen > *dlen) {
> +        error_setg(errp, "Invalid content length: %lu", vlen);
> +        return -1;
> +    }
> +
> +    value = *data;
> +    qcrypto_der_cut_nbytes(data, dlen, vlen);
> +
> +    if (qcrypto_der_invoke_callback(cb, ctx, value, vlen, errp) != 0) {
> +        return -1;
> +    }
> +    return vlen;
> +}



> diff --git a/crypto/der.h b/crypto/der.h
> new file mode 100644
> index 0000000000..aaa0e01969
> --- /dev/null
> +++ b/crypto/der.h
> @@ -0,0 +1,82 @@

> +#ifndef QCRYPTO_ASN1_DECODER_H
> +#define QCRYPTO_ASN1_DECODER_H
> +
> +#include "qemu/osdep.h"

osdep.h should always be in the .c file

> +#include "qapi/error.h"
> +
> +/* Simple decoder used to parse DER encoded rsa keys. */
> +
> +/**
> + *  @opaque: user context.
> + *  @value: the starting address of |value| part of 'Tag-Length-Value' pattern.
> + *  @vlen: length of the |value|.
> + *  Returns: 0 for success, any other value is considered an error.
> + */
> +typedef int (*DERDecodeCb) (void *opaque, const uint8_t *value,
> +                            size_t vlen, Error **errp);

Could you call this one   'QCryptoDERDecodeCb)'

> +
> +/**
> + * der_decode_int:

Needs updating for the new func name

> + * @data: pointer to address of input data
> + * @dlen: pointer to length of input data
> + * @cb: callback invoked when decode succeed, if cb equals NULL, no
> + * callback will be invoked
> + * @opaque: parameter passed to cb
> + *
> + * Decode integer from DER-encoded data.
> + *
> + * Returns: On success, *data points to rest data, and *dlen
> + * will be set to the rest length of data, if cb is not NULL, must
> + * return 0 to make decode success, at last, the length of the data
> + * part of the decoded INTEGER will be returned. Otherwise, -1 is
> + * returned.
> + */
> +int qcrypto_der_decode_int(const uint8_t **data,
> +                           size_t *dlen,
> +                           DERDecodeCb cb,
> +                           void *opaque,
> +                           Error **errp);
> +
> +/**
> + * der_decode_seq:

Likewise needs updating

> + *
> + * Decode sequence from DER-encoded data, similar with der_decode_int.
> + *
> + * @data: pointer to address of input data
> + * @dlen: pointer to length of input data
> + * @cb: callback invoked when decode succeed, if cb equals NULL, no
> + * callback will be invoked
> + * @opaque: parameter passed to cb
> + *
> + * Returns: On success, *data points to rest data, and *dlen
> + * will be set to the rest length of data, if cb is not NULL, must
> + * return 0 to make decode success, at last, the length of the data
> + * part of the decoded SEQUENCE will be returned. Otherwise, -1 is
> + * returned.
> + */
> +int qcrypto_der_decode_seq(const uint8_t **data,
> +                           size_t *dlen,
> +                           DERDecodeCb cb,
> +                           void *opaque,
> +                           Error **errp);
> +
> +#endif  /* QCRYPTO_ASN1_DECODER_H */


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
