Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94831C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 16:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2541D81456;
	Mon, 19 Dec 2022 16:40:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2541D81456
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLLfupRA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9fOAK_zezzq; Mon, 19 Dec 2022 16:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA4E780A81;
	Mon, 19 Dec 2022 16:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA4E780A81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C936C0032;
	Mon, 19 Dec 2022 16:40:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8235C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 16:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3268405A7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 16:40:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3268405A7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLLfupRA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 398rB-KfUDk6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 16:40:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E60C405A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E60C405A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671468038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=alI80azai2J5zn//yXaYO+UiKyXyCQg9u2KyOPNuKXg=;
 b=KLLfupRAUsMGYFUlEQZ+iCJuEep2ZYVX8oG+1NlrJ54/meCk+afA7+442Wy6n/FSJy5JTL
 l7WMVEieObyWx/Q+AFkMY5GZe1bRRyTry3WEHa7JyZeeqSD9XzBSW4hj2cUjDv0ggw5uYQ
 +np1JHBJCMVxK+ShEzPM5x01VxME1Fo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-g7sXleU3NDuV_9NBT9vuEg-1; Mon, 19 Dec 2022 11:40:36 -0500
X-MC-Unique: g7sXleU3NDuV_9NBT9vuEg-1
Received: by mail-qk1-f199.google.com with SMTP id
 r6-20020a05620a298600b007025c3760d4so1073580qkp.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 08:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=alI80azai2J5zn//yXaYO+UiKyXyCQg9u2KyOPNuKXg=;
 b=mTytntyGGEvn/Ep6PWRvEd9ix/Z3th+HKw24gdON77PHh0ixhcWkLOL18lOWfaPXpb
 tE2jPfgn65NHjKFMfuNO3a3VxlGe+NqPocmZ7CHXrFEVPHchlcgxabCQoBp2mt46aqff
 2N72nk2HYm2Qy0fx+2zK0+Ef2DxFL9JM0mjeQt72O/LhUl1JP+gcl2diwh92ToEFjs2Z
 0uGLQJm1x/Qpuh+uJlK2Q01+BWRAv4kFvquzEU4fOdw03E0VFMb1mDexXsT/fG8wK0CG
 UdyDv09u91bZNHCCQjNgYk8SSSStLBr+F6ovljWPHQQlCMp86TJ963iV+OgACMtJ397A
 9WEg==
X-Gm-Message-State: ANoB5pklCxP7s8DAeUFkF9kgW9ldLm+dh2ogtiGiKWY43gV25wE270Ej
 2mLXiKLisZAhCqEavsc8D5bEOasZ3bhXIj/In8/DJnhxyHtxFImgoG7k0Zr8xSBstEtL54JdofU
 m+IR8gxAhV2+6RGmn1xw4fpKpVJfHVh/KAdubR+h+4Q==
X-Received: by 2002:a05:622a:4ccd:b0:3a5:ad81:8aff with SMTP id
 fa13-20020a05622a4ccd00b003a5ad818affmr58808996qtb.55.1671468034678; 
 Mon, 19 Dec 2022 08:40:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FrQraq3UtEHtW8UljHw+/l2F5pAMPXM6Tg5qBf60TCPkPzgq0iUeW3Hv7LHs6MbLbNG+5NA==
X-Received: by 2002:a05:622a:4ccd:b0:3a5:ad81:8aff with SMTP id
 fa13-20020a05622a4ccd00b003a5ad818affmr58808976qtb.55.1671468034444; 
 Mon, 19 Dec 2022 08:40:34 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 h19-20020ac85693000000b0039c7b9522ecsm6241119qta.35.2022.12.19.08.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 08:40:33 -0800 (PST)
Date: Mon, 19 Dec 2022 11:40:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221219114024-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <20221219054757-mutt-send-email-mst@kernel.org>
 <CAJs=3_B+NB9LuqDBw_1a_6mXGCP2rA6bsrxLuoQ6gWdEg-vscg@mail.gmail.com>
 <20221219060316-mutt-send-email-mst@kernel.org>
 <CAJs=3_Cq3ca=evn9J=mQT3ieF0wi2YVfjfgJ3Ykh-Adu7Fxujw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_Cq3ca=evn9J=mQT3ieF0wi2YVfjfgJ3Ykh-Adu7Fxujw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 virtualization@lists.linux-foundation.org
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

On Mon, Dec 19, 2022 at 01:32:22PM +0200, Alvaro Karsz wrote:
> Ok,
> 
> > can be patch on top ...
> 
> Just to be sure,  you mean here to create a new patch adding a comment
> to the kconfig file, not a new version for this patch, right?

yes

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
