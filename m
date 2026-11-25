Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795641692;
	b=HkkFbL0EwQbRXICvrhBaC33hA3/i9XVy6eDPgajDqHGGPJs4iCYIDeJEBY+3isUEeVm6
	 hNEtR2QeqjmhiVFZ96r/yFAiURHVrBVA/hOCfsvL4Qc2W8GimtP4PWOVh/3XrHVLkXch7
	 rNdk39CxrRfqkRFwGj8PdgDpKv696w97QRzfKZroQZPzZBqWJ1nN2sDIkb0PI9c9SAAI2
	 QqPrIVXuu0EfYVj7207XIxgE/Be4TPN+rtQOi9wC/ceP6I1IxyOdcPVZWLEXMLgJhRM6A
	 S/c1NrjSPisffPzmcosaCpLm1amr2MeYFBL9k1k5wtsEcvtNHledy5qiLzFWvfKxRYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641692;
	h=Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vfLZQumhvisvpmzurTjKPkeiD17r56G5HfxylZWgS5c=;
	b=hcaGMme7v9XtVSR4bliKT1HJXLwDmIAt7nok2+xvDJEDHR2NfDdeLFrBIckTy3tfGEi8
	 Ef+YDNUYQzhiEnHoXmCXivwmQpDWjeIPzDHlUaP7R94fKmDSslScvQdAYsq0/rXsDioYi
	 tt9OtmN0kIdIbe1NGJRHzi5qREn1hJ0IMuEpF6dd8K2h+RFayBPdLfyNw7SZeEG2ZlkYi
	 wLavLKrMJyzWrYRaJQftikKVDCjETI9UWl9ZvCQW/BRgWkN4bhn6VYDKC9KTuEf/KN9C8
	 jqe/PEJCpyUlwwJghrU0nqUhwjtL/ECyH/BzmxytroXHzQcDHKkvfNCf0FR0XSJTyIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="K6HH/md3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.136
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215D606A333
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=K6HH/md3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAFE1606A0
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 21:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.35
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppYMEWlFJh8S for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2026 21:21:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95D266069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795641690;
	b=RW9NaT3xEWjuZknCiJ2tBB88rzUzb003JE89YdResRh2ir65i5VUVvH1itGrfhkxEt03
	 JhpLGIHnlojLmKStggW+4Q9XSbXEhWJMnJysl1rjWepIV1p4yCimMYrQicuOvdV1wiTly
	 jS+hxajbIaozbZFf9FdXap6MSQVHULQjAqZEdBhYCZ2C/KwJrdMLti21AKoB+rodGwuDb
	 /9hkVy8/aijG8Ov8EvOhS+2hgANZrMLDRhFH/RUViDCW9C/u8Q2CspGTczQAYd/WKdIDG
	 9tSow3RGUp694aXyWEr1EJCQS+50cRKBof/Qn31qmHOjLI9AayFv+xM8ywQPupYubig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795641690;
	h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=vfLZQumhvisvpmzurTjKPkeiD17r56G5HfxylZWgS5c=;
	b=no/0/xxj3ec7YXvF/dcDKGSS0zXdepxq0jWSXXnx1CZY+k5WNm0oHAgQsJcZ7M9vjOlB
	 I9Fkwdm/NsU+LDGEHDQksTpVNrwTRAwEJ1aWYhR9HdtB5oJ5CwI+tPZrxycUqKEAqFQ3J
	 rFcz+NBT5OJJPnaq9rrSZbFKaAn4NsMffET4Tad1kxAtkplccBwnTdzEpiXvBtGku35KA
	 5lZo6LfL6+0EGo5hhCO0ZDEIIDneh9vE7P4dOwK1H4c/Ar9da7kkcwlM91H+2MBYgtKPt
	 By/j4a6M8L2IuXVt7O6JyRsJMQr11+m8hF7v4UPzkgdtV5wbbTSn71c2+Es9b1x8QPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b="K6HH/md3";
	arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45; helo=mail-06.mail-europe.com; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=K6HH/md3
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95D266069A
	for <virtualization@lists.linux-foundation.org>; Wed, 25 Nov 2026 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1795641671; x=1795900871;
	bh=vfLZQumhvisvpmzurTjKPkeiD17r56G5HfxylZWgS5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K6HH/md3pBKFeCn6smvdxo3PrAftyS8IW5f6xh7qv2uIyYwqd0JUpPVm+2xPbYHM6
	 Qt4RHM9I1ScB7leWfeEwOKuycQI14m1Yu27mEK32Pwav3AvcUs/F4gOiv8qf16nDYT
	 gV9QP4ML4lQI3mOQoHb4nLKK4SydwrwztGVv3R6P4/cbx+w8hpdEnDe2TURO5ESzXl
	 Ug7mnZv6y4G0sb0p9JoiOTLBP6e9CH3eI5c4IGE4L+pEwdlgGruVSx1yRIC3r0XC0Y
	 RIsWJOZv9uQomc20hXludvz8FgWNuU852aG+w/saQZVLOh7zl1hzkkOzTLO8UjcAF7
	 F26BT1Tv0vmAQ==
Date: Wed, 25 Nov 2026 21:21:01 +0000
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: "chenglong.ma" <longpareto@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 2312891301@qq.com, blum@kernel.org, co+6dcbccedc9ec6452@bugs.sh, eperezma@redhat.com, fangxy@xiaopeng.com, jasowangio@gmail.com, kmehltretter@gmail.com, linfeng.sun.dev@gmail.com, lirongqing@baidu.com, oss.patchbox@gmail.com, phx0fer@gmail.com, physicalmtea@gmail.com, sergiiushakov@google.com, shubham@octane.security, stable@vger.kernel.org, stjepan.poljak@gmail.com, syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com, tavhadia@gmail.com, tjdqudcks0424@naver.com, tz2294@columbia.edu, xieyongji@bytedance.com, xmei5@asu.edu, yuz08559@gmail.com, zenghui.yu@linux.dev, zhaimingbing@cmss.chinamobile.com, zhangjiao2@cmss.chinamobile.com
Subject: Re: [GIT PULL] vhost,virtio,vdpa: bugfixes
Message-ID: <s1xGKGqyb3Uk_gDZmeWG7nVEq4_m00HsO9pS1RL3cUnIdr4GMgH5OEBifQIl-30ZdUu7_uUoe-TxhMQd2GuW2sWKzY6UUGSWXKaqMz_XeEE=@1g4.org>
In-Reply-To: <awbTgufgR4Uge1kJ@gremlin>
References: <20261104081535-mutt-send-email-mst@kernel.org> <awWOpS3HR_2FTN3I@gremlin> <20261125060533.1296-1-longpareto@gmail.com> <awbTgufgR4Uge1kJ@gremlin>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 4a2ea5626cc74c6da271abf63e2ead6a3c9e8c0a
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

There appears to be a recurring problem with how previously reported=20
vulnerabilities are being handled in this subsystem.

Yu Zhang publicly reported the VDUSE VA/PA confusion on August 7,=20
including runtime evidence and a proposed fix:

https://lore.kernel.org/r/20260807022657.11318-1-yuz08559@gmail.com

Nearly three months later, bb2e6f166547 was merged with attribution to=20
Claude Code, but without any acknowledgment of Yu's earlier report. As=20
Lorenzo has now pointed out, the accepted patch also breaks the driver's=20
mmap path.

This is particularly concerning given my own experience with the vDPA=20
netlink double-free.

I reported the issue in March, submitted a patch at your request, provided=
=20
runtime evidence, and received repeated assurances that my patch would be=
=20
applied. Nearly eight months later, a different Claude-assisted implementat=
ion=20
was merged instead after I reported it to security list a second time.

I acknowledge that I eventually received a Reported-by tag. That does not e=
xplain=20
why a known and acknowledged memory-safety defect remained unfixed for near=
ly eight=20
months.

I have no objection to the use of AI-assisted development. I do object to a=
 process=20
in which previously submitted security fixes remain unresolved for months, =
only to=20
be replaced by AI-assisted implementations, particularly when those impleme=
ntations=20
introduce regressions that basic functional testing would have caught.

Why was Yu Zhang's earlier report not acknowledged?

And what is being done to ensure that previously reported vulnerabilities a=
re not left=20
unresolved until they are rediscovered?

Thanks,
Paul
