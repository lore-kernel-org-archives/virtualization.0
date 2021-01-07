Return-Path: <SRS0=voLO=GK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEB4C433E0
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 13:45:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1E6224BD
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 13:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1E6224BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F132869BB;
	Thu,  7 Jan 2021 13:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJWsAztuoDgT; Thu,  7 Jan 2021 13:45:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13AF786982;
	Thu,  7 Jan 2021 13:45:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C403BC0891;
	Thu,  7 Jan 2021 13:45:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3648AC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 13:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1599720101
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 13:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f7lC6TaObBYJ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 13:45:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id D2CB92002A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610027136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G6uWpqlwSVKh90kRGilN8ra4QedFEQSfInlrRXbuegk=;
 b=cZH404yhvQr8tGpnhYTY83IwlIBA4SNB09rjYlig1RDJQb65Dzceeyu+NDR3SkNqcH0OtH
 pXEcxfLUOTQdQyrmV0zK9R+qBps9Bt5bmSdahdoF5x+22spIK1IWOtyZbOkKoHM97Xi6WD
 l8h+KKO05pEl7ufjPAUwGO4YN2hZ1e8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-NSWZqKYPP3aM_679BK_YRA-1; Thu, 07 Jan 2021 08:45:33 -0500
X-MC-Unique: NSWZqKYPP3aM_679BK_YRA-1
Received: by mail-wr1-f72.google.com with SMTP id r11so2662267wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jan 2021 05:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G6uWpqlwSVKh90kRGilN8ra4QedFEQSfInlrRXbuegk=;
 b=juJtsazQWZnuqotgRipPUbJIs9jrpOBNFlewOvbERmPp6PI32BnBfemSYvio6maM/c
 eRyoSXbETzpG0tKmBW8VJNHyR8gTHgZVXI1zJCx3qN7tJhLOSKQo4V5NwO/FDlkCk/kC
 7INVxbaGklqFLBlVTHzjybq0lmIeQTslNoHN2847CWUZJS6ddg4cxXSpd522JKBaCLZ4
 pZdwUNq5xsRxYm5wey1D7jqvbPP8aKUxFlplqK96ZLhfLmEfMfWnNumWlp/80cEVeCT/
 qFqsvhlbkwo555TQgh2QmIRcD4ZBw3pCvmaUyeOB8x7PsDdnOBKLp/f5QCt9MT9Qgjss
 7ARg==
X-Gm-Message-State: AOAM5312oEsah6LkLllCz0DBMw+Mf1jp76ORWfIB7aaB79WTexW40oag
 fAwKjxK5BaRayiOiymN1MgQVcwTNkr/mWz1cdHa186uGF6ZneFCBH0JaHkLmlbk9r7MSHMEYY6M
 4sBzf2LoN6FYZfnoo+gvigxikvzvbLVVYyYuIomTWlw==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr8926397wrw.399.1610027131332; 
 Thu, 07 Jan 2021 05:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyA2UrtrIHsH2Ay8M5rV/B/Zag5MzLoAwcRGNIv5Kptx1Fsqxqz6UWeR//a5TyGmHyZ+dnixA==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr8926389wrw.399.1610027131153; 
 Thu, 07 Jan 2021 05:45:31 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v1sm7998471wrr.48.2021.01.07.05.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 05:45:30 -0800 (PST)
Date: Thu, 7 Jan 2021 14:45:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 1/6] vdpa_sim_net: Make mac address array
 static
Message-ID: <20210107134528.uw72mstpdorhcyvg@steredhat>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
 <20210105103203.82508-2-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210105103203.82508-2-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jan 05, 2021 at 12:31:58PM +0200, Parav Pandit wrote:
>MAC address array is used only in vdpa_sim_net.c.
>Hence, keep it static.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>---
>Changelog:
>v1->v2:
> - new patch
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index c10b6981fdab..f0482427186b 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -33,7 +33,7 @@ static char *macaddr;
> module_param(macaddr, charp, 0);
> MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
>
>-u8 macaddr_buf[ETH_ALEN];
>+static u8 macaddr_buf[ETH_ALEN];
>
> static struct vdpasim *vdpasim_net_dev;
>
>-- 
>2.26.2
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
