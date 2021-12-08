Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FD1C433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 20:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFBE840232;
	Wed,  8 Dec 2021 20:31:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uzGtOZx1nJQt; Wed,  8 Dec 2021 20:31:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F1CC400FC;
	Wed,  8 Dec 2021 20:31:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1960EC001E;
	Wed,  8 Dec 2021 20:31:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B0D6C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15FF060B91
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:31:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hPV_hpKRZnEA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70B3D60625
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638995462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d3gz/WWxNoZd3rbf83cwD1q5W83Lbqve4TkTnpm34lg=;
 b=Bn4FHq0joI2Yqbc4kcVVVWtqsrKECn/kCSK0gC7NA9p8eomNHwtVJM0SLZGhlhn+/N1WL3
 kIGDNLT1G87r7GiKla8ZDiTJrWDcr2X4z/UL3hskBHqVlw6thYo8FAxo7K/fzdjokQafGi
 KGxH0E1BAFX0+mFqfr7Tt22QjNwpJ+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-WsYo7mOTOdGGmmYcOInbZg-1; Wed, 08 Dec 2021 15:31:01 -0500
X-MC-Unique: WsYo7mOTOdGGmmYcOInbZg-1
Received: by mail-wr1-f71.google.com with SMTP id
 q17-20020adff791000000b00183e734ba48so687918wrp.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 12:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d3gz/WWxNoZd3rbf83cwD1q5W83Lbqve4TkTnpm34lg=;
 b=mjrC/6WEOZx5SSec8aVOwmaO8KEdt0/dXAdQv1GPU/673Tw6KMo9jCwr+MgiXPukn/
 sgWDnCuBEgry9mxh/K6OZTvOh1LGr3UxSU+GTGsPVFKDovtw5mQ/G027AHH1icuasz0y
 GcZmB6RdzCYnpB3oDNnriIIsXqkLJAI60qVNA7gNszR2Ur4SgYr88BMcPGjRp703VfSf
 g+rCzpETxSkaTD6kvdRaCCcZNOzZStb72PUVELxpMLxTCGVu2JMjunxfDEVr84XdDLMs
 3UXc96KOwDrO3aQAK3xlQUeaVsHGBFtgBw5OlZsc/UBg50hlFMEkI96gPhb1t0H2YBm0
 22Yg==
X-Gm-Message-State: AOAM532H0ZOhhee9SYi0HBXbz16uPkwvOAdRjQt0Y0ALCMqPOi/PTR34
 /dWmIy3qnF7sTVVQakYgX5hLGScpZ8JrGWcSPcbuny6ysJbYSjjFTr85VqNMz0S2ccg2kumHwts
 wpWd12NxkKPnqzo+s+PzAftyShKrZHyTQaadWEKgiig==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr1288744wmh.15.1638995459904;
 Wed, 08 Dec 2021 12:30:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyj39pEqvoYfcqblVGRBOqDM2mL22uo6JzDCWQeyjKhLXLg6fToe9PzdS0HzVeiEzENfAOkww==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr1288728wmh.15.1638995459746;
 Wed, 08 Dec 2021 12:30:59 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id n1sm3913843wmq.6.2021.12.08.12.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 12:30:59 -0800 (PST)
Date: Wed, 8 Dec 2021 15:30:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATH v1 0/2] Support reading vendor statistics through
 iproute2/vdpa tool
Message-ID: <20211208153040-mutt-send-email-mst@kernel.org>
References: <20211124165531.42624-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211124165531.42624-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Wed, Nov 24, 2021 at 06:55:29PM +0200, Eli Cohen wrote:
> The following patches add support for reading vdpa statistics
> information from a vdpa instance using netlink messages.
> 
> mlx5_vdpa is also implemented to provide that information.
> 
> The supported statistics data are number of descriptors recieved by the
> virtqueue and the number of descriptors completed by it.

So I assume a v2 of this will be forthcoming, right?

> v0 -> v1:
> Emphasize that we're dealing with vendor specific counters.
> Add mutex to synchronize query stats with changing of number of queues
> 
> Eli Cohen (2):
>   vdpa: Add support for querying vendor statistics
>   vdpa/mlx5: Add support for reading descriptor statistics
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 143 ++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa.c                | 144 +++++++++++++++++++++++++++++
>  include/linux/mlx5/mlx5_ifc.h      |   1 +
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  39 ++++++++
>  include/linux/vdpa.h               |  10 ++
>  include/uapi/linux/vdpa.h          |   9 ++
>  6 files changed, 346 insertions(+)
> 
> -- 
> 2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
