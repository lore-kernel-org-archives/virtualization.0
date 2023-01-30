Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEA2C636D4
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 19:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 44913404EC;
	Mon, 30 Jan 2023 19:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 44913404EC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWlUD+2f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCb1wL6Xqgpx; Mon, 30 Jan 2023 19:26:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD3CE40AF4;
	Mon, 30 Jan 2023 19:26:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD3CE40AF4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3DF2C0032;
	Mon, 30 Jan 2023 19:26:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C884BC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96FBF40AF4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96FBF40AF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uciIwWuAMEU2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DA8AF404EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA8AF404EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675106809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zReAwY9Qd1mvDcwb5xa4eZkleNP48xcTFspo+kBenI=;
 b=dWlUD+2fsd8XQ9Cu22pfjNX6xbwxft8xtXyFJDsHbQ2q6biqDdBztn7nMaB4CmJDdkw/XI
 H1e/F1HR5WB+fYzCq6Djqwhta5GEZkirb3SM4WACR5DtmxH3yzLCJrIz+aEwDLnvoVae0J
 sMA5V7yjyTi1mFB0znFWgicTf4u5+ww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-WJeR8En2MZ2ZEZSx7V_4sA-1; Mon, 30 Jan 2023 14:26:48 -0500
X-MC-Unique: WJeR8En2MZ2ZEZSx7V_4sA-1
Received: by mail-wm1-f70.google.com with SMTP id
 l23-20020a7bc457000000b003db0cb8e543so4813405wmi.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 11:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zReAwY9Qd1mvDcwb5xa4eZkleNP48xcTFspo+kBenI=;
 b=q7VjmYm7sw0XtIpPEuSWsVi8KSQrGAnHTrYuZ57lfCyAw2KTA9JI5oxSc8mNtWcfSS
 BUWq2rZ2S38rNl2sajK2Uiss78GmHxis3qBjiN9cSUSpsUyk1yEwAxnNH2WVQVo0tYuW
 sYEMEZCh54kva280rbjq/uMN5ag+Mfaxjwjm0FGA6zjK/qZfKS5eQ3qa0WWqiRak3Pq5
 1f1uwZDnk7qHim1gukSmxFzvLjQJjhYI6Zo95K4+TQ11C6UYlSMMVMDQnJ1qP5iCdwgK
 Hzq1tHWnB6aUIBD49kSFTAsjvut0mmwE0nhj8mqpyTstURibqpKBkxNQD71MlZyHlzkL
 n3kA==
X-Gm-Message-State: AO0yUKUvRSGN0msFvB7XfXcacdEvMfLM8GMP/dJZ53CtqBzigXRufc/V
 +MSH1s3aNwFv9yCuyBMyHJvRESQmPG+Vx5Wughiv3CS2N+u16QODMCYynRs7w7eyadb9lA4rDvT
 5c/5v7f7U8OjmZwEIOJD/E+jxCRoIvX1mISkFgP+caA==
X-Received: by 2002:a05:600c:2043:b0:3dc:5622:5ded with SMTP id
 p3-20020a05600c204300b003dc56225dedmr5615006wmg.12.1675106807284; 
 Mon, 30 Jan 2023 11:26:47 -0800 (PST)
X-Google-Smtp-Source: AK7set+HKEF9qcmjdJeRfPmi1S0Zd9e5l2jeadeqVtxapSUKMx1q9Jxjx+GC52FTU98gwddsnpi9XA==
X-Received: by 2002:a05:600c:2043:b0:3dc:5622:5ded with SMTP id
 p3-20020a05600c204300b003dc56225dedmr5615000wmg.12.1675106807099; 
 Mon, 30 Jan 2023 11:26:47 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b003db09692364sm18781196wmn.11.2023.01.30.11.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jan 2023 11:26:46 -0800 (PST)
Date: Mon, 30 Jan 2023 14:26:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ross Zwisler <zwisler@chromium.org>
Subject: Re: [PATCH 7/9] tools/virtio: use canonical ftrace path
Message-ID: <20230130142616-mutt-send-email-mst@kernel.org>
References: <20230130181915.1113313-1-zwisler@google.com>
 <20230130181915.1113313-8-zwisler@google.com>
MIME-Version: 1.0
In-Reply-To: <20230130181915.1113313-8-zwisler@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, linux-trace-kernel@vger.kernel.org
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

On Mon, Jan 30, 2023 at 11:19:13AM -0700, Ross Zwisler wrote:
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
> A few spots in tools/virtio still refer to this older debugfs
> path, so let's update them to avoid confusion.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  tools/virtio/virtio-trace/README        | 2 +-
>  tools/virtio/virtio-trace/trace-agent.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtio/virtio-trace/README b/tools/virtio/virtio-trace/README
> index b64845b823ab..cea29a2a4c0a 100644
> --- a/tools/virtio/virtio-trace/README
> +++ b/tools/virtio/virtio-trace/README
> @@ -95,7 +95,7 @@ Run
>  
>  1) Enable ftrace in the guest
>   <Example>
> -	# echo 1 > /sys/kernel/debug/tracing/events/sched/enable
> +	# echo 1 > /sys/kernel/tracing/events/sched/enable
>  
>  2) Run trace agent in the guest
>   This agent must be operated as root.
> diff --git a/tools/virtio/virtio-trace/trace-agent.c b/tools/virtio/virtio-trace/trace-agent.c
> index cdfe77c2b4c8..805942d02e9f 100644
> --- a/tools/virtio/virtio-trace/trace-agent.c
> +++ b/tools/virtio/virtio-trace/trace-agent.c
> @@ -19,7 +19,7 @@
>  #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
>  #define PIPE_MAX_SIZE		(1024*1024)
>  #define READ_PATH_FMT	\
> -		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
> +		"/sys/kernel/tracing/per_cpu/cpu%d/trace_pipe_raw"

Should we try both old and new path then?

>  #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
>  #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
>  
> -- 
> 2.39.1.456.gfc5497dd1b-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
