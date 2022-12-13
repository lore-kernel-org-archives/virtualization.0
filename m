Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537CDC4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 15:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C85FB81E4E;
	Tue, 13 Dec 2022 15:06:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C85FB81E4E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rg4CVutK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8W5IIsvKX9Kl; Tue, 13 Dec 2022 15:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7051381E0D;
	Tue, 13 Dec 2022 15:06:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7051381E0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F93EC0033;
	Tue, 13 Dec 2022 15:06:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8BD8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24A3281E0D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:06:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24A3281E0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SiERrigauMWe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:06:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7142D81E49
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7142D81E49
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670943995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QIV38DnRgw5d8eTHW5XOjPjMdQVy/JxED3DRuC/h3DU=;
 b=Rg4CVutKaYIPhGJ5x524jy2+Y8lJH70UlmdoL8YSfhoEmqaAjs1hn4nMLaz4kR5734BrXU
 2+X/nG4AtWWCvYe2mdnti+TK+VtOZnVs/tNKt5qxiaaOhVLaXv//hQ2jQmzZrGATqBL8d5
 0fKwA4YaP4l+GO8ORH88UmBNWwDsewo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-388-wlqnLZppOL634D5VlUIQGQ-1; Tue, 13 Dec 2022 10:06:31 -0500
X-MC-Unique: wlqnLZppOL634D5VlUIQGQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 v19-20020ac25933000000b004b55ec28779so1270356lfi.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 07:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIV38DnRgw5d8eTHW5XOjPjMdQVy/JxED3DRuC/h3DU=;
 b=vIfkuoaWIlNFMA2Mq0Ax/wIsM8RZnJNk1RU1Ae7tb7NHHQjXe0IXXPPMBpMbgybRd2
 9Gz9X3lJKGIaemXet02VwhH/gK74vKLxnifK1JLA2Fpbz/+p9EfFzSR+hkPLoMAywz11
 U/bzB8ko8TZndgN87Ob8+a2rEBi+7zrr4s1Bne6VPIahkFlP8bnfYfHPQi8zt0a1Lm23
 v0yE0OdjKKnHPCLMahmzs5FA/YzSxrM0eePYazA32LK9qFCRoaN7GfoYLLyo8jzXOFcI
 XIwzTC9fPZyK2woe2XEKyFAvAL/YeVJUTWiZqeKYTDOs96ieVgRGDxlOx+XVveflzgDZ
 strg==
X-Gm-Message-State: ANoB5plIyesE0UWZ26ndQxYy0L13OJtcSktb+nhBIEuzFMz3k5wo+cTn
 XOKEH5rd0RwfhDFcohboLd/MWXTrp6+053xvfFHb5e9cGSNWx8xgfpW9kBwllpxI2naLrwAF5ij
 7TjWO1POa2bEoeItgbbFutiZ824bH8/If7ABUo7s+Qw==
X-Received: by 2002:a05:6512:25a4:b0:4b5:87da:8b35 with SMTP id
 bf36-20020a05651225a400b004b587da8b35mr6373272lfb.61.1670943988393; 
 Tue, 13 Dec 2022 07:06:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vgbEpA6HaWdsVzT53anYyRdWOSR1rrrHGJQiAPEgrJcsGLx4k6nbiisfQn77DohtXbaWyzg==
X-Received: by 2002:a05:6512:25a4:b0:4b5:87da:8b35 with SMTP id
 bf36-20020a05651225a400b004b587da8b35mr6373254lfb.61.1670943988122; 
 Tue, 13 Dec 2022 07:06:28 -0800 (PST)
Received: from redhat.com ([2.52.138.183]) by smtp.gmail.com with ESMTPSA id
 x13-20020a5d650d000000b002365730eae8sm14773wru.55.2022.12.13.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 07:06:27 -0800 (PST)
Date: Tue, 13 Dec 2022 10:06:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next v6] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221213100510-mutt-send-email-mst@kernel.org>
References: <20221213072549.1997724-1-bobby.eshleman@bytedance.com>
 <20221213102232.n2mc3y7ietabncax@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20221213102232.n2mc3y7ietabncax@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
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

On Tue, Dec 13, 2022 at 11:22:32AM +0100, Stefano Garzarella wrote:
> > +	if (len <= GOOD_COPY_LEN && !skb_queue_empty_lockless(&vvs->rx_queue)) {
> 
> Same here.
> 
> If there are no major changes to be made, I think the next version is the
> final ones, though we are now in the merge window, so net-next is closed
> [1], only RFCs can be sent [2].
> 
> I suggest you wait until the merge window is over (two weeks usually) to
> send the next version.

Nah, you never know, could be more comments. And depending on the timing
I might be able to merge it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
