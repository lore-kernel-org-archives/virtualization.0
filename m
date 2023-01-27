Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8785EC61DA4
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 13:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0977382D96;
	Fri, 27 Jan 2023 13:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0977382D96
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ZapjK9qA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZiyV4Orh-JE5; Fri, 27 Jan 2023 13:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9728E82B21;
	Fri, 27 Jan 2023 13:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9728E82B21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61F0AC0033;
	Fri, 27 Jan 2023 13:31:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BD1C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6406F82CD4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6406F82CD4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CoQdTlCKIejY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:31:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 856BC82B21
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 856BC82B21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 13:31:42 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC2E61C4E;
 Fri, 27 Jan 2023 13:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36368C433D2;
 Fri, 27 Jan 2023 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674826300;
 bh=IunA0Pc8LL+zSuJ7WZCxCQOUJgXGl22zLfNJLSaAsn8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZapjK9qAo4jtAF/ANodw/fxTC0/TbcBp0lzlRR08wC8qrMW0PRXVxuWXelZ5KOdf3
 npaNshhnj64hW1sMT40oieEvwtU0PcThEWgBZKPMR2nPmB72TrS1Xd5Kq4MbyIEz2m
 Sj0Df1cvD9xZGWxDu3O+uiPbC1LItfgRFAvO86Mc=
Date: Fri, 27 Jan 2023 14:31:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y9PSObAeUyHK2cc3@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
 <20230127055944-mutt-send-email-mst@kernel.org>
 <87k018p4xs.fsf@ubik.fi.intel.com>
 <20230127071152-mutt-send-email-mst@kernel.org>
 <87edrgp2is.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87edrgp2is.fsf@ubik.fi.intel.com>
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

On Fri, Jan 27, 2023 at 02:47:55PM +0200, Alexander Shishkin wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Fri, Jan 27, 2023 at 01:55:43PM +0200, Alexander Shishkin wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> >> >> When handling control messages, instead of peeking at the device memory
> >> >> to obtain bits of the control structure,
> >> >
> >> > Except the message makes it seem that we are getting data from
> >> > device memory, when we do nothing of the kind.
> >> 
> >> We can be, see below.
> >> 
> >> >> take a snapshot of it once and
> >> >> use it instead, to prevent it from changing under us. This avoids races
> >> >> between port id validation and control event decoding, which can lead
> >> >> to, for example, a NULL dereference in port removal of a nonexistent
> >> >> port.
> >> >> 
> >> >> The control structure is small enough (8 bytes) that it can be cached
> >> >> directly on the stack.
> >> >
> >> > I still have no real idea why we want a copy here.
> >> > If device can poke anywhere at memory then it can crash kernel anyway.
> >> > If there's a bounce buffer or an iommu or some other protection
> >> > in place, then this memory can no longer change by the time
> >> > we look at it.
> >> 
> >> We can have shared pages between the host and guest without bounce
> >> buffers in between, so they can be both looking directly at the same
> >> page.
> >> 
> >> Regards,
> >
> > How does this configuration work? What else is in this page?
> 
> So, for example in TDX, you have certain pages as "shared", as in
> between guest and hypervisor. You can have virtio ring(s) in such
> pages. It's likely that there'd be a swiotlb buffer there instead, but
> sharing pages between host virtio and guest virtio drivers is possible.

If it is shared, then what does this mean?  Do we then need to copy
everything out of that buffer first before doing anything with it
because the data could change later on?  Or do we not trust anything in
it at all and we throw it away?  Or something else (trust for a short
while and then we don't?)

Please be specific as to what you want to see happen here, and why.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
