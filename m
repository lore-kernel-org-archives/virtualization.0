Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F6DC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 00:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 828708206E;
	Fri,  3 Feb 2023 00:20:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 828708206E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Q+7fPWvP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ceXhr9KxvUyr; Fri,  3 Feb 2023 00:20:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1969A82062;
	Fri,  3 Feb 2023 00:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1969A82062
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBD7DC0032;
	Fri,  3 Feb 2023 00:20:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5E02C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 809BA82062
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:20:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 809BA82062
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfPvHuoiSpxJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:20:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4DBA81358
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4DBA81358
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 00:20:17 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id qw12so11052876ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4SeCtxpTd27qR0RdpcpFno4SRCl6KUuB+kcMLwMuEs=;
 b=Q+7fPWvPlZlKiRFwOebhnC/iujWBaiUECP4cOuLomaMGCsrTaSSFwu6NUnirPZ9+0r
 udrwj8gZKy1N0/sU/gqKjEmE3i76LfJ22MYfwOCp20sV5YXorrAY1INPbtG5ZtgaWzqh
 VMzywQfT+LzEDpBsXEmlYVkThE1KCS8Q/mJA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4SeCtxpTd27qR0RdpcpFno4SRCl6KUuB+kcMLwMuEs=;
 b=TZNUJnFa0QszJbNr6nO1PsW4Ts39dQ9pY6BZJSfl3nUBatG0za8QBqbxliu4V9xlg3
 cM8sdHBD/ksygbebt/CyXZ2kRNuf+Is3WWbeLynv2emUgEbfyBb/Tv370ubZAB6lxYsD
 ejdpIlXLNKytASNqBPx526xnId33ExJSsUk2CMJ1vqDrdUY+88DX3S3Uvm2LqgrUaiS4
 q+VwnW+F6sKXFaBLepF8vIGf8Z64IVCs4uNjKNOp0HaJVrZgsIVqb8LJm7vHRiBSiKje
 x8zK7TLumDFJtcXLazm5ZKml6YXVTRZx/RaahoHraGpSaV6K7SX19/kb2An3NGYwlHWT
 BCrg==
X-Gm-Message-State: AO0yUKUh8qTw3MwC030ckOykuZAOXHKSoIxo8zO+5vvWtjM46n3W7jyC
 NJLzlapIxyn7DNo65J1NhizVHfJbB9mrbo/7MlFzO8pV
X-Google-Smtp-Source: AK7set8C0lvMKy8pwhKZ+Cru2UpWC8OBNsLqwInamcGegk068GVp3zVvT2eQ+GJjG3qcMcz96mKt5A==
X-Received: by 2002:a17:906:39cd:b0:878:5f8e:26c0 with SMTP id
 i13-20020a17090639cd00b008785f8e26c0mr104849eje.7.1675383615581; 
 Thu, 02 Feb 2023 16:20:15 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com.
 [209.85.218.46]) by smtp.gmail.com with ESMTPSA id
 r17-20020a05640251d100b0046c7c3755a7sm383488edd.17.2023.02.02.16.20.14
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Feb 2023 16:20:15 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id ud5so11016184ejc.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 16:20:14 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2323578ejb.187.1675383614548; Thu, 02
 Feb 2023 16:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-5-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-5-michael.christie@oracle.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Feb 2023 16:19:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF6j264jDFcY3wgzOUA2RL2SpD2oL5BF9JqCkz3A413Q@mail.gmail.com>
Message-ID: <CAHk-=wjF6j264jDFcY3wgzOUA2RL2SpD2oL5BF9JqCkz3A413Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] fork: Add USER_WORKER flag to ignore signals
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
> +       if (args->worker_flags & USER_WORKER_SIG_IGN)
> +               ignore_signals(p);

Same comment as for the other case.

There are real reasons to avoid bitfields:

 - you can't pass addresses to them around

 - it's easier to read or assign multiple fields in one go

 - they are horrible for ABI issues due to the exact bit ordering and
padding being very subtle

but none of those issues are relevant here, where it's a kernel-internal ABI.

All these use-cases seem to actually be testing one bit at a time, and
the "assignments" are structure initializers for which named bitfields
are actually perfect and just make the initializer more legible.

            Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
