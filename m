Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E0C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 07:23:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9E1611AF
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 07:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC9E1611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88383607F2;
	Tue, 24 Aug 2021 07:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2MgiVVF5_MLi; Tue, 24 Aug 2021 07:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2D8A606E2;
	Tue, 24 Aug 2021 07:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA05DC0010;
	Tue, 24 Aug 2021 07:23:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C0A3C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5AB61606E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNuBfFj9qfv6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:23:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B52EE60723
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1629789790;
 x=1661325790; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IfhqP2RM3ChQYnmM5eJg3nw2hVwagJF4PQHhkcCi/ms=;
 b=BPG80mAwvnVzGWGY4n4gKIhg7JcbJdQWfgQ/E5xKNghbhQReSYeeOkSr
 OwR5+b9YLqJDzsteyZuAjcw727gGDNMY4ppYhQmnwKXOwB37A8FNMWaoP
 /kNL1Dl1V0yW2bC9xb0EQ0ON/HRYoN0XT0/M1v3kYm4catPSDb5SoTkgL
 Dh3ihHasMrcuUjGonm5TKBTzsRfz8snPrYf+JnzOnkKumPnlM/MCQD7XM
 jiBoEzJn3XhI1mIxJF1uEkGSORymhXI0+57Qp2eOqvHu3obe38hdgDtON
 QaXjJKOAZrcFs2x18cg3+1kALuwYk/LGvO21SIBGbdRBGcM6BeyImCfOB Q==;
Date: Tue, 24 Aug 2021 09:23:06 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: add support for mandatory barriers
Message-ID: <20210824072306.GA29073@axis.com>
References: <20210823081437.14274-1-vincent.whitchurch@axis.com>
 <20210823171609-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823171609-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, kernel <kernel@axis.com>
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

On Mon, Aug 23, 2021 at 11:19:56PM +0200, Michael S. Tsirkin wrote:
> On Mon, Aug 23, 2021 at 10:14:37AM +0200, Vincent Whitchurch wrote:
> > vhost always uses SMP-conditional barriers, but these may not be
> > sufficient when vhost is used to communicate between heterogeneous
> > processors in an AMP configuration, especially since they're NOPs on
> > !SMP builds.
> > 
> > To solve this, use the virtio_*() barrier functions and ask them for
> > non-weak barriers if requested by userspace.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> 
> I am inclined to say let's (ab)use VIRTIO_F_ORDER_PLATFORM for this.
> Jason what do you think?

OK, thanks, I'll look into that.

> Also is the use of DMA variants really the intended thing here? Could
> you point me at some examples please?

I'm using this on an ARM-based SoC.  The main processor is a Cortex-A53
(arm64) and this processor runs the virtio drivers.  The SoC also has
another processor which is a Cortex-A5 (arm32) and this processor runs
the virtio device end using vhost.  There is no coherency between these
two processors and to each other they look like any other DMA-capable
hardware.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
