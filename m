Return-Path: <SRS0=k2cl=LJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC453C48BDF
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 07:43:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89586613DE
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 07:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89586613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 53F8A83ACB;
	Tue, 15 Jun 2021 07:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLzYUlm6fmAC; Tue, 15 Jun 2021 07:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E498783AC5;
	Tue, 15 Jun 2021 07:43:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADDA3C000E;
	Tue, 15 Jun 2021 07:43:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95AADC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 825B76063C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qagbCQL_n6qh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:43:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EE7060596
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623743018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5BYj4j/2r6NqdvA1bsc1o0RQ7n98tK7o7BcnsyMqpo=;
 b=MQFa8Ke9Kls97YgJPeTE9jcue0ZkeBn8Je5v2/FKxLsyl967otqTuqGxQYWPdDtB6p1oPC
 PVE+YPQR0BA8nCWMdMYI7MxmIQ+H0e1nndrqanpmc5PSoO4JTTil+brO3JCYcEIvpb9qB1
 oDZH6NZYx0rX+4IVHmAlqLZ+Oproy54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-w9-5Ci7yOvGGWsQvO48Ezw-1; Tue, 15 Jun 2021 03:43:36 -0400
X-MC-Unique: w9-5Ci7yOvGGWsQvO48Ezw-1
Received: by mail-wm1-f70.google.com with SMTP id
 m33-20020a05600c3b21b02901a44b1d2d87so1152493wms.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 00:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=v5BYj4j/2r6NqdvA1bsc1o0RQ7n98tK7o7BcnsyMqpo=;
 b=b0SIrUrTUryffqnT8qw4wOqQHXivmeGfoKwxL/NaM8YdFn3P3LlmkNF2zozhHqvnNC
 3f8C8RI0fC3wAmwqtEvJ/s9R8kV4IPs0whqNbUxZdOfJ4ARpwQneAHF9K95prsAMSzW9
 HxonEr5nDoIOiEnzjJ032QiySo9bO2SvGUwknrbfAlfxZBktfZC0LpYUM9wXabuy+i99
 lowce+QP0/c1kju1e9+6+5Gqooy9zULtv0q0919zQeNVjBh3ge0YpKviUpTEGs8F2+WY
 f1RAiuN+nNpn5DwtIZQrriKj5eVwL0pTGlTajGww1pPoAAKvLQM/TevMiC/O40CNc5QZ
 GtqA==
X-Gm-Message-State: AOAM530g8vZnfdR10Xqu1RO+kYWSLI2RkQzLhYDUEE97nh9fPH9l3OWc
 acWyEVzerEUsEvmx7K59S7jW1nLFAVYZCbObfbqnBUMQA3sZAdkLLF+vHYVHQkJ7j5GmW+CoSxn
 REEYrZQrmU1ycFkUNPN522KTK7OZiU5o6miAsvkNQAQ==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr23844154wrq.336.1623743015004; 
 Tue, 15 Jun 2021 00:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMxOPKD3EUDoJqW31zoVPS5bmkuhx9H0WhqkSf3TNl8uon/XcN4wF0Lr6RJPhGNltMeiOgrg==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr23844143wrq.336.1623743014831; 
 Tue, 15 Jun 2021 00:43:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6136.dip0.t-ipconnect.de. [91.12.97.54])
 by smtp.gmail.com with ESMTPSA id
 g186sm15065784wme.6.2021.06.15.00.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 00:43:34 -0700 (PDT)
Subject: Re: [RFC] virtio-mem: virtio_mem_init: Access bb_size just in BBM mode
To: Hui Zhu <teawater@gmail.com>, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210615065948.23493-1-teawater@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7fd8bf39-642d-1cdf-bc5d-c19630045013@redhat.com>
Date: Tue, 15 Jun 2021 09:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210615065948.23493-1-teawater@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Hui Zhu <teawaterz@linux.alibaba.com>
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

On 15.06.21 08:59, Hui Zhu wrote:
> From: Hui Zhu <teawaterz@linux.alibaba.com>
> 
> /* In BBM, we also want at least two big blocks. */
> vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
> 			      vm->offline_threshold);
> This line does not modify vm->offline_threshold depending on the data in
> vm->sbm that shares this address is 0 in SBM mode.
> I think it might be difficult to make sure when we change this in the
> future.
> 
> This commit adds an if to make sure that this line just be executed in
> BBM mode.
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_mem.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 10ec60d..8185916 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2472,8 +2472,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
>   	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
>   				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
>   	/* In BBM, we also want at least two big blocks. */
> -	vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
> -				      vm->offline_threshold);
> +	if (!vm->in_sbm)
> +		vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
> +					      vm->offline_threshold);
>   
>   	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
>   	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
> 

Good that you also spotted it, I already have a fix pending for that :)

https://lkml.kernel.org/r/20210602185720.31821-2-david@redhat.com

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
