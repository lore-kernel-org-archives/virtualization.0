Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4FBC54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 11:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CAE6125C;
	Fri, 27 Jan 2023 11:19:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5CAE6125C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=utmF3gy7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5_vs8qHuGql; Fri, 27 Jan 2023 11:19:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13727611F1;
	Fri, 27 Jan 2023 11:19:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13727611F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3B3DC0033;
	Fri, 27 Jan 2023 11:19:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4E87C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F440417DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:19:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F440417DE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=utmF3gy7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IC8Tav6-grdK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:19:06 +0000 (UTC)
X-Greylist: delayed 18:15:46 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74043417D6
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 74043417D6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:19:06 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2A3AD21889;
 Fri, 27 Jan 2023 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674818344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jg6tAtljWkLOtzvKkDNIoiHHgxanNXV1iXTx9cL+UQU=;
 b=utmF3gy7DItB+OI2ZalxyBwjhN8ryT8raie78QEcmelb6Gaa27V6jEgklx42rzficIjadI
 nu+HqyEOKtdYizLCOtQkNWx4S2VvGWugKipxH2r9HOc4bA9hB+YRcYXTY/zW8bW0QlDX7r
 g41e96/5ttY1iEwr1MNKmU14WzKGC0w=
Received: from suse.cz (unknown [10.100.201.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A46122C141;
 Fri, 27 Jan 2023 11:19:03 +0000 (UTC)
Date: Fri, 27 Jan 2023 12:19:03 +0100
To: "Seth Forshee (DigitalOcean)" <sforshee@digitalocean.com>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9OzJzHIASUeIrzO@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <Y9KyVKQk3eH+RRse@alley> <Y9LswwnPAf+nOVFG@do-x1extreme>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9LswwnPAf+nOVFG@do-x1extreme>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, live-patching@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>
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
From: Petr Mladek via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu 2023-01-26 15:12:35, Seth Forshee (DigitalOcean) wrote:
> On Thu, Jan 26, 2023 at 06:03:16PM +0100, Petr Mladek wrote:
> > On Fri 2023-01-20 16:12:20, Seth Forshee (DigitalOcean) wrote:
> > > We've fairly regularaly seen liveptches which cannot transition within kpatch's
> > > timeout period due to busy vhost worker kthreads.
> > 
> > I have missed this detail. Miroslav told me that we have solved
> > something similar some time ago, see
> > https://lore.kernel.org/all/20220507174628.2086373-1-song@kernel.org/
> 
> Interesting thread. I had thought about something along the lines of the
> original patch, but there are some ideas in there that I hadn't
> considered.

Could you please provide some more details about the test system?
Is there anything important to make it reproducible?

The following aspects come to my mind. It might require:

   + more workers running on the same system
   + have a dedicated CPU for the worker
   + livepatching the function called by work->fn()
   + running the same work again and again
   + huge and overloaded system


> > Honestly, kpatch's timeout 1 minute looks incredible low to me. Note
> > that the transition is tried only once per minute. It means that there
> > are "only" 60 attempts.
> > 
> > Just by chance, does it help you to increase the timeout, please?
> 
> To be honest my test setup reproduces the problem well enough to make
> KLP wait significant time due to vhost threads, but it seldom causes it
> to hit kpatch's timeout.
> 
> Our system management software will try to load a patch tens of times in
> a day, and we've seen real-world cases where patches couldn't load
> within kpatch's timeout for multiple days. But I don't have such an
> environment readily accessible for my own testing. I can try to refine
> my test case and see if I can get it to that point.

My understanding is that you try to load the patch repeatedly but
it always fails after the 1 minute timeout. It means that it always
starts from the beginning (no livepatched process).

Is there any chance to try it with a longer timeout, for example, one
hour? It should increase the chance if there are more problematic kthreads.

> > This low timeout might be useful for testing. But in practice, it does
> > not matter when the transition is lasting one hour or even longer.
> > It takes much longer time to prepare the livepatch.
> 
> Agreed. And to be clear, we cope with the fact that patches may take
> hours or even days to get applied in some cases. The patches I sent are
> just about improving the only case I've identified which has lead to
> kpatch failing to load a patch for a day or longer.

If it is acceptable to wait hours or even days then the 1 minute
timeout is quite contra-productive. We actually do not use any timeout
at all in livepatches provided by SUSE.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
