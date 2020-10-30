Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D85C00A89
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 08:51:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530DF22210
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 08:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+s9Hf+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530DF22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B335085FA4;
	Fri, 30 Oct 2020 08:51:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESHivnJ53PZX; Fri, 30 Oct 2020 08:51:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9EC4D85EBB;
	Fri, 30 Oct 2020 08:51:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87525C0893;
	Fri, 30 Oct 2020 08:51:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4B02C0859
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5BE8E2050D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:51:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rB-lFwyHu90Q
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:51:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id E397E204EB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604047885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkkbFBzuO71laTFHVRqjnoW6qUXVs253bo//A3S1us4=;
 b=X+s9Hf+dtLT9ILSnfBjDRoIQurlGFW6N2dpnlwlS84QhgmaTGonH8s+AV3jR6bt5FlG5t2
 oTSY8iwC6OYD+edbVzSkAzm2LEO/pO5aNd2Skc+zDOOQRs6j+sti23pfnjISnODe9ts1WH
 3AyEHvG5u8YWOaz/TzPqcr1ijJ/qMRE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-cNtKfBRuMlazh7U2TO6-Sg-1; Fri, 30 Oct 2020 04:51:21 -0400
X-MC-Unique: cNtKfBRuMlazh7U2TO6-Sg-1
Received: by mail-wr1-f72.google.com with SMTP id b6so2367764wrn.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EkkbFBzuO71laTFHVRqjnoW6qUXVs253bo//A3S1us4=;
 b=quQgEtCCyUvOrewz4fdW1gzpUtgKMta7Kw3xWxB0czPFsRXgG1+6qVRkWa+H4I6cav
 6O7nxzqzlbkRFYD0tymfj1U7B7sIp5gREQtgIdPnWsIHJjTdgVT+TfLwZMzUP7skpm55
 RXCSihcZJgtr/y26IoHvPNSg0zc+2csZZjTskjV8KqHOGS5QZFcLrqYywTYhNptGr2S1
 zygySwsRZ/yZcbCtyazyL3b1GivuIl865x4IuMIHCyAgo4zTyKcQEA9FCRFMaM0oFqt1
 Nic1QtCjo6MyhgPSzW4VZ+p+fdYoxorq47DYLPkIloricxunfq0S8YazNumJ1Yec9nOg
 ONCQ==
X-Gm-Message-State: AOAM532aZZ16SMvgIpk+89jSoXFmHKo5TJzY5N47+XQJdfoqiy2BiqFm
 tqwIiPHmBuLMknioig10jCZX1H5LcA/YR8NoOAsh704pogT2JEDjWw7u9uzV1iENExYct+p9rtK
 YDv6cHWsECF0YyZwJGrXjTIrtjgoJ2j657OUYgaTJTg==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr1649451wrw.120.1604047880318; 
 Fri, 30 Oct 2020 01:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj1MIwQ89bJ9kkwAMBxlNZwrbEnzRE72LWtV7F3wZEY97skaECdSnY11+Ta3iR9UnpXR/YyQ==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr1649435wrw.120.1604047880142; 
 Fri, 30 Oct 2020 01:51:20 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id o10sm3889774wma.47.2020.10.30.01.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 01:51:19 -0700 (PDT)
Date: Fri, 30 Oct 2020 04:51:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 09/17] vhost scsi: fix cmd completion race
Message-ID: <20201030045053-mutt-send-email-mst@kernel.org>
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-10-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1603326903-27052-10-git-send-email-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Wed, Oct 21, 2020 at 07:34:55PM -0500, Mike Christie wrote:
> We might not do the final se_cmd put from vhost_scsi_complete_cmd_work.
> When the last put happens a little later then we could race where
> vhost_scsi_complete_cmd_work does vhost_signal, the guest runs and sends
> more IO, and vhost_scsi_handle_vq runs but does not find any free cmds.
> 
> This patch has us delay completing the cmd until the last lio core ref
> is dropped. We then know that once we signal to the guest that the cmd
> is completed that if it queues a new command it will find a free cmd.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>


Paolo, could you review this one?

> ---
>  drivers/vhost/scsi.c | 42 +++++++++++++++---------------------------
>  1 file changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index f6b9010..2fa48dd 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -322,7 +322,7 @@ static u32 vhost_scsi_tpg_get_inst_index(struct se_portal_group *se_tpg)
>  	return 1;
>  }
>  
> -static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
> +static void vhost_scsi_release_cmd_res(struct se_cmd *se_cmd)
>  {
>  	struct vhost_scsi_cmd *tv_cmd = container_of(se_cmd,
>  				struct vhost_scsi_cmd, tvc_se_cmd);
> @@ -344,6 +344,16 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
>  	vhost_scsi_put_inflight(inflight);
>  }
>  
> +static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
> +{
> +	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
> +					struct vhost_scsi_cmd, tvc_se_cmd);
> +	struct vhost_scsi *vs = cmd->tvc_vhost;
> +
> +	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
> +	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
> +}
> +
>  static u32 vhost_scsi_sess_get_index(struct se_session *se_sess)
>  {
>  	return 0;
> @@ -366,28 +376,15 @@ static int vhost_scsi_get_cmd_state(struct se_cmd *se_cmd)
>  	return 0;
>  }
>  
> -static void vhost_scsi_complete_cmd(struct vhost_scsi_cmd *cmd)
> -{
> -	struct vhost_scsi *vs = cmd->tvc_vhost;
> -
> -	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
> -
> -	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
> -}
> -
>  static int vhost_scsi_queue_data_in(struct se_cmd *se_cmd)
>  {
> -	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
> -				struct vhost_scsi_cmd, tvc_se_cmd);
> -	vhost_scsi_complete_cmd(cmd);
> +	transport_generic_free_cmd(se_cmd, 0);
>  	return 0;
>  }
>  
>  static int vhost_scsi_queue_status(struct se_cmd *se_cmd)
>  {
> -	struct vhost_scsi_cmd *cmd = container_of(se_cmd,
> -				struct vhost_scsi_cmd, tvc_se_cmd);
> -	vhost_scsi_complete_cmd(cmd);
> +	transport_generic_free_cmd(se_cmd, 0);
>  	return 0;
>  }
>  
> @@ -433,15 +430,6 @@ static void vhost_scsi_free_evt(struct vhost_scsi *vs, struct vhost_scsi_evt *ev
>  	return evt;
>  }
>  
> -static void vhost_scsi_free_cmd(struct vhost_scsi_cmd *cmd)
> -{
> -	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
> -
> -	/* TODO locking against target/backend threads? */
> -	transport_generic_free_cmd(se_cmd, 0);
> -
> -}
> -
>  static int vhost_scsi_check_stop_free(struct se_cmd *se_cmd)
>  {
>  	return target_put_sess_cmd(se_cmd);
> @@ -560,7 +548,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  		} else
>  			pr_err("Faulted on virtio_scsi_cmd_resp\n");
>  
> -		vhost_scsi_free_cmd(cmd);
> +		vhost_scsi_release_cmd_res(se_cmd);
>  	}
>  
>  	vq = -1;
> @@ -1096,7 +1084,7 @@ static u16 vhost_buf_to_lun(u8 *lun_buf)
>  						      &prot_iter, exp_data_len,
>  						      &data_iter))) {
>  				vq_err(vq, "Failed to map iov to sgl\n");
> -				vhost_scsi_release_cmd(&cmd->tvc_se_cmd);
> +				vhost_scsi_release_cmd_res(&cmd->tvc_se_cmd);
>  				goto err;
>  			}
>  		}
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
