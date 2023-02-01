Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D38C05027
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 11:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9D0F418EB;
	Wed,  1 Feb 2023 11:10:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9D0F418EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyI0EWUPupX6; Wed,  1 Feb 2023 11:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6AD48418C3;
	Wed,  1 Feb 2023 11:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AD48418C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B389C0032;
	Wed,  1 Feb 2023 11:10:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9BCC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 11:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61F4C408D3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 11:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61F4C408D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kagMKiLap6Co
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 11:10:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2621840482
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2621840482
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 11:10:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 242CA4B3;
 Wed,  1 Feb 2023 03:11:07 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.10])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2183F882;
 Wed,  1 Feb 2023 03:10:22 -0800 (PST)
Date: Wed, 1 Feb 2023 11:10:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9pInB8KvcyhAwDa@FVFF77S0Q05N>
References: <20230127044355.frggdswx424kd5dq@treble>
 <Y9OpTtqWjAkC2pal@hirez.programming.kicks-ass.net>
 <20230127165236.rjcp6jm6csdta6z3@treble>
 <20230127170946.zey6xbr4sm4kvh3x@treble>
 <20230127221131.sdneyrlxxhc4h3fa@treble>
 <Y9e6ssSHUt+MUvum@hirez.programming.kicks-ass.net>
 <Y9gOMCWGmoc5GQMj@FVFF77S0Q05N>
 <20230130194823.6y3rc227bvsgele4@treble>
 <Y9jr0fP7DtA9Of1L@FVFF77S0Q05N>
 <20230131163832.z46ihurbmjcwuvck@treble>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230131163832.z46ihurbmjcwuvck@treble>
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@digitalocean.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
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

On Tue, Jan 31, 2023 at 08:38:32AM -0800, Josh Poimboeuf wrote:
> On Tue, Jan 31, 2023 at 10:22:09AM +0000, Mark Rutland wrote:
> > > Hm, it might be nice if our out-of-line static call implementation would
> > > automatically do a static key check as part of static_call_cond() for
> > > NULL-type static calls.
> > > 
> > > But the best answer is probably to just add inline static calls to
> > > arm64.  Is the lack of objtool the only thing blocking that?
> > 
> > The major issues were branch range limitations (and needing the linker to add
> > PLTs),
> 
> Does the compiler do the right thing (e.g., force PLT) if the branch
> target is outside the translation unit?  I'm wondering if we could for
> example use objtool to help enforce such rules at the call site.

It's the linker (rather than the compiler) that'll generate the PLT if the
caller and callee are out of range at link time. There are a few other issues
too (e.g. no guarnatee that the PLT isn't used by multiple distinct callers,
CMODX patching requirements), so we'd have to generate a pseudo-PLT ourselves
at build time with a patching-friendly code sequence. Ard had a prototype for
that:

  https://lore.kernel.org/linux-arm-kernel/20211105145917.2828911-1-ardb@kernel.org/

... but that was sufficiently painful that we went with the current static key
approach:

  https://lore.kernel.org/all/20211109172408.49641-1-mark.rutland@arm.com/

> > and painful instruction patching requirements (e.g. the architecture's
> > "CMODX" rules for Concurrent MODification and eXecution of instructions). We
> > went with the static key scheme above because that was what our assembled code
> > generation would devolve to anyway.
> > 
> > If we knew each call-site would only call a particular function or skip the
> > call, then we could do better (and would probably need something like objtool
> > to NOP that out at compile time), but since we don't know the callee at build
> > time we can't ensure we have a PLT in range when necessary.
> 
> Unfortunately most static calls have multiple destinations.

Sure, but here we're just enabling/disabling a call, which we could treat
differently, or wrap at a different level within the scheduler code. I'm happy
to take a look at that.

> And most don't have the option of being NULL.

Oh, I was under the impression that all could be disabled/skipped, which is
what a NULL target implied.

Thanks,
Mark.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
