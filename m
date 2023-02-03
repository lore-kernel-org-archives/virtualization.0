Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC565C636D6
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 00:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B20B820A3;
	Fri,  3 Feb 2023 00:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B20B820A3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=CHCoyYGB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGg-OA1XKTCJ; Fri,  3 Feb 2023 00:43:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D17E281D46;
	Fri,  3 Feb 2023 00:43:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D17E281D46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2E2DC0032;
	Fri,  3 Feb 2023 00:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD2DC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 414C86121C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:43:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 414C86121C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=CHCoyYGB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gLVd_UZX-AqY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:43:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 376966121A
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 376966121A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:43:38 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id ml19so11285863ejb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M5SZoZOf4A1Tqrq26h6hgOv78mY8qXAzROlOIKANtsE=;
 b=CHCoyYGBdRXOIoA+Jr7dkkawF4QVxNelCcER/Z8yLvuWU5rEVD95xnWe7+vQy9vp4e
 DVDx7Zc7ndN58VVIxRJWxoclMnG3zPJ1ArBwZ1jd+P3PGKG9+DBtYR0F7vIB30AJCHRo
 0LunAY9rQ0MfEk33PcW07KL6arMLZqus6t4zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M5SZoZOf4A1Tqrq26h6hgOv78mY8qXAzROlOIKANtsE=;
 b=uI0vzgNM0I7kH9T9qPl14DSnqBwHF884eBe/TCR0uKrWKIwdJomhqe7C9mr4w1TkOG
 TZp6YR0MGAtBwwpA1q6JwMOtruu0nK4Y28uxLmiRx9GG68s2yu6hqFjfmpiyq9YeEEAy
 Fa0CXE1yy+x1YL9UB0mKZfvm/glJlm6xLlacE3vOg8p99wLvNVlKcA7aswoqStChyf8Q
 HT/1pgPJKGJ+nyksH5uP90ffuEKlNfstvmeCyYdy1I+ciV/yA4QoqZ2gSpOFN2tYCsGP
 7jsSjREzJCBZjkMkbnKFRduhBRgmgQxtBFGUrwwbitt6oIqyjDLZkzNevb21t8IvVWkP
 xtjw==
X-Gm-Message-State: AO0yUKUpTzOrGdwXSWaQlIbfwGcQSg39Ijw/IYEeLp2ODH35sMwMunJL
 btuN76Hj39vn7gTApjzKzVeoQ7OlqZFlocRaxjEeb1Pb
X-Google-Smtp-Source: AK7set8KsU3zN0sI+/E0dYirj7cB/3ldvZORKpntPMOOYUvBH0mqiIeyuVvOgrDcae/VP5peLGYzMQ==
X-Received: by 2002:a17:906:fb19:b0:882:2027:c8e2 with SMTP id
 lz25-20020a170906fb1900b008822027c8e2mr9117034ejb.56.1675385015817; 
 Thu, 02 Feb 2023 16:43:35 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com.
 [209.85.218.42]) by smtp.gmail.com with ESMTPSA id
 z20-20020a1709060ad400b0085d6bfc6201sm539064ejf.86.2023.02.02.16.43.34
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Feb 2023 16:43:34 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id hx15so11046370ejc.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:43:34 -0800 (PST)
X-Received: by 2002:a17:906:4f98:b0:87b:d510:77a8 with SMTP id
 o24-20020a1709064f9800b0087bd51077a8mr2541345eju.235.1675385014409; Thu, 02
 Feb 2023 16:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-7-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-7-michael.christie@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Feb 2023 16:43:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEx+G7bwOj6MsHgpWavVkPAg6c1D1zcg4cgugg+ccrPQ@mail.gmail.com>
Message-ID: <CAHk-=wiEx+G7bwOj6MsHgpWavVkPAg6c1D1zcg4cgugg+ccrPQ@mail.gmail.com>
Subject: Re: [PATCH v11 6/8] vhost_task: Allow vhost layer to use copy_process
To: Mike Christie <michael.christie@oracle.com>
Cc: brauner@kernel.org, mst@redhat.com, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, ebiederm@xmission.com, stefanha@redhat.com
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
> +/**
> + * vhost_task_start - start a vhost_task created with vhost_task_create
> + * @vtsk: vhost_task to wake up
> + * @namefmt: printf-style format string for the thread name
> + */
> +void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...)
> +{
> +       char name[TASK_COMM_LEN];
> +       va_list args;
> +
> +       va_start(args, namefmt);
> +       vsnprintf(name, sizeof(name), namefmt, args);
> +       set_task_comm(vtsk->task, name);
> +       va_end(args);
> +
> +       wake_up_new_task(vtsk->task);
> +}

Ok, I like this more than what we do for the IO workers - they set
their own names themselves once they start running, rather than have
the creator do it like this.

At the same time, my reaction to this was "why do we need to go
through that temporary 'name[]' buffer at all?"

And I think this patch is very much correct to do so, because
"copy_thread()" has already exposed the new thread to the rest of the
world, even though it hasn't actually started running yet.

So I think this is all doing the right thing, and I like how it does
it better than what io_uring does, BUT...

It does make me think that maybe we should make that task name
handling part of copy_process(), and simply create the task name
before we need this careful set_task_comm() with a temporary buffer.

Because if we just did it in copy_process() before the new task has
been exposed anywhere,. we could just do it as

        if (args->name)
            vsnprintf(tsk->comm, TASK_COMM_LEN, "%s-%d", args->name, tsk->pid);

or something like that.

Not a big deal, it was just me reacting to this patch with "do we
really need set_task_comm() when we're creating the task?"

               Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
