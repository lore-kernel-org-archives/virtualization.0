Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27128C64E7A
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 14:31:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1AD206E5
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 14:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1AD206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCF0086F8E;
	Tue, 24 Nov 2020 14:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YoiuI4ZZojie; Tue, 24 Nov 2020 14:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 68C2986FCD;
	Tue, 24 Nov 2020 14:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FB7AC0891;
	Tue, 24 Nov 2020 14:31:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2CFEC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 14:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C5629204E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 14:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzMG0zrPSfOm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 14:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id B1924203FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 14:31:41 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B682520674;
 Tue, 24 Nov 2020 14:31:39 +0000 (UTC)
Date: Tue, 24 Nov 2020 09:31:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201124093137.48d1e603@gandalf.local.home>
In-Reply-To: <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home>
 <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201123140934.38748be3@gandalf.local.home>
 <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, Amit Shah <amit@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
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

On Tue, 24 Nov 2020 11:22:03 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Btw, have a quick search, there are several other drivers that uses tx 
> lock in the tx NAPI.

tx NAPI is not the issue. The issue is that write_msg() (in netconsole.c)
calls this polling logic with the target_list_lock held.

Are those other drivers called by netconsole? If not, then this is unique
to virtio-net.

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
