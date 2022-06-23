Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA4AC433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Jun 2022 03:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA7FB845EE;
	Thu, 23 Jun 2022 03:41:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA7FB845EE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IoAWaiPU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9yPe7Q0-iL1; Thu, 23 Jun 2022 03:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24CF4845EB;
	Thu, 23 Jun 2022 03:41:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24CF4845EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED434C0032;
	Thu, 23 Jun 2022 03:41:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E45D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AACF160BA9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:41:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AACF160BA9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IoAWaiPU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VfVthiLlL-vj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:41:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7EAF60A71
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7EAF60A71
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 03:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655955659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiF/hZE79qFgnRr7vycw43sCH5KeoUxCMY9Y1NxAp7k=;
 b=IoAWaiPUOY1hvAcUdsGfZepGQhwvjSVHNWgM0U69p8WctZwTPO3ivju1p1jGyRd3Ne60ja
 +1UwLs49LXAvT7265z/yXtjTYsylNJmaV5+21wF4GYz4rU5eNhG2Qn7pxwMC2G/R28ST3y
 Bd5S9hZTgm3Vh5y7k9RwOQrcDZYX1Eo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-AxWp5utaM0GHTx84ehe2jQ-1; Wed, 22 Jun 2022 23:40:56 -0400
X-MC-Unique: AxWp5utaM0GHTx84ehe2jQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 n5-20020a0565120ac500b0047da8df6b2cso9410714lfu.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 20:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KiF/hZE79qFgnRr7vycw43sCH5KeoUxCMY9Y1NxAp7k=;
 b=eZfuyK2gjO5XnLWJBVa/7R0vXeGBOBc/NE0YAW1Jz1i+1k2TtbWx0TwGpF52WBmmHM
 VQWavD28c2mxJgfFf1oLm47sXYz7d9j/kXrr0oQaaEsSymklpxrGRbuyAC5VOyBVgPsn
 Sct9F/Z947ai1iLFBrzsQy+NUQRB9k3kn6BnPNt+YrZS3QB6Z1al8KvRlBkU1WFSqrm5
 pWUY/Se+zYt3RaryABvfGIP+vSiViLnEKgwQCmK4EJTY4dXAi0rYqkr2OaXQf2cUWwkM
 RUvROxXqEUDw9HPAq0aj3Q5KWsC9sMAQKnsvVY5oziu5nJ6QuaYsxq7aCi256rDbev8O
 BauA==
X-Gm-Message-State: AJIora8GFEP5iuKAlsKyYHPssYaZ1+aOO0+min4abPguB+Xtu2du02un
 oCpgC+lZV9LtkrpXjegvJ9c6KZrPK1auTOIaPhNB/Qz2vKGNHZaV4F9i0EdgHUQ9f+fpKVGkZML
 wkajnImcPOIwyuuSWa5/dj/77vQoklJrk78Xtaeas1RM+xfN57FLPoVxlWg==
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr497871ljo.487.1655955654821; 
 Wed, 22 Jun 2022 20:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0vnxyVZ3lSg79H5V5lG6eHxw0VCJyRXUocHKOF/cwDjvQDRinefk8NlQ3aWmf8BWIcnr0CohuTQZgm8bFcGs=
X-Received: by 2002:a2e:b703:0:b0:25a:93d0:8a57 with SMTP id
 j3-20020a2eb703000000b0025a93d08a57mr497860ljo.487.1655955654604; Wed, 22 Jun
 2022 20:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160859.196646-1-sgarzare@redhat.com>
 <20220621160859.196646-2-sgarzare@redhat.com>
In-Reply-To: <20220621160859.196646-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jun 2022 11:40:43 +0800
Message-ID: <CACGkMEsdx24TMSw_HgDemNKLAQJfym_fkn-th1HEX8q8ESRoag@mail.gmail.com>
Subject: Re: [PATCH 1/3] vdpa_sim_blk: use dev_dbg() to print errors
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

On Wed, Jun 22, 2022 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Use dev_dbg() instead of dev_err()/dev_warn() to avoid flooding the
> host with prints, when the guest driver is misbehaving.
> In this way, prints can be dynamically enabled when the vDPA block
> simulator is used to validate a driver.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 42d401d43911..a83a5c76f620 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -76,13 +76,13 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                 return false;
>
>         if (vq->out_iov.used < 1 || vq->in_iov.used < 1) {
> -               dev_err(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
> +               dev_dbg(&vdpasim->vdpa.dev, "missing headers - out_iov: %u in_iov %u\n",
>                         vq->out_iov.used, vq->in_iov.used);
>                 return false;
>         }
>
>         if (vq->in_iov.iov[vq->in_iov.used - 1].iov_len < 1) {
> -               dev_err(&vdpasim->vdpa.dev, "request in header too short\n");
> +               dev_dbg(&vdpasim->vdpa.dev, "request in header too short\n");
>                 return false;
>         }
>
> @@ -96,7 +96,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &hdr,
>                                       sizeof(hdr));
>         if (bytes != sizeof(hdr)) {
> -               dev_err(&vdpasim->vdpa.dev, "request out header too short\n");
> +               dev_dbg(&vdpasim->vdpa.dev, "request out header too short\n");
>                 return false;
>         }
>
> @@ -110,7 +110,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>         switch (type) {
>         case VIRTIO_BLK_T_IN:
>                 if (!vdpasim_blk_check_range(sector, to_push)) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "reading over the capacity - offset: 0x%llx len: 0x%zx\n",
>                                 offset, to_push);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -121,7 +121,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                               vdpasim->buffer + offset,
>                                               to_push);
>                 if (bytes < 0) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "vringh_iov_push_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
>                                 bytes, offset, to_push);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -133,7 +133,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>
>         case VIRTIO_BLK_T_OUT:
>                 if (!vdpasim_blk_check_range(sector, to_pull)) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "writing over the capacity - offset: 0x%llx len: 0x%zx\n",
>                                 offset, to_pull);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -144,7 +144,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                               vdpasim->buffer + offset,
>                                               to_pull);
>                 if (bytes < 0) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "vringh_iov_pull_iotlb() error: %zd offset: 0x%llx len: 0x%zx\n",
>                                 bytes, offset, to_pull);
>                         status = VIRTIO_BLK_S_IOERR;
> @@ -157,7 +157,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                                               vdpasim_blk_id,
>                                               VIRTIO_BLK_ID_BYTES);
>                 if (bytes < 0) {
> -                       dev_err(&vdpasim->vdpa.dev,
> +                       dev_dbg(&vdpasim->vdpa.dev,
>                                 "vringh_iov_push_iotlb() error: %zd\n", bytes);
>                         status = VIRTIO_BLK_S_IOERR;
>                         break;
> @@ -167,8 +167,8 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>                 break;
>
>         default:
> -               dev_warn(&vdpasim->vdpa.dev,
> -                        "Unsupported request type %d\n", type);
> +               dev_dbg(&vdpasim->vdpa.dev,
> +                       "Unsupported request type %d\n", type);
>                 status = VIRTIO_BLK_S_IOERR;
>                 break;
>         }
> --
> 2.36.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
