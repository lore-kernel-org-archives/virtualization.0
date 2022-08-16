Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6376C25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 11:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2775C827CA;
	Tue, 16 Aug 2022 11:56:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2775C827CA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=v8PP2Y7z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIx9D02fYpRC; Tue, 16 Aug 2022 11:56:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F4B9827A9;
	Tue, 16 Aug 2022 11:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F4B9827A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7332BC0032;
	Tue, 16 Aug 2022 11:56:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2E40C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D4A9827A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D4A9827A9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eX-8xHA6LNKT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:56:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C47EE827CA
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C47EE827CA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 11:56:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8D263B816AA;
 Tue, 16 Aug 2022 11:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACE5C433D6;
 Tue, 16 Aug 2022 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1660650995;
 bh=FVUSKZvyxeYHla7DAI1S7uQ9b45W1lFMmWt54ll5JlA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v8PP2Y7zNU+FVQizPga9MODb0WFzHKVad+1VohxTjTDc+95kRo6+FlTlwZiET+gOj
 rI3kpk1WipL/kLv/6gv0XXNK+NrFFcDJFwt2vngBa+mVLRX7m5i+DafP+blpINyKqM
 iF0Qnt+XnOywNTiwwOBU918gkxWz6UVgzOTVIBMA=
Date: Tue, 16 Aug 2022 13:56:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <YvuF8CsP0M1TAK1a@kroah.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
 <YvtoDxvefWUJBfAS@kroah.com>
 <f88fe469-d4a4-3240-b325-a745255bf01c@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f88fe469-d4a4-3240-b325-a745255bf01c@virtuozzo.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Nadav Amit <namit@vmware.com>, Nicholas Piggin <npiggin@gmail.com>,
 kernel@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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

On Tue, Aug 16, 2022 at 02:47:22PM +0300, Alexander Atanasov wrote:
> Hello,
> 
> On 16.08.22 12:49, Greg Kroah-Hartman wrote:
> > On Tue, Aug 16, 2022 at 12:41:14PM +0300, Alexander Atanasov wrote:
> 
> > >   rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)
> > 
> > Why rename the .h file?  It still handles the "balloon compaction"
> > logic.
> 
> File contains code that is common to balloon drivers,
> compaction is only part of it. Series add more code to it.
> Since it was suggested to use it for such common code.
> I find that common becomes a better name for it so the rename.
> I can drop the rename easy on next iteration if you suggest to.

"balloon_common.h" is very vague, you should only need one balloon.h
file in the include/linux/ directory, right, so of course it is "common"
:)

thanks,

greg "naming is hard" k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
