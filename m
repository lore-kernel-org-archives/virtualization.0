Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E4BC433F5
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 16:18:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9492F6023D
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 16:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9492F6023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B8BE60658;
	Sun,  5 Sep 2021 16:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XPyhIhlZ66a; Sun,  5 Sep 2021 16:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D76776066A;
	Sun,  5 Sep 2021 16:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A476DC0010;
	Sun,  5 Sep 2021 16:18:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DBC7C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 872DB403C2
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hg2dOz-S1Gab
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2CC44039D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630858682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hW1sN5QGx3Kx2EPNmaIE4CRt6Il/ANBqcp567eWWlqk=;
 b=NzkRj9Titj7saPXnb7z70ke5gZiqAyAknju4Az/6KZCzKUsLsU+WO2UodfHunzETTk4bFe
 OPI5/+0u66svGhm2/qnhTZ/YOnnR+e29aZBEKDsgjdGraHm0kYIOf6wwAJLoDEVNhEt0Zo
 l9jS6VRAJN4wAQDlGER5CecQxyyQPe8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-r6XkAsLANWaZj3Qnxa_BvQ-1; Sun, 05 Sep 2021 12:18:01 -0400
X-MC-Unique: r6XkAsLANWaZj3Qnxa_BvQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 o20-20020a05600c379400b002e755735eedso2208029wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 09:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hW1sN5QGx3Kx2EPNmaIE4CRt6Il/ANBqcp567eWWlqk=;
 b=GU/6gURezHwLw1rrKfMQIO5TGSioPJy17ryarKsqAn3g3D7fQWFaxYvC1sE6+mve8e
 HizglUds0ASTiW0Fyk2jXQkgaw3+mQomID/7STyVF3jmsvpLjdCEKTQmqTPH6v6Vjyqt
 KpwftrnIuIU1SHb83CtwD5W53PEgSj36Nzn/vW/0fMv7Rx3Ne1bwLkQJyrZUdswm64vb
 /GG60tsWJdsc/kbUPCLSYrEz3RvLFmbn8YTB7QVzekLMzx8O70bEQIRiXoxVj1VIg2oD
 X6GbVmssihELq+Do4rOYQ2x8Y9rWixmE2uYtAHNnDzb0jEwhAagkxFXUjTYQ0G3iD4Rm
 qgNg==
X-Gm-Message-State: AOAM533v/FAQJE9QkFcSUNZwIa6o/yoVX1UJYKg2kJ1IOZwSvnH5mCis
 5IdrOehoKZ9Ky7U7yULLM60fUSMMCYkXfe/4gHuHTIATjIWNyBfWtgw3yTOH7Zb3NdoTPVGNQq6
 gC/X/WUJxOlBh8gtoMVWqPEwDssRyeCzmLb1wM5nLhw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr9020244wrm.198.1630858680218; 
 Sun, 05 Sep 2021 09:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCY+j+7T+nDz0P50mK89ZiTPM8ct/jZZ3HWCX3r0RyVKusgkTEzB0PV/xPQQ6NTWshHSYVWg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr9020227wrm.198.1630858679962; 
 Sun, 05 Sep 2021 09:17:59 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id n18sm4795503wmc.22.2021.09.05.09.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 09:17:58 -0700 (PDT)
Date: Sun, 5 Sep 2021 12:17:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: Re: [PATCH] vhost_net: Convert from atomic_t to refcount_t on
 vhost_net_ubuf_ref->refcount
Message-ID: <20210905121737-mutt-send-email-mst@kernel.org>
References: <1626517230-42920-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
In-Reply-To: <1626517230-42920-1-git-send-email-xiyuyang19@fudan.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xin Tan <tanxin.ctf@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org,
 yuanxzhang@fudan.edu.cn, linux-kernel@vger.kernel.org,
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

On Sat, Jul 17, 2021 at 06:20:30PM +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Pls resubmit after addressing the build bot comments.
Thanks!

> ---
>  drivers/vhost/net.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 6414bd5741b8..e23150ca7d4c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -5,6 +5,7 @@
>   * virtio-net server in host kernel.
>   */
>  
> +#include <linux/refcount.h>
>  #include <linux/compat.h>
>  #include <linux/eventfd.h>
>  #include <linux/vhost.h>
> @@ -92,7 +93,7 @@ struct vhost_net_ubuf_ref {
>  	 *  1: no outstanding ubufs
>  	 * >1: outstanding ubufs
>  	 */
> -	atomic_t refcount;
> +	refcount_t refcount;
>  	wait_queue_head_t wait;
>  	struct vhost_virtqueue *vq;
>  };
> @@ -240,7 +241,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  	ubufs = kmalloc(sizeof(*ubufs), GFP_KERNEL);
>  	if (!ubufs)
>  		return ERR_PTR(-ENOMEM);
> -	atomic_set(&ubufs->refcount, 1);
> +	refcount_set(&ubufs->refcount, 1);
>  	init_waitqueue_head(&ubufs->wait);
>  	ubufs->vq = vq;
>  	return ubufs;
> @@ -248,7 +249,8 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  
>  static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  {
> -	int r = atomic_sub_return(1, &ubufs->refcount);
> +	refcount_dec(&ubufs->refcount);
> +	int r = refcount_read(&ubufs->refcount);
>  	if (unlikely(!r))
>  		wake_up(&ubufs->wait);
>  	return r;
> @@ -257,7 +259,7 @@ static int vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
>  static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
>  {
>  	vhost_net_ubuf_put(ubufs);
> -	wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));
> +	wait_event(ubufs->wait, !refcount_read(&ubufs->refcount));
>  }
>  
>  static void vhost_net_ubuf_put_wait_and_free(struct vhost_net_ubuf_ref *ubufs)
> @@ -909,7 +911,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  			ctl.ptr = ubuf;
>  			msg.msg_controllen = sizeof(ctl);
>  			ubufs = nvq->ubufs;
> -			atomic_inc(&ubufs->refcount);
> +			refcount_inc(&ubufs->refcount);
>  			nvq->upend_idx = (nvq->upend_idx + 1) % UIO_MAXIOV;
>  		} else {
>  			msg.msg_control = NULL;
> @@ -1384,7 +1386,7 @@ static void vhost_net_flush(struct vhost_net *n)
>  		vhost_net_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
>  		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  		n->tx_flush = false;
> -		atomic_set(&n->vqs[VHOST_NET_VQ_TX].ubufs->refcount, 1);
> +		refcount_set(&n->vqs[VHOST_NET_VQ_TX].ubufs->refcount, 1);
>  		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
>  	}
>  }
> -- 
> 2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
