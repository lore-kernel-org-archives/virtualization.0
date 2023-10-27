Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A885C25B67
	for <virtualization@archiver.kernel.org>; Fri, 27 Oct 2023 08:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A84AB705B4;
	Fri, 27 Oct 2023 08:02:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A84AB705B4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d7ub/FCe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hghjoMlTDR9K; Fri, 27 Oct 2023 08:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A9F5705AA;
	Fri, 27 Oct 2023 08:02:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A9F5705AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E46F6C0039;
	Fri, 27 Oct 2023 08:02:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF84C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9259B43302
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9259B43302
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d7ub/FCe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQ5JolFPfFbL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:02:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F5BD40108
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 08:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F5BD40108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698393732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qahb/LE7va9Q1Iif0xKr62EhnyUP1QxSWkvvxRc0UUw=;
 b=d7ub/FCeSIoeXyJBMmjpHe/ZOWIlx4ltL4ZU+miZJbOptUYpqCmZMbzhs2k9Xhu9dw6GSc
 QqlJb0xY5QdiosbXEcPhiNhmI1AHVQYPgg6HkCCJzUl19YroIWKw5tKcfONxdmdV5lt2rZ
 fS5rtKOgx9tHlo1Fxr1X9VMcbTwZt8g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-jey8X-ZLOKisboCeIT1Zeg-1; Fri, 27 Oct 2023 04:02:00 -0400
X-MC-Unique: jey8X-ZLOKisboCeIT1Zeg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40853e14f16so14436705e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Oct 2023 01:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698393719; x=1698998519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qahb/LE7va9Q1Iif0xKr62EhnyUP1QxSWkvvxRc0UUw=;
 b=QIAz/mNObguqZi1VXlHJpH/agSWZhKcflh22ZpzfAMgFujgG5qjREDNwqYp0AGonSf
 Pjl1qWzglIS5VqdzT4whv8+PKwzthRVdRmGEJ2aPdxT/Ba+4VCGDZMClBH+H2Uf5+EgF
 rUmGMTZYvkozuonvHKTPxhV+I8laZ3FHrIOlS4TnxQO0akiUYsv4wQe4K2DAyMc6n5JD
 vVDgXwgFa2kPXkcwl03g38AY6CY97z4xkDeViY13GGZdnHcPPKNlInwMsZBH0ZbyUAeY
 KGwdMFhIVHrlUC55GkeqNnCKF77QyCwvYQr6J6wJ0KwNuI81IpiD3mMTdMqwjqFuqiRm
 u7NA==
X-Gm-Message-State: AOJu0Ywuzl869Y5DiSZpY5BjWKAIe0we8FhsXR1idMZGXXE+K+N2lbc+
 wsWHL6gTJeW/rHqbpTxMrjFnphwftag/TNeoQnKBehH9A6aVwjpHc0UkyisPeLFlQhiNh06vHOT
 pkhcAILTsWFoNzGKHczF7wabzgPP312Ye442/aEFwEw==
X-Received: by 2002:a7b:cb19:0:b0:403:b86:f624 with SMTP id
 u25-20020a7bcb19000000b004030b86f624mr1470989wmj.23.1698393719509; 
 Fri, 27 Oct 2023 01:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWq4ysIXWhOeaSY7ybDArSvHomlUP94STda82wQjfGaQQaqu+1TEC/2s6C4J8Uij9mn2YWA==
X-Received: by 2002:a7b:cb19:0:b0:403:b86:f624 with SMTP id
 u25-20020a7bcb19000000b004030b86f624mr1470972wmj.23.1698393719078; 
 Fri, 27 Oct 2023 01:01:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 ay32-20020a05600c1e2000b004065daba6casm4464276wmb.46.2023.10.27.01.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 01:01:58 -0700 (PDT)
Date: Fri, 27 Oct 2023 10:01:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Subject: Re: [PATCH net] virtio/vsock: Fix uninit-value in
 virtio_transport_recv_pkt()
Message-ID: <waodmdtiiq6qcdj4pwys5pod7eyveqkfq6fwqy5hqptzembcxf@siitwagevn2f>
References: <20231026150154.3536433-1-syoshida@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231026150154.3536433-1-syoshida@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bobbyeshleman@gmail.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 stefanha@redhat.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Fri, Oct 27, 2023 at 12:01:54AM +0900, Shigeru Yoshida wrote:
>KMSAN reported the following uninit-value access issue:
>
>=====================================================
>BUG: KMSAN: uninit-value in virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> virtio_transport_recv_pkt+0x1dfb/0x26a0 net/vmw_vsock/virtio_transport_common.c:1421
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was stored to memory at:
> virtio_transport_space_update net/vmw_vsock/virtio_transport_common.c:1274 [inline]
> virtio_transport_recv_pkt+0x1ee8/0x26a0 net/vmw_vsock/virtio_transport_common.c:1415
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>Uninit was created at:
> slab_post_alloc_hook+0x105/0xad0 mm/slab.h:767
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x5a2/0xaf0 mm/slub.c:3523
> kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:559
> __alloc_skb+0x2fd/0x770 net/core/skbuff.c:650
> alloc_skb include/linux/skbuff.h:1286 [inline]
> virtio_vsock_alloc_skb include/linux/virtio_vsock.h:66 [inline]
> virtio_transport_alloc_skb+0x90/0x11e0 net/vmw_vsock/virtio_transport_common.c:58
> virtio_transport_reset_no_sock net/vmw_vsock/virtio_transport_common.c:957 [inline]
> virtio_transport_recv_pkt+0x1279/0x26a0 net/vmw_vsock/virtio_transport_common.c:1387
> vsock_loopback_work+0x3bb/0x5a0 net/vmw_vsock/vsock_loopback.c:120
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0xff6/0x1e60 kernel/workqueue.c:2703
> worker_thread+0xeca/0x14d0 kernel/workqueue.c:2784
> kthread+0x3cc/0x520 kernel/kthread.c:388
> ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>
>CPU: 1 PID: 10664 Comm: kworker/1:5 Not tainted 6.6.0-rc3-00146-g9f3ebbef746f #3
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 04/01/2014
>Workqueue: vsock-loopback vsock_loopback_work
>=====================================================
>
>The following simple reproducer can cause the issue described above:
>
>int main(void)
>{
>  int sock;
>  struct sockaddr_vm addr = {
>    .svm_family = AF_VSOCK,
>    .svm_cid = VMADDR_CID_ANY,
>    .svm_port = 1234,
>  };
>
>  sock = socket(AF_VSOCK, SOCK_STREAM, 0);
>  connect(sock, (struct sockaddr *)&addr, sizeof(addr));
>  return 0;
>}
>
>This issue occurs because the `buf_alloc` and `fwd_cnt` fields of the
>`struct virtio_vsock_hdr` are not initialized when a new skb is allocated
>in `virtio_transport_alloc_skb()`. This patch resolves the issue by
>initializing these fields during allocation.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

CCin Bobby, the original author, for any additional comments/checks.

Yeah, I see, before that commit we used kzalloc() to allocate the
header so we forgot to reset these 2 fields, and checking they are
the only 2 missing.

I was thinking of putting a memset(hdr, 0, sizeof(*hdr)) in
virtio_vsock_alloc_skb() but I think it's just extra unnecessary work,
since here we set all the fields (thanks to this fix), in vhost/vsock.c
we copy all the header we receive from the guest and in
virtio_transport.c we already set it all to 0 because we are
preallocating the receive buffers.

So I'm fine with this fix!

>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 352d042b130b..102673bef189 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -68,6 +68,8 @@ virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
> 	hdr->dst_port	= cpu_to_le32(dst_port);
> 	hdr->flags	= cpu_to_le32(info->flags);
> 	hdr->len	= cpu_to_le32(len);
>+	hdr->buf_alloc	= cpu_to_le32(0);
>+	hdr->fwd_cnt	= cpu_to_le32(0);
>
> 	if (info->msg && len > 0) {
> 		payload = skb_put(skb, len);
>-- 
>2.41.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
