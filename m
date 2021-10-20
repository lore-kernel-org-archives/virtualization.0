Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79940C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 10:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C89A6128B
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 10:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C89A6128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAE8B83A7F;
	Wed, 20 Oct 2021 10:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxVQfhKpI7ug; Wed, 20 Oct 2021 10:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84DD083AA2;
	Wed, 20 Oct 2021 10:55:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E2DFC0011;
	Wed, 20 Oct 2021 10:55:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5857EC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 466C9406D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6SixAcTwwTCn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:55:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F63F40696
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1634727357;
 x=1666263357; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nHNmZOTmEfWp7T9719d3q3afCE/4ZU54ct9XTonwH8g=;
 b=DeVLfgIWBrdweJkA1UgPpqjwXhXLVsEVf7oEmavfIcQFaD6Yrjz3Fiw0
 rJoN09Hxwsj7nQiGoeiVFspTFcr4sXZK3F5oZgMV7LE9i7XcuPxDgXu95
 wzbU+pNnepoA59N8LWSGng2jsurpDkEuvEoIpYnyfQOz35tlWRqhQmWK+
 HvBJGpdX0BgwKi0qME1b6s9AETSeF5Z0TrITwWsHhAHiAgviDPdELvypW
 PgQIOCtL0hmhiw6uro/XUBBPmp4gjLRIstrPzAUvJhrBkDQ0zZRV4D5eF
 uN8YGHB5NJRMyFj4jKYjELCY3HplFkxTBLxYQ6BTfiX/Kx4MGIAfobLtE Q==;
Date: Wed, 20 Oct 2021 12:55:54 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211020105554.GB9985@axis.com>
References: <YW6Rj/T6dWfMf7lU@kroah.com>
 <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6pHkXOPvtidtwS@kroah.com>
 <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
 <YW8LFTcBuN1bB3PD@ninjato>
 <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
 <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
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

On Wed, Oct 20, 2021 at 09:04:45AM +0200, Jie Deng wrote:
> On 2021/10/20 14:41, Viresh Kumar wrote:
> > On 20-10-21, 14:35, Jie Deng wrote:
> >> Yes, but we need to know what's the best value to be configured for a
> >> specific "other side".
> >>
> >> I think the "other side" should be more aware of what value is reasonable to
> >> be used.
> > If we _really_ need that, then it would require an update to the
> > specification first.
> >
> > I am not sure if the other side is the only party in play here. It
> > depends on the entire setup and not just the hardware device.
> > Specially with virtualisation things become really slow because of
> > context switches, etc. It may be better for the guest userspace to
> > decide on the value.
> >
> > Since this is specially for virtualisation, the kernel may set the
> > value to few HZ by default, lets say 10 (Yeah its really high) :).
> 
> I'm OK with this way for the simplicity.

That would not be safe.  Userspace can change this timeout and the end
result with the current implementation of the driver is potentially
kernel memory corruption, which is something userspace of course never
should be able to trigger.

Even if the timeout were hardcoded in the driver and the driver made to
ignore what userspace requests, it would need to be set to a
ridiculously high value so that we can guarantee that the timeout never
ever occurs (since the result is potentially random kernel memory
corruption).  Which is basically equivalent to disabling the timeout
entirely as my patch does.

If the timeout cannot be disabled, then the driver should be fixed to
always copy buffers and hold on to them to avoid memory corruption in
the case of timeout, as I mentioned in my commit message.  That would be
quite a substantial change to the driver so it's not something I'm
personally comfortable with doing, especially not this late in the -rc
cycle, so I'd leave that to others.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
