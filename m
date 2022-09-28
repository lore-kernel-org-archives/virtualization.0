Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AEAC32771
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 08:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9434A4011B;
	Wed, 28 Sep 2022 08:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9434A4011B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFDiBFUU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3JSYdqzd2Ar9; Wed, 28 Sep 2022 08:28:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D799740524;
	Wed, 28 Sep 2022 08:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D799740524
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD2CFC0033;
	Wed, 28 Sep 2022 08:28:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0D04C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 08:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABC48600CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 08:28:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABC48600CD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IFDiBFUU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UpX8vyabF8hN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 08:28:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90786600CB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90786600CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664353710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g5jRqFBs3ZpqqID4I8CKzY6l+aiJ3r8Xkuq0qHKyk3s=;
 b=IFDiBFUUSZvfS9fbp/IzVM0jVUHpgLyUGNd8GAuxV059a10nFr6Y3r0Gg4y5GZaWnfLjbO
 BKzZfJqxUpzMu0veeVSfwR3Bd5OOcGxhJXJ1WgBY6+O18rU0PeuU+XNJvLc6pyEYe+Vgk+
 VmtQqGLFgyNuaRO+eXJcluvycyHpAM4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-0WIvtWgiOImOJwSUcr_NEg-1; Wed, 28 Sep 2022 04:28:29 -0400
X-MC-Unique: 0WIvtWgiOImOJwSUcr_NEg-1
Received: by mail-wm1-f71.google.com with SMTP id
 f25-20020a7bc8d9000000b003b4768dcd9cso328332wml.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=g5jRqFBs3ZpqqID4I8CKzY6l+aiJ3r8Xkuq0qHKyk3s=;
 b=l6B8ylv7neAXna3OHIlvftEWV7Md221Vd013iYEc+71PZfqfWdgqo+9mNM4a5Zs/PL
 gNGB+RFpkG3wAc6BDO8vhX1DmRc9H7yDPOf3LcgKQl3Kza7ViyxZlkLQZ31o2bgoVpbr
 nuwR50rTLXtM5ksyIKQ7SSPE9bsG/Qaghi3kszA1Ad40+58w58sHgE4184cDmaBzISlg
 tGkMHQyqNGNYJQdWgMeRLqR4gvarXWLIl5ub8tM078wtCvhbbjoWI48bd14vC7SW6WLQ
 MURyXyLg19xFkEkUuN0JxcX4L7eGON0ajfvqRF09XBS6p1ec70myzA7Bo2CsT3+VIXza
 4ByA==
X-Gm-Message-State: ACrzQf0fvWTTrAcCI5p7EVI4PKbHXUC3fPK70rsiM+uxqhhcJm2Tq6PH
 Pg8DRBr/JjVvwsmQovq5gjKi7aB0dC4gmnBeg5OfbD0bAGKPCDvxvxA76fblXx6j8NTTckpvNnQ
 UNu4WEh6ys/o12W1lBAUVIA2rXt7hzE0kFL/FvuAP+A==
X-Received: by 2002:a7b:c4cc:0:b0:3b4:757b:492f with SMTP id
 g12-20020a7bc4cc000000b003b4757b492fmr5920805wmk.74.1664353707731; 
 Wed, 28 Sep 2022 01:28:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM47jgP3O0DziLeVykTicWQQEQFnRqKDM2sPzfZXITIBwu4Xs1v2ngdyKb/2zKNsf907hLdJjw==
X-Received: by 2002:a7b:c4cc:0:b0:3b4:757b:492f with SMTP id
 g12-20020a7bc4cc000000b003b4757b492fmr5920780wmk.74.1664353707446; 
 Wed, 28 Sep 2022 01:28:27 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1cf30a000000b003b47575d304sm1233345wmq.32.2022.09.28.01.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Sep 2022 01:28:26 -0700 (PDT)
Date: Wed, 28 Sep 2022 10:28:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junichi Uekawa <uekawa@chromium.org>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
References: <20220928064538.667678-1-uekawa@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20220928064538.667678-1-uekawa@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
>When copying a large file over sftp over vsock, data size is usually 32kB,
>and kmalloc seems to fail to try to allocate 32 32kB regions.
>
> Call Trace:
>  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
>  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
>  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
>  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
>  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
>  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
>  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
>  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
>  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
>  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
>  [<ffffffffb683ddce>] kthread+0xfd/0x105
>  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
>  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
>  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>
>Work around by doing kvmalloc instead.
>
>Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
>---
>
> drivers/vhost/vsock.c                   | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 368330417bde..5703775af129 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -393,7 +393,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	pkt->buf = kmalloc(pkt->len, GFP_KERNEL);
>+	pkt->buf = kvmalloc(pkt->len, GFP_KERNEL);
> 	if (!pkt->buf) {
> 		kfree(pkt);
> 		return NULL;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ec2c2afbf0d0..3a12aee33e92 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1342,7 +1342,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>
> void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
> {
>-	kfree(pkt->buf);
>+	kvfree(pkt->buf);

virtio_transport_free_pkt() is used also in virtio_transport.c and 
vsock_loopback.c where pkt->buf is allocated with kmalloc(), but IIUC 
kvfree() can be used with that memory, so this should be fine.

> 	kfree(pkt);
> }
> EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);
>-- 
>2.37.3.998.g577e59143f-goog
>

This issue should go away with the Bobby's work about introducing 
sk_buff [1], but we can queue this for now.

I'm not sure if we should do the same also in the virtio-vsock driver 
(virtio_transport.c). Here in vhost-vsock the buf allocated is only used 
in the host, while in the virtio-vsock driver the buffer is exposed to 
the device emulated in the host, so it should be physically contiguous 
(if not, maybe we need to adjust virtio_vsock_rx_fill()).
So for now I think is fine to use kvmalloc only on vhost-vsock 
(eventually we can use it also in vsock_loopback), since the Bobby's 
patch should rework this code:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

[1] 
https://lore.kernel.org/lkml/65d117ddc530d12a6d47fcc45b38891465a90d9f.1660362668.git.bobby.eshleman@bytedance.com/

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
