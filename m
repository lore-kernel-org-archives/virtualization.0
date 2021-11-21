Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABFAC433EF
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 18:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27CEB40283;
	Sun, 21 Nov 2021 18:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lnf6ZxT6WVsb; Sun, 21 Nov 2021 18:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1B2A401B9;
	Sun, 21 Nov 2021 18:17:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83DDCC001E;
	Sun, 21 Nov 2021 18:17:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88372C0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 18:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6961280EF2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 18:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUl1Dr76d1kD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 18:17:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8794C80EE5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 18:17:14 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id m9so20431699iop.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=65ULih4jdhx6XkQY8ehRAlPWusFwZCWzdiFX6NIjolQ=;
 b=zsu+Q+VX2+NPXr/UZpR3x8W6pK2OUzMcgE9wIP3twPbveAU5n6DCF9iCldcLy6JDM4
 KH0YOJnq3845kg/IwYFUHqsX+y2rPHel5OGwTXxMdYA8Kc6x7xJv58Gesr5xLxy7I+PO
 Xxzzenfqcv8tOqA/CrwXaq8l4o/W+CFe+aaC3snazzVCEEqHzaiYwaQ274/A1P85Lu0y
 7tYKQsr2c/U1nnczak+Ay6lLm97LUQ0y7uiK6z7pI7EmvgIPFGIJ+JxFWkzi8tgh64Sm
 oCl/PD5AMaMPSPh4nNossSRAURME9mAooZWtYWejKzUlwt32f+0DHAsdChx9WIQtZ8Uu
 FdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=65ULih4jdhx6XkQY8ehRAlPWusFwZCWzdiFX6NIjolQ=;
 b=ym0tIHwMourxPBp8MNa1+MROD6/jk5oZ8sRwHhVCLiW+vkAeJyUIfsqemr2n8KF0pV
 oluGsETZMX3yf9C6lHXDhwutg8N6gDdDGpY+XCJWJsRhrd3/tqXMQ4do418uoeJ13T6L
 B6Fv037qDS2BEPMQQYCCrXZktflPcqlvPUBhaWnf9j+WAhuvPbrsOpN2qkVMAf8zM7Ik
 vT8PqPSBvR4/r64gy/aisFIKr/0eUrYTMDYrOktYejwn+yfvy0AyoFNzqrElXLEdPJ2R
 eqRNKpj5zxzA1m56XAadsN38OQzCDs50nOSdf8HjRSp0harb7h3gpubf3PqIwC7vuIP2
 GKoQ==
X-Gm-Message-State: AOAM531o/z7NTUFPp7SaAi+Z0YApyO47DXtG9l7ZureE0CuZOO6UPVXG
 ScPhh1K6w60oDKPQdQuulpwrvA==
X-Google-Smtp-Source: ABdhPJzw33awYOKSTWKfJtvcy+AEFNV9QEEPzQz4YtCnyDKg7Y8JpBa2tT4xsZNOEkt3tdNz09enPg==
X-Received: by 2002:a05:6638:3a4:: with SMTP id
 z4mr43190679jap.76.1637518633978; 
 Sun, 21 Nov 2021 10:17:13 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id l1sm3323116ioj.29.2021.11.21.10.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Nov 2021 10:17:13 -0800 (PST)
Subject: Re: [PATCH V5 07/10] io_uring: switch to kernel_worker
To: Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
 vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
References: <20211121174930.6690-1-michael.christie@oracle.com>
 <20211121174930.6690-8-michael.christie@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0a69a253-3865-322c-3a6d-6f8bb1c36023@kernel.dk>
Date: Sun, 21 Nov 2021 11:17:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211121174930.6690-8-michael.christie@oracle.com>
Content-Language: en-US
Cc: Christoph Hellwig <hch@lst.de>
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

On 11/21/21 10:49 AM, Mike Christie wrote:
> Convert io_uring and io-wq to use kernel_worker.

I don't like the kernel_worker name, that implies it's always giving you
a kernel thread or kthread. That's not the io_uring use case, it's
really just a thread off the original task that just happens to never
exit to userspace.

Can we do a better name? At least io_thread doesn't imply that.

Also I do think this deserves a bit more commit message, there's really
nothing in here.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
