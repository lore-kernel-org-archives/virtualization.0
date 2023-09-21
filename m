Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D4CE7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 19:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80DA341FD7;
	Thu, 21 Sep 2023 19:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80DA341FD7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LHJOpx7r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id boEXc4fm6Xr5; Thu, 21 Sep 2023 19:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA64041F70;
	Thu, 21 Sep 2023 19:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA64041F70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90FA4C0039;
	Thu, 21 Sep 2023 19:17:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E12AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6881983CB7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:17:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6881983CB7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LHJOpx7r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHyP2Jpx3E-s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:17:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B635583CB3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:17:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B635583CB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695323854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4F18HtJIvSpDrNeybXoV/nJvscTALrB3uUN04vezK4=;
 b=LHJOpx7rX96KC6tdT/HBYX9q3ZduUk0YNv7ieleQ8XqZtDsFHxogs/Tbrfuan6ZqNeySVS
 oyb7c4P9IW6voEUlqCJn9KjL/jtLJpqKokeAiCaEE1a9LLUyOfM3dJoNaY+noFGFwbgB3l
 7UfXle4DSWr+kxR35b+rLl/qrQHA+b8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-xh1q-6tXNnmlKIoYhUkK5g-1; Thu, 21 Sep 2023 15:17:33 -0400
X-MC-Unique: xh1q-6tXNnmlKIoYhUkK5g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bffd454256so19287241fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695323851; x=1695928651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4F18HtJIvSpDrNeybXoV/nJvscTALrB3uUN04vezK4=;
 b=FitAd8HHqTI6sn2faVOCMo/XtMY6fTehe2w5ImHTbC6h0vB6lK+FeFM8eAWocTs7yJ
 qpwX5y4o+onUmizMDypT61zkXzwVz8SBfVamIaPbnwchT+2fg6x5DgOMpX8H/3bmG/Rk
 Wo7LCemC5c1SJm/eSIzqu5p+McYm5x43soGlVdCHB3WnlXUkl35y4uFpbX6VX1ExLW1A
 JH04uRHWVvmsCHLpBOJoU5sQBaESBMmAUzhXY06RHLhsKuM6noscq8B0AeYgdKzlNo1A
 6xdEpGk63mCtnFCe8jE2vy5glsU2c7Q2u3EGLBvmI9Jkj7gZgwZLnLEnFz3V9mHmnB+m
 zuPQ==
X-Gm-Message-State: AOJu0YziP/mPjoG302vcnEYRF+J09sG1U/Nh6/T0qT8TTtt8kYDUJnDE
 EuaI9J02sh//X1RBz4uVB+9zNKkkSJ40ifqZ1srs37rnijxOM3b5i/maHqgsfbPo6sRbf4Kp414
 d4c1yMfN+JnZ05HByloMmuTs34e12FaZVy8NWKV0j8w==
X-Received: by 2002:a05:6512:34c9:b0:503:333e:b387 with SMTP id
 w9-20020a05651234c900b00503333eb387mr5157548lfr.41.1695323850808; 
 Thu, 21 Sep 2023 12:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLO6U0t/NII2ddctv8iFsd2bsjD4CmnkBmvFzO3e8EHefAPfb77ysHKgmXf03wCOOWJP3JWg==
X-Received: by 2002:a05:6512:34c9:b0:503:333e:b387 with SMTP id
 w9-20020a05651234c900b00503333eb387mr5157528lfr.41.1695323850453; 
 Thu, 21 Sep 2023 12:17:30 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 e23-20020a056402089700b00530bc7cf377sm1218240edy.12.2023.09.21.12.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 12:17:29 -0700 (PDT)
Date: Thu, 21 Sep 2023 15:17:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921151325-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921183926.GV13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 03:39:26PM -0300, Jason Gunthorpe wrote:
> > What is the huge amount of work am I asking to do?
> 
> You are asking us to invest in the complexity of VDPA through out
> (keep it working, keep it secure, invest time in deploying and
> debugging in the field)

I'm asking you to do nothing of the kind - I am saying that this code
will have to be duplicated in vdpa, and so I am asking what exactly is
missing to just keep it all there. So far you said iommufd and
note I didn't ask you to add iommufd to vdpa though that would be nice ;)
I just said I'll look into it in the next several days.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
