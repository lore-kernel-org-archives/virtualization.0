Return-Path: <SRS0=Hf4y=FJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888AC433FE
	for <virtualization@archiver.kernel.org>; Sat,  5 Dec 2020 20:59:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACA023110
	for <virtualization@archiver.kernel.org>; Sat,  5 Dec 2020 20:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACA023110
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AFC886868;
	Sat,  5 Dec 2020 20:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHl4qdO0faym; Sat,  5 Dec 2020 20:59:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7254A85EC0;
	Sat,  5 Dec 2020 20:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51AD0C0FA7;
	Sat,  5 Dec 2020 20:59:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD1E7C013B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 20:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A281A876EF
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 20:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qeU7uLbrW0XY
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 20:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 29DC08765F
 for <virtualization@lists.linux-foundation.org>;
 Sat,  5 Dec 2020 20:59:02 +0000 (UTC)
Date: Sat, 5 Dec 2020 15:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607201941;
 bh=74iRxwmFnt99WWNxEo0C+m2cD1/u91IB6ixYgd0wOdM=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z374KlqjZe4kc1SSbgtmFHMGfwkeRIYFWhpyCggp3buV5fZ3gQKevOLwV0PL0AsKz
 DqifZT9toGw7/e8w1JJjGqyPEPCf57Gt2crZKgKjOLwCVwhaYYUTK+YBs9WXPCyBs1
 8ZoKJL+QMOmwBs80astNJFETR4tTsMW911W/kngpuJHFVxyib8G7JNAwQad+46s+oG
 len+BF3J3eDwtuSpOEFe+WLElNxHk6b5RzvMz2i5Q5tVEUQfJFF4Bq6umIUD63Fcgo
 QcZOsE6wdpzD+K5+6GcsTW568xzhrqAjnBxzxs1PYhUa/RX/FuaJA+j77EY5N/8xcG
 lDsicw86itMqw==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <20201205205900.GD643756@sasha-vm>
References: <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <20201130173832.GR643756@sasha-vm>
 <238cbdd1-dabc-d1c1-cff8-c9604a0c9b95@redhat.com>
 <9ec7dff6-d679-ce19-5e77-f7bcb5a63442@oracle.com>
 <4c1b2bc7-cf50-4dcd-bfd4-be07e515de2a@redhat.com>
 <20201130235959.GS643756@sasha-vm>
 <6c49ded5-bd8f-f219-0c51-3500fd751633@redhat.com>
 <20201204154911.GZ643756@sasha-vm>
 <d071d714-3ebd-6929-3f3b-c941cce109f8@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d071d714-3ebd-6929-3f3b-c941cce109f8@redhat.com>
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

On Fri, Dec 04, 2020 at 06:08:13PM +0100, Paolo Bonzini wrote:
>On 04/12/20 16:49, Sasha Levin wrote:
>>On Fri, Dec 04, 2020 at 09:27:28AM +0100, Paolo Bonzini wrote:
>>>On 01/12/20 00:59, Sasha Levin wrote:
>>>>
>>>>It's quite easy to NAK a patch too, just reply saying "no" and it'll be
>>>>dropped (just like this patch was dropped right after your first reply)
>>>>so the burden on maintainers is minimal.
>>>
>>>The maintainers are _already_ marking patches with "Cc: stable".=A0 =

>>>That
>>
>>They're not, though. Some forget, some subsystems don't mark anything,
>>some don't mark it as it's not stable material when it lands in their
>>tree but then it turns out to be one if it sits there for too long.
>
>That means some subsystems will be worse as far as stable release =

>support goes.  That's not a problem:
>
>- some subsystems have people paid to do backports to LTS releases =

>when patches don't apply; others don't, if the patch doesn't apply the =

>bug is simply not fixed in LTS releases

Why not? A warning mail is originated and folks fix those up. I fixed a
whole bunch of these myself for subsystems I'm not "paid" to do so.

>- some subsystems are worse than others even in "normal" releases :)

Agree with that.

>>>(plus backports) is where the burden on maintainers should start =

>>>and end.=A0 I don't see the need to second guess them.
>>
>>This is similar to describing our CI infrastructure as "second
>>guessing": why are we second guessing authors and maintainers who are
>>obviously doing the right thing by testing their patches and reporting
>>issues to them?
>
>No, it's not the same.  CI helps finding bugs before you have to waste =

>time spending bisecting regressions across thousands of commits.  The =

>lack of stable tags _can_ certainly be a problem, but it solves itself =

>sooner or later when people upgrade their kernel.

If just waiting with fixing issues is ok until a user might "eventually"
upgrade is acceptable then why bother with a stable tree to begin with?

-- =

Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
