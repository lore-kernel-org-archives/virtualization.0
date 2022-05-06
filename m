Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F73C433F5
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 11:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0D04840A4;
	Fri,  6 May 2022 11:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XEPO9eipO4Zt; Fri,  6 May 2022 11:33:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7193C83415;
	Fri,  6 May 2022 11:33:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2451FC0039;
	Fri,  6 May 2022 11:33:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3C99C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 11:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8BD040BD0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 11:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U1EmDDBTkq04
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 11:33:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.133.74])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B847E40BBB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651836818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ucCpzTQkF8XhUkvL7+8cXDWEm9SjV8gZcvK7m79UBU=;
 b=Ub1hTqjHotADcLx3s7Iw9AbPT+M7KRXbQ5tOd2GiyGfH/yKEa8T4n4IbayBid36JGKUStq
 28TslEfu7dztzEdEhvAgQE9MBZLz2b00EXJddfh15nwKhOAEkLCC1GTDpgYHm109aAiAUz
 eMTf9YQR++wM3u3Di5d3k4h3SRo4W1g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-wL4K7KCBNAa6v-xgt5d5KA-1; Fri, 06 May 2022 07:33:37 -0400
X-MC-Unique: wL4K7KCBNAa6v-xgt5d5KA-1
Received: by mail-ej1-f72.google.com with SMTP id
 nb10-20020a1709071c8a00b006e8f89863ceso4202505ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 04:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1ucCpzTQkF8XhUkvL7+8cXDWEm9SjV8gZcvK7m79UBU=;
 b=TjxuYpFqLDFgH1s7LeUsUrXRRfjpY38vIvjS1oM5XSdetA9jJKvBhrbO8K2y/Q0zQR
 r35u/8Xt+6h5p8Md6Z7vPQwcJR8et+HQXlBMAY9haJ8YG0PMx79MO1boNevXJQ5VBEa5
 H8si+xRZT+06/ybQ6RweDS8stk/otlFLwF+j2W3hbCnHWD8TD709neF5FnyYPn+9M7a5
 fynzG47rkyKkFFfq2lCuJRXFHBsAC6fP5LgPd0TZs8y7IxpqBY+Y23+89C5dn5FhXafN
 EfzasRGKrQ90uMv+wSsq7KA7BzIQ/YZ5H5kBREE8zUNQlCqqWr8NUtsh8U0ACMDQRTYv
 7VYg==
X-Gm-Message-State: AOAM533OAGFq7rFMu2fuwjeY6580dPlG7RgraPmekQMsn1R0DhsHJ4oJ
 LJ56yu4hEBGmSemHo4sU9TYAR6htDTncHG8sFgAUAHhMzrcuXFIfAhAc07zLe23+WkN54Hn6mcl
 ccrZNzHtZ4MmGPPQLH5AL7cImYetsyWlyhtvLUXjxng==
X-Received: by 2002:a17:906:148a:b0:6f3:833d:5a0f with SMTP id
 x10-20020a170906148a00b006f3833d5a0fmr2560428ejc.49.1651836816382; 
 Fri, 06 May 2022 04:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWqNhgRcK629dCnuKAST3WbCl+p9Mce05cC+BHLm/aKmxrKARyEIXE+pvxtLSGIpCklwFmrA==
X-Received: by 2002:a17:906:148a:b0:6f3:833d:5a0f with SMTP id
 x10-20020a170906148a00b006f3833d5a0fmr2560103ejc.49.1651836811295; 
 Fri, 06 May 2022 04:33:31 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107e:a6f7:2ba7:16e9:af89:1a95])
 by smtp.gmail.com with ESMTPSA id
 hy5-20020a1709068a6500b006f3ef214ddcsm1808167ejc.66.2022.05.06.04.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 04:33:30 -0700 (PDT)
Date: Fri, 6 May 2022 07:33:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: RE: [PATCH v5 5/5] virtio-crypto: enable retry for
 virtio-crypto-dev
Message-ID: <20220506073316-mutt-send-email-mst@kernel.org>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-6-pizhenwei@bytedance.com>
 <ad61b1ae4bd145eaa18fc28696e9502a@huawei.com>
 <48c9b073-0b03-5769-633b-5b668cea6fa4@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <48c9b073-0b03-5769-633b-5b668cea6fa4@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>
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

On Fri, May 06, 2022 at 05:55:33PM +0800, zhenwei pi wrote:
> On 5/6/22 17:34, Gonglei (Arei) wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> > > Sent: Thursday, May 5, 2022 5:24 PM
> > > To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> > > Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
> > > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > > linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
> > > pizhenwei@bytedance.com; davem@davemloft.net
> > > Subject: [PATCH v5 5/5] virtio-crypto: enable retry for virtio-crypto-dev
> > > 
> > > From: lei he <helei.sig11@bytedance.com>
> > > 
> > > Enable retry for virtio-crypto-dev, so that crypto-engine can process
> > > cipher-requests parallelly.
> > > 
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Gonglei <arei.gonglei@huawei.com>
> > > Signed-off-by: lei he <helei.sig11@bytedance.com>
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > >   drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> > > b/drivers/crypto/virtio/virtio_crypto_core.c
> > > index 60490ffa3df1..f67e0d4c1b0c 100644
> > > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > > @@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
> > >   		spin_lock_init(&vi->data_vq[i].lock);
> > >   		vi->data_vq[i].vq = vqs[i];
> > >   		/* Initialize crypto engine */
> > > -		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
> > > +		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true,
> > > NULL, 1,
> > > +						virtqueue_get_vring_size(vqs[i]));
> > 
> > Here the '1' can be 'true' too.
> > 
> > Sure, you can add
> > 
> > Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> > 
> > Regards,
> > -Gonglei
> > 
> > >   		if (!vi->data_vq[i].engine) {
> > >   			ret = -ENOMEM;
> > >   			goto err_engine;
> > > --
> > > 2.20.1
> > 
> 
> Thanks to Lei!
> 
> Hi, Michael
> I would appreciate it if you could apply this minor change, or I send the v6
> series, which one do you prefer?
> 
> -- 


send v6 with acks and change pls

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
