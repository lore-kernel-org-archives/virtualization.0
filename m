Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F95C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 07:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D105060B38;
	Mon, 19 Dec 2022 07:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D105060B38
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eK48hdlh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_ckIfocb5d7; Mon, 19 Dec 2022 07:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6145E60B15;
	Mon, 19 Dec 2022 07:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6145E60B15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC635C0032;
	Mon, 19 Dec 2022 07:33:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11406C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D24008138C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:33:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D24008138C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eK48hdlh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ki6rQyUmiz5O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:33:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 090E08002E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 090E08002E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671435196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0d/LzPh9tLeJeMKVu3lKsG2+7fr+JIeuFdunk+ZR8IY=;
 b=eK48hdlhZ1eg7EIYr3XYNn0h8+XbBPqopGiR+inq6OXZOh76vNB/FgCDFH3fmOeJxZfnGL
 hWP+Q5TppsuC1S5ZlbjOG/xLljzXffXWr3r10QW9UfWJpVP1PwxJI0Toydr2yCllHOKrc5
 XP4RtWUsAmTzMUltVCBR8bQKIncBoRA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-30-UC-74SqGPXutsrceHvga2A-1; Mon, 19 Dec 2022 02:33:15 -0500
X-MC-Unique: UC-74SqGPXutsrceHvga2A-1
Received: by mail-qv1-f71.google.com with SMTP id
 ld9-20020a056214418900b004d0ab346633so5222741qvb.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Dec 2022 23:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0d/LzPh9tLeJeMKVu3lKsG2+7fr+JIeuFdunk+ZR8IY=;
 b=D9rZrkr97wgFIQiDBMXHYovq75MynbSsULHbB9nj27VdJKlrnvSgA1+NaGDPaz9rdB
 yGlwGoNeYIl/bztoJeQUlpGtde3wEqe91z7RYRMbu5w+nzxFHpb5d5mA4VjRu7JJQJpL
 8atASF3Sx1vSbYCUoyTiA0xAdnI34dHuXqFm+tI8OmcFItSVHgXkc4bmBC4651tBMSki
 aPoC+DsywQf/KUZHmZKKqeYk9TO/2eH/CNPQ5Ei1eYmSRZx07zddgEHBF73ts9s1aLqU
 oUIkd2efpUELs6NBIhw4kL/SPnbRLcTuoohA/bLz43hu1CT5LIztvRmA1UTg7D2qRtjh
 jSFg==
X-Gm-Message-State: AFqh2kp8bdq5PvxiYR3xEdk1+DsYiwa+QeLNZ7Ro236Vkerv//CYWYPR
 AqWzqW+S/3CpbqbbnLZJyx4CXqgqS4tbDLPpuCTSrErFftkU0AuuuQYEsbesl9u3pRh8S6c+OHf
 Ah11URX+FSOb3bAzX02WQmIYWCnpfBLvmymybYJmZMg==
X-Received: by 2002:ac8:48d3:0:b0:3a9:7d16:ef64 with SMTP id
 l19-20020ac848d3000000b003a97d16ef64mr9349781qtr.57.1671435194904; 
 Sun, 18 Dec 2022 23:33:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXueArC7fYe0/6MSkh/5pNiFIk1IZRkyewdVHEmCriamttbg+rOsLqUBb3auPDqAq6r2srRb9Q==
X-Received: by 2002:ac8:48d3:0:b0:3a9:7d16:ef64 with SMTP id
 l19-20020ac848d3000000b003a97d16ef64mr9349769qtr.57.1671435194641; 
 Sun, 18 Dec 2022 23:33:14 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 d8-20020ac847c8000000b003a7e38055c9sm5574821qtr.63.2022.12.18.23.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Dec 2022 23:33:13 -0800 (PST)
Date: Mon, 19 Dec 2022 02:33:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
Message-ID: <20221219023253-mutt-send-email-mst@kernel.org>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20221205084127.535-2-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de, hch@lst.de
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

On Mon, Dec 05, 2022 at 04:41:17PM +0800, Xie Yongji wrote:
> Export irq_create_affinity_masks() so that some modules
> can make use of it to implement interrupt affinity
> spreading mechanism.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

So this got nacked, what's the plan now?

> ---
>  kernel/irq/affinity.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index d9a5c1d65a79..f074a7707c6d 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -487,6 +487,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  
>  	return masks;
>  }
> +EXPORT_SYMBOL_GPL(irq_create_affinity_masks);
>  
>  /**
>   * irq_calc_affinity_vectors - Calculate the optimal number of vectors
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
