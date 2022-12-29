Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B2C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 13:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE2958199D;
	Thu, 29 Dec 2022 13:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE2958199D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hhniMTIL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ayM_cRlULHR4; Thu, 29 Dec 2022 13:32:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7ACFB818AC;
	Thu, 29 Dec 2022 13:32:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7ACFB818AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44360C0033;
	Thu, 29 Dec 2022 13:32:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35B32C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2D8D40889
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:32:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2D8D40889
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hhniMTIL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oaSbojnt66kI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EBD2440882
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EBD2440882
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672320753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3Gyl83HskPgL5hX1kbaYaX02m6Jhq9koOzQ1xU8NY6A=;
 b=hhniMTILhVoPgr8ymPeuj90vs7vsu6djYoVcoQdlf+CVA2/xoU2sqc/R2gpaCe33uGETlI
 EyOU/+VkG3lyg6xmSdHirPy4x8e8vFzPcw5pu+J5k0JudSx+w5S6ZZgAXnVqt4//LimroJ
 mApStbMM8uKoekBr5WFBuEOPYBc5LhY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-_lX3HnkKN8WdrbwrtYcJUg-1; Thu, 29 Dec 2022 08:32:32 -0500
X-MC-Unique: _lX3HnkKN8WdrbwrtYcJUg-1
Received: by mail-wm1-f72.google.com with SMTP id
 l9-20020a7bc349000000b003d35aa4ed8eso4791907wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 05:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Gyl83HskPgL5hX1kbaYaX02m6Jhq9koOzQ1xU8NY6A=;
 b=Onxagl3VlGO5VW8u4nv7DkCgUvtmwqixoLTTZZB8yv2d3JKloi0aNQIV3SEJv9Uwwz
 /+8W7RmHJnVcqxasEq994/oEW+ww75P1oqPQ7f38xYTMx4Xm9XEx2KLXYrwyKSkigTWb
 cUlNpyKXWNDyLgFx6HoW+F/T7Bnf9Ov6OIRuRWVOGMWo6AXJn5lJP78XXBaWEI1oPb3H
 vWlT0FMFRVKRL+Hk1natBjW1c+1QxUJRgD+7UqkxlOL9SxqbBbGUFWi/5LaB2B2LA2CD
 oqU5Pf+u4B1WIl018ERLUAiK8PkEueB3T+2e7B+rbfGj2FLZieVbRLRyjsy9cbaEwHur
 9ZfQ==
X-Gm-Message-State: AFqh2krlxAW+kPZNd3UP4KrSAENfg6ZnpGy68AnBPkgFMD15rETdrtmp
 Q225XhHvVJ+Vfihy9Z+1aB/HIB4P8adG1HwUBroX0f6tbJS02o9k8JpAMTL1m2/xYcAB2BPHNsG
 eBY2bwWdAKW4E5umYVTrAnPaL0aB9ocl+XtR7WkE3qw==
X-Received: by 2002:adf:fa0b:0:b0:268:2971:465f with SMTP id
 m11-20020adffa0b000000b002682971465fmr17278258wrr.50.1672320751206; 
 Thu, 29 Dec 2022 05:32:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtGMZ92Nhp/KRKAeog2gE5PLTPwLYe2ogYIsKSOp+1I+xgWlTgqxo5XjveoIKRonsjRNzFKFw==
X-Received: by 2002:adf:fa0b:0:b0:268:2971:465f with SMTP id
 m11-20020adffa0b000000b002682971465fmr17278253wrr.50.1672320750990; 
 Thu, 29 Dec 2022 05:32:30 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 e2-20020adfe7c2000000b0024245e543absm17862623wrn.88.2022.12.29.05.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Dec 2022 05:32:30 -0800 (PST)
Date: Thu, 29 Dec 2022 08:32:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio: vdpa: explain the dependency of SNET_VDPA on HWMON
Message-ID: <20221229083155-mutt-send-email-mst@kernel.org>
References: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
 <CACGkMEtpYomDhJ+oKhXROA8NPMwWKvLfK2TQRZ30g=o_vW8cQw@mail.gmail.com>
 <CAJs=3_C7dGxs6jZjgOGK=gfL-aJh+GJKr5KPE3Q645621mxcWQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_C7dGxs6jZjgOGK=gfL-aJh+GJKr5KPE3Q645621mxcWQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Thu, Dec 29, 2022 at 02:13:57PM +0200, Alvaro Karsz wrote:
> Hi Michael,
> 
> Is this patch ok with you?
> Do you have any comments?

It's ok. I had to push everything out to next merge window
though. Sorry :(

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
