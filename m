Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539F1C25B50
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 21:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 97CE540B6D;
	Mon, 23 Jan 2023 21:53:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97CE540B6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKYSH4lVbEXK; Mon, 23 Jan 2023 21:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 210084023D;
	Mon, 23 Jan 2023 21:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 210084023D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E86B6C0033;
	Mon, 23 Jan 2023 21:53:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C941C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 21:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DF2F8205E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 21:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7DF2F8205E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQ3B8W-OtZxE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 21:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 433FD8205D
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 433FD8205D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 21:53:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 640D4B80E40;
 Mon, 23 Jan 2023 21:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F38C433EF;
 Mon, 23 Jan 2023 21:53:06 +0000 (UTC)
Date: Mon, 23 Jan 2023 16:53:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU
 is disabled
Message-ID: <20230123165304.370121e7@gandalf.local.home>
In-Reply-To: <20230123205515.059999893@infradead.org>
References: <20230123205009.790550642@infradead.org>
 <20230123205515.059999893@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com, hpa@zytor.com,
 x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, bp@alien8.de, vincent.guittot@linaro.org,
 boris.ostrovsky@oracle.com, dietmar.eggemann@arm.com, jgross@suse.com,
 seanjc@google.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mhiramat@kernel.org, pbonzini@redhat.com, bristot@redhat.com
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

On Mon, 23 Jan 2023 21:50:12 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> All RCU disabled code should be noinstr and hence we should never get
> here -- when we do, WARN about it and make sure to not actually do
> tracing.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/ftrace.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -646,6 +646,9 @@ void prepare_ftrace_return(unsigned long
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
>  		return;
>  
> +	if (WARN_ONCE(!rcu_is_watching(), "RCU not on for: %pS\n", (void *)ip))
> +		return;
> +

Please add this to after recursion trylock below. Although WARN_ONCE()
should not not have recursion issues, as function tracing can do weird
things, I rather be safe than sorry, and not have the system triple boot
due to some path that might get added in the future.

If rcu_is_watching() is false, it will still get by the below recursion
check and warn. That is, the below check should be done before this
function calls any other function.

>  	bit = ftrace_test_recursion_trylock(ip, *parent);
>  	if (bit < 0)
>  		return;
> 

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
