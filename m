Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F197C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 02:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B027409A5;
	Thu, 10 Nov 2022 02:04:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B027409A5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KIEnuw+/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLnhWa1-vjTn; Thu, 10 Nov 2022 02:04:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A77D402EA;
	Thu, 10 Nov 2022 02:04:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A77D402EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2617AC0033;
	Thu, 10 Nov 2022 02:04:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 02:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F134760AC2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 02:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F134760AC2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KIEnuw+/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KEOzdbaOV0jb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 02:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D37D607BC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D37D607BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668045849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XUbS7kkdkTb1FJ8Puq8bD35jK/Y5vjFwMtJetj4Fh+E=;
 b=KIEnuw+/U540KLohStDbLdO1bTYr8ky3NPrKqMr2kB6PDbBtBhhvZr54bREdIRP80YbR1d
 pvxcPaXhd0rZgAZ8SMJ9+4dBUx9RoTW/bqo34325B1AL5i58HEpHqOr9TsgvtRB2s9032f
 dPOd3hcrQEXFchwiH0TObJxcquWyWGw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-7DVhrtAQMXyuAPkmFajBdQ-1; Wed, 09 Nov 2022 21:04:08 -0500
X-MC-Unique: 7DVhrtAQMXyuAPkmFajBdQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 n19-20020a0568301e9300b0066c3b6f5dd0so359344otr.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 18:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUbS7kkdkTb1FJ8Puq8bD35jK/Y5vjFwMtJetj4Fh+E=;
 b=UqFn14l6f3hZtRUR7TUPya22HNOr+EPi9VpM3MuqN2rWoZrmSJtJGSRrvFnYzI4v30
 3ZhtUi3VtzpkwXrFNZuGyBXxTy3r6rs5ISaclwXEaidQHtOQqCAE6GuQI2zjWETnNYMo
 +a/n/Pf24wD76Q5x6Jo7zTMPaMDM0wbSvUMkCDXxV0jpB1bznM4ZhE0ppAojo5PI2NRm
 gn/K4FDRdMA9ejzfiuQHoeyETMQr2nO0JeeOedwFJCXAqWW99cYM7sAecBWk/EeP9Xkg
 JxPo365XyKEmWf+ou7TDfFUB4TNUgHksOqfRjTkB1sRlAyfRL0y4CBN7hMo5tDID0Isy
 BqHw==
X-Gm-Message-State: ACrzQf0q7uN9qbGQfxg+tnu1G9xCGITYWhHDEINWUGfLrw7tvDlfbIQ9
 8aq8ihCKSSfw+b29zV0kH9Sy1Lm5a0TsUePOTQ64lkBYRV60o7esw1FApAf1GrbaKf6oIjvREQb
 /okZ+YAuG6GqdLlVTpFbG5hWk8WlWrHnFV39YCB8T8v2kbEpdZKOxk2XYqQ==
X-Received: by 2002:a9d:604f:0:b0:66c:64d6:1bb4 with SMTP id
 v15-20020a9d604f000000b0066c64d61bb4mr984593otj.201.1668045842957; 
 Wed, 09 Nov 2022 18:04:02 -0800 (PST)
X-Google-Smtp-Source: AMsMyM45UkiwIqipZjueepL0FmRYOH9f819x2rJtJU36H2CB7TpfTuSLZCNIGl3lRKPzdZ9V6etpqCxhc4a3+nN7pxg=
X-Received: by 2002:a9d:604f:0:b0:66c:64d6:1bb4 with SMTP id
 v15-20020a9d604f000000b0066c64d61bb4mr984589otj.201.1668045842684; Wed, 09
 Nov 2022 18:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20221109154213.146789-1-sgarzare@redhat.com>
In-Reply-To: <20221109154213.146789-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 10:03:50 +0800
Message-ID: <CACGkMEu8qVjDwBmsow17ct6QtgPd-Bch7Z7jKiHveicGPVrrvg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: fix potential memory leak during the release
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

On Wed, Nov 9, 2022 at 11:42 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Before commit 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
> we call vhost_vdpa_iotlb_unmap(v, iotlb, 0ULL, 0ULL - 1) during the
> release to free all the resources allocated when processing user IOTLB
> messages through vhost_vdpa_process_iotlb_update().
> That commit changed the handling of IOTLB a bit, and we accidentally
> removed some code called during the release.
>
> We partially fixed with commit 037d4305569a ("vhost-vdpa: call
> vhost_vdpa_cleanup during the release") but a potential memory leak is
> still there as showed by kmemleak if the application does not send
> VHOST_IOTLB_INVALIDATE or crashes:
>
>   unreferenced object 0xffff888007fbaa30 (size 16):
>     comm "blkio-bench", pid 914, jiffies 4294993521 (age 885.500s)
>     hex dump (first 16 bytes):
>       40 73 41 07 80 88 ff ff 00 00 00 00 00 00 00 00  @sA.............
>     backtrace:
>       [<0000000087736d2a>] kmem_cache_alloc_trace+0x142/0x1c0
>       [<0000000060740f50>] vhost_vdpa_process_iotlb_msg+0x68c/0x901 [vhost_vdpa]
>       [<0000000083e8e205>] vhost_chr_write_iter+0xc0/0x4a0 [vhost]
>       [<000000008f2f414a>] vhost_vdpa_chr_write_iter+0x18/0x20 [vhost_vdpa]
>       [<00000000de1cd4a0>] vfs_write+0x216/0x4b0
>       [<00000000a2850200>] ksys_write+0x71/0xf0
>       [<00000000de8e720b>] __x64_sys_write+0x19/0x20
>       [<0000000018b12cbb>] do_syscall_64+0x3f/0x90
>       [<00000000986ec465>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Let's fix calling vhost_vdpa_iotlb_unmap() on the whole range in
> vhost_vdpa_remove_as(). We move that call before vhost_dev_cleanup()
> since we need a valid v->vdev.mm in vhost_vdpa_pa_unmap().
> vhost_iotlb_reset() call can be removed, since vhost_vdpa_iotlb_unmap()
> on the whole range removes all the entries.
>
> The kmemleak log reported was observed with a vDPA device that has `use_va`
> set to true (e.g. VDUSE). This patch has been tested with both types of
> devices.
>
> Fixes: 037d4305569a ("vhost-vdpa: call vhost_vdpa_cleanup during the release")
> Fixes: 3d5698793897 ("vhost-vdpa: introduce asid based IOTLB")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..b08e07fc7d1f 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -65,6 +65,10 @@ static DEFINE_IDA(vhost_vdpa_ida);
>
>  static dev_t vhost_vdpa_major;
>
> +static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v,
> +                                  struct vhost_iotlb *iotlb,
> +                                  u64 start, u64 last);
> +
>  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
>  {
>         struct vhost_vdpa_as *as = container_of(iotlb, struct
> @@ -135,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>                 return -EINVAL;
>
>         hlist_del(&as->hash_link);
> -       vhost_iotlb_reset(&as->iotlb);
> +       vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
>         kfree(as);
>
>         return 0;
> @@ -1162,14 +1166,14 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
>         struct vhost_vdpa_as *as;
>         u32 asid;
>
> -       vhost_dev_cleanup(&v->vdev);
> -       kfree(v->vdev.vqs);
> -
>         for (asid = 0; asid < v->vdpa->nas; asid++) {
>                 as = asid_to_as(v, asid);
>                 if (as)
>                         vhost_vdpa_remove_as(v, asid);
>         }
> +
> +       vhost_dev_cleanup(&v->vdev);
> +       kfree(v->vdev.vqs);
>  }
>
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
