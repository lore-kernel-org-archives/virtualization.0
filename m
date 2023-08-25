Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E299C3DA66
	for <virtualization@archiver.kernel.org>; Fri, 25 Aug 2023 13:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A04E041F41;
	Fri, 25 Aug 2023 13:25:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A04E041F41
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=jcGWQkTd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6J9JoCRHYQNb; Fri, 25 Aug 2023 13:25:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E513341EA2;
	Fri, 25 Aug 2023 13:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E513341EA2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ABBEC0071;
	Fri, 25 Aug 2023 13:25:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97037C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Aug 2023 13:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BB1D4049F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Aug 2023 13:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6BB1D4049F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=jcGWQkTd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oSiX9VhD85aZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Aug 2023 13:25:53 +0000 (UTC)
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9564D402E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Aug 2023 13:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9564D402E0
Received: from 8bytes.org (pd9fe95be.dip0.t-ipconnect.de [217.254.149.190])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 6AD2C2659D3;
 Fri, 25 Aug 2023 15:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1692969392;
 bh=nIJIcDHCndV6RMR52sBlpXdKyenjgdoQvcGfHbdVufI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jcGWQkTdA+AdnfpIQpjrlpuJb28zPJrt4Avl8XWWYPUEmo5VFOYLYvEM7KkYhdSp5
 VsErLvWdj+4wEeH1fcbJQS6VPwYscLzFjSotj9uEYoCBI6qbKkHwYpjZ5EO4q7nLHv
 ldOJJoL/scasqRq5XfT2bAO46758V/GZi1dH0vdXZQIw4IV88v2bUT1DKeusWrWX8x
 PbB2dZrWjtkn7p7gPJaOcL4nimTy4HVHqicnFbvEJhgfX3lrTJKVLI9u4Q9Nb93YN9
 TJuyk1ouwIo3KDz+jbeUzXgIQWGK/AqX0YUASA0G8Uur2m8FDgvAQj06W1qTQzPASd
 5FXCZZQQHzAcw==
Date: Fri, 25 Aug 2023 15:16:31 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-sgx@vger.kernel.org
Subject: Re: [CfP] Confidential Computing Microconference @ LPC 2023
Message-ID: <ZOiprzq_cPmcnyX_@8bytes.org>
References: <ZLAdPyqn8glGgYjT@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZLAdPyqn8glGgYjT@8bytes.org>
Cc: Dhaval Giani <dhaval.giani@gmail.com>
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

On Thu, Jul 13, 2023 at 05:50:23PM +0200, J=F6rg R=F6del wrote:
> Make sure to select "Confidential Computing MC" as the track and submit
> your session proposal by August 25th. Submissions made after that date
> can not be included into the microconference.

Given the relaxed timing requirements we are happy to extend the CfP
period to September 25th. There are quite a few submissions already, but
the schedule begins to fill up. So feel motivated to get your proposals
in quickly :-)

In case you need to apply for a visa to enter the US and are not
registered yet, please let us know by September 15th. We will try our
best to get you registered so that there is enough time left for the
visa process.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
