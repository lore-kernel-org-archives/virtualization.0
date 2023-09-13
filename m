Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E44EDEC52
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 13:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D576782322;
	Wed, 13 Sep 2023 13:26:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D576782322
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-3d-OSs15p6; Wed, 13 Sep 2023 13:26:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E8AF822C8;
	Wed, 13 Sep 2023 13:26:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E8AF822C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35DFFC0071;
	Wed, 13 Sep 2023 13:26:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB09C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CEF960B46
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:26:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CEF960B46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i0EMswsNZ9fH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:26:31 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46E5F60017
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 13:26:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46E5F60017
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 12B846192D;
 Wed, 13 Sep 2023 13:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFCFC433C7;
 Wed, 13 Sep 2023 13:26:27 +0000 (UTC)
Date: Wed, 13 Sep 2023 09:26:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 2/3] x86/xen: move paravirt lazy code
Message-ID: <20230913092646.5b087871@gandalf.local.home>
In-Reply-To: <20230913113828.18421-3-jgross@suse.com>
References: <20230913113828.18421-1-jgross@suse.com>
 <20230913113828.18421-3-jgross@suse.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexey Makhalov <amakhalov@vmware.com>, xen-devel@lists.xenproject.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linux-trace-kernel@vger.kernel.org
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

On Wed, 13 Sep 2023 13:38:27 +0200
Juergen Gross <jgross@suse.com> wrote:

> diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
> index 44a3f565264d..0577f0cdd231 100644
> --- a/include/trace/events/xen.h
> +++ b/include/trace/events/xen.h
> @@ -6,26 +6,26 @@
>  #define _TRACE_XEN_H
>  
>  #include <linux/tracepoint.h>
> -#include <asm/paravirt_types.h>
> +#include <asm/xen/hypervisor.h>
>  #include <asm/xen/trace_types.h>
>  
>  struct multicall_entry;
>  
>  /* Multicalls */
>  DECLARE_EVENT_CLASS(xen_mc__batch,
> -	    TP_PROTO(enum paravirt_lazy_mode mode),
> +	    TP_PROTO(enum xen_lazy_mode mode),
>  	    TP_ARGS(mode),
>  	    TP_STRUCT__entry(
> -		    __field(enum paravirt_lazy_mode, mode)
> +		    __field(enum xen_lazy_mode, mode)
>  		    ),
>  	    TP_fast_assign(__entry->mode = mode),
>  	    TP_printk("start batch LAZY_%s",
> -		      (__entry->mode == PARAVIRT_LAZY_MMU) ? "MMU" :
> -		      (__entry->mode == PARAVIRT_LAZY_CPU) ? "CPU" : "NONE")
> +		      (__entry->mode == XEN_LAZY_MMU) ? "MMU" :
> +		      (__entry->mode == XEN_LAZY_CPU) ? "CPU" : "NONE")

There's helper functions that make the above easier to implement as well as
exports the symbols so that user space can parse this better:

TRACE_DEFINE_ENUM(XEN_LAZY_NONE);
TRACE_DEFINE_ENUM(XEN_LAZY_MMU);
TRACE_DEFINE_ENUM(XEN_LAZY_CPU);

[..]

  	    TP_printk("start batch LAZY_%s",
		      __print_symbolic(mode,
				       { XEN_LAZY_NONE, "NONE" },
				       { XEN_LAZY_MMU,  "MMU   },
				       { XEN_LAZY_CPU,  "CPU"  }))

Then user space parsers that read the raw data can convert these events
into something humans can read.

-- Steve

>  	);
>  #define DEFINE_XEN_MC_BATCH(name)			\
>  	DEFINE_EVENT(xen_mc__batch, name,		\
> -		TP_PROTO(enum paravirt_lazy_mode mode),	\
> +		TP_PROTO(enum xen_lazy_mode mode),	\
>  		     TP_ARGS(mode))
>  
>  DEFINE_XEN_MC_BATCH(xen_mc_batch);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
