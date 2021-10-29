Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64452C433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 12:24:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FFB760E90
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 12:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FFB760E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEDE8400C4;
	Fri, 29 Oct 2021 12:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xKo4DQBHTBn; Fri, 29 Oct 2021 12:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28D9440018;
	Fri, 29 Oct 2021 12:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAECBC0019;
	Fri, 29 Oct 2021 12:24:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52310C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DAFD4032A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1BVYW_ZWTmzB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:24:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABFC540327
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1635510293;
 x=1667046293; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RZHGWtu1aosFk7Zxe6m47+9uQq7KcFZHkqCC1tNlnns=;
 b=o9OPxM1sEjq/0HHQYjnj5kaCXGSSaFY/px3LtUugGjnDQ0S2tfhPZtt+
 4Lu5UMzAFUS8pm5N6SCPWXEvl5Rrd/0zX32sLc/NeCNic0KDvXYMP3bty
 M4I9114EVa6p7bgC81EcOY6CxxGoedgYl3EGO/7GLkN5B6Or4/Tv0YP70
 HVltNZHPRJfrUWBiMYJS74pqanYW7WMGECoS+cC6oNTCLadf4tSNCRM/V
 8zsRzsWwsom0xpL/SJxC49G4LoUV5FzS8Ejs3EPu8LPUPXiP8wjZjcEeH
 pgAZ8hYteLjG8OihYHL0pB1nRaAh1QfsT94LLxwddJUibXtmeEupdCMl+ w==;
Date: Fri, 29 Oct 2021 14:24:51 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211029122450.GB24060@axis.com>
References: <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
 <YW8LFTcBuN1bB3PD@ninjato>
 <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
 <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
 <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
 <01d9c992-28cc-6644-1e82-929fc46f91b4@intel.com>
 <20211020105554.GB9985@axis.com>
 <20211020110316.4x7tnxonswjuuoiw@vireshk-i7>
 <df7e6127-05fb-6aad-3896-fc810f213a54@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df7e6127-05fb-6aad-3896-fc810f213a54@intel.com>
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

On Thu, Oct 21, 2021 at 05:30:28AM +0200, Jie Deng wrote:
> On 2021/10/20 19:03, Viresh Kumar wrote:
> > On 20-10-21, 12:55, Vincent Whitchurch wrote:
> >> If the timeout cannot be disabled, then the driver should be fixed to
> >> always copy buffers and hold on to them to avoid memory corruption in
> >> the case of timeout, as I mentioned in my commit message.  That would be
> >> quite a substantial change to the driver so it's not something I'm
> >> personally comfortable with doing, especially not this late in the -rc
> >> cycle, so I'd leave that to others.
> > Or we can avoid clearing up and freeing the buffers here until the
> > point where the buffers are returned by the host. Until that happens,
> > we can avoid taking new requests but return to the earlier caller with
> > timeout failure. That would avoid corruption, by freeing buffers
> > sooner, and not hanging of the kernel.
> 
> It seems similar to use "wait_for_completion". If the other side is
> hacked, the guest may never get the buffers returned by the host,
> right ?

Note that it is trivial for the host to DoS the guest.  All the host has
to do is stop responding to I/O requests (I2C or others), then the guest
will not be able to perform its intended functions, regardless of
whether this particular driver waits forever or not.  Even TDX (which
Greg mentioned) does not prevent that, see:

 https://lore.kernel.org/virtualization/?q=tdx+dos

> For this moment, we can solve the problem by using a hardcoded big
> value or disabling the timeout.

Is that an Acked-by on this patch which does the latter?

> Over the long term, I think the backend should provide that timeout
> value and guarantee that its processing time should not exceed that
> value.

If you mean that the spec should be changed to allow the virtio driver
to be able to program a certain timeout for I2C transactions in the
virtio device, yes, that does sound reasonable.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
