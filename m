Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA41C77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 11:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD05D843E3;
	Fri,  2 Jun 2023 11:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD05D843E3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lj4Iqpv3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ErYM6i84ADD; Fri,  2 Jun 2023 11:15:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BBCF84288;
	Fri,  2 Jun 2023 11:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BBCF84288
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4717FC0037;
	Fri,  2 Jun 2023 11:15:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F591C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D544C42734
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D544C42734
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lj4Iqpv3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id idXKHdBvSJM3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:15:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61B354272D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61B354272D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685704533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=imQ8hkrYLqR8ckCqlA+Lim20RdkOae7FAIksRB3MKCQ=;
 b=Lj4Iqpv37dBE4eLoM5bFWcviYP55erk9QemEqtd2L/WxjMvU8WqHz6OoG0WGhQLiN6sL70
 PgMOA4ObvgqVyQ5ydhLDFUbNrpuRaPUeCa38efAOowuVDIHEyJjTQr5VBGXqjn6kgx2Gws
 v7JQGc2j20HwgZG7eoJPF842dC394hA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-kJmES0NzPU-lk4JnEaApvg-1; Fri, 02 Jun 2023 07:15:31 -0400
X-MC-Unique: kJmES0NzPU-lk4JnEaApvg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f6f2f18ecbso11058105e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 04:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685704531; x=1688296531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imQ8hkrYLqR8ckCqlA+Lim20RdkOae7FAIksRB3MKCQ=;
 b=M4dXuMvvi6EMLrDJnIPUolrFJgG0YxC6eXmIh1EHqJSh6LouI0/68/Mg72NGnKx58g
 4bj7PaZtbsH601/sZcChj9gCxkqWW5eXRmQxz7CLdVf+DdvF1NfTsZQihHzZQEzI/M/6
 uEHjPx2YjMLuN1Y8JyIiIByWRXX9lfObOkvHpUfBKAIPEwRBkVVLBjGSPcJZwCTEq878
 MEuVSDH+5LIXImJAyASAbd8U/1lRSPAVtBprictd/efmJ3/0Ssy1yZ8R0Z1v5lWbW+XE
 mtpiKTC5GCTah7ih5Dh1TzRBiywmChaWnp4JDXdbtaf5GjG2E0jyoYEzCDmaB4r9prV0
 Oa/g==
X-Gm-Message-State: AC+VfDzkfgcU6nlFDfCne46FVcpiX2zsoFpEFpmnCWrI0WOZU4038N94
 paWXknUFf29baYRGI9thc1cOsOprSlhehjb8xrIyJn19mtXudqh4oH3/XaZGe9jhGuXIcce/mSc
 fVAIxIBX72VetMNvFlVVVR1bIyyHRZxYIWQOKy4diKw==
X-Received: by 2002:a7b:c841:0:b0:3f7:26f8:f9c3 with SMTP id
 c1-20020a7bc841000000b003f726f8f9c3mr1064699wml.5.1685704530892; 
 Fri, 02 Jun 2023 04:15:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UWcaTAnKc4xQxzU4UjZxKiFiySGLh197x+LFMig+w4H4npT0uQes1m4bOREHyF9AKJ4OAiw==
X-Received: by 2002:a7b:c841:0:b0:3f7:26f8:f9c3 with SMTP id
 c1-20020a7bc841000000b003f726f8f9c3mr1064685wml.5.1685704530633; 
 Fri, 02 Jun 2023 04:15:30 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 w11-20020a1cf60b000000b003f423f5b659sm1630095wmc.10.2023.06.02.04.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:15:29 -0700 (PDT)
Date: Fri, 2 Jun 2023 07:15:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ross Zwisler <zwisler@chromium.org>
Subject: Re: [PATCH v2 5/6] tools/virtio: use canonical ftrace path
Message-ID: <20230602071517-mutt-send-email-mst@kernel.org>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230215223350.2658616-6-zwisler@google.com>
MIME-Version: 1.0
In-Reply-To: <20230215223350.2658616-6-zwisler@google.com>
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

On Wed, Feb 15, 2023 at 03:33:49PM -0700, Ross Zwisler wrote:
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

queued this too. thanks!

> ---
>  tools/virtio/virtio-trace/README        |  2 +-
>  tools/virtio/virtio-trace/trace-agent.c | 12 ++++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)
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
> index cdfe77c2b4c8..7e2d9bbf0b84 100644
> --- a/tools/virtio/virtio-trace/trace-agent.c
> +++ b/tools/virtio/virtio-trace/trace-agent.c
> @@ -18,8 +18,9 @@
>  #define PIPE_DEF_BUFS		16
>  #define PIPE_MIN_SIZE		(PAGE_SIZE*PIPE_DEF_BUFS)
>  #define PIPE_MAX_SIZE		(1024*1024)
> -#define READ_PATH_FMT	\
> -		"/sys/kernel/debug/tracing/per_cpu/cpu%d/trace_pipe_raw"
> +#define TRACEFS 		"/sys/kernel/tracing"
> +#define DEBUGFS 		"/sys/kernel/debug/tracing"
> +#define READ_PATH_FMT		"%s/per_cpu/cpu%d/trace_pipe_raw"
>  #define WRITE_PATH_FMT		"/dev/virtio-ports/trace-path-cpu%d"
>  #define CTL_PATH		"/dev/virtio-ports/agent-ctl-path"
>  
> @@ -120,9 +121,12 @@ static const char *make_path(int cpu_num, bool this_is_write_path)
>  	if (this_is_write_path)
>  		/* write(output) path */
>  		ret = snprintf(buf, PATH_MAX, WRITE_PATH_FMT, cpu_num);
> -	else
> +	else {
>  		/* read(input) path */
> -		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, cpu_num);
> +		ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, TRACEFS, cpu_num);
> +		if (ret > 0 && access(buf, F_OK) != 0)
> +			ret = snprintf(buf, PATH_MAX, READ_PATH_FMT, DEBUGFS, cpu_num);
> +	}
>  
>  	if (ret <= 0) {
>  		pr_err("Failed to generate %s path(CPU#%d):%d\n",
> -- 
> 2.39.1.637.g21b0678d19-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
