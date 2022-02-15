Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702DAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Feb 2022 07:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F369D82AC8;
	Tue, 15 Feb 2022 07:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 34o5kvSbfPfk; Tue, 15 Feb 2022 07:48:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B9B281432;
	Tue, 15 Feb 2022 07:48:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 751B3C002D;
	Tue, 15 Feb 2022 07:48:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31445C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 07:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 107D64011B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 07:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ePJDF9l82f8K
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 07:48:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A60594000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644911299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8TBMpDANby8RmP/LFmogH2MgUB/cxamBFb1C+IRX38=;
 b=ECuQ6+fOI9cxDx2lbpHPd7IssXXnXTleML4APLvpxkd1NPE2a7g80F7XxuLreRP8/e1Ms1
 i+bIWWd8HExn8woJfVtsKhECpnjD5p4+NDgl70tTMnr2PsOSeUgwPom9a8ULQuLbggmfjf
 Uojw6to24vt1wpGHwWV6vbC0YxQxhHI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-YkbXgrfLPTqGRhiVk3gkwg-1; Tue, 15 Feb 2022 02:48:17 -0500
X-MC-Unique: YkbXgrfLPTqGRhiVk3gkwg-1
Received: by mail-lf1-f71.google.com with SMTP id
 m13-20020a19520d000000b00443423ff116so1425578lfb.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 23:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S8TBMpDANby8RmP/LFmogH2MgUB/cxamBFb1C+IRX38=;
 b=JIeWtABks2HW2l79THv9wck6K4aP3oncKXTTC2a+SFSew0vlp9+AEqmJCHtUWIoqDL
 HioGriVRoPpaWle9A79LoOhwfsBIwPdu/qnvujmvzjUHBxzMTJUfsO4qRG6muoCggp90
 xeoYBE9VlooxeSc18AcoGJVXJsn71+8UxROoeHLAtEfd6B0QmuizN3UuJQEmo74+57PB
 XjUkAVvszmbSov9s203p7E+GKI3iLxzXdBPqUXIfCLMS8Uck9j356BoCeaC4FPnFzGlT
 X7S9Cqr/YCZg76i+n5J3dsckPQxPUANZl8+LB8pgGAhkvDljFf7sn5rMNGuhS6QG9uat
 /5pg==
X-Gm-Message-State: AOAM53059l2BhfhGk7HL01WrgzO3LVeQw4MOp79XXF3QnbsNiX/UT8wn
 y5BOSFLvCu2PTh9YWKBi0XqhW43LFk10FyVOy61irkM/0/ffI/b5oO1IKqmhvbVib9ww9GCq1D4
 6yt8uB9tphfoVFLY43qiGb6CXzH3VBgK4b3S1ev16Ew0dalOb/qYaZWCwlw==
X-Received: by 2002:ac2:4437:: with SMTP id w23mr2253844lfl.481.1644911296353; 
 Mon, 14 Feb 2022 23:48:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrPGSBjibGvDtlM9Z1Jt9MP9dvUIJlBBoHq0xmqexyKC5if7aafgy71D/1u2QPpo0U8LGebpqeueCGo0+ygO8=
X-Received: by 2002:ac2:4437:: with SMTP id w23mr2253833lfl.481.1644911296148; 
 Mon, 14 Feb 2022 23:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20220215053430.24650-1-gdawar@xilinx.com>
In-Reply-To: <20220215053430.24650-1-gdawar@xilinx.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Feb 2022 15:48:04 +0800
Message-ID: <CACGkMEs7UEFM=ospckg0-LMw92wj74D_NLPsZy6oSY=dio9V-w@mail.gmail.com>
Subject: Re: [PATCH] Add definition of VIRTIO_F_IN_ORDER feature bit
To: Gautam Dawar <gautam.dawar@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, pabloc@xilinx.com
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

On Tue, Feb 15, 2022 at 1:34 PM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
> This patch adds the definition of VIRTIO_F_IN_ORDER feature bit
> in the relevant header file to make it available in QEMU's
> linux standard header file virtio_config.h, which is updated using
> scripts/update-linux-headers.sh
>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/uapi/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b5eda06f0d57..f0fb0ae021c0 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -82,6 +82,12 @@
>  /* This feature indicates support for the packed virtqueue layout. */
>  #define VIRTIO_F_RING_PACKED           34
>
> +/*
> + * Inorder feature indicates that all buffers are used by the device
> + * in the same order in which they have been made available.
> + */
> +#define VIRTIO_F_IN_ORDER              35
> +
>  /*
>   * This feature indicates that memory accesses by the driver and the
>   * device are ordered in a way described by the platform.
> --
> 2.30.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
