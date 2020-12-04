Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AABC433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 15:49:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8473F22C7D
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 15:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8473F22C7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 312072E2E0;
	Fri,  4 Dec 2020 15:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2k8GSxdOiyjJ; Fri,  4 Dec 2020 15:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C46A6204C6;
	Fri,  4 Dec 2020 15:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A158FC0FA7;
	Fri,  4 Dec 2020 15:49:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDFA2C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 15:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A3E6B873E6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 15:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fz0PJXwuGu66
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 15:49:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 20F478730D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 15:49:13 +0000 (UTC)
Date: Fri, 4 Dec 2020 10:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607096952;
 bh=Ow4G56Wm/9Nfwmkt+etIYtnevqjnp+bk9nlnFoU8UQk=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=RQjC41VglvvhGwAWU6XRMSSSMnzpp3JOxd1JNCylOQy/kEvUZ/ewOpyE/wOqQW/7j
 878hxCTLNSyKUEwvhP2o5iMZhV6F/W385j25+TYB/QZlSyrDcFDoYe0rgky3hMcZ/P
 Nspyf5ZojFO6emRkgFk9EeTs/eGl6Km4CtSDUo55DCdJh1xlIRobP9bnqaHpnGlsvQ
 4TMZgz2q7uNKvG3exf/XFGcNg+7tXIby71tbnOypYg4j4+erSHdVGjPaDmkBXDFxXN
 ICWQyjSwysK+pQXANGOHy6hLAsiPnYnR3u4UiD59Fj+QIoSr52SNzsJ+5WH4vYhD2/
 XjdW17iIoYZ9Q==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <20201204154911.GZ643756@sasha-vm>
References: <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <20201130173832.GR643756@sasha-vm>
 <238cbdd1-dabc-d1c1-cff8-c9604a0c9b95@redhat.com>
 <9ec7dff6-d679-ce19-5e77-f7bcb5a63442@oracle.com>
 <4c1b2bc7-cf50-4dcd-bfd4-be07e515de2a@redhat.com>
 <20201130235959.GS643756@sasha-vm>
 <6c49ded5-bd8f-f219-0c51-3500fd751633@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c49ded5-bd8f-f219-0c51-3500fd751633@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Dec 04, 2020 at 09:27:28AM +0100, Paolo Bonzini wrote:
>On 01/12/20 00:59, Sasha Levin wrote:
>>
>>It's quite easy to NAK a patch too, just reply saying "no" and it'll be
>>dropped (just like this patch was dropped right after your first reply)
>>so the burden on maintainers is minimal.
>
>The maintainers are _already_ marking patches with "Cc: stable".  That 

They're not, though. Some forget, some subsystems don't mark anything,
some don't mark it as it's not stable material when it lands in their
tree but then it turns out to be one if it sits there for too long.

>(plus backports) is where the burden on maintainers should start and 
>end.  I don't see the need to second guess them.

This is similar to describing our CI infrastructure as "second
guessing": why are we second guessing authors and maintainers who are
obviously doing the right thing by testing their patches and reporting
issues to them?

Are you saying that you have always gotten stable tags right? never
missed a stable tag where one should go?

-- 
Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
