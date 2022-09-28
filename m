Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB255C04A95
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 15:11:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30F3A408CB;
	Wed, 28 Sep 2022 15:11:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30F3A408CB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQaCAnqW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2KdV0-vPmud; Wed, 28 Sep 2022 15:11:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F4BE416C5;
	Wed, 28 Sep 2022 15:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F4BE416C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 013A0C0033;
	Wed, 28 Sep 2022 15:11:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82BBBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 15:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A1BA40A20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 15:11:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A1BA40A20
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQaCAnqW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iwaAP1OngA-E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 15:11:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E91BB405E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E91BB405E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664377906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N//yqD+aufpyhJZtChEf3+2TXlqXFfc1L7JPLKS/TRs=;
 b=JQaCAnqWkm0UfUis46yCIr28O15cI2bg3jV2uR+Ndzzb99SIbOIOYf8uDV97xUIg/kdk0+
 iXKP3FuTnLSOPMA3GTZBGxrYalDFRAk43mSZJpkQG6aBg7MW3CyVP1AWlQAR9MiSAPqsWF
 FDs4QSJbfnm0o78tsPE85IZEdrd+1g0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-Fp_vWx6nMxSDJ0ijfTxOPw-1; Wed, 28 Sep 2022 11:11:45 -0400
X-MC-Unique: Fp_vWx6nMxSDJ0ijfTxOPw-1
Received: by mail-qk1-f198.google.com with SMTP id
 o13-20020a05620a2a0d00b006cf9085682dso7894807qkp.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 08:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=N//yqD+aufpyhJZtChEf3+2TXlqXFfc1L7JPLKS/TRs=;
 b=EV4kRylWmLXl3M04RSOqAsc1UZkggd2GY5Ts0MY9V8lmHHDVaco+PHCn2bTSMeIgG0
 G0uqC/oN+J7nj+27AiwibcDzztV3aYX8vhjyMyTHume827o6KNOd9m2dTmmi3xRkz6Xv
 3940Y6utQUjptzkReKSIf3X2gund5zdLsp2ylkvpkSb/ampx+0DybSuigJE7ElOGeUuW
 HpNpVwT7B59/9ih1WG5OMGqieYkw86uNhkKhKj4cm0AmYzXOUemo43ybTE609/uPwGYS
 1H935RTxbOJN1WgZFK9keQYQbZlfd22IFjkmeE4B2o4v7RUqIMq+jSRbZ/gha2OKmxNI
 3wwQ==
X-Gm-Message-State: ACrzQf36OBZFjW/VP4vOJms7EvlJUWZmav+CUh83mD9k7l0haFSeEYfn
 ME2V1rWBCN0iWpUwPTFfMMZHu/vAr7CKr68R0pymnTtrOQTxKGRq7LoovxaZzW8fAY1zcJsqtt2
 zsN2Ae3dEdXNjbC15GlDXSZaI/+8DHFRhiWbI6pQBkQ==
X-Received: by 2002:a37:68d6:0:b0:6cb:cf29:dfb with SMTP id
 d205-20020a3768d6000000b006cbcf290dfbmr21582936qkc.406.1664377905059; 
 Wed, 28 Sep 2022 08:11:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6F5FAU27MZ7cS3Ks7xMKNVxbwnEj7yH65umY8MeviEbyJkDkQQ9uEbZ9y2Bnsn/Fvx15R7pQ==
X-Received: by 2002:a37:68d6:0:b0:6cb:cf29:dfb with SMTP id
 d205-20020a3768d6000000b006cbcf290dfbmr21582904qkc.406.1664377904744; 
 Wed, 28 Sep 2022 08:11:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it.
 [79.46.200.222]) by smtp.gmail.com with ESMTPSA id
 h18-20020a05620a245200b006ced196a73fsm3185370qkn.135.2022.09.28.08.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Sep 2022 08:11:43 -0700 (PDT)
Date: Wed, 28 Sep 2022 17:11:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220928052738-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Junichi Uekawa <uekawa@chromium.org>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, Bobby Eshleman <bobby.eshleman@gmail.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 davem@davemloft.net
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

On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
>On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
>> > When copying a large file over sftp over vsock, data size is usually 32kB,
>> > and kmalloc seems to fail to try to allocate 32 32kB regions.
>> >
>> > Call Trace:
>> >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
>> >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
>> >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
>> >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
>> >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
>> >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
>> >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
>> >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
>> >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
>> >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
>> >  [<ffffffffb683ddce>] kthread+0xfd/0x105
>> >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
>> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
>> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> >
>> > Work around by doing kvmalloc instead.
>> >
>> > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
>
>My worry here is that this in more of a work around.
>It would be better to not allocate memory so aggressively:
>if we are so short on memory we should probably process
>packets one at a time. Is that very hard to implement?

Currently the "virtio_vsock_pkt" is allocated in the "handle_kick" 
callback of TX virtqueue. Then the packet is multiplexed on the right 
socket queue, then the user space can de-queue it whenever they want.

So maybe we can stop processing the virtqueue if we are short on memory, 
but when can we restart the TX virtqueue processing?

I think as long as the guest used only 4K buffers we had no problem, but 
now that it can create larger buffers the host may not be able to 
allocate it contiguously. Since there is no need to have them contiguous 
here, I think this patch is okay.

However, if we switch to sk_buff (as Bobby is already doing), maybe we 
don't have this problem because I think there is some kind of 
pre-allocated pool.

>
>
>
>> > ---
>> >
>> > drivers/vhost/vsock.c                   | 2 +-
>> > net/vmw_vsock/virtio_transport_common.c | 2 +-
>> > 2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 368330417bde..5703775af129 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -393,7 +393,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
>> > 		return NULL;
>> > 	}
>> >
>> > -	pkt->buf = kmalloc(pkt->len, GFP_KERNEL);
>> > +	pkt->buf = kvmalloc(pkt->len, GFP_KERNEL);
>> > 	if (!pkt->buf) {
>> > 		kfree(pkt);
>> > 		return NULL;
>> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > index ec2c2afbf0d0..3a12aee33e92 100644
>> > --- a/net/vmw_vsock/virtio_transport_common.c
>> > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > @@ -1342,7 +1342,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>> >
>> > void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
>> > {
>> > -	kfree(pkt->buf);
>> > +	kvfree(pkt->buf);
>>
>> virtio_transport_free_pkt() is used also in virtio_transport.c and
>> vsock_loopback.c where pkt->buf is allocated with kmalloc(), but IIUC
>> kvfree() can be used with that memory, so this should be fine.
>>
>> > 	kfree(pkt);
>> > }
>> > EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);
>> > --
>> > 2.37.3.998.g577e59143f-goog
>> >
>>
>> This issue should go away with the Bobby's work about introducing sk_buff
>> [1], but we can queue this for now.
>>
>> I'm not sure if we should do the same also in the virtio-vsock driver
>> (virtio_transport.c). Here in vhost-vsock the buf allocated is only used in
>> the host, while in the virtio-vsock driver the buffer is exposed to the
>> device emulated in the host, so it should be physically contiguous (if not,
>> maybe we need to adjust virtio_vsock_rx_fill()).
>
>More importantly it needs to support DMA API which IIUC kvmalloc
>memory does not.
>

Right, good point!

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
