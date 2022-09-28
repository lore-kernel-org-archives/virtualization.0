Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D28C32771
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 09:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB4D74093F;
	Wed, 28 Sep 2022 09:32:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB4D74093F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XlFilf+Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrqaZ9_0c8OF; Wed, 28 Sep 2022 09:32:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7FFC0400D3;
	Wed, 28 Sep 2022 09:32:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FFC0400D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14A10C0033;
	Wed, 28 Sep 2022 09:32:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25C5AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 09:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9E7140201
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 09:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9E7140201
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eeoXcIHMImWa
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 09:32:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D13CE400D3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D13CE400D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664357525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKWhiaA5Wv0V2eMraFNdl4jrLjbjCkjEq9//t8SsrB0=;
 b=XlFilf+ZjUT+pKjNcA6oOCQq4W7j1mndcNw0ReohF/7uAukWnjl7MByeaI7U7moZrRL54v
 mOntlWknFf9yaYUX7QjItnL98c7lJWMZLTzfyXnhq/K9LDmrVRKF9hS571xCT9TeC6c6Uw
 ODXvHRHHUz6EfYomIj+dp/64XKRVwjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-12-ydRX6oyrOPqGmfuPcxpCZw-1; Wed, 28 Sep 2022 05:32:04 -0400
X-MC-Unique: ydRX6oyrOPqGmfuPcxpCZw-1
Received: by mail-wm1-f72.google.com with SMTP id
 i132-20020a1c3b8a000000b003b339a8556eso6851487wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 02:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=RKWhiaA5Wv0V2eMraFNdl4jrLjbjCkjEq9//t8SsrB0=;
 b=48dMJtPrv+pCwGDOUEfWmA7r0E/LoIK3lkpv0Jouzwya/DXMKt6CwIBY3rg8qtTDOV
 qJOU9Yxz9sM0KzhA0fB44OQY8R5jLZSwVkKgPqyPY2LdEvI9+EkRpJ0BQxVUZBE/IuHW
 nDoyHkFBzaFpUTUhhG9KgGfw4L7ecRkrs6Z8yEH9Sptjpcz4cJX/JHGAb1oJgDOURlBr
 c2eAQicmgZ+cNmhK/5rHNfUna8X+m5TpWuStIXYBZDPoUJ8/Lvtd66OBubLr5AF0A1GL
 ePq7YJpUrnZWcQmbLSvgW6QvWvyuChwAUE12UZ4JVcmyNXZxhkQdWOeDmhkCsYEu7pnX
 wkDg==
X-Gm-Message-State: ACrzQf0qNUk5XXfjIg0dsmP7+2G0OxGmbdx/rg5zki3mJHLEezPXma3L
 hBWYgkqAyX5BgIa6BMuZu8UHqLwt2+3oIUeetNs7yt21KA/6hZFFMPp2Wl4k2JswomAx5lxkHGS
 WqhXZyULNhWD7K3GXwEgPin3jp6Q5VXQo4fwHudEbFg==
X-Received: by 2002:adf:ec09:0:b0:22c:c81b:b76a with SMTP id
 x9-20020adfec09000000b0022cc81bb76amr1504088wrn.302.1664357522970; 
 Wed, 28 Sep 2022 02:32:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7kxutijrNlyBi7mEzPyu48cri6KyE/47cghTsg07CI6Bc2dECrlSlgkIO63V29kUYGSktS1g==
X-Received: by 2002:adf:ec09:0:b0:22c:c81b:b76a with SMTP id
 x9-20020adfec09000000b0022cc81bb76amr1504062wrn.302.1664357522722; 
 Wed, 28 Sep 2022 02:32:02 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 l13-20020a5d410d000000b0022cbcfa8447sm3829691wrp.87.2022.09.28.02.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Sep 2022 02:32:02 -0700 (PDT)
Date: Wed, 28 Sep 2022 05:31:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220928052738-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
> On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
> > When copying a large file over sftp over vsock, data size is usually 32kB,
> > and kmalloc seems to fail to try to allocate 32 32kB regions.
> > 
> > Call Trace:
> >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
> >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
> >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
> >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
> >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
> >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
> >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
> >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
> >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
> >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
> >  [<ffffffffb683ddce>] kthread+0xfd/0x105
> >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > 
> > Work around by doing kvmalloc instead.
> > 
> > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>

My worry here is that this in more of a work around.
It would be better to not allocate memory so aggressively:
if we are so short on memory we should probably process
packets one at a time. Is that very hard to implement?



> > ---
> > 
> > drivers/vhost/vsock.c                   | 2 +-
> > net/vmw_vsock/virtio_transport_common.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 368330417bde..5703775af129 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -393,7 +393,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> > 		return NULL;
> > 	}
> > 
> > -	pkt->buf = kmalloc(pkt->len, GFP_KERNEL);
> > +	pkt->buf = kvmalloc(pkt->len, GFP_KERNEL);
> > 	if (!pkt->buf) {
> > 		kfree(pkt);
> > 		return NULL;
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index ec2c2afbf0d0..3a12aee33e92 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1342,7 +1342,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
> > 
> > void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
> > {
> > -	kfree(pkt->buf);
> > +	kvfree(pkt->buf);
> 
> virtio_transport_free_pkt() is used also in virtio_transport.c and
> vsock_loopback.c where pkt->buf is allocated with kmalloc(), but IIUC
> kvfree() can be used with that memory, so this should be fine.
> 
> > 	kfree(pkt);
> > }
> > EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);
> > -- 
> > 2.37.3.998.g577e59143f-goog
> > 
> 
> This issue should go away with the Bobby's work about introducing sk_buff
> [1], but we can queue this for now.
> 
> I'm not sure if we should do the same also in the virtio-vsock driver
> (virtio_transport.c). Here in vhost-vsock the buf allocated is only used in
> the host, while in the virtio-vsock driver the buffer is exposed to the
> device emulated in the host, so it should be physically contiguous (if not,
> maybe we need to adjust virtio_vsock_rx_fill()).

More importantly it needs to support DMA API which IIUC kvmalloc
memory does not.

> So for now I think is fine to use kvmalloc only on vhost-vsock (eventually
> we can use it also in vsock_loopback), since the Bobby's patch should rework
> this code:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> [1] https://lore.kernel.org/lkml/65d117ddc530d12a6d47fcc45b38891465a90d9f.1660362668.git.bobby.eshleman@bytedance.com/
> 
> Thanks,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
