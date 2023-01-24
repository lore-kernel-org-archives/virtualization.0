Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC770C38142
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 14:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B44882298;
	Tue, 24 Jan 2023 14:25:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B44882298
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KNcWsDp9ojtG; Tue, 24 Jan 2023 14:25:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E0C7782112;
	Tue, 24 Jan 2023 14:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0C7782112
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6C0EC0033;
	Tue, 24 Jan 2023 14:25:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3D9DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F68F41990
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:25:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F68F41990
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUGc47X8xwQu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:25:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1F96409E7
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1F96409E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:25:06 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id ss4so39332990ejb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 06:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HFiY49QSpECHmg3/XnIBpM7+6TWXqD6hxAB2tKV4uVM=;
 b=oA6SlFZ0oeDxp9SKcyIV5Iak5GB/HZ5zCXEJdsfpjrhZnC2e71ELSbEfzxaoRunntJ
 e6WMEzEKLAIbU4N6c1zDfxsQQaUdptBaF6OAprpKEXludkjBs2EbxZlcR1CtnP+cGQgP
 eaFRT90l6bMOQLBL/7Wq6ga0ajSLyax7i+ZTWYx/1oPLTYCN77mD9SCBTDTZLH1+HT6p
 PfIUskWU0CwE6sP5Up2/5jJA1WEF3K+O1naXPlo27fx2Fcr+GDn6+x9iRdL1sQF4Cwg+
 X1vBVkbJSTHeyJRIfPYH3KSGH3HbRfepKcbZiftkziy6y9XvUNNBBO79f8XJReAB9sUk
 xg9Q==
X-Gm-Message-State: AFqh2kp5JHVHn12rXyuyMzAQYIPVEDP5SFV+OWeRswMChjpkMYeqCdY3
 1xevge4lPmbmu6fZ6SkGGuQkXuukOaZ99aXI19c=
X-Google-Smtp-Source: AMrXdXuJpYU/fVjzod6h2/vaXZp4NAt4KpSzd9J+SqARc7LgKOGgdEnk0S9WeDDl/G8RAbK5Y/RXyWsg2NY+LUrUB/o=
X-Received: by 2002:a17:907:2b23:b0:877:8b1d:354e with SMTP id
 gc35-20020a1709072b2300b008778b1d354emr2505342ejc.309.1674570304853; Tue, 24
 Jan 2023 06:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20230123205009.790550642@infradead.org>
 <20230123205515.233366796@infradead.org>
In-Reply-To: <20230123205515.233366796@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Jan 2023 15:24:53 +0100
Message-ID: <CAJZ5v0jnmyWDQw=VXcViZLUfjjVgkP8TYKg3nS62jANT2qr-mg@mail.gmail.com>
Subject: Re: [PATCH 6/6] cpuidle: Fix poll_idle() noinstr annotation
To: Peter Zijlstra <peterz@infradead.org>
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com, hpa@zytor.com,
 x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 kernel test robot <oliver.sang@intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 bp@alien8.de, vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
 dietmar.eggemann@arm.com, jgross@suse.com, seanjc@google.com,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, mhiramat@kernel.org,
 pbonzini@redhat.com, bristot@redhat.com
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

On Mon, Jan 23, 2023 at 9:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The instrumentation_begin()/end() annotations in poll_idle() were
> complete nonsense. Specifically they caused tracing to happen in the
> middle of noinstr code, resulting in RCU splats.
>
> Now that local_clock() is noinstr, mark up the rest and let it rip.
>
> Fixes: 00717eb8c955 ("cpuidle: Annotate poll_idle()")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202301192148.58ece903-oliver.sang@intel.com

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpuidle/cpuidle.c    |    2 +-
>  drivers/cpuidle/poll_state.c |    2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -426,7 +426,7 @@ void cpuidle_reflect(struct cpuidle_devi
>   * @dev:   the cpuidle device
>   *
>   */
> -u64 cpuidle_poll_time(struct cpuidle_driver *drv,
> +__cpuidle u64 cpuidle_poll_time(struct cpuidle_driver *drv,
>                       struct cpuidle_device *dev)
>  {
>         int i;
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -15,7 +15,6 @@ static int __cpuidle poll_idle(struct cp
>  {
>         u64 time_start;
>
> -       instrumentation_begin();
>         time_start = local_clock();
>
>         dev->poll_time_limit = false;
> @@ -42,7 +41,6 @@ static int __cpuidle poll_idle(struct cp
>         raw_local_irq_disable();
>
>         current_clr_polling();
> -       instrumentation_end();
>
>         return index;
>  }
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
