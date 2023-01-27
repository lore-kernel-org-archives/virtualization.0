Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34238C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 14:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD4CC82FC9;
	Fri, 27 Jan 2023 14:37:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD4CC82FC9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QTjYikNJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2QPmIbvO8rX; Fri, 27 Jan 2023 14:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29B54826E7;
	Fri, 27 Jan 2023 14:37:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29B54826E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0087FC0032;
	Fri, 27 Jan 2023 14:37:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F90EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED83741D11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:37:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED83741D11
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=QTjYikNJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOXa0dxKHktE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:37:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6276141D0D
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6276141D0D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 14:37:46 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 733C5CE28BB;
 Fri, 27 Jan 2023 14:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB2EC433EF;
 Fri, 27 Jan 2023 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674830257;
 bh=4P+BnZZYqm9/jN3n52aAZ3KaAO6LHlKsf7XWo/0ZLdU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QTjYikNJyDwHGBo8C8xfWCcMjouYJznEdDemUlvRnCT23G/aZnffjkU9uixx6fZs8
 4r63JJJYczHJmQodCQoi4d7cx18TDW+gvppWE6ARRxazqzw2TRir08fT9H6yojbE0e
 TnYCoqLUA75xM9nC06ZHaZDBQQFFJ1mlzb6VW5y0=
Date: Fri, 27 Jan 2023 15:37:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y9PhrjovJvxMuF9+@kroah.com>
References: <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com> <Y9PSObAeUyHK2cc3@kroah.com>
 <87bkmkoyd1.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bkmkoyd1.fsf@ubik.fi.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elena.reshetova@intel.com, kirill.shutemov@linux.intel.com
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

On Fri, Jan 27, 2023 at 04:17:46PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> >> >> We can have shared pages between the host and guest without bounce
> >> >> buffers in between, so they can be both looking directly at the same
> >> >> page.
> >> >> 
> >> >> Regards,
> >> >
> >> > How does this configuration work? What else is in this page?
> >> 
> >> So, for example in TDX, you have certain pages as "shared", as in
> >> between guest and hypervisor. You can have virtio ring(s) in such
> >> pages. It's likely that there'd be a swiotlb buffer there instead, but
> >> sharing pages between host virtio and guest virtio drivers is possible.
> >
> > If it is shared, then what does this mean?  Do we then need to copy
> > everything out of that buffer first before doing anything with it
> > because the data could change later on?  Or do we not trust anything in
> > it at all and we throw it away?  Or something else (trust for a short
> > while and then we don't?)
> 
> The first one, we need a consistent view of the metadata (the ckpt in
> this case), so we take a snapshot of it. Then, we validate it (because
> we don't trust it) to be correct. If it is not, we discard it, otherwise
> we act on it. Since this is a ring, we just move on to the next record
> if there is one.

So you do an additional extra copy of everything, making the bounce
buffer useless?  :)

> Meanwhile, in the shared page, it can change from correct to incorrect,
> but it won't affect us because we have this consistent view at the
> moment the snapshot was taken.

Wonderful, copy everything out then, the whole page, don't do it
piecemeal field by field.  And then justify it to everyone whose
throughput you just tanked...

good luck!

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
