Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3356BC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBB9E40352;
	Mon,  7 Mar 2022 04:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tJbVlV0UMiaH; Mon,  7 Mar 2022 04:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 62D884033C;
	Mon,  7 Mar 2022 04:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44B6DC001D;
	Mon,  7 Mar 2022 04:28:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3FE9C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 04:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EEED401F5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 04:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LIBfPoDiTT-U
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 04:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D2E5401E7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 04:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646627306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9tbExO3BDZat3L0Mr6cR1o35ZQT83FwaaZZrCN3AvXs=;
 b=Md9CH+nNZmfkHtDtJJ2gzg2uGM/eAQWQRc8oQYSax0mtxN3ps7KWZeni1ywLHJi6FrGQks
 djPdhK9AAog6TbwbiUR2rWM6lOvfckw4CFdpf3rh3g8FsCHrkMTI7L3a9K6qEEjcnZ6OQw
 UIkZfu3QTKh/vKTN7IRobfyRZYtvCkg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-G_9wc0sjPki5zb6RA1_OJg-1; Sun, 06 Mar 2022 23:28:23 -0500
X-MC-Unique: G_9wc0sjPki5zb6RA1_OJg-1
Received: by mail-lf1-f69.google.com with SMTP id
 i22-20020a0565123e1600b004482f623159so131827lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Mar 2022 20:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9tbExO3BDZat3L0Mr6cR1o35ZQT83FwaaZZrCN3AvXs=;
 b=nM/CjV2cr8MxKqdbJvW+YY8V4XnOSQsGwz3dlxr8niIGLQu8giVrsURrpLlTvkbE7c
 umh41hMOHKH026qZMEeGbCJtDAzUXc6EHRfUQrd4PSUC0jq+healJWuPxn2u3gUn5sn4
 ITgI1M6UGdKNUx3a6s/2GTSq7f93ZKnhF+bEDAPyUAduw1naY8UlilvPff8aK/Fj64Ro
 W8mp92Lb3l3GnHz8OFjMrVSPTncxRu82quAvChW3Za56YrzSyrjm2ajGGtz5Q0vEgkKB
 cqSrcIDUPHAp7fem3h6gKdBuB+o1bNzb2yIy8xAPsRRLHBcBwSJAXGZblpQM9p2RFSIO
 ak7A==
X-Gm-Message-State: AOAM53171Ig60wJbpH1aardDd3+BlN7eR39fkoePMbyQbrVd/rz5YSY/
 bemQCfB4ihHQyZYv4QT1QR4kx6esaFzUJFtWPeDKIc3Ptoo+VI3IEY7Ixa4i5znvY9H6S9kv2VH
 YgK8R8hROvepEiCqPcDpdjWMddNqjFy6xQK19GX7Jca1vpaz45+QckIE1dg==
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id
 y4-20020a2eb004000000b00247e29ffbd4mr3315714ljk.315.1646627302403; 
 Sun, 06 Mar 2022 20:28:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7t/FmOlAHsaca3+vPWPLkhh6GrRRORwyNVIv0iuzGeDQK5UazN9tjcM5HcXUU0LViwU9VgxZDMfLowP80K9M=
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id
 y4-20020a2eb004000000b00247e29ffbd4mr3315706ljk.315.1646627302185; Sun, 06
 Mar 2022 20:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20220305095525.5145-1-mail@anirudhrb.com>
In-Reply-To: <20220305095525.5145-1-mail@anirudhrb.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Mar 2022 12:28:10 +0800
Message-ID: <CACGkMEtb6qSq2=WXWeaDZknw77C7pQwSgxP0-KxCCVhTyM-HwQ@mail.gmail.com>
Subject: Re: [PATCH v3] vhost: fix hung thread due to erroneous iotlb entries
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

On Sat, Mar 5, 2022 at 5:56 PM Anirudh Rayabharam <mail@anirudhrb.com> wrote:
>
> In vhost_iotlb_add_range_ctx(), range size can overflow to 0 when
> start is 0 and last is ULONG_MAX. One instance where it can happen
> is when userspace sends an IOTLB message with iova=size=uaddr=0
> (vhost_process_iotlb_msg). So, an entry with size = 0, start = 0,
> last = ULONG_MAX ends up in the iotlb. Next time a packet is sent,
> iotlb_access_ok() loops indefinitely due to that erroneous entry.
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
> To fix this, do two things:
>
> 1. Return -EINVAL in vhost_chr_write_iter() when userspace asks to map
>    a range with size 0.
> 2. Fix vhost_iotlb_add_range_ctx() to handle the range [0, ULONG_MAX]
>    by splitting it into two entries.
>
> Fixes: 0bbe30668d89e ("vhost: factor out IOTLB")
> Reported-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
> Changes in v3:
> 1. Simplify expression since start is always 0
> 2. Fix checkpatch issue
> 3. Add Fixes tag
>
> v2: https://lore.kernel.org/kvm/20220224143320.3751-1-mail@anirudhrb.com/
> Changes in v2:
> 1. Don't reject range [0, ULONG_MAX], split it instead.
> 2. Validate msg.size in vhost_chr_write_iter().
>
> v1: https://lore.kernel.org/lkml/20220221195303.13560-1-mail@anirudhrb.com/
>
> ---
>  drivers/vhost/iotlb.c | 11 +++++++++++
>  drivers/vhost/vhost.c |  5 +++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 670d56c879e5..40b098320b2a 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -57,6 +57,17 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>         if (last < start)
>                 return -EFAULT;
>
> +       /* If the range being mapped is [0, ULONG_MAX], split it into two entries
> +        * otherwise its size would overflow u64.
> +        */
> +       if (start == 0 && last == ULONG_MAX) {
> +               u64 mid = last / 2;
> +
> +               vhost_iotlb_add_range_ctx(iotlb, start, mid, addr, perm, opaque);

Do we need to check the errors and fail?

Others look good.

Thanks

> +               addr += mid + 1;
> +               start = mid + 1;
> +       }
> +
>         if (iotlb->limit &&
>             iotlb->nmaps == iotlb->limit &&
>             iotlb->flags & VHOST_IOTLB_FLAG_RETIRE) {
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..55475fd59fb7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1170,6 +1170,11 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>                 goto done;
>         }
>
> +       if (msg.size == 0) {
> +               ret = -EINVAL;
> +               goto done;
> +       }
> +
>         if (dev->msg_handler)
>                 ret = dev->msg_handler(dev, &msg);
>         else
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
