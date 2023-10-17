Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6E4CDB474
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 15:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86CCC401C9;
	Tue, 17 Oct 2023 15:29:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86CCC401C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vHSNLCsZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aKf3r-H0fVFZ; Tue, 17 Oct 2023 15:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 966CE41D99;
	Tue, 17 Oct 2023 15:29:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 966CE41D99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73EC8C0072;
	Tue, 17 Oct 2023 15:29:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D645C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C3A880BAE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C3A880BAE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=vHSNLCsZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUNf7s5SxqXj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:29:47 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0A2780B71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 15:29:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0A2780B71
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9bda758748eso656377166b.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697556585; x=1698161385;
 darn=lists.linux-foundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=icVo8OYlNGHinMiG2OSQr5+QuLZHNWWjVJ6HQFa+TXk=;
 b=vHSNLCsZoqs0+kuGcPsCQXcn+rwA5D/PPiVgTLwidmZgYQkhJ4pPjx8UvLM8j5uPRJ
 TY/MBKOaKdUmpQcOZ/VB8wbphe4CtUnA7Fr6fe4x512tD8p49eUbgWl6viLfAU9xcfeP
 L0EMb90iOYTdzexLAI9sCNT8eB6yknfq1TljUK9+cEsMkH7oc10S46aEKzlq6rBWzder
 Hpmz4UbqrIzx+xFHe2hZOuc3XHOYJIOclOVuNkB7P7UFDyceYzX7JA+28QVSfKVSKTZp
 EFMlyJwkItLyJNV1An/ELHGSIRIOm9UYVJWV9wnYzdK1gWgXUiAISY/kZxm/2fweBmbs
 yxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697556585; x=1698161385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=icVo8OYlNGHinMiG2OSQr5+QuLZHNWWjVJ6HQFa+TXk=;
 b=G8QnxNmYigfXo1gaRaxDY7AkIdUU9pbJo7oIxTr4ocv+ONecbnPxRH85Wn41YPNtVu
 D83/bSJm8AW+2nqwGDaK+wGBoJypLLlqwpBxLnuh4hMAgwX5oF+VM1y0ayvYwon83ffa
 Qm/UMklkQU9y3bX/ybv/Dmh4qmuNtywOBD3G1IqWCqY6G8LZ7ANIQ/Zx5l2P3NoJNCfJ
 Yi2IuI1xZqagvfYAZMd0oynWfhOXdZ7Hwk6w2ZVKOKh20naxXKklJer+j1JiNscaadjB
 AoMPRzOkMu7/H/aElTOYbNsALklFrZf8QIrmDkSFrH8qx/0U5lAtZ5uKhAIhvrbuAtgx
 kvMA==
X-Gm-Message-State: AOJu0YzLcDLbp5iRF3pG9q2XtVj6IhkbH9YAfxkDyLas4G3F3b3BRQFr
 /4eF/K4uWZT6YM+Q30iX2HHEidxvT0Le3ZTATpiWCg==
X-Google-Smtp-Source: AGHT+IErw2vtjAFzBfxr7XKHvKWn3p/TqHKuasrkFRDB0VRsq9iZwqZKi5kZoEyw5IHPgiUE9wHvjN5uiYVamYv7984=
X-Received: by 2002:a17:907:2d9e:b0:9c3:e66e:2002 with SMTP id
 gt30-20020a1709072d9e00b009c3e66e2002mr2030601ejc.6.1697556585115; Tue, 17
 Oct 2023 08:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZS6mA6/EsmvDVlTC@fedora>
In-Reply-To: <ZS6mA6/EsmvDVlTC@fedora>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 17 Oct 2023 18:29:28 +0300
Message-ID: <CAAjaMXYZ7u=jTfWLNRaRwOpsmuHXu62SGd03PTwxUupOybQJ8Q@mail.gmail.com>
Subject: Re: virtio-sound: release control request clarification
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org
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

On Tue, 17 Oct 2023 at 18:19, Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> Hello,
>
> This email is to clarify the VirtIO specification regarding the RELEASE
> control request. Section 5.14.6.6.5.1 [1] states the following device
> requirements for the RELEASE control request:
> 1. The device MUST complete all pending I/O messages for the specified
> stream ID.
> 2. The device MUST NOT complete the control request while there are
> pending I/O messages for the specified stream ID.
>
> The 1) requirement does not indicate what "complete" means. Does it mean
> that the pending I/O messages in the tx queue shall be outputted in the
> host, i.e., consumed by the audio backend? Or, completion means simply
> to put the requests in the used-ring without consuming them?

It means the latter. At no point is the host's consumption of audio
data mentioned except for implicit or explicit period notifications.

>
> Regarding 2), I interpret it as "the device shall wait until all I/O
> messages are proceeded to complete the RELEASE control request".

Possible state transitions to RELEASE state are from PREPARE and STOP,
which neither are associated with active I/O in the streams.
The correct interpretation is "Do not reply to the control request if
you have pending I/O messages for this stream ID".

> Currently, the kernel driver seems not expecting such a delay when the
> RELEASE command is sent. If I understand correctly, the kernel driver
> first sends the RELEASE command and waits a fixed amount of time until
> the device can process it. Then, the driver waits a fixed amount of time
> until all pending IO messages are completed. If the device follows the
> specification and waits until all messages IO are completed to issue the
> completion of the RELEASE command, the kernel driver may timeout. The
> time to complete N IO messages in the TX queue could be proportional
> with the number of pending messages.
>
> In our device implementation [2], RELEASE is handled as follows:
> - Drop all messages in the TX queue without outputting in the host.
> - Complete the RELEASE control request.
>
> This seems to be working, however, I can observe that sometimes there
> are still requests in the TX queue when we get RELEASE. Those requests
> are never reproduced in the host.

My guess is this is because of the guest alsa doing prebuffering, not
that the host is supposed to handle those I/O messages.

--
Manos
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
