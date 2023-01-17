Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CFBC46467
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 03:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A2EC416E4;
	Tue, 17 Jan 2023 03:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A2EC416E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=atVjC5jh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z0_ynERR3fJh; Tue, 17 Jan 2023 03:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC55416A9;
	Tue, 17 Jan 2023 03:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BC55416A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B9F2C0032;
	Tue, 17 Jan 2023 03:06:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0F53C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A51AB404A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:06:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A51AB404A9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=atVjC5jh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDmyDNnMePiJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB491402B1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB491402B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 03:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673924808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCv8L9Niwto4Q2Ad+faNDvGVhVwAWcTAHe2m/50/oBY=;
 b=atVjC5jhFfA8e+yGVi0pTqKBOIQhzQapEBxIglrS2MAGrO62YwYCus4+UTsY2Ebh8qJ3MP
 baa8SsK4oUFxg2GeSipVxJTa17vNjDypPTEd/uVH9S7SvEszyckiZRX6Tsa82DdK+XKQBn
 iVtLHOxi/KAJTk/OQBLV/+d8HPK9DIA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-p2l-6kWFPKyEFI94Drs0eA-1; Mon, 16 Jan 2023 22:06:47 -0500
X-MC-Unique: p2l-6kWFPKyEFI94Drs0eA-1
Received: by mail-ot1-f72.google.com with SMTP id
 cp12-20020a056830660c00b00682cd587d0cso7233338otb.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 19:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WCv8L9Niwto4Q2Ad+faNDvGVhVwAWcTAHe2m/50/oBY=;
 b=XPw83uCG6nA1M4SGJdbepDLAkKccdrtjr4X+b8yzD0f9Nfmdgzet+rU+HL2KTNp8+X
 iNVHPx4DL+e50W7oYmpZ8MBIYrZadIdJbkfjnOPYMuhsdcwxEjfB2F2HOwdfxTc6vt/g
 XsDAAIxz+Z0wfxmDdcKdW+0qCzPGcXj7xdIf6xE7GMLvHQqje7ry4F+eWl7itANgzXne
 N7XEaSRqiv9yNd5nqk7tKGYwkXn+iNMZdmDUdb6Tsjc2F+3Dncbo7NP/1acVQQKVRxd6
 JjatfnAVYl6BZbfwrIZreqv9rkU2nNaF9Ila4mZVOqmFT+mbx+ErjYedyqdD/OlDbjMN
 4JYQ==
X-Gm-Message-State: AFqh2kopyxqiEP0XZwI0ukneQDw25VCSxxkKYcVb6IiEH0jn0NbQfI6f
 VBjLlKQYGOrHXB6nkPx1SENduAD5KiU7T8QMBw9UmsN0Lhcn0L5Vm0qlFrIHKusFLVwjK8Ypi+y
 tn+FOvnjb+yLaPQxsGffnTtr4dt0CgtQLG/eY/gWZp+GZ10DjCHOUWhOUrg==
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr144235oab.280.1673924806267; 
 Mon, 16 Jan 2023 19:06:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuE4n9qengW9Wi+EitDgqK1mTSq/ug3YpFzqkdzLOAz1mDXbCkDmt8bbuyfQ5S9MX2FL0HT0CvWxCsOFkDEVFI=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr144225oab.280.1673924806018; Mon, 16
 Jan 2023 19:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20230116202708.276604-1-parav@nvidia.com>
In-Reply-To: <20230116202708.276604-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Jan 2023 11:06:35 +0800
Message-ID: <CACGkMEuoZXG=p4oaFd-BMDm=UpkD8tzG+CMiMOpyUHw1DZnkgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: Reuse buffer free function
To: Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Jan 17, 2023 at 4:27 AM Parav Pandit <parav@nvidia.com> wrote:
>
> virtnet_rq_free_unused_buf() helper function to free the buffer
> already exists. Avoid code duplication by reusing existing function.
>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7723b2a49d8e..31d037df514f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1251,13 +1251,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
>                 dev->stats.rx_length_errors++;
> -               if (vi->mergeable_rx_bufs) {
> -                       put_page(virt_to_head_page(buf));
> -               } else if (vi->big_packets) {
> -                       give_pages(rq, buf);
> -               } else {
> -                       put_page(virt_to_head_page(buf));
> -               }
> +               virtnet_rq_free_unused_buf(rq->vq, buf);
>                 return;
>         }
>
> --
> 2.26.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
