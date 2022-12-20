Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE32AC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 10:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 660278125F;
	Tue, 20 Dec 2022 10:35:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 660278125F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JSZk8AE/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2LhhItXyGqB; Tue, 20 Dec 2022 10:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD8708125E;
	Tue, 20 Dec 2022 10:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD8708125E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29821C0035;
	Tue, 20 Dec 2022 10:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9836DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6889460BC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:35:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6889460BC3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JSZk8AE/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TXVjLQ9q99_Z
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:35:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ED7A60A9E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ED7A60A9E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671532548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xIE948N+OVyD9RxTPjKQ11q6Fjch6dgm41Al2E4iz0=;
 b=JSZk8AE/mOLR2CGX4/TuEHPjPlHK8NPTw1FzAg6Yl9M69ThYWWQKEUQXE1vadI2RhepvmT
 xl+TqflenIT2eq0eEnqTdPKmqB2CWv0NHqPsa3kVK6pkKFKK3vNoHuabaCi8SNi/n+zaLg
 afyEqCaZFqEpwIbpc3lFLa7BzJzzW98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-Y64rYBORMpKrqnpKMiN6nQ-1; Tue, 20 Dec 2022 05:35:45 -0500
X-MC-Unique: Y64rYBORMpKrqnpKMiN6nQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so2459494wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 02:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xIE948N+OVyD9RxTPjKQ11q6Fjch6dgm41Al2E4iz0=;
 b=pSut5DCi8ww60bxzPLLQxuqDCi+cfilzp5SU2bSBKj3ZtUFWf+2jYPMrTZka+7vE7d
 yybrRlAlZIjMKmQCHi6XYOP0n+N7mt+63M8v7TfleVlniNzt4E8KbKnwK5GStTeKYlUA
 Nh+Bq+skRn7gO0DH7YNjPtChJSUSul/9T6226ICK1HhwHgWpOithNOPz+D5Uyu7qprZo
 Bb7wwqYLJwuUmhTGxsKNTNBgFo+Jp6a5LcSax8kfmGK2PKfB8ojPS7GPo2z/xhS+cnWI
 8jFIKF/LdG4yJjnncZuP8y3pyrXt5Ikqyif6MMmnWwl+6gTjXgVIs/x+6W3kZb3B5Rai
 qrVA==
X-Gm-Message-State: AFqh2kpP4PSf1U8C2f20S22JCnsVavPyLcgpEjthx+/jQTE3kbcGICbg
 5qS1Vj8xTCEuFr20xAajxndoKUQmjWqkviPS3WloNLcOLb0cGH1azN39UCvjKeRE0F0tGnt/PY0
 so6CnN6rQ22+R1suBIwwB9XmRnR5yc1nsvt0F/DSDhw==
X-Received: by 2002:a05:600c:3b08:b0:3d3:4a47:52e9 with SMTP id
 m8-20020a05600c3b0800b003d34a4752e9mr8998382wms.15.1671532544034; 
 Tue, 20 Dec 2022 02:35:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXswZvLV6vC3rUs9MMkLlnmeQY6d+pmClDori0caDrXbfFSl7htQYg5vZB4m7wOx5HQXfo1nIg==
X-Received: by 2002:a05:600c:3b08:b0:3d3:4a47:52e9 with SMTP id
 m8-20020a05600c3b0800b003d34a4752e9mr8998362wms.15.1671532543832; 
 Tue, 20 Dec 2022 02:35:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b003d23928b654sm21773342wmf.11.2022.12.20.02.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 02:35:43 -0800 (PST)
Date: Tue, 20 Dec 2022 11:35:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 4/4] test/vsock: vsock_perf utility
Message-ID: <20221220103538.msrgcwsolmzoc2r4@sgarzare-redhat>
References: <e04f749e-f1a7-9a1d-8213-c633ffcc0a69@sberdevices.ru>
 <d92184cd-e79b-80ae-4f89-92dfd43d1e92@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <d92184cd-e79b-80ae-4f89-92dfd43d1e92@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Dec 20, 2022 at 07:23:46AM +0000, Arseniy Krasnov wrote:
>This adds utility to check vsock rx/tx performance.
>
>Usage as sender:
>./vsock_perf --sender <cid> --port <port> --bytes <bytes to send>
>Usage as receiver:
>./vsock_perf --port <port> --rcvlowat <SO_RCVLOWAT>
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/Makefile     |   3 +-
> tools/testing/vsock/README       |  34 +++
> tools/testing/vsock/vsock_perf.c | 441 +++++++++++++++++++++++++++++++
> 3 files changed, 477 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/vsock/vsock_perf.c
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index f8293c6910c9..43a254f0e14d 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -1,8 +1,9 @@
> # SPDX-License-Identifier: GPL-2.0-only
>-all: test
>+all: test vsock_perf
> test: vsock_test vsock_diag_test
> vsock_test: vsock_test.o timeout.o control.o util.o
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>+vsock_perf: vsock_perf.o
>
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
>diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
>index 4d5045e7d2c3..e6f6735bba05 100644
>--- a/tools/testing/vsock/README
>+++ b/tools/testing/vsock/README
>@@ -35,3 +35,37 @@ Invoke test binaries in both directions as follows:
>                        --control-port=$GUEST_IP \
>                        --control-port=1234 \
>                        --peer-cid=3
>+
>+vsock_perf utility
>+-------------------
>+'vsock_perf' is a simple tool to measure vsock performance. It works in
>+sender/receiver modes: sender connect to peer at the specified port and
>+starts data transmission to the receiver. After data processing is done,
>+it prints several metrics(see below).
>+
>+Usage:
>+# run as sender
>+# connect to CID 2, port 1234, send 1G of data, tx buf size is 1M
>+./vsock_perf --sender 2 --port 1234 --bytes 1G --buf-size 1M
>+
>+Output:
>+tx performance: A Gb/s
>+
>+Output explanation:
>+A is calculated as "number of bytes to send" / "time in tx loop"
>+
>+# run as receiver
>+# listen port 1234, rx buf size is 1M, socket buf size is 1G, SO_RCVLOWAT is 64K
>+./vsock_perf --port 1234 --buf-size 1M --vsk-size 1G --rcvlowat 64K
>+
>+Output:
>+rx performance: A Gb/s
>+total in 'read()': B sec
>+POLLIN wakeups: C
>+average in 'read()': D ns
>+
>+Output explanation:
>+A is calculated as "number of received bytes" / "time in rx loop".
>+B is time, spent in 'read()' system call(excluding 'poll()')
>+C is number of 'poll()' wake ups with POLLIN bit set.
>+D is B / C, e.g. average amount of time, spent in single 'read()'.

Since now we prints Gbits/s I think we should update the previous lines.
But the rest looks good to me. So with the updated README:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
