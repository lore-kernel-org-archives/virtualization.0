Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E37C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 10:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2442A40346;
	Tue, 20 Dec 2022 10:25:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2442A40346
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F8AMLL4b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvT7UtVLaRhB; Tue, 20 Dec 2022 10:25:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 43C0240354;
	Tue, 20 Dec 2022 10:25:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43C0240354
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0973DC0035;
	Tue, 20 Dec 2022 10:25:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5C9EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96B4340354
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96B4340354
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ztcfehMmf_Wu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:25:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85CD840346
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85CD840346
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671531913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFprmyhyXtWWl/GWswLwnRk9bAltqimW1rgZ5muozxA=;
 b=F8AMLL4b/EfAj743dPslBC052qh6uvxS5QURe6eODp4JErVseJA9Qvti+d14M3TWy0WQ/k
 sP7zIMWfZ6oA33+GopZA2QE70XQar8ZbgaB6VkOJkw9ya5eLNxP4y8RCy2lrL5KrRLUr4l
 S2h7MuTdcbxaKeKwkiHQD58QrKZWhpw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-TY0Olpg1O1K_r6BKQhvpow-1; Tue, 20 Dec 2022 05:25:12 -0500
X-MC-Unique: TY0Olpg1O1K_r6BKQhvpow-1
Received: by mail-qk1-f200.google.com with SMTP id
 o13-20020a05620a2a0d00b006cf9085682dso9113067qkp.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 02:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sFprmyhyXtWWl/GWswLwnRk9bAltqimW1rgZ5muozxA=;
 b=QFndphdmMyFGCGI15JO/5/q98H2oArgptlVD4Caw2C2+zTuRyC4EnZCG3XvVXh+H2z
 efKDU+0VfjxKv/o/wrEj71dAYlZkPL41o5baAovqnzv9nrzxqy7QkBM44+gq6j8dwSnd
 qcdbEpGF4kWzu3CxlJXPp7tBtUe7Masydcuj+XYEOJJ8s1F5JOLCZfg3ACUWipf5pved
 FzrXgHCOdF/69t/+NsSq07popEM7tGv2JE5O/SWwekH1pXThaBVAFrjaBpSmDxQQTWcT
 13i2yQd58X3nloYxHx6ifNsfWA3WNhpKdNwiG7fO+sNuOlbfCGTrWw+BRc2usPWffFgN
 ufWg==
X-Gm-Message-State: ANoB5pmYeBUhXitM5l+HtgNpJU5LZd2mqq8J0+GBfDMPKwQ4wcTn9YWn
 HjuQGZU5drRtdeH7PaQv+DSLNa6KPl2C8QEacVnhVU3+JS8/1MSE/j6Dc1amDCCmmbzzeTP8ZH1
 YAeCN/JW9sqlbCOdBn/Nn2dwocGJVJerVzbnhMTD2LA==
X-Received: by 2002:ac8:5196:0:b0:3a8:2ccb:f55d with SMTP id
 c22-20020ac85196000000b003a82ccbf55dmr31369908qtn.33.1671531910849; 
 Tue, 20 Dec 2022 02:25:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5s5r8ee0zNepl2yTpSZkf9vUEHeFz4DqkBlyrZAPziMRft+VMGYHoUlkzApghdDwESVdTexw==
X-Received: by 2002:ac8:5196:0:b0:3a8:2ccb:f55d with SMTP id
 c22-20020ac85196000000b003a82ccbf55dmr31369889qtn.33.1671531910547; 
 Tue, 20 Dec 2022 02:25:10 -0800 (PST)
Received: from redhat.com ([37.19.199.118]) by smtp.gmail.com with ESMTPSA id
 a12-20020ac84d8c000000b003434d3b5938sm7346943qtw.2.2022.12.20.02.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 02:25:10 -0800 (PST)
Date: Tue, 20 Dec 2022 05:25:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Message-ID: <20221220052333-mutt-send-email-mst@kernel.org>
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <Y6F8dlRQbOzIvJff@debian.me>
 <bf9bd0ba-c703-1903-7df2-ac95dea0f3e8@collabora.com>
MIME-Version: 1.0
In-Reply-To: <bf9bd0ba-c703-1903-7df2-ac95dea0f3e8@collabora.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, kernel@collabora.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Dec 20, 2022 at 10:54:17AM +0100, Ricardo Ca=F1uelo wrote:
> Hi Bagas,
> =

> Thanks for the review, some comments below:
> =

> On 20/12/22 10:12, Bagas Sanjaya wrote:> On Tue, Dec 20, 2022 at 08:37:09=
AM +0100, Ricardo Ca=F1uelo wrote:
> > Describe the steps needed to fix both warnings above. I see in the diff=
 that:
> > =

> >    * move vq_callback_t() declaration above;
> >    * match entity type of virtio_config_ops; and
> >    * reformat @finalize_features description.
> =

> I wouldn't like to add redundant info in the commit message for
> such a trivial patch. The commit message describes _what_ the
> patch does. The _how_ is just as clear in the patch itself as in
> this description, IMO.

Yea it's overkill for this patch.

> > =

> > > Signed-off-by: Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com>
> > =

> > You need to add appropriate tags:
> > =

> > Link: https://lore.kernel.org/linux-next/20221220105956.4786852d@canb.a=
uug.org.au/
> > Fixes: 333723e8bc393d ("docs: driver-api: virtio: virtio on Linux")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> =

> Thanks for the tip although, actually, it's not that commit that
> needs to be fixed but the kerneldoc itself.

This doesn't matter I think, what Fixes tag does is tell tools
if you have commit A you want this one on top.

> The warnings were
> made visible after that commit but not introduced by it. I'll add
> the Reported-by tag in v2.
> =

> Cheers,
> Ricardo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
