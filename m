Return-Path: <SRS0=D/xy=H6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC248C433E0
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:27:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6725E64E54
	for <virtualization@archiver.kernel.org>; Sun, 28 Feb 2021 21:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6725E64E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2012B430B2;
	Sun, 28 Feb 2021 21:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0JYUFWn70NLt; Sun, 28 Feb 2021 21:27:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1ADD43016;
	Sun, 28 Feb 2021 21:27:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4FFC000A;
	Sun, 28 Feb 2021 21:27:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F6CBC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 100A183DD6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IjcJqCEg9V7b
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:27:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59AC983DCC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 21:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614547649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8Erxl2uAhVRjyIZZpSw14ya09f39S8gw2UbjCw0S0w=;
 b=L5ehP8Y9cQhmOOx6QiQSSQGB+tZK+dGanqKHRw7koB1oe7YYcGKTi7pjwkXLifdATlvB22
 VSO0edHkoaA4RTSNv3YgSDYHChv7orqnWee9dy8ct3l/wPNhfOnN59RWlKSacNkYMpo0pP
 qop+Sbw3+b7ia0tdYU4Fm7gs7PvElv0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-qInFYp6WMnGYXsXtsPrf7g-1; Sun, 28 Feb 2021 16:27:27 -0500
X-MC-Unique: qInFYp6WMnGYXsXtsPrf7g-1
Received: by mail-ej1-f70.google.com with SMTP id v10so5637837ejh.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 13:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h8Erxl2uAhVRjyIZZpSw14ya09f39S8gw2UbjCw0S0w=;
 b=WzlBpRSzQV8sypijozwH9CQp3yxkaRbOMnFa6p9gIWg9YcfkCDFJO2k7XcgqERx+k9
 ee4Ou+91mlJVLSDmkKipXPC8HnfdojlzY72s3j5ukQF8qBiDlG9uQuxccEOnq2Vbmv3W
 s6HA2NZcoV9dWKIJ1jMFh0Na8C782OJQxP0/EH6Rs1kzMvS0Lz6GAI7IEbfw0lLjXPmJ
 yKk6HNwHriEpDhdi+Zw5FewoyWmzF7qgNDhiiodWoE3YmJZz6GcSreAyS91sFDyCrktY
 qGF1oB1mdsq127jPRr1Ogyx10t7hLaJWgzLC3WgxBsdsd5Djoo96RyU9Q9lksoPgi3Dz
 CGKA==
X-Gm-Message-State: AOAM531RYyZWn8qesYuvLlbaKWYPMjbL+ZSdTPWgKH2IiJSV/Psj5D/L
 OaSeoubTKCiC79Rs8HrUyH6/inEe39688QvqnH9K/I2HyEhmyvqfe5ylBxSoWjot/mLSOPfPJ33
 OqrCckhTAU1oj+lbQ8wCrqTdyU5Fcx3s4EdlgQ8zCjQ==
X-Received: by 2002:a05:6402:50c8:: with SMTP id
 h8mr13170597edb.360.1614547646402; 
 Sun, 28 Feb 2021 13:27:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ6jCc9+dU7zV1WxCqoV1CE3zGmJfGpzvUi/N9qj2WdyBA/tM4wl7SoqLgRgWmy6Sdh81JZQ==
X-Received: by 2002:a05:6402:50c8:: with SMTP id
 h8mr13170588edb.360.1614547646299; 
 Sun, 28 Feb 2021 13:27:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id cq20sm12388210edb.18.2021.02.28.13.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Feb 2021 13:27:25 -0800 (PST)
Date: Sun, 28 Feb 2021 16:27:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210228162604-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <3e833db8-e132-0b00-34d0-7559bab10123@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3e833db8-e132-0b00-34d0-7559bab10123@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com, linux-kernel@vger.kernel.org
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

On Thu, Feb 25, 2021 at 04:56:42PM -0800, Si-Wei Liu wrote:
> 
> Hi Michael,
> 
> Are you okay to live without this ioctl for now? I think QEMU is the one
> that needs to be fixed and will have to be made legacy guest aware. I think
> the kernel can just honor the feature negotiation result done by QEMU and do
> as what's told to.Will you agree?
> 
> If it's fine, I would proceed to reverting commit fe36cbe067 and related
> code in question from the kernel.
> 
> Thanks,
> -Siwei


Not really, I don't see why that's a good idea.  fe36cbe067 is the code
checking MTU before FEATURES_OK. Spec explicitly allows that.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
