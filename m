Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D76C83013
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 17:34:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E50208DB
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 17:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKH2vtu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E50208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 169F38728F;
	Mon, 30 Nov 2020 17:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpEwBaEMhlNz; Mon, 30 Nov 2020 17:34:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D0B987289;
	Mon, 30 Nov 2020 17:34:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79F02C1836;
	Mon, 30 Nov 2020 17:34:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8687AC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 733DC85A78
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFowq5djVhzk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A044860E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 17:34:42 +0000 (UTC)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3D8CB2073C;
 Mon, 30 Nov 2020 17:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606757681;
 bh=h2mSOc2MjK1hNd7ubl8zDnNrESM0nN8QfNkIPSrKIa8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jKH2vtu1zUtn2pkTnBJ4leZjTZuVbtifI7BhDN0kQoHRtp/8o8jcHF4U44pyZJV7D
 y/OXSpHnu5n22jmRnXSU1EHgA5m940y+BZOCAvLPvrJwWEfkTV6suDAlJWMl6SbEQy
 TMurzywftHn3Nk/p/t7zid4fYfpQSaJcyZZLh2q0=
Date: Mon, 30 Nov 2020 12:34:40 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <20201130173440.GQ643756@sasha-vm>
References: <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <X8TzeoIlR3G5awC6@kroah.com>
 <17481d8c-c19d-69e3-653d-63a9efec2591@redhat.com>
 <X8T6RWHOhgxW3tRK@kroah.com>
 <8809319f-7c5b-1e85-f77c-bbc3f22951e4@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8809319f-7c5b-1e85-f77c-bbc3f22951e4@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, netdev@vger.kernel.org,
 Mike Christie <michael.christie@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 30, 2020 at 03:00:13PM +0100, Paolo Bonzini wrote:
>On 30/11/20 14:57, Greg KH wrote:
>>>Every patch should be "fixing a real issue"---even a new feature.  But the
>>>larger the patch, the more the submitters and maintainers should be trusted
>>>rather than a bot.  The line between feature and bugfix_sometimes_  is
>>>blurry, I would say that in this case it's not, and it makes me question how
>>>the bot decided that this patch would be acceptable for stable (which AFAIK
>>>is not something that can be answered).
>>I thought that earlier Sasha said that this patch was needed as a
>>prerequisite patch for a later fix, right?  If not, sorry, I've lost the
>>train of thought in this thread...
>
>Yeah---sorry I am replying to 22/33 but referring to 23/33, which is 
>the one that in my opinion should not be blindly accepted for stable 
>kernels without the agreement of the submitter or maintainer.

But it's not "blindly", right? I've sent this review mail over a week
ago, and if it goes into the queue there will be at least two more
emails going out to the author/maintainers.

During all this time it gets tested by various entities who do things
that go beyond simple boot testing.

I'd argue that the backports we push in the stable tree sometimes get
tested and reviewed better than the commits that land upstream.

-- 
Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
