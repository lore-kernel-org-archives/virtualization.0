Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5150DC433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 14:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCBC640223;
	Mon, 22 Nov 2021 14:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8ZIZUN_V9A5; Mon, 22 Nov 2021 14:20:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 22E104012A;
	Mon, 22 Nov 2021 14:20:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAFCBC002E;
	Mon, 22 Nov 2021 14:20:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 124CDC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0CD64046A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ix6oCtmKhH0p
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:20:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19FC140461
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 14:20:06 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id w15so18234574ill.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=87fS3MfuXyxeM48QrmQXjZhP26c/dRVf2nmaGCq3Ooo=;
 b=MCT0sGQ5n9wFn8f1v5dDS1cB6pSsIHeRuf0QPw0piEm1jUTUSLX+oiMnbH84YQN2RB
 Lajf58SdXwsAoRK1ncoCRNzVry1ytjIxwsh2wOBPueM2SPmflaEWZP0UTdwQgeBgt9JL
 e8m4pCaNPyOQeqp+ow6bir/p+G28KACgYdPXUguFLlkY9KsrZaDT+dSGSm2+nz8UIFE0
 LD2SPS2xn64MpUZxv4liSyiVGaeX9Sc9Op4XoLfDS1VPvXtnJgC9OAedQa6zGf8//+ee
 VqfdJ7y99wWte0Pud+dO99IKisl+gmMXhMzICTFREVv8gu/hzg0t7dJiQ2Lh7cDo7JNt
 FDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=87fS3MfuXyxeM48QrmQXjZhP26c/dRVf2nmaGCq3Ooo=;
 b=pquo2swUX8aVGMmXxKLbUuy1mCFSeg0g9hqiMQqzKQcIMlJSeKJzveVnRrxAeFgl+B
 6FZGmq8fIZxqjekLuigeBJDJYWAOUyzZIoRh6p7Qq8ujn2byErcMYMdShSMusMDING9L
 B5yDc9cWZ8KKMp4eShqzxcKSTG8FOHgmgjsXYcmlOuvcqNi3xaMtm7EuUyT+QPxdQXAi
 jYP6hjFfRwXcofl42B9HfGXyIF/HRhdMCZekEsSo2usfn04lGoPlUxjdsO76ESVhQ6eS
 2vHwZQMtelNJrpSnffrJJKmNMDtyWkAzO4lnF1gmkYzD8UNxWRUXMCuGaPHdDLljmEv8
 vg6A==
X-Gm-Message-State: AOAM533mMpYVuyJfaHjnGFbCYfM1nd1u3OZ19QZcP3MnZu8bGjN2wU1H
 LoXy0RNEM76UxwNmrwtKchnGHA==
X-Google-Smtp-Source: ABdhPJyK9hdXMsXAZrf6WJPCgGgys29RcikUa50BD5KPgYgoW7moIcwnMtomK6V4NlvKLh7y/J2vzA==
X-Received: by 2002:a05:6e02:1a2d:: with SMTP id
 g13mr19335748ile.134.1637590805845; 
 Mon, 22 Nov 2021 06:20:05 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id x15sm4990039iob.8.2021.11.22.06.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 06:20:05 -0800 (PST)
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
To: Christian Brauner <christian.brauner@ubuntu.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
 <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
 <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f2a421da-1bb0-c65a-d8e2-7cbbb2cccfab@kernel.dk>
Date: Mon, 22 Nov 2021 07:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211122100228.wdeovpqxg6gl3ldb@wittgenstein>
Content-Language: en-US
Cc: hdanton@sina.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 vverma@digitalocean.com, geert@linux-m68k.org, stefanha@redhat.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 11/22/21 3:02 AM, Christian Brauner wrote:
> On Sun, Nov 21, 2021 at 11:17:11AM -0700, Jens Axboe wrote:
>> On 11/21/21 10:49 AM, Mike Christie wrote:
>>> Convert io_uring and io-wq to use kernel_worker.
>>
>> I don't like the kernel_worker name, that implies it's always giving you
>> a kernel thread or kthread. That's not the io_uring use case, it's
>> really just a thread off the original task that just happens to never
>> exit to userspace.
>>
>> Can we do a better name? At least io_thread doesn't imply that.
> 
> Yeah, I had thought about that as well and at first had kernel_uworker()
> locally but wasn't convinced. Maybe we should just make it
> create_user_worker()?

That's better, or maybe even create_user_inkernel_thread() or something?
Pretty long, though... I'd be fine with create_user_worker().

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
