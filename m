Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC0BC0015E
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 15:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D1BB405AF;
	Thu, 13 Jul 2023 15:50:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D1BB405AF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=B4SXyn6r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id klh0nbyteiqs; Thu, 13 Jul 2023 15:50:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F8D44174E;
	Thu, 13 Jul 2023 15:50:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F8D44174E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD1D5C0072;
	Thu, 13 Jul 2023 15:50:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 611CAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C0A583CA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:50:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C0A583CA1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=B4SXyn6r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EzCsyiWLC-xQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:50:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56C8383C9F
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56C8383C9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 15:50:27 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id B01B828012A;
 Thu, 13 Jul 2023 17:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1689263424;
 bh=OLJU3SR6cRiJ6OsOAtXZ0G0weObZUi+vKis4ETdMDq8=;
 h=Date:From:To:Cc:Subject:From;
 b=B4SXyn6rxFd9d9kM1MadPeDKBKhPsBYAaoYXWfrO24UOMnxYJZSd/JdEWiVrU9STk
 TQWp1IETI7NzkBQUbpqMHlVfoLmfcvfm9HQuBoWWER/Or3nOyDgjZPsDDtQVuBGgFl
 vlcNpvTH8qWvk6rQUTSeb42TMNSFpH2w5Uo84C21EMvqYgZJFZ2RU9wAXZ3oJsEKnr
 OxW6kfRZ5/jzZ9q950rQO7Cmr1e95nwjWl9NzxJc490KUryPqLUDT7sNZZ2Pxdo+dk
 RcWLY9RE6euw49DkQc7eRezkLnh5Mvgc0yyCTDgemVYtQwZ/JOfvLxpoXOygfBdrTm
 z2a7cX+z2BGEg==
Date: Thu, 13 Jul 2023 17:50:23 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-sgx@vger.kernel.org
Subject: [CfP] Confidential Computing Microconference @ LPC 2023
Message-ID: <ZLAdPyqn8glGgYjT@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

We are pleased to announce the call for presentations for this years
Confidential Computing MC at the Linux Plumbers Conference.

In this microconference we want to discuss ongoing developments around
Linux support for memory encryption and support for confidential
computing in general.

Topics of interest include:

	* Support for unaccepted memory

	* Attestation workflows

	* Confidential Computing threat model

	* Secure VM Service module (SVSM) and paravisor architecture and implementation

	* Live migration of confidential virtual machines

	* ARM64 Confidential Computing

	* RISC-V CoVE

	* Secure IO and device attestation

	* Intel TDX Connect

	* AMD SEV-TIO

Please use the LPC CfP process to submit your proposals. Submissions can
be made via

	https://lpc.events/event/17/abstracts/

Make sure to select "Confidential Computing MC" as the track and submit
your session proposal by August 25th. Submissions made after that date
can not be included into the microconference.

Looking forward to seeing all of you in Richmond, Virginia in November!

Thanks,

	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
