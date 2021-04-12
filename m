Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5947C433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 23:22:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36ADB61220
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 23:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ADB61220
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED39A60B17;
	Mon, 12 Apr 2021 23:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7Uit13dz2nl; Mon, 12 Apr 2021 23:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1F5C60B1C;
	Mon, 12 Apr 2021 23:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D964C000C;
	Mon, 12 Apr 2021 23:22:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC88FC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 23:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BACB060B17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 23:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S4cgGFmDXhiN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 23:22:53 +0000 (UTC)
X-Greylist: delayed 00:07:48 by SQLgrey-1.8.0
Received: from mail.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1446B60B1C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 23:22:52 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 by mail.monkeyblade.net (Postfix) with ESMTPSA id 799E54D254D0A;
 Mon, 12 Apr 2021 16:15:02 -0700 (PDT)
Date: Mon, 12 Apr 2021 16:14:58 -0700 (PDT)
Message-Id: <20210412.161458.652699519749470159.davem@davemloft.net>
To: mst@redhat.com
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
From: David Miller <davem@davemloft.net>
In-Reply-To: <20210412183141-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
 <20210412180353-mutt-send-email-mst@kernel.org>
 <20210412183141-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2
 (mail.monkeyblade.net [0.0.0.0]); Mon, 12 Apr 2021 16:15:02 -0700 (PDT)
Cc: netdev@vger.kernel.org, weiwan@google.com,
 virtualization@lists.linux-foundation.org, willemb@google.com, kuba@kernel.org
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

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 12 Apr 2021 18:33:45 -0400

> On Mon, Apr 12, 2021 at 06:08:21PM -0400, Michael S. Tsirkin wrote:
>> OK I started looking at this again. My idea is simple.
>> A. disable callbacks before we try to drain skbs
>> B. actually do disable callbacks even with event idx
>> 
>> To make B not regress, we need to
>> C. detect the common case of disable after event triggering and skip the write then.
>> 
>> I added a new event_triggered flag for that.
>> Completely untested - but then I could not see the warnings either.
>> Would be very much interested to know whether this patch helps
>> resolve the sruprious interrupt problem at all ...
>> 
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hmm a slightly cleaner alternative is to clear the flag when enabling interrupts ...
> I wonder which cacheline it's best to use for this.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Please make a fresh new submission if you want to use this approach, thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
