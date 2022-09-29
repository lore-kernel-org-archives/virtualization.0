Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1475BC04A95
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B43186111C;
	Thu, 29 Sep 2022 07:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B43186111C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCZg9P89
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fN1_B2a7n7f6; Thu, 29 Sep 2022 07:47:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 430A961111;
	Thu, 29 Sep 2022 07:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 430A961111
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 172BEC0033;
	Thu, 29 Sep 2022 07:47:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F88AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A9A761117
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A9A761117
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r2HhCHz650BX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:47:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1D3361111
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1D3361111
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664437640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PsFKA0JcnshzZDoVR/7R357TCzayyacAiy4vW0aVEaY=;
 b=jCZg9P89iHWvWNMtkN3zHpG6RSwaURqnoR0TovU+ACUKBppMxtvYAA2+bnEkVoRXJfLGeM
 cC5iQDVV0aqcnRkvxCKQOqjElW7HEueSenPJKmtWIXt/k9Q648m1RWuufa7S157687irTc
 gKJmCpeIB8hiIRpAfFhlrzX7wQFvhr8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-4yoObKSVO1qiFHFeynzpPQ-1; Thu, 29 Sep 2022 03:47:14 -0400
X-MC-Unique: 4yoObKSVO1qiFHFeynzpPQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 l15-20020a05600c4f0f00b003b4bec80edbso317248wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=PsFKA0JcnshzZDoVR/7R357TCzayyacAiy4vW0aVEaY=;
 b=RqShMyB/r7j5RIVGQmufTJwPlnCWBleKPpVCsiUDMzSr5dhagintYibT644Nhinmea
 8enrUozwWL5zO5VBpl1i+ly49IbGOWhFgU7lQUshk2eEFqNnddJr+lTq7Rl1JEgKcIcx
 mBp9U4x1E6xvXK+rOEVio0X10VYTkN4tAA+iqXE0QYctJZahUjkj8tFdDqkbds0m80Hw
 4DBO/0qJ3sZs2RoEyVYW+lLBeY65AEajUJC/Izvx91RMWFxEu2NsRAi1fwNI0VzDN85L
 ZjhOs87Va9Soj0nqZhNcMbzT0l9Tb2bzB40ITAhP6d3Mn7Zgvem76m94U+3klougUZrx
 7W9Q==
X-Gm-Message-State: ACrzQf24Os8DdOFi7kvTpMJdtxX3w3hlLVUrS/nhB8zS77RrmApQ5mvC
 0+xg+dyDKgZrjz1ZmMcil7u9FIHYvH/UPJsy0mDqNJhEqyxTnO4EYRgRE3j8nSAVWFU/J6k41vO
 H8RQgq/d/LL4At0XZMhEI0cFMpZRuGDHvvSxQmGIjQQ==
X-Received: by 2002:a5d:4284:0:b0:22a:291e:fa8f with SMTP id
 k4-20020a5d4284000000b0022a291efa8fmr1154737wrq.553.1664437633412; 
 Thu, 29 Sep 2022 00:47:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+U+FYi8gr6euyVSrck8fFbYRHG3C6n/KBq6oIquAU+3k+fHj1pTJKlSFhr1Cm9nI7F+MMDw==
X-Received: by 2002:a5d:4284:0:b0:22a:291e:fa8f with SMTP id
 k4-20020a5d4284000000b0022a291efa8fmr1154726wrq.553.1664437633210; 
 Thu, 29 Sep 2022 00:47:13 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 3-20020a05600c230300b003b4727d199asm3639886wmo.15.2022.09.29.00.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:47:12 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:47:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220929034552-mutt-send-email-mst@kernel.org>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
 <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
 <20220928160116-mutt-send-email-mst@kernel.org>
 <20220929074010.37mksjmwr3l4wlwt@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220929074010.37mksjmwr3l4wlwt@sgarzare-redhat>
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

On Thu, Sep 29, 2022 at 09:40:10AM +0200, Stefano Garzarella wrote:
> On Wed, Sep 28, 2022 at 04:02:12PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 28, 2022 at 05:11:35PM +0200, Stefano Garzarella wrote:
> > > On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
> > > > > On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
> > > > > > When copying a large file over sftp over vsock, data size is usually 32kB,
> > > > > > and kmalloc seems to fail to try to allocate 32 32kB regions.
> > > > > >
> > > > > > Call Trace:
> > > > > >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
> > > > > >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
> > > > > >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
> > > > > >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
> > > > > >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
> > > > > >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
> > > > > >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
> > > > > >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
> > > > > >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
> > > > > >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
> > > > > >  [<ffffffffb683ddce>] kthread+0xfd/0x105
> > > > > >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
> > > > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > > > > >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
> > > > > >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
> > > > > >
> > > > > > Work around by doing kvmalloc instead.
> > > > > >
> > > > > > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
> > > >
> > > > My worry here is that this in more of a work around.
> > > > It would be better to not allocate memory so aggressively:
> > > > if we are so short on memory we should probably process
> > > > packets one at a time. Is that very hard to implement?
> > > 
> > > Currently the "virtio_vsock_pkt" is allocated in the "handle_kick" callback
> > > of TX virtqueue. Then the packet is multiplexed on the right socket queue,
> > > then the user space can de-queue it whenever they want.
> > > 
> > > So maybe we can stop processing the virtqueue if we are short on memory, but
> > > when can we restart the TX virtqueue processing?
> > 
> > Assuming you added at least one buffer, the time to restart would be
> > after that buffer has been used.
> 
> Yes, but we still might not have as many continuous pages to allocate, so I
> would use kvmalloc the same.


you would do something like
	if (is_vmalloc_addr())
		stop adding buffers.



> I agree that we should do better, I hope that moving to sk_buff will allow
> us to better manage allocation. Maybe after we merge that part we should
> spend some time to solve these problems.
> 
> Thanks,
> Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
