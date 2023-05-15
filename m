Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F0C7EE23
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 15:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D11FE615D5;
	Mon, 15 May 2023 15:52:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D11FE615D5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20221208.gappssmtp.com header.i=@kernel-dk.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=dPfzHFra
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n1hBUTUroKBg; Mon, 15 May 2023 15:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C256615D4;
	Mon, 15 May 2023 15:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C256615D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 508DEC0036;
	Mon, 15 May 2023 15:52:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0724BC0036
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5CE541D8D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5CE541D8D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel-dk.20221208.gappssmtp.com
 header.i=@kernel-dk.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=dPfzHFra
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3Jdadj5uMxa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:52:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC8AA40129
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC8AA40129
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 15:52:14 +0000 (UTC)
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-76c56d0e265so44384139f.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684165933; x=1686757933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hm+bqbzJwc1Xl9qj26W/HzaWbXKYcWn1gV7Sqsapjuk=;
 b=dPfzHFraE/umRN0sczlZ+1ZrJIK1F6iOIk0i33ZHUvL6COessIxmfsZ6hm8vbdLaP7
 i6w6AXlHCa4WhTE0jdKRniI/DiaqhUf0iSRhWDqUdqjYkgf7f44V2WUrYWLqfOWESDj7
 ZP48z+vkRfe72GFGeB88iu3dnZU1ptrTAfXnRU6Af6j1bf/vBrlky5ZdrJp1sfwfr84K
 vul0e/ni8s4dGIkNpSpt5aCnyh0Ka1z/q7Nfv6qQlMG46Uv8DyQU4sQTd8v0du8GdJV5
 ud59i6J6rLEl5Pgbv0mL6ZE4f99ZwkVrgKlecGOWklUWQuesDvKds+S4hjdB5aLQ1K2V
 Gpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684165933; x=1686757933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hm+bqbzJwc1Xl9qj26W/HzaWbXKYcWn1gV7Sqsapjuk=;
 b=kWDd60FjfZEfBPIq0/H1bGGop2Noccfcfvxq9jLYSZvCIQ6CFcAWwQ9oS6r5FFrCzw
 10ea1K0xEg4Hkm1uR8Eyu31DkiFyAqqellC1Wvve1a1K4SuQzb4HS+NTe60DgWqebaG9
 A8RzlCxOpbMZ5kOMZlh9/5i9nCGHS1OyvfIGCvqFz14nhjjvTahiosW7HEY44QstAXvp
 bSmKGLHi4zdzvk9WVprQ4yQJma110J5dT0UDzFJyMlhAklP2yDWhkJFtiAH/tFQLZWIF
 PzM3jNxX1fXvCMOQWEM9HYYZ+pPOXOeNoL5fxGd23z8hTHB/6/q2/QIrzjg6PUnNxHGD
 Asvg==
X-Gm-Message-State: AC+VfDzS2UywyUCX1gshxDS3E4hzGCLLVfU+SAPkKrnvpcLSBRcqKSN6
 eatNUCzU+iOCE8WfCeMDlHGj2Q==
X-Google-Smtp-Source: ACHHUZ67ppZkczvltB/Ej7MOunMBKq/HKJDp3WTg061+vQEirR5F91+5ZfFi+zLqKRaMSbTbdEj7Sw==
X-Received: by 2002:a92:a010:0:b0:32f:1232:f5d5 with SMTP id
 e16-20020a92a010000000b0032f1232f5d5mr91880ili.2.1684165933638; 
 Mon, 15 May 2023 08:52:13 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2]) by smtp.gmail.com with ESMTPSA id
 b71-20020a02194a000000b00411bf6b457bsm7365767jab.101.2023.05.15.08.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 08:52:12 -0700 (PDT)
Message-ID: <33b84605-1d0c-1b0e-7927-7ffa96b3c308@kernel.dk>
Date: Mon, 15 May 2023 09:52:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, nicolas.dichtel@6wind.com
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

On 5/15/23 9:44?AM, Linus Torvalds wrote:
> On Mon, May 15, 2023 at 7:23?AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> So I think we will be able to address (1) and (2) by making vhost tasks
>> proper threads and blocking every signal except for SIGKILL and SIGSTOP
>> and then having vhost handle get_signal() - as you mentioned - the same
>> way io uring already does. We should also remove the ingore_signals
>> thing completely imho. I don't think we ever want to do this with user
>> workers.
> 
> Right. That's what IO_URING does:
> 
>         if (args->io_thread) {
>                 /*
>                  * Mark us an IO worker, and block any signal that isn't
>                  * fatal or STOP
>                  */
>                 p->flags |= PF_IO_WORKER;
>                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
>         }
> 
> and I really think that vhost should basically do exactly what io_uring does.
> 
> Not because io_uring fundamentally got this right - but simply because
> io_uring had almost all the same bugs (and then some), and what the
> io_uring worker threads ended up doing was to basically zoom in on
> "this works".
> 
> And it zoomed in on it largely by just going for "make it look as much
> as possible as a real user thread", because every time the kernel
> thread did something different, it just caused problems.

This is exactly what I told Christian in a private chat too - we went
through all of that, and this is what works. KISS.

> So I think the patch should just look something like the attached.
> Mike, can you test this on whatever vhost test-suite?

Seems like that didn't get attached...

> I did consider getting rid of ".ignore_signals" entirely, and instead
> just keying the "block signals" behavior off the ".user_worker" flag.
> But this approach doesn't seem wrong either, and I don't think it's
> wrong to make the create_io_thread() function say that
> ".ignore_signals = 1" thing explicitly, rather than key it off the
> ".io_thread" flag.
> 
> Jens/Christian - comments?
> 
> Slightly related to this all: I think vhost should also do
> CLONE_FILES, and get rid of the whole ".no_files" thing. Again, if
> vhost doesn't use any files, it shouldn't matter, and looking
> different just to be different is wrong. But if vhost doesn't use any
> files, the current situation shouldn't be a bug either.

Only potential downside is that it does make file references more
expensive for other syscalls, since you now have a shared file table.
But probably not something to worry about here?

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
