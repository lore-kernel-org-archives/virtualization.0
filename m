Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD66C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D95D60AD2;
	Wed, 16 Feb 2022 04:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFijsY8JFNgr; Wed, 16 Feb 2022 04:14:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F2E5360B72;
	Wed, 16 Feb 2022 04:14:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A38C001A;
	Wed, 16 Feb 2022 04:14:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34006C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F7AA41632
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7YF0hfNckzfK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 679854162F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2raDdORm9sCAKZb6XeZ+x40LM248zzmNyFjzWRyfSv4=;
 b=eYy6jj32H+CapIlCTV1HmEfd0Ki+AP5VyXSKL8pnAqqVzn3OdZ66I307GDvPwT+cWJlGOV
 2CobOz7CICx1Mz8m5tl+IwFWvok285dxVaiYHLqNWiOgpJHFsaJhse3wGWtM/gYa5SKnno
 N8ruaRZKfNl8kFCic49WHt+BzCXZvzY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-RrmvP72IPrWEhGQ-UVMYeA-1; Tue, 15 Feb 2022 23:14:44 -0500
X-MC-Unique: RrmvP72IPrWEhGQ-UVMYeA-1
Received: by mail-lj1-f199.google.com with SMTP id
 y19-20020a2e9793000000b0023f158d6cc0so458411lji.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2raDdORm9sCAKZb6XeZ+x40LM248zzmNyFjzWRyfSv4=;
 b=KhHjJznvqR9llVgEbjd7KHeK+7M29UxE27iVn//wxe88wbs4dK703eWKQVFXw7sLFp
 u1Izdlr6jTs9Xg0v7W186RWujbFQUyzW8Xz6w/bPb7JKIxv1dsEPoDYMjDTrvm/Z2lxz
 NCr+eP025TYHxsZyKZohlM+bFS+Gn7bmTtDVAGSvS6XStZk6wg24goAZEmhYRr/N+Sjz
 AbS9+wiGoFWPWExZZalDQgehg2I9q/aJ1JTsFwxOEF7uH/uoNYgbKtKXpSX6ih+4CZzh
 O6HgOKFXMeRPlK6oDzOrtosVodGOJTU2Rkj5H9FuTavfuhIuvLC7VYaKLtyR8MydVxKl
 aPdw==
X-Gm-Message-State: AOAM532yJa8ecHAREPPH5s3j6YugqCfFRbQHq+9CbhD2xIRO/4NHwA6W
 kW0P3+43xGLC4AICh1snKyzoMkcK5r+kHVXSiOCj/jJlK/qVVHlGKJRtaN8DGu07LdUykEFcH5S
 6NstVHI2EATmDgNCY1Qpu+kHifzxJM3OhzZKwTLZQ01jEfT7yBGzUDrpeBQ==
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr684186lji.420.1644984882226; 
 Tue, 15 Feb 2022 20:14:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH6YX6v5CHZMPwVh4dpJuBHMaStdfAomp4/RnQuTSSt3QANNDD4w+gRLrrwap+t4sKtL3jQ5qhoIHJD7N0c7g=
X-Received: by 2002:a2e:8798:0:b0:244:d49b:956a with SMTP id
 n24-20020a2e8798000000b00244d49b956amr684177lji.420.1644984882033; Tue, 15
 Feb 2022 20:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:31 +0800
Message-ID: <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
Subject: Re: [PATCH v5 20/22] virtio_net: set the default max ring num
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Sets the default maximum ring num based on virtio_set_max_ring_num().
>
> The default maximum ring num is 1024.

Having a default value is pretty useful, I see 32K is used by default for IFCVF.

Rethink this, how about having a different default value based on the speed?

Without SPEED_DUPLEX, we use 1024. Otherwise

10g 4096
40g 8192

etc.

(The number are just copied from the 10g/40g default parameter from
other vendors)

Thanks

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a4ffd7cdf623..77e61fe0b2ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -35,6 +35,8 @@ module_param(napi_tx, bool, 0644);
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
>  #define GOOD_COPY_LEN  128
>
> +#define VIRTNET_DEFAULT_MAX_RING_NUM 1024
> +
>  #define VIRTNET_RX_PAD (NET_IP_ALIGN + NET_SKB_PAD)
>
>  /* Amount of XDP headroom to prepend to packets for use by xdp_adjust_head */
> @@ -3045,6 +3047,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>                         ctx[rxq2vq(i)] = true;
>         }
>
> +       virtio_set_max_ring_num(vi->vdev, VIRTNET_DEFAULT_MAX_RING_NUM);
> +
>         ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
>                                   names, ctx, NULL);
>         if (ret)
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
