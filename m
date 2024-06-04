Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8942B9BF
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513020; cv=none; b=XWeF17Lk3t2ef66sObPLqH+Kw6RehVpodA4N02WrbLq78HDn8INvR2TXXbq+2aoMTHhYaKY66ct2jV91bcw4P21PNrkJ97EYhVDSZGg5rD5s44+zSNe6jXixpRbj62o2qlCq51IMLHcSfpFBQF9tgS+YYBSexTSFaWPgpOBZ6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513020; c=relaxed/simple;
	bh=LANm07rXulL9ApxBvdsMiKVZhbidRpa5Qu4jlOZvGHk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H7F2YkZ5VuBRalx8t1hRtrqh3JjooP+OrvbkuRUIsBHdK4v99lCaio9Vd2xK+gOzK8Z70YXEOOg0oUYMn8mO22K+uOqqeJS0xdesOvFaMBUPzKYz2lDv/aKtOTG0Ol5O39/8s3f8Z1/bREzuQxCr3VyX13wElwDSMICqrWHaqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FzrN1Kds; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FzrN1Kds"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 860FE61096
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 14:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y2r2of660lqA for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jun 2024 14:56:57 +0000 (UTC)
X-Greylist: delayed 514 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 04 Jun 2024 14:56:57 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 654BF61095
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=8bytes.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 654BF61095
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=FzrN1Kds
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=<UNKNOWN> 
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by smtp3.osuosl.org (Postfix) with ESMTP id 654BF61095
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 14:56:56 +0000 (UTC)
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 223171C78B6;
	Tue,  4 Jun 2024 16:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717512605;
	bh=LANm07rXulL9ApxBvdsMiKVZhbidRpa5Qu4jlOZvGHk=;
	h=Date:From:To:Cc:Subject:From;
	b=FzrN1Kds631zTIBTSz4dBpVeMvB1pGtIFg7wcRSE572DTLpCGo1I8Bj6AZ9vvsWIr
	 oBxmB9CutBlPmcRQGSTAN/w2BC0If+ofJfZxFcrBOuPx6tyK4i/kgYkxf9W4hru/sW
	 dhlh4t+EoIeKgfslE+b4dAFf5Tl2MDKgAyzMSahRVsqVMD5OUF21VqjOP7BxU6vvn9
	 gLtG1JVMEoZHA30XRr4WZoy5+ySFZMv7zxP3cJQY5d2RZvJ+FaIsyj11h5rwcK9twz
	 qX6jkBbOSXoZFVpPnSG8yHDwfdSAhdG+GTW9CG5LYIepxfbKWasWTaXvPXeG1P18qC
	 4jifFXXMXHMgA==
Date: Tue, 4 Jun 2024 16:50:04 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	kvm@vger.kernel.org, linux-sgx@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Subject: [CfP] Confidential Computing Microconference @ LPC 2024
Message-ID: <Zl8pnPS8EVgFgxSR@8bytes.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are pleased to announce the call for presentations for the
Confidential Computing microconference at the Linux Plumbers Conference,
happening in Vienna from September 18th to 20th.

In this microconference we want to discuss ongoing developments around Linux
support for memory encryption and confidential computing in general.

Topics of interest include:


	* Support TEE privilege separation extensions (TDX partitioning and AMD
	  SEV-SNP VM Privilege Levels) both on the guest and host side.

	* Secure IRQ delivery

	* Secure VM Service Module (SVSM) support for multiple TEE architectures

	* Trusted I/O software architecture

	* Live migration of confidential virtual machines

	* Remote attestation architectures

	* Deployment of Confidential VMs

	* Linux as a CVM operating system across hypervisors

	* Unification of various confidential computing API

Please use the LPC CfP process to submit your proposals. Submissions can
be made via

	https://lpc.events/event/18/abstracts/

Make sure to select "Confidential Computing MC" as the track and submit
your session proposal by July 15th. Submissions made after that date
can not be included into the microconference.

Looking forward to seeing all of you in Vienna in September!

Thanks,

	Dhaval and Joerg

