Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1949DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:47:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5FF60C4B
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB5FF60C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F0D3608DA;
	Wed, 13 Oct 2021 12:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mqrhLD73XFWJ; Wed, 13 Oct 2021 12:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 418FB605EE;
	Wed, 13 Oct 2021 12:47:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF8EC000F;
	Wed, 13 Oct 2021 12:47:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCD0C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F31F404D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orcwo-6o4A5b
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F8A1404E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634129226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wp+/d0F+qzlGdrrSoGXSKcXwbRm7uRB50CWJ1pV00sA=;
 b=QTfNvJnvYCHpzqE66sRusuz1zu12vlFMJtnztwxJHUwYBkzKknvA73NKrPHeLAR6PxCJTg
 2fxmvvWIR5fhtgBlTzAE95BoM6uDoBfkrPptCOyftCexUSTcji9m2zSfP/5ina8dZ921fx
 r/UCLKppOJOSg2SEdosYUbsOHpEX+W0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-QKJxkWlKPN-3vaTln4rj2Q-1; Wed, 13 Oct 2021 08:47:05 -0400
X-MC-Unique: QKJxkWlKPN-3vaTln4rj2Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 f1-20020a5d64c1000000b001611832aefeso1867307wri.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wp+/d0F+qzlGdrrSoGXSKcXwbRm7uRB50CWJ1pV00sA=;
 b=tWIpOtGn20c+0LWjuCquet55zQ1C7eJFia3ipcDDtupTivqIUovUMUTJAPNNPTQUOW
 IdLUiCkWLL+Mk1iGNSfhW1oGYpN3e9xpCCdrtPQA99mL3qHKmXi8abs3YPyIF5BYB5mh
 DW96Dc8NJKc8DpKqPHlFUSh6a0GcmI3g61+cu6iy7L2WMIigpFHEBVVOBDmt+1R1Kml8
 5jsFpyYe8KO8iQdvEd3WFNdYIQL0bQd3sjW8sG9wsnC5qpYdM8HFvAAJ9WUIhUHhrSC0
 pEgsjxBkVpu6xdKBSCVGMMm2ZktSnDv1/yS3BTXD7sqMNiE28iofol0w5PP8AegZS1qD
 vkQg==
X-Gm-Message-State: AOAM533a13s2WxzG0FKSw9xAOfcBU+4x8aCCX7KPun8qWNwZ1M2auYoq
 pHJ90WF9Yr9HZ+xxx/BknfRJULz70+JPlCMxZYlXbCszmMpxHHLpGb1wLtr5Kb1eXdeCJeWKpO+
 lT6kqYHrtrDZY+rVbOB57SsgL01fX2ko8rpr/hZnjdg==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12306415wmj.160.1634129224184; 
 Wed, 13 Oct 2021 05:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3bu0Nu2sTQ0+QNSDdqXyjCUIauFl76JolUN+8aoRczJi/YTb07iDFPZNwrmi/5HPNNvtB6A==
X-Received: by 2002:a7b:c258:: with SMTP id b24mr12306384wmj.160.1634129223978; 
 Wed, 13 Oct 2021 05:47:03 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id b190sm5299164wmd.25.2021.10.13.05.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:47:03 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:46:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013084640-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
 <20211013060923-mutt-send-email-mst@kernel.org>
 <96561e29-e0d6-9a4d-3657-999bad59914e@de.ibm.com>
 <20211013081836-mutt-send-email-mst@kernel.org>
 <20211013144408.2812d9bd.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211013144408.2812d9bd.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Xie Yongji <xieyongji@bytedance.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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

On Wed, Oct 13, 2021 at 02:44:08PM +0200, Halil Pasic wrote:
> On Wed, 13 Oct 2021 08:24:53 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > OK this looks good! How about a QEMU patch to make it spec compliant on
> > > > BE?  
> > > 
> > > Who is going to do that? Halil? you? Conny?  
> > 
> > Halil said he'll do it... Right, Halil?
> 
> I can do it but not right away. Maybe in a couple of weeks. I have some
> other bugs to hunt down, before proceeding to this. If somebody else
> wants to do it, I'm fine with that as well.
> 
> Regards,
> Halil

Couple of weeks is ok I think.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
