Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD1BE7E631
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 13:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5391940AEE;
	Tue, 26 Sep 2023 13:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5391940AEE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dcyyhclP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GgvzYu75KMeh; Tue, 26 Sep 2023 13:04:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8C7A408EC;
	Tue, 26 Sep 2023 13:04:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8C7A408EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB86C0039;
	Tue, 26 Sep 2023 13:04:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CEDAC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AD8E40ADD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AD8E40ADD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6d3UGAAKhuoA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:04:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68CE8408EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 13:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68CE8408EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695733480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pw3uLk1RX7EItsMeljDJQUwIv63n45/6NY/27SYTAmo=;
 b=dcyyhclPoEvQiFVV291RH3zf6iHaekplfvzeuXGDNDGBvFuNXqXAuaSnJFg2KbeFQ/09aE
 KNcDS628YYum4q0HJnZu6CRNhLsE8Cj3odkJt2v+LgD9rbvf3WOt5pdayQKTQTN8oAGtsn
 OUUGfkqaVVr72CJIjeshU4AkghRhIpA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-CcBZ3QI1OUGw8mMicKUocg-1; Tue, 26 Sep 2023 09:04:37 -0400
X-MC-Unique: CcBZ3QI1OUGw8mMicKUocg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a5d86705e4so755624266b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 06:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695733476; x=1696338276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pw3uLk1RX7EItsMeljDJQUwIv63n45/6NY/27SYTAmo=;
 b=ZHiB1lNdnc1D1fWBy12SMCp9IGJ6GSiSM1rFQBfdbpzK0E571z66kZ9m/L8jrmypee
 vy4lGmu4r55SJrETpfVKJw4F6IdHv+7YVFr/5qcaDG0P/73wNfdMZchsmFW5WlOOvi2O
 6jOLuDfOyM1si5sGqaPDUXfRNJU6BP2Dwim9hR74wfZh0Fc15MmM0XgI/k0GCRG88NZL
 WFsFnHPmzYagbGymIk8B1+k+Kk/FygZHHr1hANQ6fs+d/AZPiZeXsO/cwpNcYOLeBJjO
 AqraAVYpggZoQ31HCwGnW00VWbUB+rcgn0GYB2KaCRuV2/4U+pNnZFcSoWHj5eMbQxpq
 Zzuw==
X-Gm-Message-State: AOJu0Yx0YpsdharpDJWKLLsVe/CVFN8S6UrGV2/sSf3huoMw7/N0aB8j
 66N7TForw9IJ8iYoQBbiSTc0fVW/PI2OD/STZspViByY3IwDF4xUWqBWMSu85nZBSXwTXC8rdyr
 DTT9EgmO/r9bX0RUhVDOEmQdr69d/TX8+LvOBRf0acA==
X-Received: by 2002:a17:906:3299:b0:9ae:6196:a4d0 with SMTP id
 25-20020a170906329900b009ae6196a4d0mr8605624ejw.17.1695733476626; 
 Tue, 26 Sep 2023 06:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPT+qJWI4CE1FK30C7JELaHKq82GsQA7VABRt7UrHezh/PpcrPOPNsUXvYOw92dsnA/haacQ==
X-Received: by 2002:a17:906:3299:b0:9ae:6196:a4d0 with SMTP id
 25-20020a170906329900b009ae6196a4d0mr8605597ejw.17.1695733476299; 
 Tue, 26 Sep 2023 06:04:36 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a170906704b00b00999bb1e01dfsm7746690ejj.52.2023.09.26.06.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 06:04:35 -0700 (PDT)
Date: Tue, 26 Sep 2023 15:04:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 12/12] test/vsock: io_uring rx/tx tests
Message-ID: <kfuzqzhrgdk5f5arbq4n3vd6vro6533aeysqhdgqevcqxrdm6e@57ylpkc2t4q4>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-13-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230922052428.4005676-13-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Fri, Sep 22, 2023 at 08:24:28AM +0300, Arseniy Krasnov wrote:
>This adds set of tests which use io_uring for rx/tx. This test suite is
>implemented as separated util like 'vsock_test' and has the same set of
>input arguments as 'vsock_test'. These tests only cover cases of data
>transmission (no connect/bind/accept etc).
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Use LDLIBS instead of LDFLAGS.
>
> tools/testing/vsock/Makefile           |   7 +-
> tools/testing/vsock/vsock_uring_test.c | 321 +++++++++++++++++++++++++
> 2 files changed, 327 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/vsock/vsock_uring_test.c
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 1a26f60a596c..c84380bfc18d 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -1,12 +1,17 @@
> # SPDX-License-Identifier: GPL-2.0-only
>+ifeq ($(MAKECMDGOALS),vsock_uring_test)
>+LDLIBS = -luring
>+endif
>+

This will fails if for example we call make with more targets,
e.g. `make vsock_test vsock_uring_test`.

I'd suggest to use something like this:

--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -1,13 +1,11 @@
  # SPDX-License-Identifier: GPL-2.0-only
-ifeq ($(MAKECMDGOALS),vsock_uring_test)
-LDLIBS = -luring
-endif
-
  all: test vsock_perf
  test: vsock_test vsock_diag_test
  vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o
  vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
  vsock_perf: vsock_perf.o
+
+vsock_uring_test: LDLIBS = -luring
  vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o

  CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE

> all: test vsock_perf
> test: vsock_test vsock_diag_test
> vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> vsock_perf: vsock_perf.o
>+vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o

Shoud we add this new test to the "test" target as well?

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
