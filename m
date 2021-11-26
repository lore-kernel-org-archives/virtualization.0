Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB9AC433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 08:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB6554043D;
	Fri, 26 Nov 2021 08:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3w-k7cky-Coc; Fri, 26 Nov 2021 08:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E02E403CA;
	Fri, 26 Nov 2021 08:51:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2847C001E;
	Fri, 26 Nov 2021 08:51:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 146EFC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE55A4014B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fHwfEI2Csa17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9CF940012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637916673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0q1FtV/hCmMxBW6bOw7HA8YRfBLsTGYeP2j6B9MS2M=;
 b=PvGi/rzQFxmh164CYooeBN9hznOZfGqdIcbM+lGMZIa1ipCAsoAsKgCIWIm40KaMJpg5Hs
 3bw9S+cETp97ob3TXcMqE7+kaNC/hwKpqp7GwgjHwKE198AH0R9WfRYCfr3nSCU1r5g9XC
 StnewvjxZxc2WpOTIow40TGP8Wu348Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-QVf8oE96OP2YwwMrzjSOPA-1; Fri, 26 Nov 2021 03:51:12 -0500
X-MC-Unique: QVf8oE96OP2YwwMrzjSOPA-1
Received: by mail-wr1-f72.google.com with SMTP id
 p3-20020a056000018300b00186b195d4ddso1539116wrx.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 00:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=m0q1FtV/hCmMxBW6bOw7HA8YRfBLsTGYeP2j6B9MS2M=;
 b=FRjysgkLft0xs0nP5AkOcyV9jVnRbWccQPSNbP8nItXQJhSIX2NWNZSs7p718lyZvE
 MT5jIWQ/szW9eHislqOmcB+eMys/M9Ofs953Cz9hFAI9BROPc6rz0i8VNKB7ZR5z7ZoE
 XRs1ZakAWX2ojJNWyLrRZ3w6l9PAbQTLNC91G14pkPIOhPDwm+11WnmRUSXsry5eM2Gn
 zND/3NZlqk594myCM7N8QLIWWSEG8hxIUcun1vW1eclMwdjuiubxLSMcosKBP94YxI69
 VoY20V+S1U1Vw315/PGI/DNsJop3t268iBK+6in3gmPcZbtbDqWFr5nMW+b8NX4PWeO4
 Bgtg==
X-Gm-Message-State: AOAM530IM4oGcInlS31dBJvSPdDVcRj5ykw3d84G+bjQuXOFb3yNFEj1
 FnqsHarydCDBmaT4Pk47RBm7rTgK/X+oAhxIhwTq+cZ3Lfxmim6uaP2Akgf2cGC7OMEiv5GYOK4
 86SryA9Uqooz2X12fCZ7Y50my/13ftU/j4UNeBjwqyg==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr12864181wrw.138.1637916671003; 
 Fri, 26 Nov 2021 00:51:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJWBwXygeN6NpMAN/QamV/bgObotWaHpViXb90YpSCTC9w/eitvSmw9kmmsoYm62fZ47Za3w==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr12864158wrw.138.1637916670803; 
 Fri, 26 Nov 2021 00:51:10 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
 by smtp.gmail.com with ESMTPSA id r62sm5373757wmr.35.2021.11.26.00.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 00:51:10 -0800 (PST)
Message-ID: <33f597f0-3237-112e-692f-add18c4ca976@redhat.com>
Date: Fri, 26 Nov 2021 09:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH AUTOSEL 5.10 3/4] virtio-mem: support
 VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20211126023034.440961-1-sashal@kernel.org>
 <20211126023034.440961-3-sashal@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211126023034.440961-3-sashal@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>
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

On 26.11.21 03:30, Sasha Levin wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> [ Upstream commit 61082ad6a6e1f999eef7e7e90046486c87933b1e ]
> 
> The initial virtio-mem spec states that while unplugged memory should not
> be read, the device still has to allow for reading unplugged memory inside
> the usable region. The primary motivation for this default handling was
> to simplify bringup of virtio-mem, because there were corner cases where
> Linux might have accidentially read unplugged memory inside added Linux
> memory blocks.
> 
> In the meantime, we:
> 1. Removed /dev/kmem in commit bbcd53c96071 ("drivers/char: remove
>    /dev/kmem for good")
> 2. Disallowed access to virtio-mem device memory via /dev/mem in
>    commit 2128f4e21aa2 ("virtio-mem: disallow mapping virtio-mem memory via
>    /dev/mem")
> 3. Sanitized access to virtio-mem device memory via /proc/kcore in
>    commit 0daa322b8ff9 ("fs/proc/kcore: don't read offline sections,
>    logically offline pages and hwpoisoned pages")
> 4. Sanitized access to virtio-mem device memory via /proc/vmcore in
>    commit ce2814622e84 ("virtio-mem: kdump mode to sanitize /proc/vmcore
>    access")

As 2. and 4. are part of v5.16-rc1 but not v5.10-stable

Nacked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
