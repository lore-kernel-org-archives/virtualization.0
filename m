Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8340C433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 10:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F112641554;
	Mon, 28 Nov 2022 10:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F112641554
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dQofxjLX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4TRet0Xjxxcl; Mon, 28 Nov 2022 10:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0522E414CE;
	Mon, 28 Nov 2022 10:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0522E414CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDFD5C0033;
	Mon, 28 Nov 2022 10:58:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B53DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 564394018D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 564394018D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=dQofxjLX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jkZwoYVvOgRl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:58:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 724FA400D9
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 724FA400D9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:58:06 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 l39-20020a05600c1d2700b003cf93c8156dso8064043wms.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RJWW55YirRAop5qsW7MfjO2Cb/aqkPmNR9CcfbISB+E=;
 b=dQofxjLXnoc26i6nPlHarHAeQE6K5JdlUoYIAkYWqQ8OXVXhxrGTV0CsAzSp9FAFfc
 ljgf/9Z5HMDjT5FBdCeba0HMsdGRRUcITsxBBfxHvxrdvz1OBRvG7Pc8cy3yNY/ivjKm
 DkVNSkmq+PorGOWtELShs5PNDK5NTyTUlbQ/yAQP1KVme6tU24kh0jaJtUxU0mBtJHy3
 93wDB9IiAO6YRBk4zV1xntDX0jF8k6h3AyEQ5ol/bIKFtQiLif+b1bctn82MFVGYEO6R
 xgbD/zDRIbWvCPvO4xS6TRUNQYIjppGIMbBrqjD2EKDeboZ9xHFcWVdBZJTctIcyLns7
 7O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJWW55YirRAop5qsW7MfjO2Cb/aqkPmNR9CcfbISB+E=;
 b=OsYH7maHHktC2BCdNUWqykuod4Kp//B04W7CJQg3MeIiZtjEMvAQwXiVO8DvQM8CjP
 AMuh0UMmp7KGAO5jp0yReJEJmhJ7YQ27I4NFOnKLTI/vDyRLNfpDjFI2AgtgyVrwAFZd
 k513mL9lP/D+MBpMWxVL9Te4K/FkXFYlfKnA2HaRYU0yfy1YPFpzq22y48cf/xCdYVW+
 06CkgAVASRE9TUE2KwzhCWsmZsW2b+cHn9gdOcLn+k3BV7ERH2fxmtFQfb5yRRoK0+Sf
 m0ByPPzz0wnJHCOwgbY2R08ozkKoviADVAoCCQOTWkc9Zmbq1d7CoCqNVdSTHV5AO7O4
 Vx9Q==
X-Gm-Message-State: ANoB5pkN0kER1PZI80AoEKlL/F8G4pLS8nt3/bi8zKfBQEJKUORYZegW
 jJRZ1NpGI7/QiaVh5rrd1Ag=
X-Google-Smtp-Source: AA0mqf5IuTik8Ro64P5r5SVtIhAVcxG64UqWcuZ3jHH4R3pdS13JJ8pHu6w6RIoMm8uCUUUYLeF6ig==
X-Received: by 2002:a05:600c:5406:b0:3d0:21f6:43ec with SMTP id
 he6-20020a05600c540600b003d021f643ecmr26996220wmb.162.1669633084216; 
 Mon, 28 Nov 2022 02:58:04 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 j15-20020a5d452f000000b002416e383e1csm10601418wra.25.2022.11.28.02.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 02:58:03 -0800 (PST)
Date: Mon, 28 Nov 2022 13:58:00 +0300
From: Dan Carpenter <error27@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Message-ID: <Y4SUOPX2WRFiuB7n@kadam>
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128105312.3ajursuudvmysiie@sgarzare-redhat>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, harshit.m.mogalapalli@gmail.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
> On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
> > Add a limit to 'config->vq_num' which is user controlled data which
> > comes from an vduse_ioctl to prevent large memory allocations.
> > 
> > This is found using static analysis with smatch.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > v1->v2: Change title of the commit and description, add a limit to
> > 	vq_num.
> > 
> > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
> > Only compile and boot tested.
> > ---
> > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index 35dceee3ed56..31017ebc4d7c 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
> > 	if (config->config_size > PAGE_SIZE)
> > 		return false;
> > 
> > +	if (config->vq_num > 0xffff)
> 
> What about using U16_MAX here?

Where is the ->vq_num stored in a u16?  I looked for this but didn't
see it.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
