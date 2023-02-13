Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7062AC636CC
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E2128193E;
	Mon, 13 Feb 2023 12:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E2128193E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GzkwqNJb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPLQ49tZZeB0; Mon, 13 Feb 2023 12:26:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A05A981947;
	Mon, 13 Feb 2023 12:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A05A981947
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72F4CC0032;
	Mon, 13 Feb 2023 12:26:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66804C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4166481947
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:26:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4166481947
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qQzu3FoiFF11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:26:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 882128193E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 882128193E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676291179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYAi+KZbADlPRkjU5Qjf0pWYUfcTGnNZhSgKsO4qTic=;
 b=GzkwqNJbMXgu57c2WBw5UyW7BuzOEQffB60nGSZxeCJa0fsin8NNU2iMKJu32PeUwr0ege
 H/5W0mLLTluJj9/5TPY0F2nqiZw9f5b4l3LECb6ep27pO284UBqdHmuhbiFkDeT/Bfm7gi
 ECxM4OAYZaQ8khxg62dctFDH/eaFlCM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-SRUHfyQ6MoS4YbxjpA1R4g-1; Mon, 13 Feb 2023 07:26:18 -0500
X-MC-Unique: SRUHfyQ6MoS4YbxjpA1R4g-1
Received: by mail-ej1-f71.google.com with SMTP id
 qa17-20020a170907869100b0088ea39742c8so7542346ejc.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYAi+KZbADlPRkjU5Qjf0pWYUfcTGnNZhSgKsO4qTic=;
 b=J0fMiV8R0hIBnY45fy1t8evKNVVyVp0AfYytx/IeaE7EWsCEloCLw8kOzU1Mp9FG3M
 Ted+8tLCliNGrl9ndelth6vZMlYyoc+HmReDQwoDL6GObM7rR7+6uP/jDDqw8L/Za4kS
 fCYqJHZdUu/uEZfAf9tpQTrXXa1O35RCWU0+ngbhuolMtPXAOy0mj+T5cczImlmsZkpU
 yux0NO7nZiA/9RWmkV521/pOFtvS2MIejMXR2vAqhbXJMxa1rdkUyWn/zxJYrBxqCTDy
 o8u7+nlw7khUGjY7++6p+yhnsny1mA7EjXgar40WHcH9BSVPpU0Clej+fkaj0gKWuUGf
 iMQw==
X-Gm-Message-State: AO0yUKUT5r3Eff8QbYB2Ck7mU9Mkl9Mbettaz+uDpNqqIVN6D3j/3L/r
 99s5QQJxbe0+961MrEOUb+2AePL95Bj3la2KJ0DK6eDP/1wxHSxrnpdMFN98VEJHfhDW9CJrftj
 f3cA1xI9FDgv/P7ooSuXVFFKp61wEByYzNU5f0gEj/A==
X-Received: by 2002:a17:907:72d2:b0:8af:ef00:b853 with SMTP id
 du18-20020a17090772d200b008afef00b853mr10986423ejc.73.1676291177260; 
 Mon, 13 Feb 2023 04:26:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9D6+DyAHCli0gWTvlnEmn3aEja9HqsIfJ6Xv6OFZmnLVMJua5RhJODuIKRPOQ7jzKGIJB3tA==
X-Received: by 2002:a17:907:72d2:b0:8af:ef00:b853 with SMTP id
 du18-20020a17090772d200b008afef00b853mr10986408ejc.73.1676291177060; 
 Mon, 13 Feb 2023 04:26:17 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 b19-20020a17090636d300b0085d6bfc6201sm6727325ejc.86.2023.02.13.04.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:26:16 -0800 (PST)
Date: Mon, 13 Feb 2023 07:26:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Initialize CVQ iotlb spinlock
Message-ID: <20230213072516-mutt-send-email-mst@kernel.org>
References: <20230206122016.1149373-1-elic@nvidia.com>
 <20230213071855-mutt-send-email-mst@kernel.org>
 <570ab4b9-eed7-3c5a-400a-261a9a205b4f@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <570ab4b9-eed7-3c5a-400a-261a9a205b4f@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
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

On Mon, Feb 13, 2023 at 02:24:40PM +0200, Eli Cohen wrote:
> 
> On 13/02/2023 14:19, Michael S. Tsirkin wrote:
> > On Mon, Feb 06, 2023 at 02:20:16PM +0200, Eli Cohen wrote:
> > > Initialize itolb spinlock.
> > > 
> > > Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > threading was broken here but whatevs.
> What exactly do you mean by "threading was broken". Is it because I sent two
> unrelated fixes together appearing as patch 1/2 and 2/2?

exactly. if I see 2/2 I expect a thread so I can find 1/2
and preferably a cover letter explaining what unifies all
these patches.
If they are unrelated no need to number them.

> > 
> > > ---
> > >   drivers/vdpa/mlx5/core/resources.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > index 45ad41287a31..d5a59c9035fb 100644
> > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > @@ -233,6 +233,7 @@ static int init_ctrl_vq(struct mlx5_vdpa_dev *mvdev)
> > >   	if (!mvdev->cvq.iotlb)
> > >   		return -ENOMEM;
> > > +	spin_lock_init(&mvdev->cvq.iommu_lock);
> > >   	vringh_set_iotlb(&mvdev->cvq.vring, mvdev->cvq.iotlb, &mvdev->cvq.iommu_lock);
> > >   	return 0;
> > > -- 
> > > 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
