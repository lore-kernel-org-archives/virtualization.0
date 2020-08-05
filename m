Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3ABC433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:53:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA352245C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 11:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkqOnSNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA352245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C9FCA21FA9;
	Wed,  5 Aug 2020 11:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLVtOtizuZdb; Wed,  5 Aug 2020 11:53:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BC8F821503;
	Wed,  5 Aug 2020 11:53:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3E5DC0051;
	Wed,  5 Aug 2020 11:53:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED4AFC004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4978877F4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yz8+mTQEcVFv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:53:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4F1F877E1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596628427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=536n/y6iFl/5D6nOT9vy92U02GWyC/k+fDxzVf0r1Qs=;
 b=gkqOnSNrv1G9ZeLOwbzgcNxaORhd3HG8yIoLjspEq1pZwib64lbtdTjGprs/YNvPMmxaIk
 NMqeZx4MxuwktY4HXwD6muB4BNUbr2g6+bn/uZKuTJNvJKC0KTJ78fuB07z5gGcZgYvetm
 EreZMzcqA0hRrQwH8+Hf4O0n3Pq4gtk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-iLCVN1gvOnSP7zIcLBrBaQ-1; Wed, 05 Aug 2020 07:53:46 -0400
X-MC-Unique: iLCVN1gvOnSP7zIcLBrBaQ-1
Received: by mail-wr1-f70.google.com with SMTP id j2so10926404wrr.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 04:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=536n/y6iFl/5D6nOT9vy92U02GWyC/k+fDxzVf0r1Qs=;
 b=KyN4vHehqIlk2mk/+i7SRYTx/SC44wrdjvUbdEVnJp0rV/sda916vbvT8GTdkZS+hc
 n+GzzyyR4bdyS1HS+UXW2OrEvAndF8CZrNJUsPLgnqp98OiS0aM7DL9zeBgVpw5Os/cN
 65qt8PgtLGaV54kxpcm5OvEAVbz2hBD8SRviLGPblPtMOY/q8DikGOhhZPOpabpKPWq1
 ho8IwbY7j0eHEHkE3QYNa4QTRi0d6jiO46+uHEHWIlw5NZ4wGt/2jvHS8QnAoreqMjlY
 7SIp2JIEc6pCqikMCVUwPBK8b/ZzCdMaQjRh/qV/23srcFL8Py6JYviSmGo0YpTHVhmV
 4cDA==
X-Gm-Message-State: AOAM533sW6YcEqwirrEepdb0HAqChCd10GCQyJWETeUFuwr0wsQwDLrF
 onaVS/WSuVyqEEEbb6xO9F74TqayvWs6j8v6FzhIcrNiw+RRwu1EYWnSEQkgi+gPSLrv7MjjTFN
 4V40Evn+/GUvqzZm0P2dbO10WMkqp+D5a06cxQsPp0g==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr2959882wmf.0.1596628424847;
 Wed, 05 Aug 2020 04:53:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+wbkOm3jDct7STQrMsu6ZusEOvveaPFmID5XQoyiqlXiOd8CqLKRq0y1l+w8OoRQyu4N5ow==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr2959868wmf.0.1596628424612;
 Wed, 05 Aug 2020 04:53:44 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 v15sm2493810wrm.23.2020.08.05.04.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 04:53:43 -0700 (PDT)
Date: Wed, 5 Aug 2020 07:53:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 2/2] vhost_vdpa: unified set_vq_irq() and update_vq_irq()
Message-ID: <20200805075253-mutt-send-email-mst@kernel.org>
References: <20200805113832.3755-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200805113832.3755-1-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, parav@mellanox.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

On Wed, Aug 05, 2020 at 07:38:32PM +0800, Zhu Lingshan wrote:
> This commit merge vhost_vdpa_update_vq_irq() logics into
> vhost_vdpa_setup_vq_irq(), so that code are unified.
> 
> In vhost_vdpa_setup_vq_irq(), added checks for the existence
> for get_vq_irq().
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

which commit should I squash this into?

commit f8e695e9dbd88464bc3d1f01769229dedf8f30d6
Author: Zhu Lingshan <lingshan.zhu@intel.com>
Date:   Fri Jul 31 14:55:31 2020 +0800

    vhost_vdpa: implement IRQ offloading in vhost_vdpa
    

this one?

> ---
>  drivers/vhost/vdpa.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 26f166a8192e..044e1f54582a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -122,8 +122,12 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
>  	struct vdpa_device *vdpa = v->vdpa;
>  	int ret, irq;
>  
> -	spin_lock(&vq->call_ctx.ctx_lock);
> +	if (!ops->get_vq_irq)
> +		return;
> +
>  	irq = ops->get_vq_irq(vdpa, qid);
> +	spin_lock(&vq->call_ctx.ctx_lock);
> +	irq_bypass_unregister_producer(&vq->call_ctx.producer);
>  	if (!vq->call_ctx.ctx || irq < 0) {
>  		spin_unlock(&vq->call_ctx.ctx_lock);
>  		return;
> @@ -144,26 +148,6 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
>  	spin_unlock(&vq->call_ctx.ctx_lock);
>  }
>  
> -static void vhost_vdpa_update_vq_irq(struct vhost_virtqueue *vq)
> -{
> -	spin_lock(&vq->call_ctx.ctx_lock);
> -	/*
> -	 * if it has a non-zero irq, means there is a
> -	 * previsouly registered irq_bypass_producer,
> -	 * we should update it when ctx (its token)
> -	 * changes.
> -	 */
> -	if (!vq->call_ctx.producer.irq) {
> -		spin_unlock(&vq->call_ctx.ctx_lock);
> -		return;
> -	}
> -
> -	irq_bypass_unregister_producer(&vq->call_ctx.producer);
> -	vq->call_ctx.producer.token = vq->call_ctx.ctx;
> -	irq_bypass_register_producer(&vq->call_ctx.producer);
> -	spin_unlock(&vq->call_ctx.ctx_lock);
> -}
> -
>  static void vhost_vdpa_reset(struct vhost_vdpa *v)
>  {
>  	struct vdpa_device *vdpa = v->vdpa;
> @@ -452,7 +436,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>  			cb.private = NULL;
>  		}
>  		ops->set_vq_cb(vdpa, idx, &cb);
> -		vhost_vdpa_update_vq_irq(vq);
> +		vhost_vdpa_setup_vq_irq(v, idx);
>  		break;
>  
>  	case VHOST_SET_VRING_NUM:
> -- 
> 2.18.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
