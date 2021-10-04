Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F5EC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:30:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4549861505
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 20:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4549861505
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 178056074E;
	Mon,  4 Oct 2021 20:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WVSru-23rOjf; Mon,  4 Oct 2021 20:30:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BDE69606EF;
	Mon,  4 Oct 2021 20:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A11C000F;
	Mon,  4 Oct 2021 20:30:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5006C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B313B838B6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UEjn6EEB1ChJ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:30:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 386C4838B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 20:30:14 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id p80so21815278iod.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=hxMugFlrhkWFOyvUUoClqgASfxacPxvOevTMxO7yAo4=;
 b=ESwse+jDKIu6q5BR2jgOUg7zAxbfsr1XtHvgSUxbYc/LXkGpmEz1LvIHWbJ8O9TsNG
 vBNECy0wh4oawiUIHXGqEIxyQlPfzIgaIDE1iDvqbTek+LEs03kEAWcnFWLUfJDCoLx4
 hn3ZVR0PDOBVrwD0zI5bz3JD++x/NkBzVtChiK+3JxzjaC3bQgVuZ2l1EAh66jn8HTb5
 fa5E+v6fOG0qU+JD/2L7ZqsIGsAqxkY/ZuI92EoXox5U6poOA2F6zsaQ7bB1HSx3eL71
 t2sPHd8kf/7C+PXKfwS3Q6sV9vfyl231mnU3yD0OtbxG2NIGMRXBrlB+6VnbPHnAIah3
 UeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hxMugFlrhkWFOyvUUoClqgASfxacPxvOevTMxO7yAo4=;
 b=dgA5WN0KeDetK6/jF3ZYL2WNQVqd6K+5dRDTrt+Bx3Mlf4yLv+m5pbKHYE9eNp3ch3
 l6s03v333Hwo2cnf4ydKQKZyjHjWDwoPUrc57YknNEvPeaM3EzAJzKUQYAqBpeij9WTk
 bXHhTckZS4iQkMhM0uPEysIBA9rEE8C1yGBOTk/dhl6L5pe5T39pvCENR7H1jsv7rQSp
 GaEPP8D8wywX8FJanKtb8fFEdx3EAcf7aQ8+/9Vs5LHnz3ktUnwIVFCCZcTymwIhuVSu
 gfh2TFHbh/Ntk/RGAnIX58RyEy+fIo59O3EBK2BZPSogKAe4xtcG0S12n48dOeFaEKvo
 Z9sw==
X-Gm-Message-State: AOAM532eHWT3FhvYX0d29rvAPWhUOSH6NUqt5MSlDVf2Mgc1OHmqclii
 DfMU/357KR3HQ4Q4JPoR93IjZA==
X-Google-Smtp-Source: ABdhPJyVHL6uANaYYRdy8It3v68z5LTEyqAY14i50vAHAEOQ5vQ0id1O7tvsYvmN2Tk0fG0UX7qLIw==
X-Received: by 2002:a5e:9810:: with SMTP id s16mr11308615ioj.171.1633379414192; 
 Mon, 04 Oct 2021 13:30:14 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id e9sm9481130iob.52.2021.10.04.13.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Oct 2021 13:30:13 -0700 (PDT)
Subject: Re: [PATCH V3 6/9] io_uring: switch to kernel_worker
To: Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
 vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-7-michael.christie@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6882df86-9dcd-26ac-af85-9b11d37ba598@kernel.dk>
Date: Mon, 4 Oct 2021 14:30:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211004192128.381453-7-michael.christie@oracle.com>
Content-Language: en-US
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

On 10/4/21 1:21 PM, Mike Christie wrote:
> Convert io_uring and io-wq to use kernel_worker.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
