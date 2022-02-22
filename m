Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EACEC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 03:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 164EC60E40;
	Tue, 22 Feb 2022 03:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9w8b-yBe1NG; Tue, 22 Feb 2022 03:31:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CCFF860B6A;
	Tue, 22 Feb 2022 03:31:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB50C001A;
	Tue, 22 Feb 2022 03:31:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9FF4C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FE89404F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rx_96cpzlXNb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:31:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A48904013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 03:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645500695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lubWbTfYU2QeCD9ZpJQ27jDo+iZ27Wdo56dXzmDGV9Q=;
 b=hgOgDLypNVinXFI8rpPpMqyhiDG/B6IhsfwTlJ3lAphdKkl4pJinozj8WDN3UoLCF4/WFF
 26TK2UPEdVW4ajl3Kw/ahADaFHQELlB+K/GLcxRcfOYif1PkchemP5Ib9IjdHqjQCy/vFh
 AmHysj02L1DSO7vM/JV2Ntl3ASdWduI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-D8rkOdYpPPuqevs4cICRDg-1; Mon, 21 Feb 2022 22:31:34 -0500
X-MC-Unique: D8rkOdYpPPuqevs4cICRDg-1
Received: by mail-lj1-f198.google.com with SMTP id
 a5-20020a2eb545000000b002462b5eddb3so3798341ljn.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 19:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lubWbTfYU2QeCD9ZpJQ27jDo+iZ27Wdo56dXzmDGV9Q=;
 b=j8B113w5/9jmUDT0w49z7Jv1TAgrK+sCRdKgujcrNNJXFgRWkKMZomNgIL9319cXSv
 0cPla4xqzWH2XEx2q1i0T94wzSHjNxqfq2XUg8eJeQtX+B/v816qqBwd0wN4pbdphpyN
 YDoEA8tkBHsjcKPQ3/hNFcs1t/7YQOKSo6R3adJ0cZD5ifFxXQ+SxXL4HLcGJFVxc7wT
 aa7qTTPKK8zelnuBfvFIHGNmEOPV+s1WeGhOjtE3t2B/2ieMnfSMrBLW8KE3sAA+WDfk
 mEfkQgj4fZX2oVlnyqrhEIzr62ILzBc/LDmTGtbIVbglop7xwTQSaFMr6lq8pphxSyul
 DESw==
X-Gm-Message-State: AOAM532PeMO9dUOtj+yH56WkmplVURu7Yxtthv1QDsyIN7QVAfeRsODt
 Vn6WViki0Q6XMGiKr3dChbHdNqOmeAvoXjtPiSkr7j4osCx9co2Dg7A2LDQhFiuTRfmBw3ANRQ6
 BjB8lNzzQzgmphzs4OWegz9KGCddEEfbUOPZxjVAR9QjJ08LVy5MhKVmNsw==
X-Received: by 2002:a2e:8449:0:b0:246:440d:b2aa with SMTP id
 u9-20020a2e8449000000b00246440db2aamr3449925ljh.107.1645500692607; 
 Mon, 21 Feb 2022 19:31:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBkws66ufp/Lytz18JkzH1AJr/rWGac6Yq7AJ/qSAyBo1HXByYb4ZhVW/j8q8T/9OnapeDFtWLmFKhRHEFyrs=
X-Received: by 2002:a2e:8449:0:b0:246:440d:b2aa with SMTP id
 u9-20020a2e8449000000b00246440db2aamr3449911ljh.107.1645500692433; Mon, 21
 Feb 2022 19:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20220221120743.208990-1-elic@nvidia.com>
In-Reply-To: <20220221120743.208990-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 11:31:21 +0800
Message-ID: <CACGkMEvCzuR67X_PjkWSH041AaE1hssYLM-vCcH+3iF9sYTGSw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio: Add definition for VIRTIO_F_NOTIFICATION_DATA
 feature flag
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 Gautam Dawar <gdawar@xilinx.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>, eperezma <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, radovano@xilinx.com
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

On Mon, Feb 21, 2022 at 8:08 PM Eli Cohen <elic@nvidia.com> wrote:
>
> This is required by iproute2 to display the capabilities of a vdpa based
> virtio device.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> v0 -> v1:
> Avoid modifying mcdi_pcol.h

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/uapi/linux/virtio_config.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index b5eda06f0d57..30eb76dcdcad 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -92,4 +92,10 @@
>   * Does the device support Single Root I/O Virtualization?
>   */
>  #define VIRTIO_F_SR_IOV                        37
> +
> +/* When negotiated, indicates that the driver can pass extra data beyond
> + * virtqueue identification when sending notifications
> + */
> +#define VIRTIO_F_NOTIFICATION_DATA     38
> +
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
