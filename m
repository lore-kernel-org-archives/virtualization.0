Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03CBC25B08
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 13:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 892DC40BB0;
	Wed, 17 Aug 2022 13:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 892DC40BB0
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CcDgHmLI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqdR1x5U8ngr; Wed, 17 Aug 2022 13:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 19968409EE;
	Wed, 17 Aug 2022 13:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19968409EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5EF8C0035;
	Wed, 17 Aug 2022 13:48:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8806BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 13:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56CE9409F8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 13:48:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56CE9409F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cg1w-yPuZSi3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 13:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8021F409EE
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8021F409EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 13:48:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C9BA46142E;
 Wed, 17 Aug 2022 13:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6715C433C1;
 Wed, 17 Aug 2022 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660744108;
 bh=oY072z80Whl/TUmfEqOyp7S4ZsatcvmMePOWmEYF/S8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CcDgHmLIV4tCGEyoJrzSBdurHpYWl9R6XeREsD6lPC0w71gTtjgqU1vGAl+jGsSzt
 0KXdk07balqqyaUc7wrZ3apURgh2lqjAAi8CcfJ7Njp4HljGNcdKYBIF83KKHhq/gX
 UD4RdhsxHsb/2YtbtEFNOttwJEb4Quor0tOTcF9Wa7/eO7nefXJE4e6pE7PalqFN8c
 kLiErlxkEJ9lZL1a/+GzYyiasaok7R/OJRMxcRxXXjVmwJRSdD8beiETSpxCUedA54
 DGmhZtfETu6jo6G6LzHgA1RTRltifmC0eYRMUjZxs3QPviZZPDsiXDBh+Be+kwZ8rJ
 RThzudAdbiD6A==
Date: Wed, 17 Aug 2022 14:48:22 +0100
From: Will Deacon <will@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220817134821.GA12615@willie-the-truck>
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
 <20220808101850.GA31984@willie-the-truck>
 <20220808083958-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808083958-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jiyong@google.com, kvm@vger.kernel.org, kernel-team@android.com,
 maz@kernel.org, keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, crosvm-dev@chromium.org, torvalds@linux-foundation.org
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

On Mon, Aug 08, 2022 at 08:45:48AM -0400, Michael S. Tsirkin wrote:
> > > Also yes, I think it's a good idea to change crosvm anyway.  While the
> > > work around I describe might make sense upstream I don't think it's a
> > > reasonable thing to do in stable kernels.
> > > I think I'll prepare a patch documenting the legal vhost features
> > > as a 1st step even though crosvm is rust so it's not importing
> > > the header directly, right?
> > 
> > Documentation is a good idea regardless, so thanks for that. Even though
> > crosvm has its own bindings for the vhost ioctl()s, the documentation
> > can be reference or duplicated once it's available in the kernel headers.
> > 
> So for crosvm change, I will post the documentation change and
> you guys can discuss?

FYI, the crosvm patch is merged here:

https://github.com/google/crosvm/commit/4e7d00be2e135b0a2d964320ea4276e5d896f426

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
