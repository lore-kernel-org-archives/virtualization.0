Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC09C4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 14:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5314460D5E;
	Tue, 22 Feb 2022 14:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hotdH1zvnVMx; Tue, 22 Feb 2022 14:05:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C2DF1605A7;
	Tue, 22 Feb 2022 14:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 961B0C001A;
	Tue, 22 Feb 2022 14:04:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0AB3C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 14:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4975402C3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 14:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P_IwX9Judxrx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 14:04:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4463340143
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645538694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+0qFceD01hVCN/fQNTDDfz9J6CvlRYxeXEgGXKvXoqM=;
 b=g7arPT733wIlIvm1xIhkPotHbM3gxO2VOaQGe57alZLpWFTY01MjbAFesxLbxYTYHpTc02
 P4KJGw/yU8oVfuNX8Gn31JElxApZXCF6mWC3lvbx2qmsTm/cTU2qn0bZKEyNHKhRFJDG+1
 g2H3zHbvQtczeKil6pVwiw/PFc304iU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-MYIA-teZMmKwo-6v4hikAA-1; Tue, 22 Feb 2022 09:04:52 -0500
X-MC-Unique: MYIA-teZMmKwo-6v4hikAA-1
Received: by mail-wm1-f72.google.com with SMTP id
 g22-20020a1c4e16000000b0037bc7a977b3so2001535wmh.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 06:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+0qFceD01hVCN/fQNTDDfz9J6CvlRYxeXEgGXKvXoqM=;
 b=1BBmGehSPag50tYUYyh5QUITn7oeUPPHdtfJGHavAxf3/5wfSnHrZ26Uh0ZxNzcLbB
 AEVyTpLytzVrcG4/D8EZ9PCsHc89Pbtuz7BE0AsUNOZusC54o9ErjTP0aRQzWJkQMq9w
 n8uJdo1oea7+GOR7FVhoigiXOrgma1Ty5AM7v8qoi+M4RsOVO4AWINmex13CbRpw7aD3
 0isy2DvHWrewGAoYN2mWO8oinR7A+G7ikvBPPcCJEBmK4YCPZaVmxDGVsaBEh2XbLLyM
 Epg/eJTt6X5dTzam4gBWKMFLTYHFPnkPvbtgR4hRtNlCGAyXAvDoBIbrFSn+lpZBJze4
 sH5Q==
X-Gm-Message-State: AOAM532ly59XM6E3lcP7NgoPASeLEiNjE8ZgVSekSLzNMwzK+k6JVraJ
 HsW/NmKH1ux2lxd8bb1DDFZPlsw8qkyuJAK3sj4P7BRKv/aZbFl5vKb1TNgSjySLiQMUDkoNroS
 Ctn13ackLWmqHsxryvGbDzp7XIZZb/vIAiRJgqXL9gw==
X-Received: by 2002:a1c:2904:0:b0:37b:ea53:4cbf with SMTP id
 p4-20020a1c2904000000b0037bea534cbfmr3521211wmp.46.1645538690587; 
 Tue, 22 Feb 2022 06:04:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnqfwv3DyvbfLKFUSw1w02W2csoa49y5OZ11ejqp+BgbeoaU6MPpX2ME5lsWarq+vpSzVxjA==
X-Received: by 2002:a1c:2904:0:b0:37b:ea53:4cbf with SMTP id
 p4-20020a1c2904000000b0037bea534cbfmr3521190wmp.46.1645538690376; 
 Tue, 22 Feb 2022 06:04:50 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
 by smtp.gmail.com with ESMTPSA id j6sm41356042wrt.70.2022.02.22.06.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 06:04:49 -0800 (PST)
Date: Tue, 22 Feb 2022 09:04:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [PATCH] vhost: validate range size before adding to iotlb
Message-ID: <20220222090406-mutt-send-email-mst@kernel.org>
References: <20220221195303.13560-1-mail@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <20220221195303.13560-1-mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
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

On Tue, Feb 22, 2022 at 01:23:03AM +0530, Anirudh Rayabharam wrote:
> In vhost_iotlb_add_range_ctx(), validate the range size is non-zero
> before proceeding with adding it to the iotlb.
> 
> Range size can overflow to 0 when start is 0 and last is (2^64 - 1).
> One instance where it can happen is when userspace sends an IOTLB
> message with iova=size=uaddr=0 (vhost_process_iotlb_msg). So, an
> entry with size = 0, start = 0, last = (2^64 - 1) ends up in the
> iotlb. Next time a packet is sent, iotlb_access_ok() loops
> indefinitely due to that erroneous entry:
> 
> 	Call Trace:
> 	 <TASK>
> 	 iotlb_access_ok+0x21b/0x3e0 drivers/vhost/vhost.c:1340
> 	 vq_meta_prefetch+0xbc/0x280 drivers/vhost/vhost.c:1366
> 	 vhost_transport_do_send_pkt+0xe0/0xfd0 drivers/vhost/vsock.c:104
> 	 vhost_worker+0x23d/0x3d0 drivers/vhost/vhost.c:372
> 	 kthread+0x2e9/0x3a0 kernel/kthread.c:377
> 	 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 	 </TASK>
> 
> Reported by syzbot at:
> 	https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
> 
> Reported-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/vhost/iotlb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
> index 670d56c879e5..b9de74bd2f9c 100644
> --- a/drivers/vhost/iotlb.c
> +++ b/drivers/vhost/iotlb.c
> @@ -53,8 +53,10 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>  			      void *opaque)
>  {
>  	struct vhost_iotlb_map *map;
> +	u64 size = last - start + 1;
>  
> -	if (last < start)
> +	// size can overflow to 0 when start is 0 and last is (2^64 - 1).

Pls use the old-style /* */  comments.

> +	if (last < start || size == 0)
>  		return -EFAULT;
>  
>  	if (iotlb->limit &&
> @@ -69,7 +71,7 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
>  		return -ENOMEM;
>  
>  	map->start = start;
> -	map->size = last - start + 1;
> +	map->size = size;
>  	map->last = last;
>  	map->addr = addr;
>  	map->perm = perm;
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
