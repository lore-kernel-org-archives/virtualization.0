Return-Path: <SRS0=mz8r=PR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB0C433EF
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 11:54:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A69610E5
	for <virtualization@archiver.kernel.org>; Fri, 29 Oct 2021 11:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1A69610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6ABE2400C5;
	Fri, 29 Oct 2021 11:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gjzag_B2xtp7; Fri, 29 Oct 2021 11:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5F9040018;
	Fri, 29 Oct 2021 11:54:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A66E6C001E;
	Fri, 29 Oct 2021 11:54:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28DB0C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 11:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EDA7401EF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 11:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XmDc5V5FD_-y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 11:54:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A15BD401E3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1635508489;
 x=1667044489; h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WG5PX38DAgJ27VX4xJTi1uDJ28hysrGjkPPeLNkkKKE=;
 b=BQ15qFklLFXkH5bGgBQsdq2QORAryaXV44gaUtKhmYVvXA349omDCGJ/
 ZznYAn1+p1bvLwWD59On+EfrlmsOX4T5wy0GByHnOQxFFTKQQxAGT/EKE
 j8/AhKWVy9ytNdEGzs+qvK6Hac9phnzOjqtgMLfR5mA8SFMnR4VrDhnsQ
 nQuo+EBHyItG+Fl9Xx1LqKUUtqDPLLzpe2Gzc7Vqp20tCEIr8b/b6lKoP
 7+Duws7CimR7E8XMmOoRBaBWFY9bfdxZpo35hCCW0cVv+WrWkhMBHlMfg
 XB+yz1dyN0aAdmSlf/UTj6j+SFksyNQUcwq/dIo3NqsFuHBE6DuiTMKEt w==;
Date: Fri, 29 Oct 2021 13:54:46 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211029115446.GA24060@axis.com>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
 <81ea2661-20f8-8836-5311-7f2ed4a1781f@intel.com>
 <20211020091721.7kcihpevzf7h4d62@vireshk-i7>
 <20211020103849.GA9985@axis.com>
 <20211020104709.k6oqo2gmegiwfre4@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020104709.k6oqo2gmegiwfre4@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "wsa@kernel.org" <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
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

On Wed, Oct 20, 2021 at 12:47:09PM +0200, Viresh Kumar wrote:
> On 20-10-21, 12:38, Vincent Whitchurch wrote:
> > I don't quite understand how that would be safe since
> > virtqueue_add_sgs() can fail after a few iterations and all queued
> > request buffers can have FAIL_NEXT set.  In such a case, we would end up
> > waiting forever with your proposed change, wouldn't we?
> 
> Good point. I didn't think of that earlier.
> 
> I think a good simple way of handling this is counting the number of
> buffers sent and received. Once they match, we are done. That
> shouldn't break anything else I believe.

That could work, but it's not so straightforward since you would have to
introduce locking to prevent races since the final count is only known
after virtio_i2c_prepare_reqs() completes, while the callback could be
called before that.  Please do not hesitate to send out a patch to fix
it that way if that is what you prefer.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
