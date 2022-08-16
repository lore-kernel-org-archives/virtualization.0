Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB175C2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8693B60B0E;
	Tue, 16 Aug 2022 08:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8693B60B0E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtMNqOWi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dw7fbFn0H_Bg; Tue, 16 Aug 2022 08:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13D0D605A3;
	Tue, 16 Aug 2022 08:43:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13D0D605A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA10DC0033;
	Tue, 16 Aug 2022 08:43:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A4FCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 360264064C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 360264064C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gtMNqOWi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5riBtCW9uFWH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 493BE4063E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 493BE4063E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660639405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lQ8+OX5Xxy8OFHIKMeBXHvilaHMyPM9qIfwd9KvB9T8=;
 b=gtMNqOWiEL6TkHDwAkt9qCMq6GAZmLsiV+ntWAf+B1f+XfrrTx9ma98+kOYHv7zBVUX2W8
 czBvY7oTJGmQbC7Qk07g0uD22GGffqd1IturOD2ozgxMdG4XxhBmMbQUHCedz5lZK7ylHE
 68fSmFBDTe7aTW9hpX2UAFUVrXWsh1A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-GmwM8DnLN_eN3RX2H3v0Aw-1; Tue, 16 Aug 2022 04:43:24 -0400
X-MC-Unique: GmwM8DnLN_eN3RX2H3v0Aw-1
Received: by mail-wm1-f71.google.com with SMTP id
 y3-20020a1c4b03000000b003a537ef75c7so1790897wma.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 01:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=lQ8+OX5Xxy8OFHIKMeBXHvilaHMyPM9qIfwd9KvB9T8=;
 b=gt46Dvhr+3SWFd7mp4H3j4OR/LgxeaO0k9DefY9ol6WHsDG7OW9JtTzRKh0BABTIcd
 FfizPK/puXqGwDlnbz0yHJEiifWBs6JtRyXOsUEvUEo4DL3aUfIXhJLXz+4pL08JV2rf
 Vyk3GwGdV3BBtxNRRi8gGt3BXMHCNjNsDueSGvSmOj0rkbFufT+h91Unlce0kcyzGoEu
 GVSU7bJtMT5KK2MASm5E5vkJ3ImG9vaxAM2vhLpQMHbSTS4/1saJe43YeXcQ3xZcLYKx
 3SDescMzM4G3yFky83ILY0K+RFKp+255bvAkwFwcyWzpQpXrBMW1YKMQLopKbsXjftnv
 2/4Q==
X-Gm-Message-State: ACgBeo3YcTW+KguzvV5OTeQaB3dYKJIPQWSMEKxBgpmmVKzmYPTeLctH
 7yxV46mgDK1q9ytL7k1sdmIPdEWW0NYXol5d5z95TijNil4iHnCKGLk9uB5bP5DmzTVrvNnKEP9
 ZoAn2aZn5xyav1VnYcbOtg5l6arsZSY/OvOXKJBt0Ng==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id
 co26-20020a0560000a1a00b0021f10a30924mr11187429wrb.650.1660639403152; 
 Tue, 16 Aug 2022 01:43:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6cDAFFABxm0UC6KHn6bIybMZn2ombgjhUlsi97ISnZjBMZOQIY2aI+6s7bBLYzIu9Hq0irDw==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id
 co26-20020a0560000a1a00b0021f10a30924mr11187420wrb.650.1660639402874; 
 Tue, 16 Aug 2022 01:43:22 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 u8-20020a05600c19c800b003a5f3de6fddsm7193442wmq.25.2022.08.16.01.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 01:43:22 -0700 (PDT)
Date: Tue, 16 Aug 2022 04:43:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lei He <helei.sig11@bytedance.com>
Subject: Re: [PATCH] crypto-virtio: fix memory-leak
Message-ID: <20220816044118-mutt-send-email-mst@kernel.org>
References: <20220816075916.23651-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220816075916.23651-1-helei.sig11@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 pizhenwei@bytedance.com, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Aug 16, 2022 at 03:59:16PM +0800, Lei He wrote:
> From: lei he <helei.sig11@bytedance.com>
> 
> Fix memory-leak for virtio-crypto akcipher request, this problem is
> introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
> The leak can be reproduced and tested with the following script
> inside virtual machine:
> 
> #!/bin/bash
> 
> LOOP_TIMES=10000
> 
> # required module: pkcs8_key_parser, virtio_crypto
> modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
> modprobe virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m
> rm -rf /tmp/data
> dd if=/dev/random of=/tmp/data count=1 bs=230
> 
> # generate private key and self-signed cert
> openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem \
> 		-outform der -out cert.der  \
> 		-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@always.com"
> # convert private key from pem to der
> openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
> 
> # add key
> PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
> echo "priv key id = "$PRIV_KEY_ID
> PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
> echo "pub key id = "$PUB_KEY_ID
> 
> # query key
> keyctl pkey_query $PRIV_KEY_ID 0
> keyctl pkey_query $PUB_KEY_ID 0
> 
> # here we only run pkey_encrypt becasuse it is the fastest interface
> function bench_pub() {
> 	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
> }
> 
> # do bench_pub in loop to obtain the memory leak
> for (( i = 0; i < ${LOOP_TIMES}; ++i )); do
> 	bench_pub
> done
> 
> Signed-off-by: lei he <helei.sig11@bytedance.com>

trash below pls drop.


> # Please enter the commit message for your changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # An empty message aborts the commit.
> #
> # Date:      Tue Aug 16 11:53:30 2022 +0800
> #
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #   (use "git push" to publish your local commits)
> #
> # Changes to be committed:
> #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> #
> # Untracked files:
> #	cert.der
> #	key.der
> #	key.pem
> #
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # An empty message aborts the commit.
> #
> # Date:      Tue Aug 16 11:53:30 2022 +0800
> #
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #   (use "git push" to publish your local commits)
> #
> # Changes to be committed:
> #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> #
> # Untracked files:
> #	cert.der
> #	key.der
> #	key.pem
> #
> 
> # Please enter the commit message for your changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # An empty message aborts the commit.
> #
> # Date:      Tue Aug 16 11:53:30 2022 +0800
> #
> # On branch master
> # Your branch is ahead of 'origin/master' by 1 commit.
> #   (use "git push" to publish your local commits)
> #
> # Changes to be committed:
> #	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> #
> # Untracked files:
> #	cert.der
> #	key.der
> #	key.pem
> #
> ---

with commit log fixed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 2a60d0525cde..168195672e2e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
>  	struct virtio_crypto_akcipher_request *vc_akcipher_req,
>  	struct akcipher_request *req, int err)
>  {
> +	kfree(vc_akcipher_req->src_buf);
> +	kfree(vc_akcipher_req->dst_buf);
> +	vc_akcipher_req->src_buf = NULL;
> +	vc_akcipher_req->dst_buf = NULL;
>  	virtcrypto_clear_request(&vc_akcipher_req->base);
>  
>  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
