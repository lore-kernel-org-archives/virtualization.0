Return-Path: <SRS0=OYIR=C6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF5C43464
	for <virtualization@archiver.kernel.org>; Mon, 21 Sep 2020 12:35:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229DE206F4
	for <virtualization@archiver.kernel.org>; Mon, 21 Sep 2020 12:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9bXgVhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229DE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C2E72002D;
	Mon, 21 Sep 2020 12:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ny0kExQikinN; Mon, 21 Sep 2020 12:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6AF3520101;
	Mon, 21 Sep 2020 12:35:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D046C0859;
	Mon, 21 Sep 2020 12:35:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16050C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 12:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03D638723D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 12:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yxh2x8Dh3RoL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 12:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 102E787237
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rwqqgkk5n+jk3i2GLt6oUS3tq+OlXcmqXoPG/Cpdq0s=;
 b=g9bXgVhzBwYlYiIJzoNqhdS8okCejX4QfL1XwjLlanQh5VWh2cNafbfnMcz+pU9myaatI7
 S+Hiwyq1rVmTjn0Hn86RVXdO46/FaC608GrzxCS0Ra1x1exD9JICvCjgSqvfYX8KP9w0fl
 34fwSYG0DjvurJtLZNvQYDOccI83vYA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-Olx8DFmoNTKxsh0NaECiTA-1; Mon, 21 Sep 2020 08:35:20 -0400
X-MC-Unique: Olx8DFmoNTKxsh0NaECiTA-1
Received: by mail-wm1-f69.google.com with SMTP id a7so3691208wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 05:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rwqqgkk5n+jk3i2GLt6oUS3tq+OlXcmqXoPG/Cpdq0s=;
 b=W4tQlCyeKbXF3999+nz9FMoRygdHd0cakXyW2KFkuMVcYFJ6Kgr4Rw8G8UGUsCkoH/
 8FaiUba+k1VWZKusiCEnw4oJqWV2A2XmacznXCx8L+9WCbwQqVa4iKMnmGDhu5BrffDP
 AD0COz957zUfnEauW18uuRlVKJde4pEVLLvLvdE5bvWMz3dqgPQ/j/w+EAuT8YvqKfHK
 /THACZk+2b+9gAFJn2UHkHP/QE4qr06N9zx15qShR8VA63uGK89bvz0+dUt3ZF+NPvRj
 Q6nTnJl9MvqxKO977vTlMQQC19wawNAQohKRLUqjKAgOf1ZqH3zSPfQIkWgkfqgNvsjq
 weww==
X-Gm-Message-State: AOAM532Vo6wZH7QK83tApTj8JWGZjWRTJlJW8pxriVpmCznLt2qWkChE
 TQmeIb83nEH+jVBW2ENgVDcM+YRh79bMQLpwJodjO6ztTe/d0fUHh5JXYv9xoBLG7iIVdmsWXVE
 YSvip5QllD+KTZGqGkJIwshNCPzrSYXEcAOnhBmHJtw==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr30608519wmj.16.1600691719646; 
 Mon, 21 Sep 2020 05:35:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk8SI4MxU+bTgGCiPisNoMYNBLevVyLRA9Cuhq7q4wZQLmwfsI5OpJ5XpRgd2fRnEGpQ1TYA==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr30608497wmj.16.1600691719495; 
 Mon, 21 Sep 2020 05:35:19 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id f6sm20641849wro.5.2020.09.21.05.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 05:35:18 -0700 (PDT)
Date: Mon, 21 Sep 2020 08:35:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH 1/2] vhost: remove mutex ops in vhost_set_backend_features
Message-ID: <20200921083506-mutt-send-email-mst@kernel.org>
References: <20200907105220.27776-1-lingshan.zhu@intel.com>
 <20200907105220.27776-2-lingshan.zhu@intel.com>
 <20200908080513-mutt-send-email-mst@kernel.org>
 <34c0bc00-e5f1-1306-d705-72758c50872e@intel.com>
MIME-Version: 1.0
In-Reply-To: <34c0bc00-e5f1-1306-d705-72758c50872e@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Sep 08, 2020 at 09:00:19PM +0800, Zhu, Lingshan wrote:
> 
> On 9/8/2020 8:05 PM, Michael S. Tsirkin wrote:
> 
>     On Mon, Sep 07, 2020 at 06:52:19PM +0800, Zhu Lingshan wrote:
> 
>         In vhost_vdpa ioctl SET_BACKEND_FEATURES path, currect code
>         would try to acquire vhost dev mutex twice
>         (first shown in vhost_vdpa_unlocked_ioctl), which can lead
>         to a dead lock issue.
>         This commit removed mutex operations in vhost_set_backend_features.
>         As a compensation for vhost_net, a followinig commit will add
>         needed mutex lock/unlock operations in a new function
>         vhost_net_set_backend_features() which is a wrap of
>         vhost_set_backend_features().
> 
>         Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> 
>     I think you need to squash these two or reorder, we can't first
>     make code racy then fix it up.
> 
> OK, I will send a V2 series with Jason's fixes tomorrow (handle SET/GET_BACKEND_FEATURES in vhost_vdpa ioctl than vring ioctl).
> 
> Thanks,
> BR
> Zhu Lingshan


this never materialized ...

> 
> 
>         ---
>          drivers/vhost/vhost.c | 2 --
>          1 file changed, 2 deletions(-)
> 
>         diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>         index b45519ca66a7..e03c9e6f058f 100644
>         --- a/drivers/vhost/vhost.c
>         +++ b/drivers/vhost/vhost.c
>         @@ -2591,14 +2591,12 @@ void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
>                 struct vhost_virtqueue *vq;
>                 int i;
> 
>         -       mutex_lock(&dev->mutex);
>                 for (i = 0; i < dev->nvqs; ++i) {
>                         vq = dev->vqs[i];
>                         mutex_lock(&vq->mutex);
>                         vq->acked_backend_features = features;
>                         mutex_unlock(&vq->mutex);
>                 }
>         -       mutex_unlock(&dev->mutex);
>          }
>          EXPORT_SYMBOL_GPL(vhost_set_backend_features);
> 
>         --
>         2.18.4
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
