Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBD2C63697
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 14:13:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC532224C
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 14:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC532224C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6E4A787237;
	Wed, 18 Nov 2020 14:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FkC9p5wxVhfC; Wed, 18 Nov 2020 14:13:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF69C8710E;
	Wed, 18 Nov 2020 14:13:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81152C0800;
	Wed, 18 Nov 2020 14:13:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D54E9C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 14:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C0DEA203DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 14:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDjeqn1XTRik
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 14:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id ECD5620356
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 14:13:00 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A03722240;
 Wed, 18 Nov 2020 14:12:59 +0000 (UTC)
Date: Wed, 18 Nov 2020 09:12:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201118091257.2ee6757a@gandalf.local.home>
In-Reply-To: <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, Amit Shah <amit@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>
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


[ Adding netdev as perhaps someone there knows ]

On Wed, 18 Nov 2020 12:09:59 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > This CPU0 lock(_xmit_ETHER#2) -> hard IRQ -> lock(console_owner) is
> > basically
> > 	soft IRQ -> lock(_xmit_ETHER#2) -> hard IRQ -> printk()
> >
> > Then CPU1 spins on xmit, which is owned by CPU0, CPU0 spins on
> > console_owner, which is owned by CPU1?  

It still looks to me that the target_list_lock is taken in IRQ, (which can
be the case because printk calls write_msg() which takes that lock). And
someplace there's a:

	lock(target_list_lock)
	lock(xmit_lock)

which means you can remove the console lock from this scenario completely,
and you still have a possible deadlock between target_list_lock and
xmit_lock.

> 
> 
> If this is true, it looks not a virtio-net specific issue but somewhere 
> else.
> 
> I think all network driver will synchronize through bh instead of hardirq.

I think the issue is where target_list_lock is held when we take xmit_lock.
Is there anywhere in netconsole.c that can end up taking xmit_lock while
holding the target_list_lock? If so, that's the problem. As
target_list_lock is something that can be taken in IRQ context, which means
*any* other lock that is taking while holding the target_list_lock must
also protect against interrupts from happening while it they are held.

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
