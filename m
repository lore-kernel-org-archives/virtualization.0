Return-Path: <SRS0=DI/B=DA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78726C52D77
	for <virtualization@archiver.kernel.org>; Wed, 23 Sep 2020 10:23:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA5823977
	for <virtualization@archiver.kernel.org>; Wed, 23 Sep 2020 10:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd0IdmQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA5823977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD92B866ED;
	Wed, 23 Sep 2020 10:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wY8Yvk5ZivLa; Wed, 23 Sep 2020 10:23:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 39A15866EA;
	Wed, 23 Sep 2020 10:23:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23BDDC0859;
	Wed, 23 Sep 2020 10:23:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF5A0C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C606886F8D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id subWOE-ALJzd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:23:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E7DFD86FAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600856590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFgJToirjL1LcUbMYxqpCEwKfTDu3I+1Nj36cIZeHgU=;
 b=Yd0IdmQTpH+5D0QQ1w/Mb0SJ3HD/w1q6wrLgrcj+8ir03so6qzuOax5OWqOWdbB8APf+sJ
 KUQBtls6bZL0rRggnw5zrvIqY3v6COVWbj5mQyHhw12ZBj2Eayd3CvCZngbSHa2VeParIx
 XK+zJcHcDbxHiZ0MO1hT1H8KdcnAuFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-bQ3tLbxjOKCChulfr7ty6Q-1; Wed, 23 Sep 2020 06:23:09 -0400
X-MC-Unique: bQ3tLbxjOKCChulfr7ty6Q-1
Received: by mail-wr1-f72.google.com with SMTP id a2so8622676wrp.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 03:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VFgJToirjL1LcUbMYxqpCEwKfTDu3I+1Nj36cIZeHgU=;
 b=Vm4C/6QGwTJ92248oY1YArAv0ChwtnUmSSGl+YNWEXzUl+aqeEViacqoA9fAzSvCqG
 383nnpfpke9kawsCNt00Kk6bfB0Je6XDnR78IJgyKzoy2oCXb5Yuudt5ikJZUubi2TzU
 NZVvLheJQUduLVRP2OG4xq5ZnjuVa6rvzlFJ9JZihfujncZG8eiP9zfAm3fbSeZPOoAO
 VNY9m2Ke5BaU3DTj41+xl/zlnIfUr5u5aJjjXloC3sXYAPWYMFCS1bzcIc++nsTX7tyb
 6fnu2RJ9Y0m7bfL9jin1E+BR07H4RjFvZIma4lN8qXp1S72G6QnXusOLToHf8bG6MOw2
 /H+A==
X-Gm-Message-State: AOAM532tzyXSqDZkjIHq7c/hWT6YQsKe7REvGeTSWypSWLgqMGj1UodF
 XZfK9QHbNFzDng3rzlyckhN8jkQkO79p/3W84i+KtwEKIFCHZECrQk+MAUzeVIYIhweTNSZFnKS
 eWONSSQCiR70oIr1UOKGdaO6vn+F02m2+Rri7CzJmBg==
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr4741708wmi.40.1600856587510; 
 Wed, 23 Sep 2020 03:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvwid4yBpJLIUdhmHJZC1dioF+qkVR7rcecEnmaK5giSVtQGS8/+Yh8i8w9490r84enyaBxw==
X-Received: by 2002:a05:600c:20c:: with SMTP id
 12mr4741681wmi.40.1600856587231; 
 Wed, 23 Sep 2020 03:23:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id y6sm30308257wrn.41.2020.09.23.03.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 03:23:06 -0700 (PDT)
Subject: Re: [PATCH 5/8] vhost scsi: add lun parser helper
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1600712588-9514-1-git-send-email-michael.christie@oracle.com>
 <1600712588-9514-6-git-send-email-michael.christie@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c981b20e-895a-d5ce-9973-ffe7b21bd724@redhat.com>
Date: Wed, 23 Sep 2020 12:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600712588-9514-6-git-send-email-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

On 21/09/20 20:23, Mike Christie wrote:
> Move code to parse lun from req's lun_buf to helper, so tmf code
> can use it in the next patch.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 26d0f75..736ce19 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -899,6 +899,11 @@ static void vhost_scsi_submission_work(struct work_struct *work)
>  	return ret;
>  }
>  
> +static u16 vhost_buf_to_lun(u8 *lun_buf)
> +{
> +	return ((lun_buf[2] << 8) | lun_buf[3]) & 0x3FFF;
> +}
> +
>  static void
>  vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
>  {
> @@ -1037,12 +1042,12 @@ static void vhost_scsi_submission_work(struct work_struct *work)
>  			tag = vhost64_to_cpu(vq, v_req_pi.tag);
>  			task_attr = v_req_pi.task_attr;
>  			cdb = &v_req_pi.cdb[0];
> -			lun = ((v_req_pi.lun[2] << 8) | v_req_pi.lun[3]) & 0x3FFF;
> +			lun = vhost_buf_to_lun(v_req_pi.lun);
>  		} else {
>  			tag = vhost64_to_cpu(vq, v_req.tag);
>  			task_attr = v_req.task_attr;
>  			cdb = &v_req.cdb[0];
> -			lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
> +			lun = vhost_buf_to_lun(v_req.lun);
>  		}
>  		/*
>  		 * Check that the received CDB size does not exceeded our
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
