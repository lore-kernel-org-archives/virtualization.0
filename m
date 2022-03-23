Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E1EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 15:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2DC561351;
	Wed, 23 Mar 2022 15:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nw7qvtP0f8TT; Wed, 23 Mar 2022 15:01:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7691660E6B;
	Wed, 23 Mar 2022 15:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE5FC0012;
	Wed, 23 Mar 2022 15:01:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FAA1C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67A2A61348
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h_9tsgiZJiDn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:01:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FC7460E6B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648047689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nV8tfFGM1AQ/P90Zz8juXEcegOc8r+b10AqC7hoVW0w=;
 b=HN6d8ijVhksAl4T1z2cKVRw4+Ak9Mk7w3dv9Xixjwe3Zt0TtQEjZvzJeUvp7lYvbE6e9sH
 HCnGvHvGZV+D90lvoKqBdDzvCqPH02SNyXfrfj2rD0y5bLJLS166+PD2yivnUD9eL3cd/n
 lei+CweZbo14Ln1qbMvg0+168bEAR80=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-JM6FYdXaO_29lV7-FHIALw-1; Wed, 23 Mar 2022 11:01:22 -0400
X-MC-Unique: JM6FYdXaO_29lV7-FHIALw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4A043838065;
 Wed, 23 Mar 2022 15:00:58 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B9ECC15D6F;
 Wed, 23 Mar 2022 15:00:56 +0000 (UTC)
Date: Wed, 23 Mar 2022 15:00:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v3 2/6] crypto-akcipher: Introduce akcipher types to qapi
Message-ID: <Yjs2JshB8ZASiHJT@redhat.com>
References: <20220323024912.249789-1-pizhenwei@bytedance.com>
 <20220323024912.249789-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220323024912.249789-3-pizhenwei@bytedance.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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

What were your intentions wrt  ecdsa - the nettle impl in this patch
series doesn't appear to actually support ecdsa. Are you intending to
add this in later versions of this patch series, or do it as separate
work at a later date ?


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
