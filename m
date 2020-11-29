Return-Path: <SRS0=PU37=FD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E814C3E8C5
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 21:06:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187E62078D
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 21:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN3AY0vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187E62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EBF2862FB;
	Sun, 29 Nov 2020 21:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKNFqj1smBJm; Sun, 29 Nov 2020 21:06:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 61E6D862EC;
	Sun, 29 Nov 2020 21:06:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC8AC163C;
	Sun, 29 Nov 2020 21:06:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EF9C0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 21:06:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C87B42049D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 21:06:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PriA3w-rQjFs
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 21:06:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D4EB2047C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 21:06:52 +0000 (UTC)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6F7220757;
 Sun, 29 Nov 2020 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606684012;
 bh=Hl+Yto9GomcGVi/UwqRwnPVmA6LiDPHsQ53LHLdabm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hN3AY0vwAvQ+nCH0zXWRe2bBjvNgGLJ8mlzqYvlqwZJNIELR2VYnbkMaYS8q+7x+1
 WSSaYJIWITRQuA+NHH/9ZEBPXOl0CB9aPs3W15SPwkZ9h8XXNygjwzTJw4N6g+r3du
 /cAVWRYjBGVNWQhn5WOW6iEWf0NAhbgDIfVyzNGs=
Date: Sun, 29 Nov 2020 16:06:50 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <20201129210650.GP643756@sasha-vm>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Nov 29, 2020 at 06:34:01PM +0100, Paolo Bonzini wrote:
>On 29/11/20 05:13, Sasha Levin wrote:
>>>Which doesn't seem to be suitable for stable either...=A0 Patch 3/5 =

>>>in
>>
>>Why not? It was sent as a fix to Linus.
>
>Dunno, 120 lines of new code?  Even if it's okay for an rc, I don't =

>see why it is would be backported to stable releases and release it =

>without any kind of testing.  Maybe for 5.9 the chances of breaking =


Lines of code is not everything. If you think that this needs additional
testing then that's fine and we can drop it, but not picking up a fix
just because it's 120 lines is not something we'd do.

>things are low, but stuff like locking rules might have changed since =

>older releases like 5.4 or 4.19.  The autoselection bot does not know =

>that, it basically crosses fingers that these larger-scale changes =

>cause the patches not to apply or compile anymore.

Plus all the testing we have for the stable trees, yes. It goes beyond
just compiling at this point.

Your very own co-workers (https://cki-project.org/) are pushing hard on
this effort around stable kernel testing, and statements like these
aren't helping anyone.

If on the other hand, you'd like to see specific KVM/virtio/etc tests as
part of the stable release process, we should all work together to make
sure they're included in the current test suite.

>Maybe it's just me, but the whole "autoselect stable patches" and =

>release them is very suspicious.  You are basically crossing fingers =


Historically autoselected patches were later fixed/reverted at a lower
ratio than patches tagged with a stable tag. I *think* that it's because
they get a longer review cycle than some of the stable tagged patches.

>and are ready to release any kind of untested crap, because you do not =

>trust maintainers of marking stable patches right.  Only then, when a =


It's not that I don't trust - some folks forget, or not realize that
something should go in stable. We're all humans. This is to complement
the work done by maintainers, not replace it.

>backport is broken, it's maintainers who get the blame and have to fix =

>it.

What blame? Who's blaming who?

>Personally I don't care because I have asked you to opt KVM out of =

>autoselection, but this is the opposite of what Greg brags about when =

>he touts the virtues of the upstream stable process over vendor =

>kernels.

What, that we try and include all fixes rather than the ones I'm paid to
pick up?

If you have a vendor you pay $$$ to, then yes - you're probably better
off with a vendor kernel. This is actually in line (I think) with Greg's
views on this
(http://kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/).

-- =

Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
