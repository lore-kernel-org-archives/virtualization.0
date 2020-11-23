Return-Path: <SRS0=KpU2=E5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89037C63697
	for <virtualization@archiver.kernel.org>; Mon, 23 Nov 2020 19:09:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D429822269
	for <virtualization@archiver.kernel.org>; Mon, 23 Nov 2020 19:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D429822269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D91185118;
	Mon, 23 Nov 2020 19:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RXFfOwr0GrGw; Mon, 23 Nov 2020 19:09:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A872857D1;
	Mon, 23 Nov 2020 19:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5935CC1DA2;
	Mon, 23 Nov 2020 19:09:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62A38C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 19:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4FD3186FD5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 19:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q7wY9aOn5bqA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 19:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B4A6786FCD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 19:09:37 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E840222252;
 Mon, 23 Nov 2020 19:09:35 +0000 (UTC)
Date: Mon, 23 Nov 2020 14:09:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201123140934.38748be3@gandalf.local.home>
In-Reply-To: <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home>
 <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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

On Mon, 23 Nov 2020 10:52:52 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 23 Nov 2020 09:31:28 -0500 Steven Rostedt wrote:
> > On Mon, 23 Nov 2020 13:08:55 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> > 
> >   
> > >  [   10.028024] Chain exists of:
> > >  [   10.028025]   console_owner --> target_list_lock --> _xmit_ETHER#2    
> > 
> > Note, the problem is that we have a location that grabs the xmit_lock while
> > holding target_list_lock (and possibly console_owner).  
> 
> Well, it try_locks the xmit_lock. Does lockdep understand try-locks?
> 
> (not that I condone the shenanigans that are going on here)

Does it?

	virtnet_poll_tx() {
		__netif_tx_lock() {
			spin_lock(&txq->_xmit_lock);

That looks like we can have:


	CPU0		CPU1
	----		----
   lock(xmit_lock)

		    lock(console)
		    lock(target_list_lock)
		    __netif_tx_lock()
		        lock(xmit_lock);

			[BLOCKED]

   <interrupt>
   lock(console)

   [BLOCKED]



 DEADLOCK.


So where is the trylock here?

Perhaps you need the trylock in virtnet_poll_tx()?

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
