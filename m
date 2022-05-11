Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF86C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C6AA83E0C;
	Wed, 11 May 2022 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eimOO4m24jLg; Wed, 11 May 2022 12:24:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E0D0483E0B;
	Wed, 11 May 2022 12:24:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B415DC0039;
	Wed, 11 May 2022 12:24:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 661E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EF166063B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApDtuMgc6cCn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:24:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AB6F60585
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 12:24:32 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D6B675A4; Wed, 11 May 2022 14:24:28 +0200 (CEST)
Date: Wed, 11 May 2022 14:24:23 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <Ynuq9wMtJKBe8WOk@8bytes.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Tue, May 10, 2022 at 11:23:11AM -0700, Linus Torvalds wrote:
> And - once again - I want to complain about the "Link:" in that commit.

I have to say that for me (probably for others as well) those Link tags
pointing to the patch submission have quite some value:

	1) First of all it is an easy proof that the patch was actually
	   submitted somewhere for public review before it went into a
	   maintainers tree.

	2) The patch submission is often the entry point to the
	   discussion which lead to this patch. From that email I can
	   see what was discussed and often there is even a link to
	   previous versions and the discussions that happened there. It
	   helps to better understand how a patch came to be the way it
	   is. I know this should ideally be part of the commit message,
	   but in reality this is what I also use the link tag for.

	3) When backporting a patch to a downstream kernel it often
	   helps a lot to see the whole patch-set the change was
	   submitted in, especially when it comes to fixes. With the
	   Link: tag the whole submission thread is easy to find.

I can stop adding them to patches if you want, but as I said, I think
there is some value in them which make me want to keep them.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
