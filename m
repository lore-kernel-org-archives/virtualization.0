Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49352C04A95
	for <virtualization@archiver.kernel.org>; Tue, 25 Oct 2022 14:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2FE8607F9;
	Tue, 25 Oct 2022 14:04:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2FE8607F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dfym4fZ6JlFy; Tue, 25 Oct 2022 14:04:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 70CDD605B0;
	Tue, 25 Oct 2022 14:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70CDD605B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 485E1C0033;
	Tue, 25 Oct 2022 14:04:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4BDC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 14:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 397B8605E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 14:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 397B8605E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nKSZ3ga5lc5i
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 14:04:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94D82605B0
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94D82605B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 14:04:10 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id s196so11566217pgs.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Oct 2022 07:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Te46Alpl4tynaaATY6iERpmfuiFBUQ+4oa5sHa3QaY=;
 b=LxFQn4WIVxRs5i1t4U+FVKhqx5L1w5jgIbb+YrMbZDBaQFMmgyVMWbbvDokUKz2KVM
 Y74BI3EAGNjIL4NqQRaZeM5y25czVC677LHF82N0gGonhUojsRG55OLE0J0duE63voxT
 x+6iG/c/uCCys1jKUV9l2NuTcfNWfZxOCyhescGQItodCc/8F7mZ3mtU6fJlDaQ3ZM40
 kwFj9knaD/ITy8Na2FVf3+qpn+uM9hoeUE4p1kit45FuUvKZlX9SC9jE7Ewe3TW7OHvV
 iCoY5Kb79ZQKgcLN7p4Z4bAe5b+XbRGpfPy6hK7a0zBp5xam6ifo5st+Vld7lGKgX16q
 b9XQ==
X-Gm-Message-State: ACrzQf3Yjp0LPIyOT+YMhZR4EvW3Kn9aqGbPHAS5ve3SJaEdUniakigr
 twZPjYM7RfoycF53D5QAdqg=
X-Google-Smtp-Source: AMsMyM7ShonRU+/ZarCJpF/LAJmrHf0u81CHO0oOSPS+LEOrBtV6JCu5S9xRZrl8cFUeZYdWnfx4Lg==
X-Received: by 2002:a63:2a81:0:b0:43c:5fa6:1546 with SMTP id
 q123-20020a632a81000000b0043c5fa61546mr32451709pgq.43.1666706649949; 
 Tue, 25 Oct 2022 07:04:09 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a170903230200b0017f61576dbesm1247772plh.304.2022.10.25.07.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Oct 2022 07:04:09 -0700 (PDT)
Message-ID: <12132794-b7ba-5b87-4dae-fad592a74ee9@acm.org>
Date: Tue, 25 Oct 2022 07:04:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early timeout
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20221025005501.281460-1-ming.lei@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221025005501.281460-1-ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 David Jeffery <djeffery@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On 10/24/22 17:55, Ming Lei wrote:
> +struct blk_expired_data {
> +	unsigned long next;
> +	unsigned long now;
> +};

How about renaming 'now' into 'before_quiesce'? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
