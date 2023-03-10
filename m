Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27783C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAC5A40127;
	Fri, 10 Mar 2023 08:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAC5A40127
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gcwXZKdJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L2XMDHUeI7hA; Fri, 10 Mar 2023 08:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0E484011B;
	Fri, 10 Mar 2023 08:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0E484011B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6677C0071;
	Fri, 10 Mar 2023 08:30:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93881C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 585584194E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:30:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 585584194E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gcwXZKdJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EzitdIokAF5z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:29:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD2E44194D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD2E44194D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678436997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VVY8kly3TcDFN9v8u5UAZIFaG8NcKB7KdRar2p0UPo=;
 b=gcwXZKdJjfaYpRzASdQdDUOcZK7GhWSEkLJoKJ5d2i8lsjarxzWzi7oPOEdnLop4WcCkq7
 EkTNWXM+7jbzKgHMAz23Cpw7GmvJ3aJYNmqRstxg0wvFwwzfqxcIjrTnKxoWqXTPrhZUSe
 cuxVpbQ9JeDdsbz7/2o6jPlkoeONqrs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-HVtntokEOOaTDHMUEb2iJg-1; Fri, 10 Mar 2023 03:29:56 -0500
X-MC-Unique: HVtntokEOOaTDHMUEb2iJg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l16-20020a05600c1d1000b003e77552705cso1706156wms.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678436995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VVY8kly3TcDFN9v8u5UAZIFaG8NcKB7KdRar2p0UPo=;
 b=hv+LvMXqoE/C7ml1gvwJBptNl7LMVQGERaVdQZqYOz4CYOJoI1aMqLWEEjQpgy1Xis
 WBieyA4M42GYwv6cYrsECNGVlKvVZklqoGdYDE+UkC9Oo4QRAg48rzSMotidMal4Kpzx
 5RgezDuC+jhrurAiBmB+e3g34sQZdH9EBpJWUV+V+5XyfposQ3qvgqcFO7W2HSDnqfdP
 a8ZpvL/mVtmlP88JepYZhER/dc6hkaBdB4WyKnbV4kIjLUkY5uY6K+EyTf9rwKo1Lxhe
 UbmxOdQHnJa1uWiNseuCX7NjjAvC0n/cgTFz1ryCE1rAPZSwonv7I7zxF5a66dXJZ6AX
 M1eQ==
X-Gm-Message-State: AO0yUKV/NgYLLR9fZXOsMrVpppNUElomdUG5B/Y7QDLzAKFIUzvIJJoV
 PccozmA/0IOdBxObTjQf6WWyR2e7BuMtobQLR4wKI0tIM/0kh5QR0msh0Cedco4crVach6D2LYm
 3UjJ9Fdi9CwqaZ+xgTFPYKI4ucpl+QQrkPMN6nzvpCA==
X-Received: by 2002:a05:600c:46d1:b0:3eb:29fe:fe19 with SMTP id
 q17-20020a05600c46d100b003eb29fefe19mr1724986wmo.34.1678436994998; 
 Fri, 10 Mar 2023 00:29:54 -0800 (PST)
X-Google-Smtp-Source: AK7set/3NDIB2yQpnAOJ1gLOd87qFJtloJUYcD7foQwbKEjLNGWL6NTidbGAfi/e3Esc+ca2i7/9Kw==
X-Received: by 2002:a05:600c:46d1:b0:3eb:29fe:fe19 with SMTP id
 q17-20020a05600c46d100b003eb29fefe19mr1724955wmo.34.1678436994706; 
 Fri, 10 Mar 2023 00:29:54 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 l14-20020a1ced0e000000b003eb20d4d4a8sm1415501wmh.44.2023.03.10.00.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:29:54 -0800 (PST)
Date: Fri, 10 Mar 2023 03:29:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ross Zwisler <zwisler@chromium.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230310032921-mutt-send-email-mst@kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
 "Tobin C. Harding" <me@tobin.cc>
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

On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:
> Changes in v2:
>  * Dropped patches which were pulled into maintainer trees.
>  * Split BPF patches out into another series targeting bpf-next.
>  * trace-agent now falls back to debugfs if tracefs isn't present.
>  * Added Acked-by from mst@redhat.com to series.
>  * Added a typo fixup for the virtio-trace README.
> 
> Steven, assuming there are no objections, would you feel comfortable
> taking this series through your tree?

Acked-by: Michael S. Tsirkin <mst@redhat.com>

if you want the virtio patches through my tree after all, let me know.

> ---
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> There are many places where this older debugfs path is still used in
> code comments, selftests, examples and tools, so let's update them to
> avoid confusion.
> 
> I've broken up the series as best I could by maintainer or directory,
> and I've only sent people the patches that I think they care about to
> avoid spamming everyone.
> 
> Ross Zwisler (6):
>   tracing: always use canonical ftrace path
>   selftests: use canonical ftrace path
>   leaking_addresses: also skip canonical ftrace path
>   tools/kvm_stat: use canonical ftrace path
>   tools/virtio: use canonical ftrace path
>   tools/virtio: fix typo in README instructions
> 
>  include/linux/kernel.h                        |  2 +-
>  include/linux/tracepoint.h                    |  4 ++--
>  kernel/trace/Kconfig                          | 20 +++++++++----------
>  kernel/trace/kprobe_event_gen_test.c          |  2 +-
>  kernel/trace/ring_buffer.c                    |  2 +-
>  kernel/trace/synth_event_gen_test.c           |  2 +-
>  kernel/trace/trace.c                          |  2 +-
>  samples/user_events/example.c                 |  4 ++--
>  scripts/leaking_addresses.pl                  |  1 +
>  scripts/tracing/draw_functrace.py             |  6 +++---
>  tools/kvm/kvm_stat/kvm_stat                   |  2 +-
>  tools/lib/api/fs/tracing_path.c               |  4 ++--
>  .../testing/selftests/user_events/dyn_test.c  |  2 +-
>  .../selftests/user_events/ftrace_test.c       | 10 +++++-----
>  .../testing/selftests/user_events/perf_test.c |  8 ++++----
>  tools/testing/selftests/vm/protection_keys.c  |  4 ++--
>  tools/tracing/latency/latency-collector.c     |  2 +-
>  tools/virtio/virtio-trace/README              |  4 ++--
>  tools/virtio/virtio-trace/trace-agent.c       | 12 +++++++----
>  19 files changed, 49 insertions(+), 44 deletions(-)
> 
> -- 
> 2.39.1.637.g21b0678d19-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
