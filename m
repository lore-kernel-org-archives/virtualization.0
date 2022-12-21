Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3165DC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 06:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B443081F96;
	Wed, 21 Dec 2022 06:40:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B443081F96
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GEYWDeBX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKRUk3sOxyE8; Wed, 21 Dec 2022 06:40:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B4E381FD7;
	Wed, 21 Dec 2022 06:40:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B4E381FD7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAB2FC0077;
	Wed, 21 Dec 2022 06:40:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CB77C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28F616101D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28F616101D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GEYWDeBX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 20vL32UT3ay1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:40:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5238E60FD9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5238E60FD9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671604822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6GIXJfP6lLbkNCudO+mG156mH9R13EdyawfZqeVfjt4=;
 b=GEYWDeBX3MV4UHfWY57ShUrdOtxhtIeCXolVZUXezsu0xoNdG8/c/2wgU5pnSIlhmeRC18
 o89O5IzThuOKHR1Od4oRPwfyeCUHmOwg5a6fMRMzdcF0xWpRzP6wdRZDjXD12ha/MZGVHd
 Ufp140ZtI6bAGHdyczXlDOZObHvE2oA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-CwiVMWu-OUC7LvQnF2PJHw-1; Wed, 21 Dec 2022 01:40:21 -0500
X-MC-Unique: CwiVMWu-OUC7LvQnF2PJHw-1
Received: by mail-qv1-f71.google.com with SMTP id
 oo9-20020a056214450900b004cfdcb99fa5so8262344qvb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 22:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GIXJfP6lLbkNCudO+mG156mH9R13EdyawfZqeVfjt4=;
 b=ZU0M3bxsSxrOfSXk35i4zVR+gZb1vOIl/7qGf5PsKWV65/qtwW6sMThEhxys/XwXq5
 3xTTBM1drErzNHjBAngdSfa5tzSursBRdd3WnNcryFWCyp3d+5pXVglyH3LKWegRUcxK
 7dL9AmyCelMEZ4o1Ea0+d3eXj8B5S65dqeYfdwQBKIpCIxnFB8X2pCo9fZdmoah813Jx
 1G8+K3vOwceer4rP43544kCot/JYnnr9rC5TCRcnWjN7f+4Kf3vmIHc62wUfInwvQhZh
 g8fYInirVk+TyeqCs2+UYuWEv6O5Yn86elzuNJI57f8Uq6NluizZ8GV9gNNz4wDuGItl
 VbRQ==
X-Gm-Message-State: AFqh2kpnVLC5hui8GjOVUm18BslNu5kV4HwA/OnCP/L0AIvM0v8dSQkK
 mk+A3f2WVuB3IuNk7KMowUib/eDPvPkqaQqBpCcTPiumxeQGS8k6TZWBC0yrBKfbTNLGegG6PyK
 38QexVKd7gunAcqizeV+xBCuMi7msMvJxg+qi1kAyMQ==
X-Received: by 2002:ac8:7542:0:b0:3ab:28ea:d849 with SMTP id
 b2-20020ac87542000000b003ab28ead849mr890793qtr.10.1671604821279; 
 Tue, 20 Dec 2022 22:40:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvY5Z6Nk+cW9c4QcsX8MAS54V9yZ+Jd55Y6+e6sz97Dtit25nevBX+Xt+gWUMZeniF5ZgyfTA==
X-Received: by 2002:ac8:7542:0:b0:3ab:28ea:d849 with SMTP id
 b2-20020ac87542000000b003ab28ead849mr890776qtr.10.1671604821067; 
 Tue, 20 Dec 2022 22:40:21 -0800 (PST)
Received: from redhat.com ([37.19.199.117]) by smtp.gmail.com with ESMTPSA id
 t15-20020ac86a0f000000b0039cc64bcb53sm8589408qtr.27.2022.12.20.22.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 22:40:20 -0800 (PST)
Date: Wed, 21 Dec 2022 01:40:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
Message-ID: <20221221013907-mutt-send-email-mst@kernel.org>
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com>
 <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
 <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean Delvare <jdelvare@suse.com>, linux-pci@vger.kernel.org,
 llvm@lists.linux.dev, virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, bhelgaas@google.com,
 Guenter Roeck <linux@roeck-us.net>
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

On Tue, Dec 20, 2022 at 06:46:20PM +0200, Alvaro Karsz wrote:
> Hi Nathan,
> 
> > This does not appear to be a false positive but what was the intent
> > here? Should the local name variables increase their length or should
> > the buffer length be reduced?
> 
> You're right, the local name variables and snprintf argument don't match.
> Thanks for noticing.
> I think that we should increase the name variables  to be
> SNET_NAME_SIZE bytes long.
> 
> How should I proceed from here?
> Should I create a new version for this patch, or should I fix it in a
> follow up patch?
> 
> Thanks,
> Alvaro


Please post a follow-up ASAP. I can squash myself if I rebase.

Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
