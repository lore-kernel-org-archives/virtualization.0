Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1BEC77B7F
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 06:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B1E1408FC;
	Tue, 16 May 2023 06:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9B1E1408FC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgZTtGtr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D3GFWpVwZ__M; Tue, 16 May 2023 06:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 10968408EB;
	Tue, 16 May 2023 06:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10968408EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C63BCC0036;
	Tue, 16 May 2023 06:12:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A091C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 06:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E608408EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 06:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E608408EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XUxcqkR50_ji
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 06:12:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 858D4408CE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 858D4408CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684217572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=acXAPI+j75jg9aaFVO84Z4crvWYhC8JaTkZZBzVz0e8=;
 b=BgZTtGtrz/8bn7R3KmhTO/+bMpzPqWjVqvAjyvnz8a3yOx0+IzCxNtI/b+8vDePRBgCHOe
 OAvvsMEM4WRpVoOXdIAZPy1jZF2PaYWHoDqyvpTle5ocraIulCEVYqdZuDuEc/95syKkVG
 OFNxnKngSoR1xn1DxyFalXFxh9NZVVQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-pulrYdQFPK6EKmP8I_JqhA-1; Tue, 16 May 2023 02:12:48 -0400
X-MC-Unique: pulrYdQFPK6EKmP8I_JqhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f509037a45so8543705e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 23:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684217567; x=1686809567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acXAPI+j75jg9aaFVO84Z4crvWYhC8JaTkZZBzVz0e8=;
 b=LfpQYtMu0PZTwTl6yFqiYmQ8aRzCOdOiE7kYpWNkfjseqMSpQjC6J/N96Fk2pCCiLj
 BOb4Yvek6DEfbX0wEUdXVSSeha0D7MxuXR9QnjDVbyp455L6yd5rrgtEBIUctBfQ63fK
 VAlo53kXr2ES+K/bgOje3QfoxkVfrV7ZQL5d638k9wba0LQY4TjDS9ZnCUQ+GDLNmMWy
 X3oTXiptJDwYEkkgH8RZhmSJpa5t/j2tE04UwVITMgeCkYNC6HGl1NwzXlJJowFcljdg
 znVL3tNc55j6L6sJqbYMu2/nkhBOdFnMdFOjDThdmfOPbk6+kfdLDA2WCmGxhnTuUDQr
 A8Cw==
X-Gm-Message-State: AC+VfDzoyhqBdPg9tx8FyFrQXpenKgxrbFkKvgRo9CwoDq/kfl70hNt9
 CKYfHsQyPDxooTB3NNBPdl57Qm+CRr27Yu0w1GLaWHEfyWA2wn4998XiqNwzoT3iN9YeQbHk4ZR
 IuCOZ/GmDoUUG/rrjcX38Rlj5dGEnVEoPLt8WyaLQqA==
X-Received: by 2002:a05:600c:4f45:b0:3f4:2bcf:e19 with SMTP id
 m5-20020a05600c4f4500b003f42bcf0e19mr16817562wmq.8.1684217566887; 
 Mon, 15 May 2023 23:12:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QmQ2YHayqLcYv6xqe53acMOnxaqTXWoMpXiMr4c4hHzQCAirgTrt8EM5xbrYsKan7zlNlmw==
X-Received: by 2002:a05:600c:4f45:b0:3f4:2bcf:e19 with SMTP id
 m5-20020a05600c4f4500b003f42bcf0e19mr16817542wmq.8.1684217566547; 
 Mon, 15 May 2023 23:12:46 -0700 (PDT)
Received: from redhat.com ([2.52.26.5]) by smtp.gmail.com with ESMTPSA id
 w12-20020a05600c474c00b003f07ef4e3e0sm32311772wmo.0.2023.05.15.23.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 23:12:45 -0700 (PDT)
Date: Tue, 16 May 2023 02:12:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Subject: Re: [PATCH v6 virtio 04/11] pds_vdpa: move enum from common to
 adminq header
Message-ID: <20230516020938-mutt-send-email-mst@kernel.org>
References: <20230516025521.43352-1-shannon.nelson@amd.com>
 <20230516025521.43352-5-shannon.nelson@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230516025521.43352-5-shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brett.creeley@amd.com, simon.horman@corigine.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 drivers@pensando.io
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

On Mon, May 15, 2023 at 07:55:14PM -0700, Shannon Nelson wrote:
> The pds_core_logical_qtype enum and IFNAMSIZ are not needed
> in the common PDS header, only needed when working with the
> adminq, so move them to the adminq header.
> 
> Note: This patch might conflict with pds_vfio patches that are
>       in review, depending on which patchset gets pulled first.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

It's a bit weird to add code in one patch then move it
in another. Why not start with it in the final location?

More importantly, the use of adminq terminology here
is a going to be somewhat confusing with the unrelated
admin virtqueue just having landed in the virtio spec.
Is this terminology coming from some hardware spec?

> ---
>  include/linux/pds/pds_adminq.h | 21 +++++++++++++++++++++
>  include/linux/pds/pds_common.h | 21 ---------------------
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
> index 98a60ce87b92..61b0a8634e1a 100644
> --- a/include/linux/pds/pds_adminq.h
> +++ b/include/linux/pds/pds_adminq.h
> @@ -222,6 +222,27 @@ enum pds_core_lif_type {
>  	PDS_CORE_LIF_TYPE_DEFAULT = 0,
>  };
>  
> +#define PDS_CORE_IFNAMSIZ		16
> +
> +/**
> + * enum pds_core_logical_qtype - Logical Queue Types
> + * @PDS_CORE_QTYPE_ADMINQ:    Administrative Queue
> + * @PDS_CORE_QTYPE_NOTIFYQ:   Notify Queue
> + * @PDS_CORE_QTYPE_RXQ:       Receive Queue
> + * @PDS_CORE_QTYPE_TXQ:       Transmit Queue
> + * @PDS_CORE_QTYPE_EQ:        Event Queue
> + * @PDS_CORE_QTYPE_MAX:       Max queue type supported
> + */
> +enum pds_core_logical_qtype {
> +	PDS_CORE_QTYPE_ADMINQ  = 0,
> +	PDS_CORE_QTYPE_NOTIFYQ = 1,
> +	PDS_CORE_QTYPE_RXQ     = 2,
> +	PDS_CORE_QTYPE_TXQ     = 3,
> +	PDS_CORE_QTYPE_EQ      = 4,
> +
> +	PDS_CORE_QTYPE_MAX     = 16   /* don't change - used in struct size */
> +};
> +
>  /**
>   * union pds_core_lif_config - LIF configuration
>   * @state:	    LIF state (enum pds_core_lif_state)
> diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
> index 2a0d1669cfd0..435c8e8161c2 100644
> --- a/include/linux/pds/pds_common.h
> +++ b/include/linux/pds/pds_common.h
> @@ -41,27 +41,6 @@ enum pds_core_vif_types {
>  
>  #define PDS_VDPA_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
>  
> -#define PDS_CORE_IFNAMSIZ		16
> -
> -/**
> - * enum pds_core_logical_qtype - Logical Queue Types
> - * @PDS_CORE_QTYPE_ADMINQ:    Administrative Queue
> - * @PDS_CORE_QTYPE_NOTIFYQ:   Notify Queue
> - * @PDS_CORE_QTYPE_RXQ:       Receive Queue
> - * @PDS_CORE_QTYPE_TXQ:       Transmit Queue
> - * @PDS_CORE_QTYPE_EQ:        Event Queue
> - * @PDS_CORE_QTYPE_MAX:       Max queue type supported
> - */
> -enum pds_core_logical_qtype {
> -	PDS_CORE_QTYPE_ADMINQ  = 0,
> -	PDS_CORE_QTYPE_NOTIFYQ = 1,
> -	PDS_CORE_QTYPE_RXQ     = 2,
> -	PDS_CORE_QTYPE_TXQ     = 3,
> -	PDS_CORE_QTYPE_EQ      = 4,
> -
> -	PDS_CORE_QTYPE_MAX     = 16   /* don't change - used in struct size */
> -};
> -
>  int pdsc_register_notify(struct notifier_block *nb);
>  void pdsc_unregister_notify(struct notifier_block *nb);
>  void *pdsc_get_pf_struct(struct pci_dev *vf_pdev);
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
