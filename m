Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2B5E7E654
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 17:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20949824EF;
	Tue, 26 Sep 2023 17:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20949824EF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ejbf+u0p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHNS5FqfzmX5; Tue, 26 Sep 2023 17:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF147824E2;
	Tue, 26 Sep 2023 17:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF147824E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC25C0071;
	Tue, 26 Sep 2023 17:14:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF554C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 17:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88F3F40616
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 17:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88F3F40616
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ejbf+u0p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VVGoOt0zy2-Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 17:14:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C750840467
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 17:14:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C750840467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695748439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iSKGZWWS3kPHTKmKQnCV3dnxajnStM2eAQDnCvJgoU=;
 b=Ejbf+u0pucWbdzUTuDaMJb+dG8SHBAcvo0jpagkwu1A8t8dq+G0tlPNMxfZzFTmiNxkrmC
 UXkCKfRV6waBrcv3pvgujtjMY/+ztnKzQu046JDD4xu2JkBtYvsUBuqP4E0Q9NFNay95b9
 Kh8Ezl/rrIk3q6uGm5vfUIRgOvGERnk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-fOoRyyFcOAutEj4mVBc0WA-1; Tue, 26 Sep 2023 13:13:57 -0400
X-MC-Unique: fOoRyyFcOAutEj4mVBc0WA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae7663e604so644678066b.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 10:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695748436; x=1696353236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iSKGZWWS3kPHTKmKQnCV3dnxajnStM2eAQDnCvJgoU=;
 b=BO5mAx7nftAT7gZhw8B/A+0uj8TeVVgtXEVh7DLcsWxF0aQeaNN6oufs0HijEHnN4M
 HgGfpUDcVkr0RBKT8I76kqSjnFYRfoLDFiC3ZWeMYBgdxiYEDPjTF/SfINnafZAeA02Q
 0JUr954QpP+zqlbz/eS5DCP0gn33EFmJpeXGyeCc/nVKNqpDCalC6f7QHMKiQZWn4jkQ
 JwWPHYj5vduFFloFEcXj1QidTAqfpfLFc4x/N0sqomOODzbp5kYCkVCz6GPzz9FwmsqL
 ygNCtrDTtcGf91R13X++76yD9wQWGDeobrM0EXeCkb9/jq6ki9MafYQCzHIgKG2e0oEy
 6vVQ==
X-Gm-Message-State: AOJu0YxB+eCrYZ1DhiYmb3lCqS+dnvJp5Zc3Kj2oBha7DZi5mXpABTcT
 YFiNcnRZHUdx/7fk6CDbUdVmJ/pzBQF8GMeVpwue+56tqW9fPVkYquPD4958AN9KascqUV3GES0
 MFk1c4hfeBPMc0kgb1uoG11p0wRxqgeGvT/EHTdIdmg==
X-Received: by 2002:a17:906:1ce:b0:9ad:fcf8:e81b with SMTP id
 14-20020a17090601ce00b009adfcf8e81bmr9202357ejj.51.1695748436233; 
 Tue, 26 Sep 2023 10:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfk+7pxiRTHX+2QchxH8dV2phzuRQiv4H+N4VC9jMJ3K5sTKGvVgc9Wfj9N5+kDslbIIRD3Q==
X-Received: by 2002:a17:906:1ce:b0:9ad:fcf8:e81b with SMTP id
 14-20020a17090601ce00b009adfcf8e81bmr9202340ejj.51.1695748435941; 
 Tue, 26 Sep 2023 10:13:55 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 j8-20020a170906050800b009934855d8f1sm7978261eja.34.2023.09.26.10.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 10:13:55 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:13:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <20230926130521-mutt-send-email-mst@kernel.org>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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

On Tue, Sep 26, 2023 at 06:41:58PM +0200, Halil Pasic wrote:
> [..]
> > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
> >  	vc_akcipher_req->src_buf = NULL;
> >  	vc_akcipher_req->dst_buf = NULL;
> >  	virtcrypto_clear_request(&vc_akcipher_req->base);
> > -
> > +	local_bh_disable();
> >  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
> > +	local_bh_enable();
> 
> Thanks Gonglei!
> 
> I did this a quick spin, and it does not seem to be sufficient on s390x.
> Which does not come as a surprise to me, because 
> 
> #define lockdep_assert_in_softirq()                                     \
> do {                                                                    \
>         WARN_ON_ONCE(__lockdep_enabled                  &&              \
>                      (!in_softirq() || in_irq() || in_nmi()));          \
> } while (0)
> 
> will still warn because  in_irq() still evaluates to true (your patch
> addresses the !in_softirq() part).
> 
> I don't have any results on x86 yet. My current understanding is that the
> virtio-pci transport code disables interrupts locally somewhere in the
> call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
> and then x86 would be fine. But I will get that verified.
> 
> On the other hand virtio_airq_handler() calls vring_interrupt() with
> interrupts enabled. (While vring_interrupt() is called in a (read)
> critical section in virtio_airq_handler() we use read_lock() and
> not read_lock_irqsave() to grab the lock. Whether that is correct in
> it self (i.e. disregarding the crypto problem) or not I'm not sure right
> now. Will think some more about it tomorrow.) If the way to go forward
> is disabling interrupts in virtio-ccw before vring_interrupt() is
> called, I would be glad to spin a patch for that.
> 
> Copying Conny, as she may have an opinion on this (if I'm not wrong she
> authored that code).
> 
> Regards,
> Halil

On a related note, config change callback is also handled incorrectly
in this driver, it takes a mutex from interrupt context.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
