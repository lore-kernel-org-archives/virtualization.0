Return-Path: <SRS0=F8NL=MB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7933AC07E99
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 19:49:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F3C61184
	for <virtualization@archiver.kernel.org>; Fri,  9 Jul 2021 19:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F3C61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CCE5C40601;
	Fri,  9 Jul 2021 19:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTyFpc4mRqOe; Fri,  9 Jul 2021 19:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A921400C4;
	Fri,  9 Jul 2021 19:48:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA83EC001A;
	Fri,  9 Jul 2021 19:48:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE95C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 19:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C5F440130
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 19:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ut3BsxXfo5v9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 19:48:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3EEAE400C4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7xOTruRzGa5B9hLk0/wSxAjaR6x7/fszhbg7rE8/TUQ=; b=vrBt/SYKQVqRA3cOE56PBVcIFu
 OImJOqgEYmHxVSPmBn+JWORi8cHqluYxcder3N4sVofDXHhj3HNcq6kkU+ep0/hWgFGVY5hq0Ogzc
 5I7sNJprJCOm6wDj/cFzFYaWNviS+XdqBfOPZ/dNXzbATrgGuHqvov7+sHMMfVzKiGl+Hzq7vVUUP
 4563HHA9K9qG5TGXXx8yTMlW8AW3JZJwSPNDL9B2oZ9WVlnoBtOybp3WKqAcMP47dhJ76/eIqjW12
 pstd60WvK5lXx8Dym5WgYOkBiZ0+bitew6m45ckOVIP1e8696UpHN42QONX3mLsW4QiDv7CFDobM7
 Bp3xcY8A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m1wUG-00EpFB-Ss; Fri, 09 Jul 2021 19:48:38 +0000
Date: Fri, 9 Jul 2021 20:48:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [RFC v1 7/8] mshv: implement in-kernel device framework
Message-ID: <YOioFOT5WgkUB+dY@casper.infradead.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-8-wei.liu@kernel.org>
 <YOhIzJVPN9SwoRK0@casper.infradead.org>
 <20210709135013.t5axinjmufotpylf@liuwe-devbox-debian-v2>
 <YOhsIDccgbUCzwqt@casper.infradead.org>
 <20210709162732.hnyzpf3uofzc7xqs@liuwe-devbox-debian-v2>
 <YOh7gO3MIDv5Eo8q@casper.infradead.org>
 <20210709191405.t3vno3zw7kdlo4ps@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709191405.t3vno3zw7kdlo4ps@liuwe-devbox-debian-v2>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, pasha.tatashin@soleen.com,
 Jonathan Corbet <corbet@lwn.net>, kumarpraveen@linux.microsoft.com,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Muminul Islam <muislam@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Lillian Grassin-Drake <ligrassi@microsoft.com>
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

On Fri, Jul 09, 2021 at 07:14:05PM +0000, Wei Liu wrote:
> You were not CC'ed on this patch, so presumably you got it via one of
> the mailing lists. I'm not sure why you only got this one patch. Perhaps
> if you wait a bit you will get the rest.

No, I won't.  You only cc'd linux-doc on this one patch and not on any
of the others.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
