Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8204DC4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 17:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0949B408BA;
	Wed,  9 Nov 2022 17:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0949B408BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W6HrIQe4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f492Rl4jiG0p; Wed,  9 Nov 2022 17:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7E1654034B;
	Wed,  9 Nov 2022 17:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E1654034B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA6DC0032;
	Wed,  9 Nov 2022 17:47:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 313A6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 17:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05004813C4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 17:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05004813C4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W6HrIQe4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oe_AhsTp34eq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 17:47:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 341AC813C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 341AC813C2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668016049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t/Kh42tMKfFvo4S/QFU8eolDVeSpitIJIiOT5FWjq3s=;
 b=W6HrIQe4wkjE7s6YhF5B1gaJIny4WJ9IDw2qn72OE0RUfksdiRp6HbRwxUCDkDE8ZAhlte
 IG44ufhxmQY6rM50yYIq7ZBHD8gbkttkMmDkx5rshrLDNjXkBcWJORpqCKz61j8RunWgA6
 c3gFdc4m327StJJddBaEVum7vgXdIrs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-TA1FjzayOBqcCHTmllNqOA-1; Wed, 09 Nov 2022 12:47:26 -0500
X-MC-Unique: TA1FjzayOBqcCHTmllNqOA-1
Received: by mail-qk1-f197.google.com with SMTP id
 bj1-20020a05620a190100b006fa12a05188so16334938qkb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 09:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/Kh42tMKfFvo4S/QFU8eolDVeSpitIJIiOT5FWjq3s=;
 b=k5WOEiiOYUDeYgJQ+WEKbhkPecGL/38U212zKdEZAD3SNdQ8u1GLKF6vct9bbvI03/
 aJB5x8ICHaf5LRRsC5NOfZyQ0hMMU1DzE45/lvn1a3ByN1S6OLAM2yUMAhAmqOLTfkKE
 pY3kmWSFwz5oVleieiUoBppCbQDYeJKh3PosuTzxQ35hcDOmMnI3l5Kxm7S6/r2G8945
 hsz7tlBwf0VO+B363HjfFgGXVKycngSk41NAOSdtHOT3KtJfY76SoaGIcFX8Zwqz9hk6
 z2pZ0TlIt+r8qK2u9J+hxG+PBGEXQJ2JkRw3AwtYrMuZsH/LhxbQhP5YQJkr8mFuSGaT
 Gbtw==
X-Gm-Message-State: ACrzQf1eueycUl/yjm25BId1IPIyqftM7+EN9Jv//qxDOr2I7bZGyYaZ
 G9kUtDAQt+Rtx0TCt7LzYMdCZAy0uaojiIsfRuMxJD3hm+Aru6aiFjvInsxyKHWZdf5mxdvfo8w
 sK7VbjUfmmGT0ROsuKs0EjqAhmjAwiEeZ6zeavzQZYw==
X-Received: by 2002:a05:6214:19e3:b0:4b6:8a99:3054 with SMTP id
 q3-20020a05621419e300b004b68a993054mr55096679qvc.108.1668016045398; 
 Wed, 09 Nov 2022 09:47:25 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4cIKDmZFid0Kdu9UcncIAXfb+bkR8ZjQnilX9u+j9N1m8IT/D1lrE9WWhovxtcPfHOO2c1+Q==
X-Received: by 2002:a05:6214:19e3:b0:4b6:8a99:3054 with SMTP id
 q3-20020a05621419e300b004b68a993054mr55096665qvc.108.1668016045154; 
 Wed, 09 Nov 2022 09:47:25 -0800 (PST)
Received: from redhat.com ([185.195.59.47]) by smtp.gmail.com with ESMTPSA id
 u12-20020a37ab0c000000b006e54251993esm11254690qke.97.2022.11.09.09.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 09:47:24 -0800 (PST)
Date: Wed, 9 Nov 2022 12:47:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: fix potential memory leak during the release
Message-ID: <20221109124430-mutt-send-email-mst@kernel.org>
References: <20221109154213.146789-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221109154213.146789-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, Nov 09, 2022 at 04:42:13PM +0100, Stefano Garzarella wrote:
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

It's fine, just pls don't say "potential" here in the subject, let's
avoid pleonasms - it's a memory leak, yes it triggers under some coditions
but little is unconditional in this world :)

No need to repost.

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
> +				   struct vhost_iotlb *iotlb,
> +				   u64 start, u64 last);
> +
>  static inline u32 iotlb_to_asid(struct vhost_iotlb *iotlb)
>  {
>  	struct vhost_vdpa_as *as = container_of(iotlb, struct
> @@ -135,7 +139,7 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>  		return -EINVAL;
>  
>  	hlist_del(&as->hash_link);
> -	vhost_iotlb_reset(&as->iotlb);
> +	vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1);
>  	kfree(as);
>  
>  	return 0;
> @@ -1162,14 +1166,14 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
>  	struct vhost_vdpa_as *as;
>  	u32 asid;
>  
> -	vhost_dev_cleanup(&v->vdev);
> -	kfree(v->vdev.vqs);
> -
>  	for (asid = 0; asid < v->vdpa->nas; asid++) {
>  		as = asid_to_as(v, asid);
>  		if (as)
>  			vhost_vdpa_remove_as(v, asid);
>  	}
> +
> +	vhost_dev_cleanup(&v->vdev);
> +	kfree(v->vdev.vqs);
>  }
>  
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
