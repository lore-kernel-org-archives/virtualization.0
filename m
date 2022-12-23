Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF7C4332F
	for <virtualization@archiver.kernel.org>; Fri, 23 Dec 2022 06:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D50E4023B;
	Fri, 23 Dec 2022 06:28:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D50E4023B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i1sDHe3f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LPWqfCSmGsia; Fri, 23 Dec 2022 06:28:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 811EF40160;
	Fri, 23 Dec 2022 06:28:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 811EF40160
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32B4AC0071;
	Fri, 23 Dec 2022 06:28:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B1BC0070
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E00460AAC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:28:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E00460AAC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i1sDHe3f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8xieq2OJUJ6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:28:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B515860A87
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B515860A87
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 06:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671776903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+WPSmc09NBkvcoLHciePhR5uOL76wqGBtt7DhnGavw=;
 b=i1sDHe3fV6snO0gsmgBrPBSHxw0XlNvj5nrqHYvOV3LVNNh66EoPiJ59Rles8uk1MEcEkJ
 B8yd6/JDQUsbMoKo1zCyYpoioP3XS0/HI4lru/XbSORBorXXUYYtrP//0daV9yOMIWm3YW
 lMSijW/yd4nMvh6bdbhnTuSv0/iHZmw=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-fmsiHJd_MVuaVer5BoUVgQ-1; Fri, 23 Dec 2022 01:28:22 -0500
X-MC-Unique: fmsiHJd_MVuaVer5BoUVgQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1437fb9949bso2037868fac.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 22:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d+WPSmc09NBkvcoLHciePhR5uOL76wqGBtt7DhnGavw=;
 b=mIwpzO1Fe/yoLBXtxpooXAzkvTbE7vpslbVVBV9kkFlfnDN48bTu2MLIY7VjSI725O
 47A4QedpxCOlUuBDZRN1Lkz48GEa10tQOrp18pMjHm8Wkb9mrMcil/C7WFlsQJnxvwFV
 ykFV+RJHU98V73ymqgHzP6HgRiLP2uoJAC3bapq1kzsY3luzdK3IYCjmshKn37C0t0aL
 vrG3yqsiJ0J4E4KK267MDxZk/GX7l6xmUFUr6DyU8XN5eOTAJuP+JsU+v7QKMyz2rmxv
 5fGWtPMk1dq1lJPIO406C8EFt7cXU9xXDNdJOgfZuzUW+FAbD6gF3w+OW1qHSKiBSN42
 xeMw==
X-Gm-Message-State: AFqh2kpwlhAw2Y6A4wLohdyd0P4Ql4IvtqXs7sx6ZpZH1l8OqOeen0hG
 /HeJIhjeov3ToXKkguKBI/hUyBkstMP9rgIRhMzD/PMbkE4HEsqcZeyPESEh8hPcZvGN3n1vmSd
 seLIBqgQK7xP9LA7QAiRXlByqu/bxNNWMrNu1Xi9W8rq/jf7SxdcM4JynIA==
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr520500otm.237.1671776901588; 
 Thu, 22 Dec 2022 22:28:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCyTF0iGCkFN/1nmqABJszPQHoPYz50tbJpkeRQsl43VUbwWnc16mtfHlwMFUc3WtPbLOU7JxUEqY7DULu4RE=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr520497otm.237.1671776901377; Thu, 22 Dec
 2022 22:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20221222193214.55146-1-mst@redhat.com>
In-Reply-To: <20221222193214.55146-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Dec 2022 14:28:10 +0800
Message-ID: <CACGkMEtayXtio4OVDdtWXM3v4giGncT9MCybiYbJoZAGmK=Ppw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: mark all zone fields LE
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Fri, Dec 23, 2022 at 3:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> zone is a virtio 1.x feature so all fields are LE,
> they are handled as such, but have mistakenly been labeled
> __virtioXX in the header.  This results in a bunch of sparse warnings.
>
> Use the __leXX tags to make sparse happy.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  include/uapi/linux/virtio_blk.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index f4d5ee7c6f30..ec3c3779406f 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -141,11 +141,11 @@ struct virtio_blk_config {
>
>         /* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
>         struct virtio_blk_zoned_characteristics {
> -               __virtio32 zone_sectors;
> -               __virtio32 max_open_zones;
> -               __virtio32 max_active_zones;
> -               __virtio32 max_append_sectors;
> -               __virtio32 write_granularity;
> +               __le32 zone_sectors;
> +               __le32 max_open_zones;
> +               __le32 max_active_zones;
> +               __le32 max_append_sectors;
> +               __le32 write_granularity;
>                 __u8 model;
>                 __u8 unused2[3];
>         } zoned;
> @@ -245,11 +245,11 @@ struct virtio_blk_outhdr {
>   */
>  struct virtio_blk_zone_descriptor {
>         /* Zone capacity */
> -       __virtio64 z_cap;
> +       __le64 z_cap;
>         /* The starting sector of the zone */
> -       __virtio64 z_start;
> +       __le64 z_start;
>         /* Zone write pointer position in sectors */
> -       __virtio64 z_wp;
> +       __le64 z_wp;
>         /* Zone type */
>         __u8 z_type;
>         /* Zone state */
> @@ -258,7 +258,7 @@ struct virtio_blk_zone_descriptor {
>  };
>
>  struct virtio_blk_zone_report {
> -       __virtio64 nr_zones;
> +       __le64 nr_zones;
>         __u8 reserved[56];
>         struct virtio_blk_zone_descriptor zones[];
>  };
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
