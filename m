Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B4399358
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551008; cv=none; b=H2+2CsoNdhHrCy5cMT7L/g9f15gZVQ3BDhpTSajQiMv+n59ZvniisJSHfIEqZ+YQsZ1bCg3SVXjPXXwkoWXFlVHY+xzvDtsXhQz4z03qtJwAkqC1hhiA/joTRNBL16cyFW/VI4LaBRRUt823F91MtipyNHMRIPAQsAPvuZjIwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551008; c=relaxed/simple;
	bh=541yCyudfl/Oig6i683jbZpLPIiYIjuPsLEPZltlbGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OWb+tFgNDQ504yRIwOQ9uy23qcRHZDobXb9urJHqLsQjVb0blsDAA9sCbyTGeSQ6xCFNcHBCrAkHUZtwfnd8DVQMG1zsXjRNkkTKxZOjt+YntqSiHRb0ZS9ofR6HIf1Y49KqkmLRt7tjuR3y77Ehj3AATYLd8wGp0SU0DNfhK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3nA6HAw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3nA6HAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775551001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXjJmisGLe9c1EBjfdUUR813+mIV6drownEtZ9rlEOc=;
	b=O3nA6HAwDQRZetWVZE5i9f57nUbYJueEJMxt1rdHLlUL7bbPbTJV2A8alc7h4e+Bcd546Z
	SujvyjY6wu5fMUcIgyhqx1YkJ0ROgtd6J+QQNcvjFDOMy7PFsSPcqqdzgPslr1h5VCwX2y
	T5VjjQsmgKx7VkhEX9FP61bm7fht2TM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-bdYKEEBgOHK1H93t3iJ8QQ-1; Tue, 07 Apr 2026 04:36:40 -0400
X-MC-Unique: bdYKEEBgOHK1H93t3iJ8QQ-1
X-Mimecast-MFC-AGG-ID: bdYKEEBgOHK1H93t3iJ8QQ_1775550999
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4887fbb4dc8so30365335e9.2
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 01:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550999; x=1776155799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXjJmisGLe9c1EBjfdUUR813+mIV6drownEtZ9rlEOc=;
        b=DrFtINAHhK5NPNg7zRv5X5eXsO/ky833jkS8wAyohZyvHaHEoIMMsvCDY5efbHUxcn
         IDZndbCMCtV4QvHU6BmMxMPaMfw6fRyg26zHyoAGlf+42emWFOw9iNIBg1IRqF1YTjVS
         U5r0v8JR4K27GuoRjljJacPCH1htqF0fZrt9FIDCUS1+rerj4boKidKaXyc0lNZr8n+M
         eGYJXqFErr9PsS0WlBDvClkf0vU0rbIRoPe/Htcv7zAm0tGVVGTKa9lrIf2XEffKs883
         LtxHm76I3lOCQrVrqvkH0EVB3mjLEaZEp3be+cRvoxQ7h/ggVLjRVWkfd/6S8aeEH0dE
         UHQg==
X-Gm-Message-State: AOJu0YxJtqWwJQ5ce8FGH4Dmds5Xq5rINqJ+0ICs6sMgcN1vfKdpMhDH
	6nkHU3yLWBWBQ10LQgs2eR/dEIVRKPdtUKdikvtuUuKbaGCcQNgioe2prMm++9CvaxDgnxkW+aI
	q45XWaKfEZ78hJfVUlSq+9SPsBFA3TSe9B39EICNZYF1ymiidFvliBRrB8dmPFKu5hEnx
X-Gm-Gg: AeBDiettH4Ocsfr2GA4KzbvoRpqgEE/EH88+QtjCbiVMxBswDjUkjT7HybBb2ToHWQ0
	xPTkk6ha+WtK/4Y1E92NTK7VW6lDeNmSQYbZhiGowJVJ9Ew2HBC9bDmdNxFNNORIc0fsy4TyfIK
	hLFRzc4Ct+t8cbPzAiTYiivCnRMyzda0Ht+8DPl4SbK4y9jsfADbdTAMwpX4pP6WD/LPDCjYdx7
	mgrv2hMzYRido5yP8yMr4khYaaP3felNI6DJFl5xdIIbdyd9f+H4W+rsupFx7wVVNT2ciRuQVmS
	IO9kFvc9ahcqoSq4V19c0XQ5iHy14XWS8Uo0cDMu/UMwTZKNApwR+2SEBMKxjv366jGC7Jd+EiE
	h/ko7KEqUpb2G9Yo=
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr27314105e9.30.1775550999353;
        Tue, 07 Apr 2026 01:36:39 -0700 (PDT)
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr27313505e9.30.1775550998854;
        Tue, 07 Apr 2026 01:36:38 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488be75215dsm36969965e9.6.2026.04.07.01.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:36:38 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:36:36 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>
Cc: virtualization@lists.linux.dev, linux-can@vger.kernel.org,
	harald.mommer@oss.qualcomm.com, mkl@pengutronix.de,
	mailhol@kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com, sgarzare@redhat.com,
	francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Message-ID: <adTCFHpT6AThJT5L@fedora>
References: <acLNB9PYmJ9L0Wvc@fedora>
 <20260402095243.647258-1-dbassey@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260402095243.647258-1-dbassey@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0AkKI_QArMFqKgSLBU0Z3KnogwrCP8V-MqMUTxvf43g_1775550999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 11:52:43AM +0200, Dorinda Bassey wrote:
> Hi Matias,
> 
> I've been testing PATCH v13 of the virtio CAN driver and encountered a
> FORTIFY_SOURCE panic when transmitting frames:
> 
> 	sh-5.3# cansend can0 123#DEADBEEF                                                                                     
> 	[   51.700501] Kernel BUG at __fortify_panic+0x9/0xb [verbose debug info unavailable]                                 
> 	[   51.700798] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI                                                      
> 	[   51.700881] CPU: 2 UID: 0 PID: 374 Comm: cansend Tainted: G        W          6.12.76 #1                           
> 	[   51.701070] Tainted: [W]=WARN                                                                                      
> 	[   51.701143] RIP: 0010:__fortify_panic+0x9/0xb                                                                      
> 	[   51.701212] Code: 01 00 00 e9 58 7e c2 ff cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90  
> 	90 40 0f b6 ff e8 57 a9 c2 ff <0f> 0b 48 8b 54 24 08 48 8b 74 24 10 4c 8d 44 24 1d 4c 89 e1 48 c7                     
> 	[   51.701406] RSP: 0018:ffffc900001ffb10 EFLAGS: 00010246                                                            
> 	[   51.701454] RAX: 0000000000000000 RBX: ffff888100ea8780 RCX: 0000000000000003                                      
> 	[   51.701530] RDX: 0000000000000000 RSI: ffffc900001ff9b8 RDI: 0000000000000001                                      
> 	[   51.701625] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fffffbff                                      
> 	[   51.701700] R10: ffffffff82239ee0 R11: ffffc900001ff9b0 R12: ffff888100ea8000                                      
> 	[   51.701789] R13: ffff888100817200 R14: ffff88810037cda0 R15: ffffc900001ffb48                                      
> 	[   51.701866] FS:  00007f7c4cda3740(0000) GS:ffff88812bd00000(0000) knlGS:0000000000000000                           
> 	[   51.701948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                      
> 	[   51.702007] CR2: 00007f7c4ceffdc0 CR3: 0000000100d12000 CR4: 0000000000350eb0                                      
> 	[   51.702072] Call Trace:                                                                                            
> 	[   51.702105]  <TASK>                                                                                                
> 	[   51.702126]  ? virtio_can_start_xmit.cold+0x2b/0x4d                                                                
> 	[   51.702171]  ? srso_alias_return_thunk+0x5/0xfbef5 
> 
> The issue is in virtio_can_start_xmit() where can_tx_msg->tx_out.length
> is set AFTER memcpy(can_tx_msg->tx_out.sdu, ...). Since sdu[] uses
> __counted_by_le(length), FORTIFY_SOURCE sees length=0 during the copy
> and panics.
> 
> The fix is to set length before the memcpy:
> 
Thanks I just pick it for v14! I did not observe this behavior before. I
guess they added a new validation that I was not aware of.

Matias

> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index xxx..yyy 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -308,6 +308,7 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
>  
>  	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
> +	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
>  	can_flags = 0;
>  
>  	if (cf->can_id & CAN_EFF_FLAG) {
> @@ -322,7 +323,6 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
>  		can_flags |= VIRTIO_CAN_FLAGS_FD;
>  
>  	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
> -	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
>  
>  	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);
> 
> Tested with vhost-device-can backend, and it works correctly after this fix.
> 
> Thanks,
> Dorinda Bassey
> 

