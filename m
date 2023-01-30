Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B9CC636D4
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 19:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EC008146D;
	Mon, 30 Jan 2023 19:26:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EC008146D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U95HQXeZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N6nZ4WScGX3V; Mon, 30 Jan 2023 19:26:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8329581428;
	Mon, 30 Jan 2023 19:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8329581428
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68776C0032;
	Mon, 30 Jan 2023 19:26:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CC45C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57ABE81464
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57ABE81464
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yb5quCZaQ5GS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01C9281428
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01C9281428
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675106776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxRPh/paZX5a/mJDhNvLvYnOtz1Fnppz2zZO/ehY1gY=;
 b=U95HQXeZxqsPumu/gpogtkGnTWlCU6P0uDMv4GK8KFAqXDEc+BHTxHRGR1kPaBSKjyBUV4
 20hbiHYgE3QUe3sBA6DWfNsDKxjEAgCHl9ONaNGtyMbzJAVZkMoWhRnyEKxfhPt8ho5wjr
 rlVsiSgQMfkoCYp6nf9y+PQZM9GByoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-TXfd_aTlOdiSv4ze-T30Zg-1; Mon, 30 Jan 2023 14:26:15 -0500
X-MC-Unique: TXfd_aTlOdiSv4ze-T30Zg-1
Received: by mail-wr1-f69.google.com with SMTP id
 u10-20020a5d6daa000000b002bfc2f61048so2191657wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxRPh/paZX5a/mJDhNvLvYnOtz1Fnppz2zZO/ehY1gY=;
 b=LaQhh4NeAljjD+/tSQlAuz9vuXz6EI22nhi8J8usM3f3e5ieHlqNov1KFTR/3zabr0
 nGEUyhWnMPeKGcxYOA/QzHlThQ9e8teCVUQQn6dINUMHsYLaslvzCXEk33k0MyK6HeaC
 Q5atLhaxt7G7cGnGAU08r69sU7NTB60FIBih/QtMiV9ltq+7GzmHxoliMmXW5ZIBt/20
 s+Sn7vKz3BhDmQZJBz+dv99RZs32hmbtr7bj37+XpTfAIO2W4lgklSZHdjnNjXNEBxOk
 fKnV59CpDCUzrM0ray2Sz8LcYb/OmxkCjmU35XGqRFf9Eer+RrPi2OrIX/2eoy9RF8If
 LlLQ==
X-Gm-Message-State: AO0yUKUlIPov0wlM6xXmPpUzEZlCnZ4/MNV7IIyuw3dcdMGxThhvh08q
 UJz7k2Z3TFvyXZSsyGLn5HtYKTejYMf0G2qMXr4hqNckGPW0GsK5kFlk52R34dmKNIju6Hn7gOx
 IpdWUcZJ8osGVANQcR3I09NVZ9XfDStfUUSANER7BdQ==
X-Received: by 2002:a5d:5908:0:b0:2bf:f027:3c30 with SMTP id
 v8-20020a5d5908000000b002bff0273c30mr3314138wrd.56.1675106774159; 
 Mon, 30 Jan 2023 11:26:14 -0800 (PST)
X-Google-Smtp-Source: AK7set+eycYJ8p0mkRD8mPxEc0uaHr5C6uQOIksxyy+K6HKOMMdutlQSlkQGNzjc/g2dbWuMCMCRzg==
X-Received: by 2002:a5d:5908:0:b0:2bf:f027:3c30 with SMTP id
 v8-20020a5d5908000000b002bff0273c30mr3314130wrd.56.1675106773965; 
 Mon, 30 Jan 2023 11:26:13 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 c17-20020adffb11000000b002bc8130cca7sm12742836wrr.23.2023.01.30.11.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 11:26:13 -0800 (PST)
Date: Mon, 30 Jan 2023 14:26:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ross Zwisler <zwisler@chromium.org>
Subject: Re: [PATCH 0/9] use canonical ftrace path whenever possible
Message-ID: <20230130142555-mutt-send-email-mst@kernel.org>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, Huang Rui <ray.huang@amd.com>,
 Stanislav Fomichev <sdf@google.com>, linux-kselftest@vger.kernel.org,
 Todd E Brandt <todd.e.brandt@linux.intel.com>, Shuah Khan <shuah@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ingo Molnar <mingo@redhat.com>, Yonghong Song <yhs@fb.com>,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ross Zwisler <zwisler@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Tycho Andersen <tycho@tycho.pizza>,
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

On Mon, Jan 30, 2023 at 11:19:06AM -0700, Ross Zwisler wrote:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
> Ross Zwisler (9):
>   tracing: always use canonical ftrace path
>   bpf: use canonical ftrace path
>   selftests/bpf: use canonical ftrace path
>   perf docs: use canonical ftrace path
>   tools/power: use canonical ftrace path
>   selftests: use canonical ftrace path
>   tools/virtio: use canonical ftrace path
>   leaking_addresses: also skip canonical ftrace path
>   tools/kvm_stat: use canonical ftrace path
> 
>  include/linux/kernel.h                        |  2 +-
>  include/linux/tracepoint.h                    |  4 ++--
>  include/uapi/linux/bpf.h                      |  8 ++++----
>  kernel/trace/Kconfig                          | 20 +++++++++----------
>  kernel/trace/kprobe_event_gen_test.c          |  2 +-
>  kernel/trace/ring_buffer.c                    |  2 +-
>  kernel/trace/synth_event_gen_test.c           |  2 +-
>  kernel/trace/trace.c                          |  2 +-
>  samples/bpf/cpustat_kern.c                    |  4 ++--
>  samples/bpf/hbm.c                             |  4 ++--
>  samples/bpf/ibumad_kern.c                     |  4 ++--
>  samples/bpf/lwt_len_hist.sh                   |  2 +-
>  samples/bpf/offwaketime_kern.c                |  2 +-
>  samples/bpf/task_fd_query_user.c              |  4 ++--
>  samples/bpf/test_lwt_bpf.sh                   |  2 +-
>  samples/bpf/test_overhead_tp_kern.c           |  4 ++--
>  samples/user_events/example.c                 |  4 ++--
>  scripts/leaking_addresses.pl                  |  1 +
>  scripts/tracing/draw_functrace.py             |  6 +++---
>  scripts/tracing/ftrace-bisect.sh              |  4 ++--
>  tools/include/uapi/linux/bpf.h                |  8 ++++----
>  tools/kvm/kvm_stat/kvm_stat                   |  2 +-
>  tools/lib/api/fs/tracing_path.c               |  4 ++--
>  tools/lib/traceevent/event-parse.c            |  8 ++++----
>  tools/perf/Documentation/perf-list.txt        |  2 +-
>  tools/perf/Documentation/perf-script-perl.txt |  2 +-
>  .../perf/Documentation/perf-script-python.txt |  4 ++--
>  tools/power/pm-graph/sleepgraph.py            |  4 ++--
>  .../x86/amd_pstate_tracer/amd_pstate_trace.py |  4 ++--
>  .../intel_pstate_tracer.py                    | 10 +++++-----
>  .../selftests/bpf/get_cgroup_id_user.c        |  2 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        |  2 +-
>  .../bpf/prog_tests/task_fd_query_tp.c         |  2 +-
>  .../bpf/prog_tests/tp_attach_query.c          |  2 +-
>  .../selftests/bpf/prog_tests/trace_printk.c   |  2 +-
>  .../selftests/bpf/prog_tests/trace_vprintk.c  |  2 +-
>  .../selftests/bpf/progs/test_stacktrace_map.c |  2 +-
>  .../selftests/bpf/progs/test_tracepoint.c     |  2 +-
>  tools/testing/selftests/bpf/test_ftrace.sh    |  2 +-
>  tools/testing/selftests/bpf/test_tunnel.sh    |  8 ++++----
>  tools/testing/selftests/bpf/trace_helpers.c   |  4 ++--
>  .../testing/selftests/user_events/dyn_test.c  |  2 +-
>  .../selftests/user_events/ftrace_test.c       | 10 +++++-----
>  .../testing/selftests/user_events/perf_test.c |  8 ++++----
>  tools/testing/selftests/vm/protection_keys.c  |  4 ++--
>  tools/tracing/latency/latency-collector.c     |  2 +-
>  tools/virtio/virtio-trace/README              |  2 +-
>  tools/virtio/virtio-trace/trace-agent.c       |  2 +-
>  48 files changed, 96 insertions(+), 95 deletions(-)
> 
> -- 
> 2.39.1.456.gfc5497dd1b-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
