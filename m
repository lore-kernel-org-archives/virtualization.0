Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29933C54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21B0C41749;
	Mon, 30 Jan 2023 09:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21B0C41749
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=eHUFE3dP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2A9L67Tupfh; Mon, 30 Jan 2023 09:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA2D8410A3;
	Mon, 30 Jan 2023 09:55:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA2D8410A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6203DC0032;
	Mon, 30 Jan 2023 09:55:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E3FC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C305560E6A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C305560E6A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=eHUFE3dP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7GIM894OdX7w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:55:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CE6E60D94
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CE6E60D94
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:55:33 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8ADDD21A3B;
 Mon, 30 Jan 2023 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675072531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wW8PYSjbj1fhy1DHl5je08VWFBPjfFkiep3fm9ftfHQ=;
 b=eHUFE3dP4kCVW2OfnU8v4jOJkOWrkHxqxK4gFtlKv2icSzUiJyeFQ3OYS3ZIadLRUXWOEv
 rhCRsRIRAD5eh6Q3o+nbnyNl1fzrHwsBfh5gSz04qjRP7dmEWwXd2KbY8HwVDLgJIUGlhh
 vWP8AVHea583RzvUzoRGge0KMOU5ntg=
Received: from suse.cz (unknown [10.100.201.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 64E7E2C141;
 Mon, 30 Jan 2023 09:55:31 +0000 (UTC)
Date: Mon, 30 Jan 2023 10:55:28 +0100
To: Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9eUEGu+wC5dm0JI@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <Y9KyVKQk3eH+RRse@alley> <Y9LswwnPAf+nOVFG@do-x1extreme>
 <Y9OzJzHIASUeIrzO@alley> <Y9PmZFBEwUBwV3s/@do-x1extreme>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9PmZFBEwUBwV3s/@do-x1extreme>
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

On Fri 2023-01-27 08:57:40, Seth Forshee wrote:
> On Fri, Jan 27, 2023 at 12:19:03PM +0100, Petr Mladek wrote:
> > Could you please provide some more details about the test system?
> > Is there anything important to make it reproducible?
> > 
> > The following aspects come to my mind. It might require:
> > 
> >    + more workers running on the same system
> >    + have a dedicated CPU for the worker
> >    + livepatching the function called by work->fn()
> >    + running the same work again and again
> >    + huge and overloaded system
> 
> I'm isolating a CPU, starting a KVM guest with a virtio-net device, and
> setting the affinity of the vhost worker thread to only the isolated
> CPU. Thus the vhost-worker thread has a dedicated CPU, as you say. (I'll
> note that in real-world cases the systems have many CPUs, and while the
> vhost threads aren't each given a dedicated CPU, if the system load is
> light enough a thread can end up with exlusive use of a CPU).
> 
> Then all I do is run iperf between the guest and the host with several
> parallel streams. I seem to be hitting the limits of the guest vCPUs
> before the vhost thread is fully saturated, as this gets it to about 90%
> CPU utilization by the vhost thread.

Thanks for the info!

> > > > Honestly, kpatch's timeout 1 minute looks incredible low to me. Note
> > > > that the transition is tried only once per minute. It means that there
> > > > are "only" 60 attempts.
> > > > 
> > > > Just by chance, does it help you to increase the timeout, please?
> > > 
> > > To be honest my test setup reproduces the problem well enough to make
> > > KLP wait significant time due to vhost threads, but it seldom causes it
> > > to hit kpatch's timeout.
> > > 
> > > Our system management software will try to load a patch tens of times in
> > > a day, and we've seen real-world cases where patches couldn't load
> > > within kpatch's timeout for multiple days. But I don't have such an
> > > environment readily accessible for my own testing. I can try to refine
> > > my test case and see if I can get it to that point.
> > 
> > My understanding is that you try to load the patch repeatedly but
> > it always fails after the 1 minute timeout. It means that it always
> > starts from the beginning (no livepatched process).
> > 
> > Is there any chance to try it with a longer timeout, for example, one
> > hour? It should increase the chance if there are more problematic kthreads.
> 
> Yes, I can try it. But I think I already mentioned that we are somewhat
> limited by our system management software and how livepatch loading is
> currently implemented there. I'd need to consult with others about how
> long we could make the timeout, but 1 hour is definitely too long under
> our current system.

Another possibility is to do not wait at all. SUSE livepatch packages load
the livepatch module, remove not longer used livepatch modules and are
done with it.

Note that the module is loaded quickly. The transition is finished
asynchronously using workqueues.

Of course, there is a risk that the transition will never finish.
It would prevent loading any newer livepatch. But it might be handled
when the the newer livepatch is loaded. It might revert the pending
transition, ...

Of course, it would be great to make the transition more reliable.
It would be nice to add the hook into the scheduler as discussed
in another branch of this thread. But it might bring another problems,
for example, affect the system performance. Well, it probably can
be optimized or ratelimited.

Anyway, I wanted to say that there is a way to get rid of the timeout
completely.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
