Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD8C64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 13:28:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124A120727
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iy6VsNPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124A120727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 85FCA228AE;
	Mon, 30 Nov 2020 13:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gTqMrbWoRJvz; Mon, 30 Nov 2020 13:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7259822882;
	Mon, 30 Nov 2020 13:28:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52FCEC0859;
	Mon, 30 Nov 2020 13:28:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAFB4C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D0272872A3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D2t96Bsyqnly
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:28:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4950987287
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 13:28:31 +0000 (UTC)
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B0B8120643;
 Mon, 30 Nov 2020 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606742910;
 bh=DQ+wSsfzzJvTpM5c/TAOzAqu4JhPI6Qw2CdCl7s9bnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iy6VsNPZIpqRMHbzHaZf4KAofuWIQmOzOyJdKPIJ3nmFXEOjDhBNETct6pTPa7KZa
 349/iqZtmBD+ozP3DeMiZdmAICZq9sXO/WuEaHhDd3HI4GtlOgDKPZQmN7vCK/BjbU
 GAUTn3NWGsgfMFU5RRd+CLK8/UccbsHngseKQN3M=
Date: Mon, 30 Nov 2020 14:28:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <X8TzeoIlR3G5awC6@kroah.com>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 30, 2020 at 09:33:46AM +0100, Paolo Bonzini wrote:
> On 29/11/20 22:06, Sasha Levin wrote:
> > On Sun, Nov 29, 2020 at 06:34:01PM +0100, Paolo Bonzini wrote:
> > > On 29/11/20 05:13, Sasha Levin wrote:
> > > > > Which doesn't seem to be suitable for stable either...=A0 Patch 3=
/5 in
> > > > =

> > > > Why not? It was sent as a fix to Linus.
> > > =

> > > Dunno, 120 lines of new code?=A0 Even if it's okay for an rc, I don't
> > > see why it is would be backported to stable releases and release it
> > > without any kind of testing.=A0 Maybe for 5.9 the chances of breaking
> > =

> > Lines of code is not everything. If you think that this needs additional
> > testing then that's fine and we can drop it, but not picking up a fix
> > just because it's 120 lines is not something we'd do.
> =

> Starting with the first two steps in stable-kernel-rules.rst:
> =

> Rules on what kind of patches are accepted, and which ones are not, into =
the
> "-stable" tree:
> =

>  - It must be obviously correct and tested.
>  - It cannot be bigger than 100 lines, with context.

We do obviously take patches that are bigger than 100 lines, as there
are always exceptions to the rules here.  Look at all of the
spectre/meltdown patches as one such example.  Should we refuse a patch
just because it fixes a real issue yet is 101 lines long?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
