Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F67C0015E
	for <virtualization@archiver.kernel.org>; Fri, 11 Aug 2023 09:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3872182F31;
	Fri, 11 Aug 2023 09:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3872182F31
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZraRSKw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XdWl5W2Fngs; Fri, 11 Aug 2023 09:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B6DE82C3E;
	Fri, 11 Aug 2023 09:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B6DE82C3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23C44C0072;
	Fri, 11 Aug 2023 09:25:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 455FCC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C1004031D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C1004031D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZraRSKw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q0UtwUhr1hvn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:25:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2321C400D1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 09:25:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2321C400D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691745921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RtQEdV4kSxWfKiCLD/Duq0kdGivje+tTk7NS8pJitEY=;
 b=aZraRSKwSREMl1C+6dFzYb+FF0y18M1caeVdpV2qUyKZtq70i4Jl9NgMgKGkP30AYEQcp+
 n51A4MdPxRrfMhocSYqFp1PgDzT61nOmmmAUv7fcvaW0g6brOFRD3QJRUrTLdLkQDSZPTP
 FjKZGQ0F9YXTPHh+s8CEGY1W2rnaXuE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0008_wEzP6K-dLXZ2S2dBQ-1; Fri, 11 Aug 2023 05:25:20 -0400
X-MC-Unique: 0008_wEzP6K-dLXZ2S2dBQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31954bc5200so613641f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Aug 2023 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691745919; x=1692350719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtQEdV4kSxWfKiCLD/Duq0kdGivje+tTk7NS8pJitEY=;
 b=SmGQB060iMmsJFYxdMezyq6XcKytMnzsbNKk/Ka1B/3aALhlLDrjd2bvkIoaWXvaIO
 0j414QZeCK19oZr+DzlOZndlWpwpIeDD+CkTw2GeVb895CjqUdOV24+eu635EuROLxSz
 FuVCldLdqoWQPjuQN7C+lAxy7ql2Uw7m7Xy3gd8MbKaOCE5l9LiCHgQA9zp5TNujWmLM
 SN0cY880D3B85YauZHih9D3k20krxxnY7kv9TkfwougG/YkfXtvZdHxIeqvSKfKVT6Za
 HUtrHdMYLUfuGg55QKVtx13l7VtWDY0OKN+nTslpJC58HvEGUGWLUaNa0XjRphywMBta
 dX8A==
X-Gm-Message-State: AOJu0YxhcrM/MmiYcElbWJWDdNoKuXDfoS/9l+tnwf//JAtgOpu47hTA
 tX13tIblLTpBj+HanjhU46Jh6r/tDHc6IWw+Pi7hc/TJjZctwvh13sjAFJKVaTyjjw5S2wCiMV9
 9oVv/RmJs2t8DfG6XEjwP/cH2JrdrIl7lDHhqVK49MA==
X-Received: by 2002:adf:e685:0:b0:317:6a7c:6e07 with SMTP id
 r5-20020adfe685000000b003176a7c6e07mr976826wrm.32.1691745919564; 
 Fri, 11 Aug 2023 02:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3VK+IffKl1asrWEq9MUaXRQo6u4uI3QC+WOFlDm3m94kVG7FfYqulrJ1Pw1X9cAg4tKLveg==
X-Received: by 2002:adf:e685:0:b0:317:6a7c:6e07 with SMTP id
 r5-20020adfe685000000b003176a7c6e07mr976808wrm.32.1691745918826; 
 Fri, 11 Aug 2023 02:25:18 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 i10-20020a5d438a000000b0031760af2331sm4760247wrq.100.2023.08.11.02.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 02:25:18 -0700 (PDT)
Date: Fri, 11 Aug 2023 05:25:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_vdpa: build affinity masks conditionally
Message-ID: <20230811052435-mutt-send-email-mst@kernel.org>
References: <20230811091539.1359865-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230811091539.1359865-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, xieyongji@bytedance.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, Aug 11, 2023 at 05:15:39AM -0400, Jason Wang wrote:
> We try to build affinity mask via create_affinity_masks()
> unconditionally which may lead several issues:
> 
> - the affinity mask is not used for parent without affinity support
>   (only VDUSE support the affinity now)
> - the logic of create_affinity_masks() might not work for devices
>   other than block. For example it's not rare in the networking device
>   where the number of queues could exceed the number of CPUs. Such
>   case breaks the current affinity logic which is based on
>   group_cpus_evenly() who assumes the number of CPUs are not less than
>   the number of groups. This can trigger a warning[1]:
> 
> 	if (ret >= 0)
> 		WARN_ON(nr_present + nr_others < numgrps);
> 
> Fixing this by only build the affinity masks only when
> 
> - Driver passes affinity descriptor, driver like virtio-blk can make
>   sure to limit the number of queues when it exceeds the number of CPUs
> - Parent support affinity setting config ops
> 
> This help to avoid the warning. More optimizations could be done on
> top.
> 
> [1]
> [  682.146655] WARNING: CPU: 6 PID: 1550 at lib/group_cpus.c:400 group_cpus_evenly+0x1aa/0x1c0
> [  682.146668] CPU: 6 PID: 1550 Comm: vdpa Not tainted 6.5.0-rc5jason+ #79
> [  682.146671] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [  682.146673] RIP: 0010:group_cpus_evenly+0x1aa/0x1c0
> [  682.146676] Code: 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc e8 1b c4 74 ff 48 89 ef e8 13 ac 98 ff 4c 89 e7 45 31 e4 e8 08 ac 98 ff eb c2 <0f> 0b eb b6 e8 fd 05 c3 00 45 31 e4 eb e5 cc cc cc cc cc cc cc cc
> [  682.146679] RSP: 0018:ffffc9000215f498 EFLAGS: 00010293
> [  682.146682] RAX: 000000000001f1e0 RBX: 0000000000000041 RCX: 0000000000000000
> [  682.146684] RDX: ffff888109922058 RSI: 0000000000000041 RDI: 0000000000000030
> [  682.146686] RBP: ffff888109922058 R08: ffffc9000215f498 R09: ffffc9000215f4a0
> [  682.146687] R10: 00000000000198d0 R11: 0000000000000030 R12: ffff888107e02800
> [  682.146689] R13: 0000000000000030 R14: 0000000000000030 R15: 0000000000000041
> [  682.146692] FS:  00007fef52315740(0000) GS:ffff888237380000(0000) knlGS:0000000000000000
> [  682.146695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  682.146696] CR2: 00007fef52509000 CR3: 0000000110dbc004 CR4: 0000000000370ee0
> [  682.146698] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  682.146700] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  682.146701] Call Trace:
> [  682.146703]  <TASK>
> [  682.146705]  ? __warn+0x7b/0x130
> [  682.146709]  ? group_cpus_evenly+0x1aa/0x1c0
> [  682.146712]  ? report_bug+0x1c8/0x1e0
> [  682.146717]  ? handle_bug+0x3c/0x70
> [  682.146721]  ? exc_invalid_op+0x14/0x70
> [  682.146723]  ? asm_exc_invalid_op+0x16/0x20
> [  682.146727]  ? group_cpus_evenly+0x1aa/0x1c0
> [  682.146729]  ? group_cpus_evenly+0x15c/0x1c0
> [  682.146731]  create_affinity_masks+0xaf/0x1a0
> [  682.146735]  virtio_vdpa_find_vqs+0x83/0x1d0
> [  682.146738]  ? __pfx_default_calc_sets+0x10/0x10
> [  682.146742]  virtnet_find_vqs+0x1f0/0x370
> [  682.146747]  virtnet_probe+0x501/0xcd0
> [  682.146749]  ? vp_modern_get_status+0x12/0x20
> [  682.146751]  ? get_cap_addr.isra.0+0x10/0xc0
> [  682.146754]  virtio_dev_probe+0x1af/0x260
> [  682.146759]  really_probe+0x1a5/0x410
> 
> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This won't fix the case where block has more queues than CPUs though,
will it?

> ---
>  drivers/virtio/virtio_vdpa.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 961161da5900..06ce6d8c2e00 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -366,11 +366,14 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	struct irq_affinity default_affd = { 0 };
>  	struct cpumask *masks;
>  	struct vdpa_callback cb;
> +	bool has_affinity = desc && ops->set_vq_affinity;
>  	int i, err, queue_idx = 0;
>  
> -	masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
> -	if (!masks)
> -		return -ENOMEM;
> +	if (has_affinity) {
> +		masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
> +		if (!masks)
> +			return -ENOMEM;
> +	}
>  
>  	for (i = 0; i < nvqs; ++i) {
>  		if (!names[i]) {
> @@ -386,20 +389,22 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  			goto err_setup_vq;
>  		}
>  
> -		if (ops->set_vq_affinity)
> +		if (has_affinity)
>  			ops->set_vq_affinity(vdpa, i, &masks[i]);
>  	}
>  
>  	cb.callback = virtio_vdpa_config_cb;
>  	cb.private = vd_dev;
>  	ops->set_config_cb(vdpa, &cb);
> -	kfree(masks);
> +	if (has_affinity)
> +		kfree(masks);
>  
>  	return 0;
>  
>  err_setup_vq:
>  	virtio_vdpa_del_vqs(vdev);
> -	kfree(masks);
> +	if (has_affinity)
> +		kfree(masks);
>  	return err;
>  }
>  
> -- 
> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
