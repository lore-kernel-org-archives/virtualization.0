Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DB28DB7D
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559281; cv=none; b=F6ysR0yDEPAWgzdiYeDJ3FXBgzkqy/3sIKOLciOM3U/Z2+FdeJi8qta2QJ4jjIUntPxto2k/34s5/WN+Ca9AeefZxLnpPr4vyYkmHORB62wR1UFqGoLm/d+RJ9+xj1L31wm5IHsZTq2X9Ourx3CupsN+xtkQ2I5uh0JDsVGOXrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559281; c=relaxed/simple;
	bh=Wki+VY2IBB2XV1fDbrHqUrdvw11dlFArO8xAq3cYY3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bDD7lFO+cveyDUfZf4AndN2Yyz+g8RS4mz/ctZE4RINVFH3yYtzWsPiuz8SM4Qcfun+4PbzVLpcqJsb8XTclCgD0pKR/61/mQZS3zXWaMvl8J0g6NTsbPj3x81rgd0F5aDITh9ps2mNdtTypEkKz+w8eji3KVgGFOibWmSHHojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ldy.ooguy.com header.i=offices@ldy.ooguy.com header.b=V/AucTtq; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ldy.ooguy.com header.i=offices@ldy.ooguy.com header.b="V/AucTtq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EA6A60693
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.992
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANK502eu1Xf0 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 12:41:19 +0000 (UTC)
X-Greylist: delayed 604 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 10 Jun 2025 12:41:19 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 234BA60669
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=ldy.ooguy.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 234BA60669
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=ldy.ooguy.com header.i=offices@ldy.ooguy.com header.a=rsa-sha1 header.s=default header.b=V/AucTtq
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.110.50.200; helo=mta0.ldy.ooguy.com; envelope-from=offices@ldy.ooguy.com; receiver=<UNKNOWN> 
Received: from mta0.ldy.ooguy.com (mta0.ldy.ooguy.com [79.110.50.200])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 234BA60669
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=ldy.ooguy.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=offices@ldy.ooguy.com;
 bh=bfOlHcLeXvHZXdro2GFDTR/G6Ms=;
 b=V/AucTtqOcq7NBC6S2B7Vr/toJj1hB+N3D45HzOvkXD85AYcQceZ7KHAeXT7XJ0x+qp3nVxc6pbM
   FyuaUq42NtgacTbV3XmS0qoNtraahGtBiO6Uqd/4EE0pg7Hoa5586ptaSTFaQtFg+M6xTWnOnr6P
   RfVKGW1HGsZMUaIeQ6U=
Reply-To: vendors@servicesetihadaviation.com
From: "Etihad Aviation Groupl" <offices@ldy.ooguy.com>
To: virtualization@lists.linux-foundation.org
Subject: Re:Confirm if  Interested
Date: 10 Jun 2025 07:31:11 -0500
Message-ID: <20250610073110.C8906DD5BFA745FD@ldy.ooguy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear Vendor,

We are excited to invite your company to register as a potential=20
vendor for Etihad Aviation Group (EAG)
We are seeking reliable and quality-driven vendors to support our=20
growth.

How to Register:
Kindly express your interest by requesting  for the Vendor=20
Questionnaire and EOI.

Thank you for your interest in partnering with us.

Regards=20
Mr. Anthony Miller
Contractors Coordinator
Email:vendors@servicesetihadaviation.com
Group Procurement & Contracts Shared Services Center
