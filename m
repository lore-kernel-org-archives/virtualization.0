Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FA2D47F1
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Aug 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937034; cv=none; b=hT3jWFtXhOzw6ilanLgznv06TshkEKtlEd4Uxg9LL1Ue4FhppWELqAazJiCvhpxA8z/t3XKdfn9IFVwdSbPXOUGHgUU4RKX4D173cj9I8QAN2W/j73RYnJr5iplX2iAyVkGD2IX4yxU9Jsy4EmGXvk2CawNg+HAN77vI6WDzo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937034; c=relaxed/simple;
	bh=SvPZlqXRWngt1utHyAUTnrl/jVOB9D2tqo++t5yz1aY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eLpmlPYPvKvIEgKgsrAL7hj9AOqlQg1A9rHNyOX+uADfPQIaPTSjID4nT1WNSoag2PJBUjVLshkBFro33j5Xtz1dIA41ve8CfVqA4VNRSyaAnnH43jUPuk8nhr0bIj6SLlXUY0OrCtlqiLolLwHtwDQGaGYQsMzmLS4Le5u0yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JbiXTDGE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JbiXTDGE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E272840D13
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Aug 2025 18:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -3.892
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZByzwdntXeVf for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Aug 2025 18:30:31 +0000 (UTC)
X-Greylist: delayed 553 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 11 Aug 2025 18:30:30 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B9C24409EA
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=8bytes.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9C24409EA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=JbiXTDGE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=<UNKNOWN> 
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9C24409EA
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Aug 2025 18:30:30 +0000 (UTC)
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3233B473D0;
	Mon, 11 Aug 2025 20:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1754936473;
	bh=SvPZlqXRWngt1utHyAUTnrl/jVOB9D2tqo++t5yz1aY=;
	h=Date:From:To:Cc:Subject:From;
	b=JbiXTDGEuSq+AOUV4o4PsNQ3+J6W+PQVn/CIT1q2IPHcInJKM398cNvcLz50fuPmX
	 voYaFt4om+GrZU0hopvOvqSeqpj4A68jsOvuU2PKfUdcusc4vppMwMIoiul4lTV/j5
	 Tw4OdnjEQpdVCQuOjqKqKtXs+Q/on2CsAGrdsEJZCVFOHG/HMpL97xwaXiLKUdKV3t
	 VI2/qEC+JPxesSGX2loC/74XdYS4Sk4iYf6AxQwWvlV+ig/Y8qOWTKVHwKQrAO/tE5
	 j8e4J28oKeLj1oz8P+kIwBnzH+ukMyPLVCcFIP/tshoVicYQEdSLK2M2cYS+0t0P9I
	 HLbuNy2Okg6Pw==
Date: Mon, 11 Aug 2025 20:21:12 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev, 
	kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Subject: [CfP] Confidential Computing Microconference @ LPC 2025
Message-ID: <hbvvob7wwgymmg3hts3gdpr6jygzhlht4yq57riewryd6oulva@jpzuxrvljzb5>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are pleased to announce the call for presentations for the Confidential
Computing microconference at the Linux Plumbers Conference, happening in Tokyo,
Japan from December 11 to 13, 2025.

In this microconference we want to discuss ongoing developments around Linux
support for memory encryption and confidential computing in general.

	- Support for large-page backing of confidential virtual machines
	  (CVM).
	- Privilege separation features in KVM via VM planes.
	- Live migration of CVMs.
	- Secure VM Service Module architecture and Linux support.
	- Trusted I/O software architecture.
	- Further topics to discuss are:
	- Possible solutions for the full CVM (remote) attestation problem.
	- Linux as a CVM operating system across hypervisors.
	- Performance of CVMs.

Please use the LPC CfP process to submit your proposals. Submissions can be
made via

	https://lpc.events/event/19/abstracts/

Make sure to select "Confidential Computing MC" as the track and submit your
session proposal by September 30th. Submissions made after that date can not be
included into the microconference.

Looking forward to seeing all of you in Tokyo in December!

Thanks,

	Dhaval and Joerg

