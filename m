Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9622AC77B75
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 08:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1434D60FCB;
	Tue, 23 May 2023 08:19:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1434D60FCB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=evqu1e6G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P7rAf31ih3yl; Tue, 23 May 2023 08:19:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD96060F2B;
	Tue, 23 May 2023 08:19:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD96060F2B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B55EDC0035;
	Tue, 23 May 2023 08:19:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BECCCC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C27F60F4D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:19:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C27F60F4D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yNRhs0OolQk7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BA0B60E2D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BA0B60E2D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684829942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ae8mGv0Ht1mICe1mpOZqw1rMYYELaKJp80YX+MnZZqM=;
 b=evqu1e6GWnmFBBFskxxnSR1BsJVBESJDPYharOzaYHhRuhX6j0rJu85BOiHpwaWQHW0ocS
 98kUqWWnbuJMhYhzZnOt1bDxjsb9gZ9fhP9G9OjLMx11qZXJB1LGXDaoQGKEpqqk+tjOTR
 cM8GS/7vwmzDMCBlCTePiu/vPeoLTgs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Zmv7GPn-N4WmUFIem3FmiA-1; Tue, 23 May 2023 04:18:59 -0400
X-MC-Unique: Zmv7GPn-N4WmUFIem3FmiA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30940b01998so2569631f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684829938; x=1687421938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ae8mGv0Ht1mICe1mpOZqw1rMYYELaKJp80YX+MnZZqM=;
 b=Jou5rfpk08oh6Q+o45+Bz2MJTueUiHlFRoMqDWFRMl7ty5pSTVkxZbsKKvRE7p74P5
 yqeFVDno3uIYZ3GD55wO0KzFIQ5dph3KSBC+3BGljiVPveKu3LLs17tRz3d2R8XVgULY
 H5XLxv6ACW7SGDkBq4Df9BqlFW5npDfxnVHbS/jNJJI6etNWntTVvPlgmTO3Dt8f/rBE
 +w9p4m0rWrJuY6IhjH6nDuHgfhpwflg8r//rkj9JRgrp0K2nxiC4wrkJuFaTNRCvSJ56
 YRs3/EQvZhxLks28/ACQ6CgDnfILACAdIzsML5aS3ViOsxShvgaQZrV1VNhL8/csNahp
 FXSg==
X-Gm-Message-State: AC+VfDyYYQZl6kSzh5LHPgiwOoOvxHES29T+eKVdt6oyH7Isbv4sis4x
 IRreRgrtHCGcGqATfljlbZPBqgNG2yv8E+jk3aqPyW0Cl7g64c3nA8jtq+UEyiLFz5h3Mz5Xw4a
 ei+hl48BmLQiWuiq/UVxhwmiS7jOKcWWSx80E6yucY7+NBIq2ww==
X-Received: by 2002:adf:f784:0:b0:2ee:f77f:3d02 with SMTP id
 q4-20020adff784000000b002eef77f3d02mr9418523wrp.0.1684829938002; 
 Tue, 23 May 2023 01:18:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xt8f1DyYu0q2DbYrjjvU8n0acT98HmdYod49LU9jrPbozcfSmmZgH6SiesN0roJ41xcTs4w==
X-Received: by 2002:adf:f784:0:b0:2ee:f77f:3d02 with SMTP id
 q4-20020adff784000000b002eef77f3d02mr9418511wrp.0.1684829937654; 
 Tue, 23 May 2023 01:18:57 -0700 (PDT)
Received: from redhat.com ([2.52.20.68]) by smtp.gmail.com with ESMTPSA id
 j17-20020a5d6191000000b0030639a86f9dsm10203433wru.51.2023.05.23.01.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 01:18:57 -0700 (PDT)
Date: Tue, 23 May 2023 04:18:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: vhost stable branch
Message-ID: <20230523041714-mutt-send-email-mst@kernel.org>
References: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <c33bac87f0a2b2b5bc9402e5547c4c6099b7f93b.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Tue, May 23, 2023 at 07:16:58AM +0000, Dragos Tatulea wrote:
> Hi,
> 
> I am looking for the stable branch for vdpa fixes in the vhost tree [1]. There
> are 3 branches that seem identical: linux-next, test and vhost. linux-next seems
> to be -next branch. Which one would be the stable branch?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> 
> Thanks,
> Dragos

I don't publish one until I am ready to send patches to Linus.
Which should be today or tomorrow.

-- 
MSt

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
