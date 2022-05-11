Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF23BC433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 10:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49DAD6058B;
	Wed, 11 May 2022 10:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Um9ny0Y33ouL; Wed, 11 May 2022 10:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CDFB6605AE;
	Wed, 11 May 2022 10:18:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6BCBC0039;
	Wed, 11 May 2022 10:18:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82C09C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E7984010C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ellerman.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WMRFfQUdgwLc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:18:37 +0000 (UTC)
X-Greylist: delayed 00:05:59 by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53275404CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:18:37 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyrLk522xz4xXh;
 Wed, 11 May 2022 20:12:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1652263951;
 bh=AYMaIHm/9FJs7QMQIGjVwHQBqVw7TF+ASqO5SvByvIQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lC0i9AXiN8OGFHknnvxL+T1hg1fn/cgusHgj0/KPf0t/otQdhWoP0Z/6icK5/jzPn
 6yFaDkgHzwr+deS+AD+tGm7GSOKZIDPTNYhu8XoTdM7zVJOIhbK3tycAVo8HDvFH8f
 6Z/+qEsRN4ipbT3AN8LxjBAKXtObESQMWSivIWkKy0R7LSRvxZpLEy4Ps0sUsiIMhW
 Izpt2mBBj+GmabSb7N6QwFt6dYrzB/VTe4GQqPVD9zuW2wt1zyrCXj3xc8vqtzOf7k
 z4WEXVtfm/ZD9BY+Q9EG9pqTKwsaPs2G40KK6X93P5tz+IpFl61hCrRJ14e44s5mak
 blQEwlyz3slZA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
In-Reply-To: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Date: Wed, 11 May 2022 20:12:27 +1000
Message-ID: <87czgk8jjo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: Netdev <netdev@vger.kernel.org>, mie@igel.co.jp,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
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

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Tue, May 10, 2022 at 5:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> A last minute fixup of the transitional ID numbers.
>> Important to get these right - if users start to depend on the
>> wrong ones they are very hard to fix.
>
> Hmm. I've pulled this, but those numbers aren't exactly "new".
>
> They've been that way since 5.14, so what makes you think people
> haven't already started depending on them?
>
> And - once again - I want to complain about the "Link:" in that commit.
>
> It points to a completely useless patch submission. It doesn't point
> to anything useful at all.
>
> I think it's a disease that likely comes from "b4", and people decided
> that "hey, I can use the -l parameter to add that Link: field", and it
> looks better that way.

Some folks have been doing it since the early 2010s.

But I think it really took off after the Change-Id discussion a few
years back:

  https://lore.kernel.org/all/CAHk-=whFbgy4RXG11c_=S7O-248oWmwB_aZOcWzWMVh3w7=RCw@mail.gmail.com/

Which I read as you endorsing Link: tags :)

> And then they add it all the time, whether it makes any sense or not.

For me it always makes sense, because it means I can easily go from a
commit back to the original submission. That's useful for automating
various things like replies and patchwork status updates.

It allows me to find the exact patch I applied, even if what I committed
is slightly different (due to fuzz or editing), which would be harder
with a search based approach.

It gives us a way to essentially augment the change log after the fact,
by replying to the original patch with things we didn't know at the time
of commit - eg. this patch was reverted because it caused a bug, etc.

If you follow the Link: and there's nothing useful there explaining
what motivated the change then that's a bug in the patch submission, not
the Link: tag.

Really important information should be in the change log itself, but the
space below the "---" is perfect for added context that would be too
verbose for the committed change log. And anyone can reply to the
original submission to add even more useful information.

cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
