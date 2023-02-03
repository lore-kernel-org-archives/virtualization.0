Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ED3C636D3
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 00:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB6868205E;
	Fri,  3 Feb 2023 00:14:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB6868205E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DNx+UcYa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ipO2ulmXlvUi; Fri,  3 Feb 2023 00:14:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EC99382023;
	Fri,  3 Feb 2023 00:14:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC99382023
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEA59C0033;
	Fri,  3 Feb 2023 00:14:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE00C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55F9841D2E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:14:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55F9841D2E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=DNx+UcYa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bRMOoqoro1Wg
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:14:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 674D541D2D
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 674D541D2D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:14:35 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so10983918ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zaQNMCliREGWsw5ki7EtaX9v0ELmXISaiv3DWIK5tsM=;
 b=DNx+UcYaPWB2GGHKmyI05nUP2WYo9nCEWB9i9rv59hvwdIew6+8E9ozFSDnwkqiR/0
 Bc5nu3ZshSHO9QfHyblOyJTTpZXUJwvxo9yU57+Y+2n/dX7I04FlrcVUmHVDqPivx+sn
 ex8/Ybm+pudw+c7E2XO7oyziEhp2m6tWVP3gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zaQNMCliREGWsw5ki7EtaX9v0ELmXISaiv3DWIK5tsM=;
 b=CTeGtxYLq0kOXTHplG0zAH5x6edCDqLDElI1DxMTTnbROMEzb0l0qMmNIkFdXgFleb
 ImrkKzV87kbX+eExHOHBP3SEdBdEjRqzaF43tijVYwa2NdpttZR+lVYw38iJpOQ+9qsQ
 mro6JZOUD1HWgbVQQW14Q3/5JN2Et6mXWQWYABKx50cVfvQ/m9NeAYdR5TX8Bp4LMa0l
 96c8IsnEtnNqP0G/1CanijkZPHrgsYZMC9mgtmLSrf6Y8ZSWuRhe542LZ7g4hTA8D3T3
 jcvgdlN9yMLkij2RjkoOmb3rdjhdVpWgZAbdDjGQcClRZ1pNf8Gk0q2ANEpDI6PxHzNz
 WVgw==
X-Gm-Message-State: AO0yUKUr0qBULaAIfYuPpDr175LNcQpCWTD6MPe3pWdO5NZOYXBJm0Q3
 KxOg6DyQGZsiAf8G8tWqxfBl17YVox9HHYkHswi2ChV9
X-Google-Smtp-Source: AK7set97X+mTUqQ3c+fmdIO9kmiEXohdj+SOTq1BhLz8ImsDvz2D3xuIOUwYivA/kKRtHPo5OLlHbA==
X-Received: by 2002:a17:906:8a5b:b0:7c0:efb9:bc0e with SMTP id
 gx27-20020a1709068a5b00b007c0efb9bc0emr8349196ejc.62.1675383273050; 
 Thu, 02 Feb 2023 16:14:33 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com.
 [209.85.208.42]) by smtp.gmail.com with ESMTPSA id
 cd11-20020a170906b34b00b008720c458bd4sm523745ejb.3.2023.02.02.16.14.31
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Feb 2023 16:14:32 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id d26so3363685eds.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:14:31 -0800 (PST)
X-Received: by 2002:a50:d715:0:b0:4a2:649a:72eb with SMTP id
 t21-20020a50d715000000b004a2649a72ebmr2549747edi.70.1675383271716; Thu, 02
 Feb 2023 16:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-2-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-2-michael.christie@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Feb 2023 16:14:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTzdQr7xNm53ZUJT0jxaxSYLkf8XT2S1CoxnyFgVafKg@mail.gmail.com>
Message-ID: <CAHk-=wjTzdQr7xNm53ZUJT0jxaxSYLkf8XT2S1CoxnyFgVafKg@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] fork: Make IO worker options flag based
To: Mike Christie <michael.christie@oracle.com>
Cc: brauner@kernel.org, mst@redhat.com, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, ebiederm@xmission.com, stefanha@redhat.com,
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

On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
>  struct kernel_clone_args {
>         u64 flags;
> +       u32 worker_flags;
>         int __user *pidfd;
>         int __user *child_tid;
>         int __user *parent_tid;

Minor nit: please put this next to "exit_signal".

As it is, you've put a new 32-bit field in between two 64-bit fields
and are generating extra pointless padding.

We have that padding by "exit_signal" already, so let's just use it.

Also, I like moving those flags to a "flags" field, but can we please
make it consistent? We have that "args->kthread" field too, which is
100% analogous to args->io_thread.

So don't make a bit field for io_thread, and then not do the same for kthread.

Finally, why isn't this all just a bitfield - every single case would
seem to prefer something like

     if (args->user_worker) ..

instead of

    if (args->worker_flags & USER_WORKER)

which would seem to make everything simpler still?

            Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
