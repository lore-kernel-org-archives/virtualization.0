Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F69C433F5
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 04:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BB5A40377;
	Tue, 29 Mar 2022 04:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpyINQHh4JVV; Tue, 29 Mar 2022 04:58:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D732C4047D;
	Tue, 29 Mar 2022 04:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEF85C002C;
	Tue, 29 Mar 2022 04:58:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 370FAC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3357C4047D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kqQRFlL2zYB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F92340377
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 04:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648529896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMiLcrQExvhVCoUkftH7rHDXBOzH1kZg7AAMME34QKg=;
 b=ZaYMzQDsoDzL4gCF9X+s3DZ1H5MCvQopir1857547bSqlV07J21IbrkXcWz0TDQcw1UtN5
 Nsb9R+Hcc2r5R3jKq9zesm+Emz2fsXyZpsQ0HFe7Sa6IhzIU9u/hPq8OJIi1LpqpAs/Hpt
 DaNSuWGUt2mxLRphsAgHy+B+nYRS2zk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-Cb_cqGDmOnaZlEzRBwKGGQ-1; Tue, 29 Mar 2022 00:58:12 -0400
X-MC-Unique: Cb_cqGDmOnaZlEzRBwKGGQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 20-20020a05651c009400b002462f08f8d2so6991501ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pMiLcrQExvhVCoUkftH7rHDXBOzH1kZg7AAMME34QKg=;
 b=rwsQ8m890sKsCFynca+RxFoFyoohhUjOUVyzwEbc/vZcA5S2v0hiGhByvcO6QSJX4N
 qXAz2biqB0Bw02w10hil7doXSsOzSnIuYyjCFm8gdFfonXCpaqoy6ehu2UalSV2qomTZ
 MJBsQz03+Dh9XdtJNuVcde4xXCrdZ42BjZmotKc5FYGcq8jBqIuY2yH9YzOc3q7KfLAB
 SnQHjyM7ROY69ygHb3+u4OQ9w/f8/JZdp76qiD7Btq+eKR9iBOiA5xrclNR0xtbYug9A
 ix5TZ+SHbnWHanARv+kEBYvF8YGt/bCMH1s4HmU7J2sZ/Cvc8eEvobKPj+E0q00iwOoT
 yF+w==
X-Gm-Message-State: AOAM533WhurOPsHG5GN+Mkh+v8yo4wRiiT0Y1WhuPdze96AP2oJ4qaZ1
 jxjhgUl8EkfIc8HRTM8s+CsbRhJp0zOZshZ7uckyRiy8r7o56iqYM1ZzJd7zyubWKAJQqf2wkCs
 /AX4yoB4LWvj+7yW7UQEwkt5CoQwlr0miaFHHD70QwUPaX+vIKBbFgn0TRg==
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr940097ljq.492.1648529891363; 
 Mon, 28 Mar 2022 21:58:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo1ucp6iRI2NP8W/KCNXb4J4giLjR7oB42N/dthtVzQ5VaU8sSt/uhEAIYgGEW7MXrw7+yBOvKOwQKxLnbqos=
X-Received: by 2002:a05:651c:892:b0:249:9e23:15 with SMTP id
 d18-20020a05651c089200b002499e230015mr940084ljq.492.1648529891181; Mon, 28
 Mar 2022 21:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220328105817.1028065-1-xianting.tian@linux.alibaba.com>
 <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220328105817.1028065-2-xianting.tian@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Mar 2022 12:57:59 +0800
Message-ID: <CACGkMEsVjcQGLr8=OwpbhSJY3_Nn_am_YK7gQKdvV6PKUb9qRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_ring: add unlikely annotation for free descs
 check
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Mar 28, 2022 at 6:58 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> The 'if (vq->vq.num_free < descs_used)' check will almost always be false.
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d597fc0874ec..ab6d5f0cb579 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -525,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>                 descs_used = total_sg;
>         }
>
> -       if (vq->vq.num_free < descs_used) {
> +       if (unlikely(vq->vq.num_free < descs_used)) {
>                 pr_debug("Can't add buf len %i - avail = %i\n",
>                          descs_used, vq->vq.num_free);
>                 /* FIXME: for historical reasons, we force a notify here if
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
