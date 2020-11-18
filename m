Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC22C5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 08:56:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61930221E9
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWnmsIYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61930221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4330D204F7;
	Wed, 18 Nov 2020 08:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4pbpMS8mJTK; Wed, 18 Nov 2020 08:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 896FE204C5;
	Wed, 18 Nov 2020 08:56:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77163C0800;
	Wed, 18 Nov 2020 08:56:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68CD1C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 08:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6AC5B84E5E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 08:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JedkIfIwHUP5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 08:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5827E84E34
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605689789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oE/IfWvNx94tBWY03gu3UuKE9ZiNz0WGz4c8BQhvfUg=;
 b=fWnmsIYFi8//KB1kpoGwjshzZ/xz6UFejcisRyhYX3yNq4pJGzEYFdHxzwWThsRwZsWwUH
 IYToonZWiHqu0d949YpQdbF8+PQluB+/oiaLv7/VmM+ywfev1MgRN2HGQA6jIkyD6glggj
 kCIrqIkesoJf0uKum6hwoYSjB2U06kI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-OfCRyfhnOV2iEtly_PIr2Q-1; Wed, 18 Nov 2020 03:56:27 -0500
X-MC-Unique: OfCRyfhnOV2iEtly_PIr2Q-1
Received: by mail-wm1-f70.google.com with SMTP id j62so746229wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 00:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oE/IfWvNx94tBWY03gu3UuKE9ZiNz0WGz4c8BQhvfUg=;
 b=H9CO8NaHSL9qgYrzAgGvYWNHo8YMX3HwFyIlZaMF2FvZBo4NhINZ8091DWXPaYrjqe
 VmaZjZzEVG23J5XZ3boMESOAbbtA5S57AAFvI8920Byn/WSG1HmuvLNfbpqHe07/UK6F
 KLCzanaI+4auHuSoZWrRTgvww1ITPdPH4nZx2UISXcmBqVmeVSv8h0r4yef+MOSbpo29
 l3N3eK81OKPJIcPvc6rHIV04MMyHyZntxKEfqcdJiSoGaapoP1cB+nSOmgQJJ8sd0lia
 klgyDNFDn+L0cXl1xF65CH4c8PUXWsp2D3y3/9r0gvpR6Iix3X3XTR2b4AYymQyPQygf
 4y6A==
X-Gm-Message-State: AOAM533ob8FTayxhOQhKpJLO2wMyOfI1k5ulsmHmujLHN7RDkmUj+9uc
 oRuroSHBHiO08AbiSqUgsi4qpWCJSJoCJi/wJOp72JgQdII5PaRzVyy9dsYv8yuLNDqCQaL865X
 /BWIz+eQ32DCO+btLJcRhQEo5tBTrordutgJt/UIIfg==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr3897456wrm.403.1605689786263; 
 Wed, 18 Nov 2020 00:56:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxueBisSh/Mu4b5J73GuuCPae8P0OUrhxdSJAhejf3LKVsO4+2I2VmxbqVKsBNYXWpdkhzG3w==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr3897444wrm.403.1605689786105; 
 Wed, 18 Nov 2020 00:56:26 -0800 (PST)
Received: from redhat.com (bzq-109-67-54-78.red.bezeqint.net. [109.67.54.78])
 by smtp.gmail.com with ESMTPSA id
 u81sm2799177wmb.27.2020.11.18.00.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 00:56:25 -0800 (PST)
Date: Wed, 18 Nov 2020 03:56:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] vhost scsi: fix lun reset completion handling
Message-ID: <20201118035452-mutt-send-email-mst@kernel.org>
References: <1605680660-3671-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605680660-3671-1-git-send-email-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Wed, Nov 18, 2020 at 12:24:20AM -0600, Mike Christie wrote:
> vhost scsi owns the scsi se_cmd but lio frees the se_cmd->se_tmr
> before calling release_cmd, so while with normal cmd completion we
> can access the se_cmd from the vhost work, we can't do the same with
> se_cmd->se_tmr. This has us copy the tmf response in
> vhost_scsi_queue_tm_rsp to our internal vhost-scsi tmf struct for
> when it gets sent to the guest from our worker thread.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Is this a fix for
    vhost scsi: Add support for LUN resets.

If so pls add a Fixes: tag.

> ---
>  drivers/vhost/scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index f22fce5..6ff8a5096 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -220,6 +220,7 @@ struct vhost_scsi_tmf {
>  	struct list_head queue_entry;
>  
>  	struct se_cmd se_cmd;
> +	u8 scsi_resp;
>  	struct vhost_scsi_inflight *inflight;
>  	struct iovec resp_iov;
>  	int in_iovs;
> @@ -426,6 +427,7 @@ static void vhost_scsi_queue_tm_rsp(struct se_cmd *se_cmd)
>  	struct vhost_scsi_tmf *tmf = container_of(se_cmd, struct vhost_scsi_tmf,
>  						  se_cmd);
>  
> +	tmf->scsi_resp = se_cmd->se_tmr_req->response;
>  	transport_generic_free_cmd(&tmf->se_cmd, 0);
>  }
>  
> @@ -1183,7 +1185,7 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
>  						  vwork);
>  	int resp_code;
>  
> -	if (tmf->se_cmd.se_tmr_req->response == TMR_FUNCTION_COMPLETE)
> +	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
>  		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
>  	else
>  		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
