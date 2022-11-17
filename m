Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE48C4332F
	for <virtualization@archiver.kernel.org>; Thu, 17 Nov 2022 16:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3146F40C63;
	Thu, 17 Nov 2022 16:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3146F40C63
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXniMMgc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DO_Dfsug1K-v; Thu, 17 Nov 2022 16:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B3AB3401B7;
	Thu, 17 Nov 2022 16:25:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3AB3401B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87588C0033;
	Thu, 17 Nov 2022 16:25:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D1DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 16:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F99041710
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 16:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F99041710
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MXniMMgc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HZBVJCgI3IjZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 16:25:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 424DC41612
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 424DC41612
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668702335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ddO8xSwm8AIeskUgBl2bXxV1BqhKg/yuCs+KcXuL1uo=;
 b=MXniMMgc0QOF9QkhO3n2JITEYeLhICfThAIQcRANjKT10wWKyUxUqDFa+F5s7dwJyaqW8G
 syg0ZXSyfcyq5hbpuqwr5F1zLN5DI++/VyeSIFYtF7Pjp7l23jzpY4vkKD6B9zvnf/ubkn
 A4lmbz181VKo+4sD11yJdk9Co9X6E+Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-yKi7nY_HOxyqCLJnow3jcQ-1; Thu, 17 Nov 2022 11:25:34 -0500
X-MC-Unique: yKi7nY_HOxyqCLJnow3jcQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 bb32-20020a05622a1b2000b003a56991a048so2097384qtb.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Nov 2022 08:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ddO8xSwm8AIeskUgBl2bXxV1BqhKg/yuCs+KcXuL1uo=;
 b=cRzgFkAqLcJ7a0m9jROxHbLH4w2EgTW4NVsb7UlDBDbKZPw5xA6DupbUIj/POMrdIK
 ZjWS0CkPPEobNHoOfMoRQYGcb4laL+abZcwPSuTXE9X9X0uKrUvPf6/xeYjiCGUW/Hee
 vWao5StWd8ZtZrRPp/kQyOSTzq0zbZvpmu/uZ8frBlHmp4uvr3c6TsQTNLyK+h0UZHRs
 xrW9RB52eBHCj0X4hBy57XC5Bpx7bKxClMtj2v55PxG4MOYLLBc2ok3YkwFXtm0tAH6q
 hG9XsNCawl/0OfJmxLqGeapAggP3gjnWJZksn+hrHyxliTEaib3Ep+KFO9zGNLdtrxzn
 RLhw==
X-Gm-Message-State: ANoB5pkuPltqpOm01SBUpdpWkd4hn3IPpfXCEBbhNyGWNgZEpIu/BaJu
 2ks4y9NIqxvRzyyxIW7Qc6WI+mgHB/kiPyj8oWpU1jfWChqtun/o5LJJfPVHtJPnbwgX9JM0NZD
 Ow1xuS7ByNu7W3MPnyap9XdJILv7iTD88408jk23Y1Q==
X-Received: by 2002:a05:620a:35a:b0:6fa:27f6:8338 with SMTP id
 t26-20020a05620a035a00b006fa27f68338mr2235548qkm.721.1668702334145; 
 Thu, 17 Nov 2022 08:25:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4lbhRxQJFiYUoLqm6KU1+0iM/S1YR+8DtldDn9LvHgzKEAKyeUS+7z4a7X6z6/x3CNsfZuRg==
X-Received: by 2002:a05:620a:35a:b0:6fa:27f6:8338 with SMTP id
 t26-20020a05620a035a00b006fa27f68338mr2235526qkm.721.1668702333898; 
 Thu, 17 Nov 2022 08:25:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 ge11-20020a05622a5c8b00b00342f8d4d0basm591430qtb.43.2022.11.17.08.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Nov 2022 08:25:33 -0800 (PST)
Date: Thu, 17 Nov 2022 17:25:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vdpa_sim_net: Offer VIRTIO_NET_F_STATUS
Message-ID: <20221117162527.yevc65p6q6hpwvmn@sgarzare-redhat>
References: <20221117155502.1394700-1-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221117155502.1394700-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Nov 17, 2022 at 04:55:02PM +0100, Eugenio P=E9rez wrote:
>VIRTIO_NET_S_LINK_UP is already returned in config reads since vdpasim
>creation, but the feature bit was not offered to the driver.
>
>Tested modifying VIRTIO_NET_S_LINK_UP and different values of "status"
>in qemu virtio-net options, using vhost_vdpa.
>
>Not considering as a fix, because there should be no driver trusting in
>this config read before the feature flag.
>
>Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
