Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C939C43334
	for <virtualization@archiver.kernel.org>; Thu, 23 Jun 2022 03:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115458194C;
	Thu, 23 Jun 2022 03:52:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 115458194C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwyuuIuX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XF3VfztfJuba; Thu, 23 Jun 2022 03:52:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BF1A817AC;
	Thu, 23 Jun 2022 03:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BF1A817AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D3E2C0032;
	Thu, 23 Jun 2022 03:52:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E4CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08C95417D5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:52:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08C95417D5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwyuuIuX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6i5l7LkLxdV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:52:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 813D2417CF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 813D2417CF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655956354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oERTIQYSyhXKjQ8GU8XC7srVUHfe3PX7kQp/nyf4Iak=;
 b=TwyuuIuXqsp6OvqlELIUNlT+PK0lypudWpUVT90CWk0xsAwbUohnc3PQapncRiAz5WDTga
 HToLLjQik1BSANZLHWlrgXMnBgYjK6VbkJy55lCoNj9gtggAOLc4X/DwUuRED9Ldt/qdcX
 hWGGff8dcBxVxDkNEsW1rggaH+XNf4I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-T_UaHM93OkusvQeu3DshHg-1; Wed, 22 Jun 2022 23:52:32 -0400
X-MC-Unique: T_UaHM93OkusvQeu3DshHg-1
Received: by mail-lf1-f69.google.com with SMTP id
 bp15-20020a056512158f00b0047f603e5f92so6317193lfb.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 20:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oERTIQYSyhXKjQ8GU8XC7srVUHfe3PX7kQp/nyf4Iak=;
 b=ZbaTsXTwMRmsOZ5Zilto4yN0xbCurJpcJoQdyt5Czdu0BFdM5qsMtuSlOBckGjCqX8
 POpIObhrnwcWhajv8lbYzrl6cokvsdlOecA0EK33bUcgiT1DWCUKL5WevBjGzVI7IQgA
 j/CxTNqOdu7Z+hq+Iea8DhmQcGVG5FZU44tHM9az2RAs7IfwcC/2hIytDqxcPBjaQWVx
 QHH3quQPexvA558CfE4RLBse1zt4zufOOfyq1JGPSIsJu2VvKSNk9Y3c/e9uSUikNIhQ
 tO2cMK8S8dzHjUaxL/TK4s1KdyfTNQIsNvFLA37Ec5ilPBIDU1jXT2WGZFZY9kXKAyMO
 EE2g==
X-Gm-Message-State: AJIora/Aoy9zAlIk8fs6jJWl7Jey16E/fRWYq2oHhAtrlJxEDWNmQ+xN
 WuCMurW/YHQg34Y5aCqttDZoSO94JTp4Jl3rkkteuZQy7jLmaoaof6JDisG3VvEoTj+yLzNCsZE
 7gp2wZUqpu7COrrFe10kMfHq9B9BFq9G3GeUcXcoIXFeWkjgC7/MabVtw1g==
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id
 z23-20020a2e8417000000b0025a7fa7fe5amr3560107ljg.323.1655956350781; 
 Wed, 22 Jun 2022 20:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uSjD9XhGJKPyenHAlWNgLInipzPx6LybWaTzbpUqxCCMKR0OcRWGtAVXq+T87H4VBC/po+k+b6agP6rWTAm10=
X-Received: by 2002:a2e:8417:0:b0:25a:7fa7:fe5a with SMTP id
 z23-20020a2e8417000000b0025a7fa7fe5amr3560098ljg.323.1655956350580; Wed, 22
 Jun 2022 20:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621161252.197173-1-sgarzare@redhat.com>
In-Reply-To: <20220621161252.197173-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jun 2022 11:52:19 +0800
Message-ID: <CACGkMEv1Y_rKSc799qi2=EkrQfm4E_d9aMWefXyz5h4vdXjxgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa_sim_blk: call vringh_complete_iotlb() also in
 the error path
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Jun 22, 2022 at 12:13 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Call vringh_complete_iotlb() even when we encounter a serious error
> that prevents us from writing the status in the "in" header
> (e.g. the header length is incorrect, etc.).
>
> The guest is misbehaving, so maybe the ring is in a bad state, but
> let's avoid making things worse.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index ac86478845b6..de9cd9843143 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -63,6 +63,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>  {
>         size_t pushed = 0, to_pull, to_push;
>         struct virtio_blk_outhdr hdr;
> +       bool handled = false;
>         ssize_t bytes;
>         loff_t offset;
>         u64 sector;
> @@ -78,12 +79,12 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
>                 dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
>                         vq->out_iov.used, vq->in_iov.used);
> -               return false;
> +               goto err;
>         }
>
>         if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
>                 dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
> -               return false;
> +               goto err;
>         }
>
>         /* The last byte is the status and we checked if the last iov has
> @@ -97,7 +98,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                       sizeof(hdr));
>         if (bytes != sizeof(hdr)) {
>                 dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
> -               return false;
> +               goto err;
>         }
>
>         to_pull -= bytes;
> @@ -182,16 +183,19 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         /* Last byte is the status */
>         bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov, &status, 1);
>         if (bytes != 1)
> -               return false;
> +               goto err;
>
>         pushed += bytes;
>
>         /* Make sure data is wrote before advancing index */
>         smp_wmb();
>
> +       handled = true;
> +
> +err:
>         vringh_complete_iotlb(&vq->vring, vq->head, pushed);
>
> -       return true;
> +       return handled;
>  }
>
>  static void vdpasim_blk_work(struct work_struct *work)
> --
> 2.36.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
