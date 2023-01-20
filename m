Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BFAC05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 07:15:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8343E82430;
	Fri, 20 Jan 2023 07:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8343E82430
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=N5/cD8+5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJnfLl-tQxwb; Fri, 20 Jan 2023 07:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0467822F3;
	Fri, 20 Jan 2023 07:15:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0467822F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABB43C0032;
	Fri, 20 Jan 2023 07:15:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 514D1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 07:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 184834011D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 07:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 184834011D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=N5/cD8+5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JWeVvDYSYWKq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 07:15:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5654F4058F
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5654F4058F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 07:15:20 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2D6EF61E2B;
 Fri, 20 Jan 2023 07:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E37C433EF;
 Fri, 20 Jan 2023 07:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674198918;
 bh=dGwXf0BmH8FB3+W1jC+RE4rVTDz4Q5BheAiK4UorBxw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N5/cD8+5/Qo1ZOqM50106fjf6hDtXPzyqTlRT7Fr7HckbdfcicUOztJa/efgae8nu
 sTND8M5DFHXarP+78nsVn8FvQn+cD0s0mZOtKkfTY8IRoTvsR24i1cNX+RFwHm886+
 rqlffC+0G3kHaQCIpDod0CZRivBH2YfmpVimDOaA=
Date: Fri, 20 Jan 2023 08:15:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y8o/g9cDZCxmL6yR@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a62eqo4h.fsf@ubik.fi.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 mst@redhat.com, Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elena.reshetova@intel.com,
 kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > Then you need to copy it out once, and then only deal with the local
> > copy.  Otherwise you have an incomplete snapshot.
> 
> Ok, would you be partial to something like this:
> 
> >From 1bc9bb84004154376c2a0cf643d53257da6d1cd7 Mon Sep 17 00:00:00 2001
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Date: Thu, 19 Jan 2023 21:59:02 +0200
> Subject: [PATCH] virtio console: Keep a local copy of the control structure
> 
> When handling control messages, instead of peeking at the device memory
> to obtain bits of the control structure, take a snapshot of it once and
> use it instead, to prevent it from changing under us. This avoids races
> between port id validation and control event decoding, which can lead
> to, for example, a NULL dereference in port removal of a nonexistent
> port.
> 
> The control structure is small enough (8 bytes) that it can be cached
> directly on the stack.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Amit Shah <amit@kernel.org>
> ---
>  drivers/char/virtio_console.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Yes, this looks much better, thanks!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
