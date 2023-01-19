Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3DFC004D4
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 19:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 151C640236;
	Thu, 19 Jan 2023 19:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 151C640236
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Z3pFPo2i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0WVw-i2dDmnJ; Thu, 19 Jan 2023 19:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C342400CE;
	Thu, 19 Jan 2023 19:18:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C342400CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 725D8C0032;
	Thu, 19 Jan 2023 19:18:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFEFAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 19:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D3F0821E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 19:18:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D3F0821E1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=Z3pFPo2i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gMLdTgDwK4zh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 19:18:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9306821DF
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9306821DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 19:18:17 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 025B5B8270B;
 Thu, 19 Jan 2023 19:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52963C433F0;
 Thu, 19 Jan 2023 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674155894;
 bh=4gNZacUVu7Qe2Z2/07/8mXyL5AH7AsaHEp2psjaXZUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z3pFPo2iBQ2puU/Wzg/SlUhsvygxszIrdglZCdyOZGM5ZJF3JjDJ3Y5oPAd6gcGjf
 OpvZa1H3tq/LTua4sr8EhBg3/E06G7WPm1m0/BrZ07wveUy6rEvQ04z5SGUT02jNQT
 QGki7K+IWMbGSFIUsxo/RNpA9IWDlyJdMNYvv1io=
Date: Thu, 19 Jan 2023 20:18:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
Message-ID: <Y8mXdFms3CzPnW+6@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
 <Y8lfHKz08EVeNa5o@kroah.com> <87fsc6qrvx.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fsc6qrvx.fsf@ubik.fi.intel.com>
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

On Thu, Jan 19, 2023 at 08:52:02PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
> >> From: Andi Kleen <ak@linux.intel.com>
> >> 
> >> --- a/drivers/char/virtio_console.c
> >> +++ b/drivers/char/virtio_console.c
> >> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
> >>  	int err;
> >>  
> >>  	nr_ports = portdev->max_nr_ports;
> >> +	if (use_multiport(portdev) && nr_ports < 1)
> >> +		return -EINVAL;
> >> +
> >>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
> >>  
> >>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
> >> -- 
> >> 2.39.0
> >> 
> >
> > Why did I only get a small subset of these patches?
> 
> I did what get_maintainer told me. Would you like to be CC'd on the
> whole thing?

If you only cc: me on a portion of the series, I guess you only want me
to apply a portion of it?  if so, why is it a longer series?

> > And why is the whole thread not on lore.kernel.org?
> 
> That is a mystery, some wires got crossed between my smtp and vger. I
> bounced the series to lkml just now and at least some of it seems to
> have landed on lore.
> 
> > And the term "hardening" is marketing fluff.   Just say, "properly parse
> > input" or something like that, as what you are doing is fixing
> > assumptions about the data here, not causing anything to be more (or
> > less) secure.
> >
> > But, this still feels wrong.  Why is this happening here, in init_vqs()
> > and not in the calling function that already did a bunch of validation
> > of the ports and the like?  Are those checks not enough?  if not, fix it
> > there, don't spread it out all over the place...
> 
> Good point! And there happens to already be 28962ec595d70 that takes
> care of exactly this case. I totally missed it.

So this series is not needed?  Or just this one?

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
