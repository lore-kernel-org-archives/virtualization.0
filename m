Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA72C2B9F8
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 07:22:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B616E61420
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 07:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B616E61420
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D61640189;
	Tue, 25 May 2021 07:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5J_VTvCb3zz; Tue, 25 May 2021 07:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D5EC400E4;
	Tue, 25 May 2021 07:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 052FCC000E;
	Tue, 25 May 2021 07:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 001BEC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D57EB4016A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:22:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rcjEvljEOfHC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:22:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B327400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621927373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h+A+HfSpXZqAH5SCxE7ycsL7iyfz3fycevoSOlmzgN8=;
 b=gYuk2LdTW8puT6AkVZxU+65PmO6r2Wp4EfMRj0y75PO0fyp5OhH1BC/qeF9YZnfI/LEdf5
 93u+4gYhNaqtXJkbJqxJmII0lnPZW1Mlq9vsNLW8glYQ6wvVGrUtakzxh1s69Bx/xQWWIc
 pLCEQMN55+mcVJwUJeGcPcyIZUk/p3I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-VMCudxX1Ma6Vu0CPTAHvGA-1; Tue, 25 May 2021 03:22:50 -0400
X-MC-Unique: VMCudxX1Ma6Vu0CPTAHvGA-1
Received: by mail-ed1-f71.google.com with SMTP id
 h16-20020a0564020950b029038cbdae8cbaso16807656edz.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h+A+HfSpXZqAH5SCxE7ycsL7iyfz3fycevoSOlmzgN8=;
 b=pUWLXaQifyEcb6bNWeZL9/Ik5Y8MrrNBiz6Z+T8SoG2yg9R73JeaM2SHGlFuZC27dw
 OJq0KsWnstFYmx36oSmYzPdicQEBh04Bvx1BWkNwFC+RAsHb6ESCj13JVoVFoZZYA4uA
 PeQhBfZhS8dAK7HH4FBnZzRKff7vEX3+NEx6HybzHzc3+mKaWmwqdgSnkghJ88JPe4D2
 wIt++YsjK2JJhwDgkmyPcY3BrHLCxl5G2uN7a5zxbfDgJ8ODe3R+8mKfpGeUDaBNN/NE
 b0eBi1iVFub0FjBmNgWxWXQv7O8Ph8dfDb4Op1dCp95SdQFtt62WOdGc/ihdjCnp+lmw
 oaRw==
X-Gm-Message-State: AOAM530xgD1LIFXFYWJeFtbcSAJA9FLYasmBMwsXC5qFiP/5WZW3UJEP
 3P2oK0EF8a8wwi7N6s9uRJsITj6imJV9ACfoPik9X4edVzvSf+QY0V1qQSLT25V7Xs5elXX/j8S
 ZTZqzT0w1i1IpcOEL3FU1HESYPdGXigODt0dxmPfK/A==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr29866812edy.224.1621927369844; 
 Tue, 25 May 2021 00:22:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwS0no7nsHNRCqlg+nhqUCjlv+Qptu6bm1cQU9E9Jv2TBtMJhNOQr2oL6OuXDEhh8h9h/8pgA==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr29866806edy.224.1621927369711; 
 Tue, 25 May 2021 00:22:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id g10sm8661205ejd.109.2021.05.25.00.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 00:22:49 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com> <20210524145928.GA3873@lst.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Message-ID: <7cc7f19b-34b3-1501-898d-3f41e047d766@redhat.com>
Date: Tue, 25 May 2021 09:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524145928.GA3873@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org
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

On 24/05/21 16:59, Christoph Hellwig wrote:
> On Thu, May 20, 2021 at 03:13:05PM +0100, Stefan Hajnoczi wrote:
>> Possible drawbacks of this approach:
>>
>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>    expensive since it requires DMA. If such devices become popular then
>>    the virtio_blk driver could use a similar approach to NVMe when
>>    VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>
>> - If a blk_poll() thread is descheduled it not only hurts polling
>>    performance but also delays completion of non-REQ_HIPRI requests on
>>    that virtqueue since vq notifications are disabled.
> 
> Yes, I think this is a dangerous configuration.  What argument exists
> again just using dedicated poll queues?

There isn't an equivalent of the admin queue in virtio-blk, which would 
allow the guest to configure the desired number of poll queues.  The 
number of queues is fixed.

Could the blk_poll() thread use preempt notifiers to enable/disable 
callbacks, for example using two new .poll_start and .end_poll callbacks 
to struct blk_mq_ops?

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
