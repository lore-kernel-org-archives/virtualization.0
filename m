Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6D846D
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513020; cv=none; b=i+917EOLOqExWIvko7Js4Or6kCiW3jL/iSCmWvN/OcJ3UKsDseIEmrM98bHmVqUY+ZkTwfVcwqQVMt+leYMdIuDaVvT0G7rYhtOjqVdWmmtUEoHVlXI7roTXKqb6dkxoU8iPxTrMZFzXcFB8OYCDSggtlIsqbj/K60o0rAKK+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513020; c=relaxed/simple;
	bh=X3pKUNEhyy4JUdYuNYNPC1vPFLR4XD7NwElEq41qojE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AC0KULyN1tqOPlzq8aQrIGoqORjET5fChc5WZm8dQAgN6ytStjFfTSLJLUcwoQDlTxPqpZuMkhh+yiPG8YvtTeiqO5WXCSrYCowCJyGH2031fT2eSvrcadHu/nITejli0uNdve1nnd/eq1OHlXO425LDukkSJX2sce4KJ+LsiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=NtkODWDF; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="NtkODWDF"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AD0041811
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 14:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0g2iETaqHhD for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jun 2024 14:56:57 +0000 (UTC)
X-Greylist: delayed 512 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 04 Jun 2024 14:56:57 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 55D6841800
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=8bytes.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 55D6841800
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=NtkODWDF
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.214.250.239; helo=mail.8bytes.org; envelope-from=joro@8bytes.org; receiver=<UNKNOWN> 
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55D6841800
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Jun 2024 14:56:56 +0000 (UTC)
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 92CD91C7728;
	Tue,  4 Jun 2024 16:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717512500;
	bh=X3pKUNEhyy4JUdYuNYNPC1vPFLR4XD7NwElEq41qojE=;
	h=Date:From:To:Cc:Subject:From;
	b=NtkODWDFp0kt1/YXItVWHnU7VGECbhhGtzzSxqe7BjnkAV16A3BIUmxyGMFRSN9h0
	 1TDdu5SzS5Ac2L1bjH6eSId5R903k9ajJ68Bk4Vb2dM4KjQ4bTqsLDkNuhHnKRT809
	 b5OmARNUfa435onkqtnGkTCcWUaDnEyZcGtSTmG2VeYz/wsJkwTjwfuXuFeDtSGvM6
	 C52vf0YkMFcjDA9BVfUzQTJcMPiXeBijj3oCvPoOT3kLt16Vvwyh0k/OXI67D2Xfp4
	 CMu74rCdsNtju3Fw7w9vmdJ+/QEpL+6p6O9ae0QeFuKucCnQjcvY1kRJWhuR5kmiE6
	 eMe3zomKdtfZw==
Date: Tue, 4 Jun 2024 16:48:19 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	kvm@vger.kernel.org, linux-sgx@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: Dhaval Giani <dhaval.giani@gmail.com>
Subject: Call for Registration - Confidential Computing Microconference @ LPC
 2024
Message-ID: <Zl8pM8aDDT10oqmd@8bytes.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are pleased to announce that the Confidential Computing Microconference has
been accepted into this years Linux Plumbers Conference, happening from
September 18th to 20th in Vienna, Austria.

With this Call for Registration we want to encourage everyone interested in
this microconference to register for LPC soon and select the Confidential
Computing among the microconferences you plan to attend.

This is important because, due to the high number of accepted
microconferences, the LPC Planing Committee did not decide yet which
microconferences will get a 3 hour vs a 1.5 hour time slot. The more
people express their interest, the better our chances for a longer time
slot.

A Call for Presentations will be sent out shortly in a separate email.

Hope to see you all there!


	Dhaval and Joerg
