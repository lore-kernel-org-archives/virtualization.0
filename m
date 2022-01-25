Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1372C433EF
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 19:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B83E40487;
	Tue, 25 Jan 2022 19:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4cYmhwSvGnP; Tue, 25 Jan 2022 19:32:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C170840004;
	Tue, 25 Jan 2022 19:32:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6BFC0039;
	Tue, 25 Jan 2022 19:32:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B847C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:32:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68C7760AEF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bxc4U2Ox3Out
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:32:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9F8260AB5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643139171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ciPfMtAL50TWYFEZLNyqHSn6Da8We+lU53UsYq3iOGI=;
 b=VlIBwN+NQZyEPhm5GQrvRl32KbIGK0nM5njn8pjJvMz85FrsQe9gYRqBYz5BxJWR5n7EGM
 IvIfkHB4+bhNXOCIkeuuUuSIcMTqiDwQhVohs/S8yZDwHZ7EgTanIIbOm/a3P+ProoAXKT
 3RfN9TSpm3yAqxM6mOJf/9ed93yM/Q4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-QR12haWDN7uCWgRD0gG4Jg-1; Tue, 25 Jan 2022 14:32:49 -0500
X-MC-Unique: QR12haWDN7uCWgRD0gG4Jg-1
Received: by mail-ej1-f71.google.com with SMTP id
 q19-20020a1709064c9300b006b39291ff3eso3866745eju.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 11:32:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ciPfMtAL50TWYFEZLNyqHSn6Da8We+lU53UsYq3iOGI=;
 b=lxzhPb3oLnNl/GKA3xrCBGtRs2b4qI+r3G1l8a8MQT0A2XVP9SPvTbVVsuXKLMgLZ6
 V5zs0Qw57w01S86gML91na7zTYkzvXpiklajuFQ1t9DJJHiHHFIaSZkD28fsXZUmIUA6
 sTp1Z6tHYdxSAIgPGi2aKvCSYEHc+dDpFpqAw6tKT2Bs9/S1xp8lGQjhGwzTlvnUbHVu
 4Wr6AFkwpklq2FUJys/OYQnMjhWlrgiUkmQqysN84UMBVQs8xnZdz/GOCWCmrY6MDO6g
 TmcgSchyYTw6A1pVAXz4A0g8QlEMmdMtFWBsw6bFaSUJIBvSRDww8ztAoLUSk4qvhJmt
 WH4w==
X-Gm-Message-State: AOAM533kwIf9tNgKF2rTULy4B5drtBFUSaDvj+RWp/9WB/JCcc4B3l5q
 W9WT09T5X1XU1aO1ytIKKvtkK/3Pye5mNHnMi1fhJYxreRRtlLjueiX3ll5aVbT9rIB84eaxbFu
 fAHwPlF9zhk/7OTsLQMOteo2of9lSh3TU36FDceqjjw==
X-Received: by 2002:a05:6402:1104:: with SMTP id
 u4mr22299209edv.24.1643139168447; 
 Tue, 25 Jan 2022 11:32:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmP7u7yUi6Xhu+9fK4nud1OqU+ebd0NePrm49LbmpmCD3peeOVKz96FWzu7vP+O7g76Bsd6A==
X-Received: by 2002:a05:6402:1104:: with SMTP id
 u4mr22299198edv.24.1643139168220; 
 Tue, 25 Jan 2022 11:32:48 -0800 (PST)
Received: from redhat.com ([176.12.185.204])
 by smtp.gmail.com with ESMTPSA id s7sm6518410ejo.212.2022.01.25.11.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 11:32:47 -0800 (PST)
Date: Tue, 25 Jan 2022 14:32:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V2 0/4] vDPA/ifcvf: implement shared IRQ feature
Message-ID: <20220125143151-mutt-send-email-mst@kernel.org>
References: <20220125091744.115996-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220125091744.115996-1-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jan 25, 2022 at 05:17:40PM +0800, Zhu Lingshan wrote:
> It has been observed that on some platforms/devices, there may
> not be enough MSI vectors for virtqueues and the config change.
> Under such circumstances, the interrupt sources of a device
> have to share vectors/IRQs.
> 
> This series implemented a shared IRQ feature for ifcvf.

Which configurations did you test with this, and what were
the results? Given patch 3 is broken ...


> Please help review.
> 
> Changes from V1:
> (1) Enable config interrupt when only one vector is allocated(Michael)
> (2) Clean vectors/IRQs if failed to request config interrupt
> since config interrupt is a must(Michael)
> (3) Keep local vdpa_ops, disable irq_bypass by setting IRQ = -EINVAL
> for shared IRQ case(Michael)
> (4) Improvements on error messages(Michael)
> (5) Squash functions implementation patches to the callers(Michael)
> 
> Zhu Lingshan (4):
>   vDPA/ifcvf: implement IO read/write helpers in the header file
>   vDPA/ifcvf: implement device MSIX vector allocator
>   vhost_vdpa: don't setup irq offloading when irq_num < 0
>   vDPA/ifcvf: implement shared IRQ feature
> 
>  drivers/vdpa/ifcvf/ifcvf_base.c |  67 +++------
>  drivers/vdpa/ifcvf/ifcvf_base.h |  60 +++++++-
>  drivers/vdpa/ifcvf/ifcvf_main.c | 254 ++++++++++++++++++++++++++++----
>  drivers/vhost/vdpa.c            |   3 +
>  4 files changed, 305 insertions(+), 79 deletions(-)
> 
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
