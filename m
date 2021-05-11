Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95A6C433B4
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 14:42:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E18613AE
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 14:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E18613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C38C64052B;
	Tue, 11 May 2021 14:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqcB3RnRBTIK; Tue, 11 May 2021 14:42:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7611E40565;
	Tue, 11 May 2021 14:42:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 560A7C000E;
	Tue, 11 May 2021 14:42:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A8FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 14:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 063E5843A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 14:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KWjdWUSUBDw4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 14:42:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57F3C84395
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 14:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620744123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/z7NrUJTKIBdoAINSyBpZ9NunsNsM6n4BDyTwrTstY=;
 b=CEU9bA4oAX1zOyq2nwJM3WWSt4ghcxxhh3LYBcPRXEERkcvnaAoblJQu2dkfPWaHk3Ob/n
 G3P2+txI/yackUUV5tyrQX0Aw72RfoM13RGsKqcitOck+S9zKDEIajAwjoRxYn8HdyKfh9
 jHmXR0BUwLOVIP14lMyAYej3oV9JxXg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-WMo0QjrOPouX2zh5_1DUKQ-1; Tue, 11 May 2021 10:42:01 -0400
X-MC-Unique: WMo0QjrOPouX2zh5_1DUKQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 i11-20020a4a6f4b0000b02901ef8b6e92a6so9307935oof.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 07:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k/z7NrUJTKIBdoAINSyBpZ9NunsNsM6n4BDyTwrTstY=;
 b=mB09eiEPha2TxHdQGRd6vMzLQbR1/il6pMY41zk2jC+mpLSeouMq/LYBs1iYSWLoEv
 oPx6VOCiX6eU8ohuhemonO5J8TVl+HRL13/nWOi9SFNFvAagxHxTb3dXauhdc3ggIjhk
 R8exjB6F0pT+NySZVPMqARCEDf8IAxr/sa4MMnZvDp70cxG5NfdS0NCg20BJ5rzQRfBR
 nomkIZ2Ys8vLs5AT25ZF8+FajQPpVJgePSJty3IZV1jIQmI+PcAIfG2itFkmSyn0WXzC
 rtnKGLFov2UOHQZWQ1cxqZL2aV6gesVymmwR9jCv2g6FjlzXqgTAOxV/dxr2wJoXnfhE
 OZpA==
X-Gm-Message-State: AOAM530iHqYvMhnXKmtVYwkIlarAocU0X+385I9hYrf9CpKCT70nJtl7
 AaGcR+1+w65bEdQ3VEtXwwPYnTdOdNCWd7qJIHZN7x+Tegla7wjc5uusUG/dj9s217NkczFyFD4
 UseGvy2gBH/txp3ewEuHC1haiqLFGzPoxjMGreL2sww==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr10122765oon.2.1620744120815;
 Tue, 11 May 2021 07:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiqcX0afnpWZRWy60CV/jDkD2+4bdEWed+5anrz6ezPzlAoWGMEGtTJiX4q+FFlUrQrMxegg==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr10122743oon.2.1620744120577;
 Tue, 11 May 2021 07:42:00 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 o6sm3917266ote.14.2021.05.11.07.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 07:42:00 -0700 (PDT)
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20210507221527.699516-1-ckuehl@redhat.com>
 <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <290eaac8-45d9-0bfb-94f5-9fb41e5a3e42@redhat.com>
Date: Tue, 11 May 2021 09:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
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

On 5/11/21 5:23 AM, Stefan Hajnoczi wrote:
> On Fri, May 07, 2021 at 05:15:27PM -0500, Connor Kuehl wrote:
>> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>>  		 req->in.h.nodeid, req->in.h.len,
>>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
>>  
>> -	fsvq = &fs->vqs[queue_id];
>> +	fsvq = this_cpu_read(this_cpu_fsvq);
> 
> Please check how CPU hotplug affects this patch. If the current CPU
> doesn't have a vq because it was hotplugged, then it may be necessary to
> pick another vq.

I'll fix this in the next revision.

Thanks,

Connor

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
