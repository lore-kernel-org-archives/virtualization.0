Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B9DC6379D
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 17:48:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C279E206F9
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 17:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZdTS1K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C279E206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 652A987674;
	Wed, 25 Nov 2020 17:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvekTAlRXZqP; Wed, 25 Nov 2020 17:48:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6F2787629;
	Wed, 25 Nov 2020 17:48:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C25C4C163C;
	Wed, 25 Nov 2020 17:48:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D19AC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 17:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 904E1872DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 17:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i9heWnMoWOwA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 17:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C4C768715C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606326507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPAlub6Lu18QJG/UwISztnXC7vpMcA+ULhrhJ2wogtA=;
 b=TZdTS1K23f56OotvAZ0r4rUQO8NVbsU4Lj89Ykmk8RlbAZZ5FwcMiYDLzZBkDRXJQe+jGx
 nv+P06I6tZeU7bo7HK0WOI9WNdUEU82CjucIgZ5ZFz7T8xmbdiSAW6Ungc0Pqmf51UfNkT
 udovizEs2AR6N9jkU5TKmB4W1gJE0+8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-GGBs2_xmMKS-BAI6bheBlA-1; Wed, 25 Nov 2020 12:48:25 -0500
X-MC-Unique: GGBs2_xmMKS-BAI6bheBlA-1
Received: by mail-ej1-f69.google.com with SMTP id gx12so1019217ejb.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PPAlub6Lu18QJG/UwISztnXC7vpMcA+ULhrhJ2wogtA=;
 b=Xw1m5oicAZVcXKcv36ehxVAMC8DUP/8Fc3nFm35AiI0MxzNdngpWcXObJqRD+swQl1
 e7fJma+tsiRhgJTJrg4IXc6GAsyi8Yjgtwy+R2BXTMTYA++miPrjlAMqCzcFSJsGcW/S
 OdFjtcphgB4wlWBqiLDrhPzay73pAvI/ixkN0j0hmDLawzZFzEX9aCj/bQHCs/46e9JP
 gvhkekS6CfXmIU+3c9uRV7DPs/ODxQnwnRZSDKz6fVSYuObgSte/e6r14h/W7RIp8yME
 4kPpADIjY4X+ATEQFatUIrn6mOoJi8DbFdKKA0f5Kj2yXTb63MCofn9NYX5IsQ5mQQJZ
 ISrg==
X-Gm-Message-State: AOAM533yLG718OehkXCMrhSrdDSR9sDVs6CB+iJzi/BysZhZ/IMQsZq/
 MRMmDrUvMI6a5F8MYUk3CyyvJ3vFZn0TEZs4PS3tlqsEpeNxwqCGGji67WOitEdFh2B+5X5JcIO
 cVE0p8zWIhBOVxL2UE3juJs6jzQV+kGHy8bNblPGLuQ==
X-Received: by 2002:a17:906:38db:: with SMTP id
 r27mr4168636ejd.328.1606326503977; 
 Wed, 25 Nov 2020 09:48:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxr2gVh9P7XRmeTfb7uFaE+EScbcdMKxEjEz+ho32BWcP+21n+ieNOFuJ/XNTV98wqLH5Q7Cg==
X-Received: by 2002:a17:906:38db:: with SMTP id
 r27mr4168614ejd.328.1606326503716; 
 Wed, 25 Nov 2020 09:48:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id mj17sm1659943ejb.59.2020.11.25.09.48.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 09:48:22 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
Date: Wed, 25 Nov 2020 18:48:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125153550.810101-22-sashal@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

On 25/11/20 16:35, Sasha Levin wrote:
> From: Mike Christie <michael.christie@oracle.com>
> 
> [ Upstream commit 18f1becb6948cd411fd01968a0a54af63732e73c ]
> 
> Move code to parse lun from req's lun_buf to helper, so tmf code
> can use it in the next patch.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Link: https://lore.kernel.org/r/1604986403-4931-5-git-send-email-michael.christie@oracle.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This doesn't seem like stable material, does it?

Paolo

> ---
>   drivers/vhost/scsi.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 5d8850f5aef16..ed7dc6b998f65 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -898,6 +898,11 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
>   	return ret;
>   }
>   
> +static u16 vhost_buf_to_lun(u8 *lun_buf)
> +{
> +	return ((lun_buf[2] << 8) | lun_buf[3]) & 0x3FFF;
> +}
> +
>   static void
>   vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>   {
> @@ -1036,12 +1041,12 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>   			tag = vhost64_to_cpu(vq, v_req_pi.tag);
>   			task_attr = v_req_pi.task_attr;
>   			cdb = &v_req_pi.cdb[0];
> -			lun = ((v_req_pi.lun[2] << 8) | v_req_pi.lun[3]) & 0x3FFF;
> +			lun = vhost_buf_to_lun(v_req_pi.lun);
>   		} else {
>   			tag = vhost64_to_cpu(vq, v_req.tag);
>   			task_attr = v_req.task_attr;
>   			cdb = &v_req.cdb[0];
> -			lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
> +			lun = vhost_buf_to_lun(v_req.lun);
>   		}
>   		/*
>   		 * Check that the received CDB size does not exceeded our
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
