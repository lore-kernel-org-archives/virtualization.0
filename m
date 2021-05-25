Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E4C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 08:06:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6836109E
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 08:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6836109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EFB54016A;
	Tue, 25 May 2021 08:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pT4xjcyHfL02; Tue, 25 May 2021 08:06:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8FEA400E4;
	Tue, 25 May 2021 08:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEAAEC000E;
	Tue, 25 May 2021 08:06:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7742CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 08:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B41983AC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 08:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hZ41ADqmcx96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 08:06:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77E8A831BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621930003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub5yjHLwnKgzkGvx4GaW/I0s0yGaXeZ4jZCMAsk/qs4=;
 b=ONGluuS6Dj9+GBOTCE7PEnMcun4BZV6k8P21zDM5VXgG1V1nTa838S2NnILhK5KCslf+5Q
 JXgFc/NduQpmhRlvJ5z4ZiKjiQFMwAX5PZ0Pa47g0Ac//oMemWfuR/2vjpbo+D1j9I0LCz
 WKVZo/GEqaRAs6mfPEHpNbapFc7jyrU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-fat8IIlXNYSPC9Kasdg91g-1; Tue, 25 May 2021 04:06:39 -0400
X-MC-Unique: fat8IIlXNYSPC9Kasdg91g-1
Received: by mail-ed1-f70.google.com with SMTP id
 u14-20020a05640207ceb029038d4bfbf3a6so13348630edy.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 01:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ub5yjHLwnKgzkGvx4GaW/I0s0yGaXeZ4jZCMAsk/qs4=;
 b=hjN5eIE5cXczTL629zR9vvsoSjRJSQyg6FitWvmkY0UMgKfcTWFpPmwLYVFTATi9Ms
 cBtATCXYpS1/zAKO2AZLohKxoBDmQEBKNQYrNGQQ3oLPbXk7Jqmxgewk+1TibXTdxT7q
 UwcZX6aA6Vc/CKB1Jhima5fLevkjmtunIJN/eFKWKlz9oZKtfHbPapvyrlczzmxTm+co
 y1YmEarg+BIZicvFNiCwG9gLrHYj5Jpl8Awqe8UFezYCpa4WKGAxx0GZBn1rZNZvPRXn
 YQ2n+n3C1z31FXQDkZV6cDQKjVfBEhcGjOlzgv0mZDcIJiiwGg/5LV091oKO00+bLejt
 aPAg==
X-Gm-Message-State: AOAM532LZjRlSuKoZ9HYVworSSmWkWElK2zTHXDozG56PAwelL0vP+wi
 55TAh3SP8YpcSyFMD9GfdQSw7o5uFNU9y1BA0rJvtTQjRgSx/gVgf9Pln1/TbbR3NC12XI7rkD/
 lGG8Idx92sqQ53NLNkmQzbJfmvpRx1ykTGIQS0UTevQ==
X-Received: by 2002:a05:6402:40c1:: with SMTP id
 z1mr29288923edb.97.1621929998252; 
 Tue, 25 May 2021 01:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygZqhf+xYB7Ndg3ayTHtQu/3t0kArAedOP5pe98sDgQVP2z7+rV66oJGM/D3XST8tFG3f5gA==
X-Received: by 2002:a05:6402:40c1:: with SMTP id
 z1mr29288906edb.97.1621929998039; 
 Tue, 25 May 2021 01:06:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id n8sm8645618ejl.0.2021.05.25.01.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 01:06:37 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
To: Ming Lei <ming.lei@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com> <20210524145928.GA3873@lst.de>
 <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com> <YKypgi2qcYVTgYdv@T590>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1997919-e059-b50b-19b3-5741e3309000@redhat.com>
Date: Tue, 25 May 2021 10:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKypgi2qcYVTgYdv@T590>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Christoph Hellwig <hch@lst.de>
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

On 25/05/21 09:38, Ming Lei wrote:
> On Tue, May 25, 2021 at 09:22:48AM +0200, Paolo Bonzini wrote:
>> On 24/05/21 16:59, Christoph Hellwig wrote:
>>> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
>>>> Possible drawbacks of this approach:
>>>>
>>>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>>>     expensive since it requires DMA. If such devices become popular then
>>>>     the virtio_blk driver could use a similar approach to NVMe when
>>>>     VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>>>
>>>> - If a blk_poll() thread is descheduled it not only hurts polling
>>>>     performance but also delays completion of non-REQ_HIPRI requests on
>>>>     that virtqueue since vq notifications are disabled.
>>>
>>> Yes, I think this is a dangerous configuration.  What argument exists
>>> again just using dedicated poll queues?
>>
>> There isn't an equivalent of the admin queue in virtio-blk, which would
>> allow the guest to configure the desired number of poll queues.  The number
>> of queues is fixed.
> 
> Dedicated vqs can be used for poll only, and I understand VM needn't to know
> if the vq is polled or driven by IRQ in VM.
> 
> I tried that in v5.4, but not see obvious IOPS boost, so give up.
> 
> https://github.com/ming1/linux/commits/my_v5.4-virtio-irq-poll

Sure, but polling can be beneficial even for a single queue.  Queues 
have a cost on the host side as well, so a 1 vCPU - 1 queue model may 
not be always the best.

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
