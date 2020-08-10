Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D7C433DF
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 14:35:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9312E20771
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 14:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/i6tISk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9312E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CD38882FF;
	Mon, 10 Aug 2020 14:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WrdMvrmnMvMl; Mon, 10 Aug 2020 14:35:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DEF488353;
	Mon, 10 Aug 2020 14:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF030C013C;
	Mon, 10 Aug 2020 14:35:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9B6C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 14:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A81D888176
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 14:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mtcboS4ZSIrn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 14:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DAC3188175
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597070146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXWSa0571ciFu2t/WYhoCRkUSyhVOHJkVHffG1Nnkws=;
 b=h/i6tISk3Rrf1tQdM4Nl+DA8+WNUEJDPbTNN2pB5UD/LgvSzkpuXTLj6t8ZfANHx3jsq48
 4e9IEYipCPo51GKruM6XHVxtAfsW5EkcRy9oYvY/VIbK80bMh9DziQaTQN7RuLVqWuWSXL
 5jVKIHE55uZvnN+jij6nCdak0GuTuKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-fSvN_VWcMcC5g7HLnx3q1A-1; Mon, 10 Aug 2020 10:35:44 -0400
X-MC-Unique: fSvN_VWcMcC5g7HLnx3q1A-1
Received: by mail-wm1-f72.google.com with SMTP id h205so2941967wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 07:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dXWSa0571ciFu2t/WYhoCRkUSyhVOHJkVHffG1Nnkws=;
 b=F6VZZY5ikFIbQIL3QgvfCURpjeLhWlXf5IyriwBXHeELQ58iy73q3pDO2Gy6pHFkXj
 JifQgVGY4vixE+4AMoNcynpBA2UnpHyCBXkdDlg7xoJu2pUzn0j8BINXuMU4Zui0Tip6
 yqax38IYk8LRynIEGMUsH03IrXtN41l+G5QnhSS2A5ni5JuUzvsZxJyFWG8/tuGdLT0o
 ZB+I5uftMNt8yPbIKo6R1ornXFDDDlT3YRXjHSQjFy0ctThN6QDQdzrd/WckzwYdSyBh
 3pR8OHZdldXJSLsJC2P0hGuWR9WllnADvUsNlQQ+rbEhh3VNOZTNiRoL2EMl7oTf1QQ3
 OmMA==
X-Gm-Message-State: AOAM530rYd2u1+6953CXRHXejkxGK6t/PGFam9VLr1Se1AbZRRX7s0yb
 hOuvBq8YxVUhyYjUoongXnqg2YbmqlAosyGMt4e5KsYIT9RUHBtV4csp0QYtL3VHYY2YHLLolSK
 u1Wl9fc2IXg0iv04+bdEpvwXHBw4Cmab7dnQVJAfWAg==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr23385143wrp.44.1597070143563; 
 Mon, 10 Aug 2020 07:35:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsJrwNV1lKdihec0GG/tFTx2Ql3DBf0DtDHWJt9b3Ujf/23hQsf72YgGEndpIM647ySIAQDw==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr23385131wrp.44.1597070143428; 
 Mon, 10 Aug 2020 07:35:43 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id k10sm20742786wrm.74.2020.08.10.07.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 07:35:42 -0700 (PDT)
Date: Mon, 10 Aug 2020 10:35:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
Message-ID: <20200810103522-mutt-send-email-mst@kernel.org>
References: <20200808093241.GB115053@mwanda>
 <BN8PR12MB3425E1FCC3E20A04182640D2AB470@BN8PR12MB3425.namprd12.prod.outlook.com>
 <20200810103147.GJ1793@kadam>
MIME-Version: 1.0
In-Reply-To: <20200810103147.GJ1793@kadam>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Parav Pandit <parav@mellanox.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Eli Cohen <eli@mellanox.com>,
 Eli Cohen <elic@nvidia.com>
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

On Mon, Aug 10, 2020 at 01:31:47PM +0300, Dan Carpenter wrote:
> On Sun, Aug 09, 2020 at 06:34:04AM +0000, Eli Cohen wrote:
> > Acked-by: Eli Cohen <elic@nvidia.com>
> > 
> > BTW, vdpa_sim has the same bug.
> > 
> 
> I sent a patch for that on April 6.
> 
> [PATCH 2/2] vdpa: Fix pointer math bug in vdpasim_get_config()
> 
> Jason acked the patch but it wasn't applied.
> 
> regards,
> dan carpenter

Oh sorry. I'll drop my patch and queue yours then.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
