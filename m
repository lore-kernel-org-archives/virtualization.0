Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E931AC433FE
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 02:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27B2B408E7;
	Tue, 22 Feb 2022 02:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZzWzVmDrQZTH; Tue, 22 Feb 2022 02:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D30B408D9;
	Tue, 22 Feb 2022 02:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6815C0021;
	Tue, 22 Feb 2022 02:50:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0E5EC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 02:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A643813E3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 02:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFaix5WfHFbe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 02:50:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74D2B813B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645498236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMERnC5Lx3ZdDjMyWgRECzQ+geOBGfR8Zn1RSSoIhoE=;
 b=cIB5eoGme6CZGxWXY/gGRli5yAbFgrUfj7Do3eUX1Padwp4yWU3dUEe2jKs1LVgC7tGvPd
 yVbAHgzW7PPy+bshsXno0mXF9+XlODQYQXcpd3yrJtn9wOVpmA+V+FyHxeK8L8zhjn4K+v
 YrGkb0sy91GZRazKgUUrVJQcGeHfeQM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-APP3KHvQPZOvKwyblkS06g-1; Mon, 21 Feb 2022 21:50:33 -0500
X-MC-Unique: APP3KHvQPZOvKwyblkS06g-1
Received: by mail-lj1-f198.google.com with SMTP id
 o1-20020a2eb301000000b0024640251ba9so2049495lja.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 18:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sMERnC5Lx3ZdDjMyWgRECzQ+geOBGfR8Zn1RSSoIhoE=;
 b=nVrgekLP0Ti5G+7vnVU+umZ81UWV9J3x5yltLRBZ3r8f2ZL+WlFtm2sfk36C0SYoRw
 2xiOqLPijAK9EFLZzhlI0einCUbEhTZGulgKVL3HKDffgszwOoVMJthIMLpb9uRqbHXw
 kP2T70/qDR73I+XvL+q890KaIZBXrUpdFI5njijtj1JNlxSaTxgRmUq5sAfbYx2P2/14
 7A++UqUsCH6XQ/mZ1eBoXLc5KgFkQq4CFdUaZRZ8DjD/zdYf7WyUViVhaF5i4tCn8d8H
 ZGGO41lchzKKkuGpyqbChDt0nL2bsouyBBp2gmOkwbwPmZ9gwhfENcEcBcYPEcnHPksQ
 syTg==
X-Gm-Message-State: AOAM533VBLTpwmYpUaPQ+Zdm/Hp32AArNthcTRe3eUcJC07vhcReKg3j
 PfOdN/8sQ83ca5lRNxAjffXWvNJhbFt5adEwa4yfspu5j3/QoFXmfczny2ki+o5hot9cSFIlNrl
 XjADzgSPHuEtk7X15QW05RNrRgWlUzhPdpuXKS2+zdqCww65nXDEKEfPyPQ==
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16189694lfq.84.1645498232049; 
 Mon, 21 Feb 2022 18:50:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCDJBSK5aeabUkY9YzJtmGlAXsaWKwi+31r65bcAa3YUsXyGltr5v5jpXObhmF/f1wYMJQ7FAIEVVK/vj/AiU=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16189687lfq.84.1645498231872; Mon, 21
 Feb 2022 18:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20220221195303.13560-1-mail@anirudhrb.com>
In-Reply-To: <20220221195303.13560-1-mail@anirudhrb.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 10:50:20 +0800
Message-ID: <CACGkMEvLE=kV4PxJLRjdSyKArU+MRx6b_mbLGZHSUgoAAZ+-Fg@mail.gmail.com>
Subject: Re: [PATCH] vhost: validate range size before adding to iotlb
To: Anirudh Rayabharam <mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
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

On Tue, Feb 22, 2022 at 3:53 AM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
>
> In vhost_iotlb_add_range_ctx(), validate the range size is non-zero
> before proceeding with adding it to the iotlb.
>
> Range size can overflow to 0 when start is 0 and last is (2^64 - 1).
> One instance where it can happen is when userspace sends an IOTLB
> message with iova=size=uaddr=0 (vhost_process_iotlb_msg). So, an
> entry with size = 0, start = 0, last = (2^64 - 1) ends up in the
> iotlb. Next time a packet is sent, iotlb_access_ok() loops
> indefinitely due to that erroneous entry:
>
>         Call Trace:
>          <TASK>
>          iotlb_access_ok+0x21b/0x3e0 drivers/vhost/vhost.c:1340
>          vq_meta_prefetch+0xbc/0x280 drivers/vhost/vhost.c:1366
>          vhost_transport_do_send_pkt+0xe0/0xfd0 drivers/vhost/vsock.c:104
>          vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
>          kthread+0x2e9/0x3a0 kernel/kthread.c:377
>          ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>          </TASK>
>
> Reported by syzbot at:
>         https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
>
> Reported-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/vhost/iotlb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 670d56c879e5..b9de74bd2f9c 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -53,8 +53,10 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>                               void *opaque)
>  {
>         struct vhost_iotlb_map *map;
> +       u64 size = last - start + 1;
>
> -       if (last < start)
> +       // size can overflow to 0 when start is 0 and last is (2^64 - 1).
> +       if (last < start || size == 0)
>                 return -EFAULT;

I'd move this check to vhost_chr_iter_write(), then for the device who
has its own msg handler (e.g vDPA) can benefit from it as well.

Thanks

>
>         if (iotlb->limit &&
> @@ -69,7 +71,7 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>                 return -ENOMEM;
>
>         map->start = start;
> -       map->size = last - start + 1;
> +       map->size = size;
>         map->last = last;
>         map->addr = addr;
>         map->perm = perm;
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
