Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD2C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:31:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAA260F22
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCAA260F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ADD760758;
	Mon, 25 Oct 2021 02:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOPKhCObvMlC; Mon, 25 Oct 2021 02:31:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBF7C600B9;
	Mon, 25 Oct 2021 02:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C59EC0012;
	Mon, 25 Oct 2021 02:31:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19DA7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E82CA4010A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rSM0Nid6aXtN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:31:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E85AA400F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635129072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5Oz1yImGGZUHz2EZai+SPCSCSljrW8cHwY9v7uuMJA=;
 b=CEke0CjeQhhtueDUbp3+5qShQL002qY7D2wIaYbMGBR42kp/pFCyiqwM6r/a4ZoBGAM06J
 ISJSeUCNb9/79mRAGoM1TgCcayPYt/ZJ5OUUfQCbqzJIBVBlWSApQ/tkeePuaHt/BOsHFL
 Kcv31+vMKv4BnoPX0czXrbLsIED//AE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-P-5boatnN_Civs8z3tUakQ-1; Sun, 24 Oct 2021 22:31:11 -0400
X-MC-Unique: P-5boatnN_Civs8z3tUakQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 k15-20020a05651239cf00b003fe1ba9c94cso4596868lfu.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 19:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O5Oz1yImGGZUHz2EZai+SPCSCSljrW8cHwY9v7uuMJA=;
 b=xhDCGLrU0jv/yXSUysdVUIdMsunfvGBc9LBwWO6HV8gHW2cbHh/z0VBGJ562WXXaWz
 9MRhBEhmNe3IfnS/N+ifBjz/x0O15WwKttbyJdj6V71G/LdoMFE0cPiQu+dc5YfwjIk9
 QRS0VU+d0Agy+BdhPeK7OInX3DYa1Upvdjp16RyVbci+WEHZewNa16xdaE3zjMTSgOuP
 HWL2A884t0CBgX4eVumwest0tU/kJhvPVwK+XDXuLfIuMAy4Ic9ZNhoS+TmyM6xI4AC2
 KXaXR1rJxyfnvcSlqUnK/VPJvXm6x7nIbVnwz9I43gg7WlCESt+PF0gPXGSyyP1JgDvR
 NDRw==
X-Gm-Message-State: AOAM5336dVPXPAyQkbQn0g1egitTowfVyzUlu6TAA767zuoWBpee/Tfa
 OKrg0jbigYe1kRjtYTS9mlyXrO2KyJDNqBDIMxLcKhLhKjozeRsqTnTRMCCUfaOiO5NSwOli8p1
 MYMyC7zKbL0niUOOi3eyz7hWxsBxJNBr33104zeJDH0GILVjlMnA7oY5cIA==
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr9397592lfv.481.1635129070041; 
 Sun, 24 Oct 2021 19:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlsLM/uyIep7GFdealvQf2xj47yGLBJrEmgQ5fqDtsyUK0M0zQLyM0ociWyqYqWx1C2KZVQXJ9yP2hq0wrrvY=
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr9397573lfv.481.1635129069857; 
 Sun, 24 Oct 2021 19:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211025015641.48293-1-xuanzhuo@linux.alibaba.com>
 <20211025015641.48293-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20211025015641.48293-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 10:30:59 +0800
Message-ID: <CACGkMEtrAOxW+dninovoWjCqYgQa2+dcUd_k8G4u2bWhTCb8SA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] virtio_ring: check desc == NULL when using
 indirect with packed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: sfr@canb.auug.org.au,
 virtualization <virtualization@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Oct 25, 2021 at 9:56 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> When using indirect with packed, we don't check for allocation failures.
> This patch checks that and fall back on direct.
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/virtio/virtio_ring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 91a46c4da87d..bc92a2faa28f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1065,6 +1065,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>
>         head = vq->packed.next_avail_idx;
>         desc = alloc_indirect_packed(total_sg, gfp);
> +       if (!desc)
> +               return -ENOMEM;
>
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail = 0\n");
> @@ -1176,6 +1178,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>         unsigned int i, n, c, descs_used, err_idx;
>         __le16 head_flags, flags;
>         u16 head, id, prev, curr, avail_used_flags;
> +       int err;
>
>         START_USE(vq);
>
> @@ -1191,9 +1194,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
>         BUG_ON(total_sg == 0);
>
> -       if (virtqueue_use_indirect(_vq, total_sg))
> -               return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> -                               out_sgs, in_sgs, data, gfp);
> +       if (virtqueue_use_indirect(_vq, total_sg)) {
> +               err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> +                                                   in_sgs, data, gfp);
> +               if (err != -ENOMEM)
> +                       return err;
> +
> +               /* fall back on direct */
> +       }
>
>         head = vq->packed.next_avail_idx;
>         avail_used_flags = vq->packed.avail_used_flags;
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
