Return-Path: <SRS0=Fazc=QA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB66C433F5
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 08:54:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C947610A1
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 08:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C947610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73D8340625;
	Sat, 13 Nov 2021 08:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mWBpkMcDuuEi; Sat, 13 Nov 2021 08:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A21FB405E9;
	Sat, 13 Nov 2021 08:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79F3EC001E;
	Sat, 13 Nov 2021 08:54:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35879C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 08:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 105CF405E9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 08:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCftGGrgrCi2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 08:54:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5D5F405E5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636793680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+z8rYoU9QD9VNjpmLDDx7zDmor9Ob3HEVQtqnctyQ0=;
 b=R2TUxULAUkahvbplfLgQrhoTxKS0gjx4/Hz/KVspMzcGWKcSRxJN3HT5Vu7lfq5/JT2B/P
 2iYk1U7DUWMHaqtQ4s9IGs6sRD55ne2ZMriFLVeATh6TSJnX0JlnzdYb5t/+nhLAs4iYn9
 iUMAbrJ9sI38a0nygoZkQcn+2kPA+kk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-15BvNm7GMlKfLGI-QBwgdA-1; Sat, 13 Nov 2021 03:54:39 -0500
X-MC-Unique: 15BvNm7GMlKfLGI-QBwgdA-1
Received: by mail-wr1-f70.google.com with SMTP id
 q7-20020adff507000000b0017d160d35a8so1882921wro.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 00:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=d+z8rYoU9QD9VNjpmLDDx7zDmor9Ob3HEVQtqnctyQ0=;
 b=vsmBs9AP3ZI8BoOatpLbVP+vbg73/Sq9RLXJHNh1cZmGyc6agAbLhv6pSAzxsjUYEv
 UQS2j51U0CZ+Jbekj0oby/AxVhOFdn0NOPrpaeb+SEca3PMM9RSoJEXwTtrjdiYjxTdB
 W9o5sfSFYKzJ/QgXa/A8N/fJYNqXlxnrKKleHC3TKqr82eSXOlqAhI/qYrw+45T/eE4T
 3GiLdXZlTExgLo8hBGrhLlwIc0vkCrWsgWYc1fz+1DYb3V6GH7uQP89hsPs4NDK1NwIH
 3asBrYSP6OLEJ4ABoEZCvxdJxOhiH3jrnaBZewkdXjhVOjw28VSvtPqw2+1e1ebvvbJb
 bepQ==
X-Gm-Message-State: AOAM530Inuwee7s1OBW1RIaKzDSNeQkvzwjrIaqAI+n4qI+6/hYqHW8R
 RtO1mLrnFzZb8sr8Wf4dU/4IKNAWqZJS0ZkxD+3d/6R80TjfyOurEscBGUGzSJ/9kYjqV4dV68J
 dgEN7XwYOEdSxwECqMY4paxX9aubARVMU4WE7XCCTMQ==
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr23578911wmc.149.1636793677178; 
 Sat, 13 Nov 2021 00:54:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykr6DLfv2aEzX3pfP8GsAedXQIQu2gXW2KdaV5PSZIQXS0yxFm3EOuj5Mw74jyDyTlm5cfeA==
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr23578895wmc.149.1636793677003; 
 Sat, 13 Nov 2021 00:54:37 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6cef.dip0.t-ipconnect.de. [91.12.108.239])
 by smtp.gmail.com with ESMTPSA id j40sm8990732wms.16.2021.11.13.00.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Nov 2021 00:54:36 -0800 (PST)
Message-ID: <6f677edc-6c81-199a-0bc6-25117fa4b34e@redhat.com>
Date: Sat, 13 Nov 2021 09:54:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [GIT PULL] virtio-mem changes for v5.16
To: linux-kernel@vger.kernel.org
References: <20211110163754.27528-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211110163754.27528-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 10.11.21 17:37, David Hildenbrand wrote:
> Hi Linus,
> 
> usually this would have went via the vhost tree, but as this patch depends
> on some patches that just went in via Andrews tree and MST doesn't have
> any other patches for this merge window, I'm sending it myself
> and base it on current mainline that contains the relevant commits
> already. Thanks!
> 

This is most probably at the end of the PULL queue, just a heads up that
it would be really nice to have this in v5.16. Thanks!


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
