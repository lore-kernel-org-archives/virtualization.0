Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625F2C7619A
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 02:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE2184013A;
	Wed, 22 Mar 2023 02:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE2184013A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZi4b9wm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycuMhVsJJK5Z; Wed, 22 Mar 2023 02:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 498F240024;
	Wed, 22 Mar 2023 02:32:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 498F240024
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9D68C0035;
	Wed, 22 Mar 2023 02:32:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE59C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5077540452
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5077540452
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZi4b9wm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xf4UT_PeVVlF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:32:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FEA4401C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FEA4401C9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 02:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679452374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BzR3eLSpqoTMzxh2NgN0pV0oM+P8NH9sKNgtkW4tjlQ=;
 b=IZi4b9wmRy2VokAZnpLkAKbkn5axwxhLgeVPtxgXzygCWcbs+UFiE1m/7dus1a2yL1JPG9
 R/C4B3Vi0DbeVa9TzpUzMUWudO4sRywTZQ8x63hRwwVRfD7ofV+WLaSLsUa55IE+XHg3rM
 IbyeFgD7Ac5J4+2JMimt7QWbKOKom40=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-y9SMPDbMN66lDlO0q5lU_Q-1; Tue, 21 Mar 2023 22:32:53 -0400
X-MC-Unique: y9SMPDbMN66lDlO0q5lU_Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 n2-20020adf8b02000000b002d26515fc49so1934290wra.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 19:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679452372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzR3eLSpqoTMzxh2NgN0pV0oM+P8NH9sKNgtkW4tjlQ=;
 b=hWF5csgcxAZgPrj+XO6MmuuS5n5yB2YVrLcNChrRw+fClk+b0O0J4PgVYpIBAcsROV
 86k1+hmNkfn/8Bx+TPE7VrD77duVQEhDWAGMSLUi5JhnOgdd1BrHOWZj/X1DvJmxSc3y
 81GhzQn+cFgNV9DzHkMf1uokgwPEUvF2EHCeuTE1MSrcAkbGeIHht7bk5W+TL42d5Ohm
 EZejMrp1jVTW/gNpem2uFalR2Zyj9iqvCaKF4hQJsEI0O8qtZJFY3jHxyEmewUsvwSVN
 sPJ56l4aOsG1Mdn0T1YFPmUbHuOYHa06xPMFgRqD0ae4W7iXXnR5pcZyQm5lUfQp4lrY
 9dww==
X-Gm-Message-State: AO0yUKWJ363R28aJcZjFO20HtM9mGXAKZBi5cIVqS6b0NyLc23vJ25Pb
 2QiBGJfkiZQ8WNzgudAhxsSe0n7/YHEMaP2t9LhSMPeE09W8ssf9TvHE6YyF/fhKA2sGLfHe8xG
 w3hPot8zpPJANejkmPrWcDmDLEzLtxqIjqqsvFlnNQA==
X-Received: by 2002:a5d:4521:0:b0:2cf:e827:b597 with SMTP id
 j1-20020a5d4521000000b002cfe827b597mr3982536wra.10.1679452371930; 
 Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set+IAoeXaV5Ezy2+ySyjfqstu/owf9Mg6SdCShB52Q1gVgr7GbSGeNN3VY0ntYreU5GIBMrYUQ==
X-Received: by 2002:a5d:4521:0:b0:2cf:e827:b597 with SMTP id
 j1-20020a5d4521000000b002cfe827b597mr3982509wra.10.1679452371580; 
 Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 n1-20020a5d67c1000000b002cfe685bfd6sm12661630wrw.108.2023.03.21.19.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 19:32:51 -0700 (PDT)
Date: Tue, 21 Mar 2023 22:32:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ross Zwisler <zwisler@chromium.org>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230321223139-mutt-send-email-mst@kernel.org>
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

for merging up to patch 5 through another tree:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'll merge patch 6, no problem.


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
