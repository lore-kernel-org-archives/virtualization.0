Received: from cvsmtppost25.nm.naver.com (cvsmtppost25.nm.naver.com [114.111.35.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E739D6FA
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279574; cv=none; b=cQrcDwNxJtypE95A7e8u/V/aOhlgw0Q7sxengcTQQ7XBO2P9KDP8Ohuua/w1MY8EzmaJZsHNIDNhnfdaGT70BvAr3ug6ono0pra3ceHZMjDsgTYEYAsuTTP+vJZeATf+KR7LwWGSfEcQShSHriKMaWC6zuzsSFX/CNT0piaOOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279574; c=relaxed/simple;
	bh=hv3YkMknznKDrsXSimNXNHCUepDX0g8wBzpKCmfDKCM=;
	h=MIME-Version:Message-ID:Date:From:In-Reply-To:References:To:Cc:
	 Subject:Content-Type; b=tgZuJRjppt1Rak98jVE1VQUOK/VtJHIMX76wXqNQbKEWwVWvZSNT/3S2oAIsGbLGU8NI6YB6qVD4h785xNdcXoBY3j4EOGtfqpQSQ57lLY/SKMyHBkgu5VA+6L56DIkS2VfYz5UgrXHPqABUzBmrSwb8G9Qzl7WHoQnpGIxzeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=O7gTclpi; arc=none smtp.client-ip=114.111.35.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="O7gTclpi"
X-Works-Smtp-Source: /rbdKoulFqJCpNmdFouXWHF0
Received: from nv1s-hmac-real-8 ([10.180.31.91])
  by cvsmtppost25.nm.naver.com with ESMTP id MwoHjybGSRW6u6GQjMHheQ
  for <multiple recipients>;
  Tue, 06 Oct 2026 09:39:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791279564; bh=hv3YkMknznKDrsXSimNXNHCUepDX0g8wBzpKCmfDKCM=;
	h=Message-ID:Date:From:To:Subject:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=O7gTclpiqViA/Df+zAKBcL2MFJ2lb3qWbclC1vVtUdorMUFA7jzrg/hiNlUbCx3sh
	 VXpfRK83yWPj1YWGPPRKYJzYfVqqsEYSJSXbUwiv3My6jYoLkARZC85CPesR8Pq0bM
	 qUts3liwMaeGxiAqe5j7KaAYLBWydlGPzm1aE7WdPI5ZWGRiZUO3/lE4SeaTMgW6xU
	 hexDD+8CcojMDc6LyJzKXmaFj+2fgovb1LsrFhwzV4Bj6exq7+ZRvsHlQI1Qak5ykw
	 o2gxCY9lVmsOFIvKmOjQ4phG+bAoUtvNHiEmgEqxEH6fOsNK7XFJZl36pvVg3sunOh
	 9//U5DCmvVuAg==
X-Session-ID: f14b3a2c8effbebe64322f257b2efacdfda1d8d7f9ece28e845c3184cf597b3f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <2b6ae98573123157c0d5aca458dd4d1@cweb009.nm>
Date: Tue, 06 Oct 2026 18:39:23 +0900
From: =?utf-8?B?7ISx67OR7LCs?= <tjdqudcks0424@naver.com>
In-Reply-To: <20261006052105-mutt-send-email-mst@kernel.org>
References: <20261006091210.828229-1-tjdqudcks0424@naver.com>
	<20261006052105-mutt-send-email-mst@kernel.org>
Importance: normal
To: =?utf-8?B?TWljaGFlbCBTLiBUc2lya2lu?= <mst@redhat.com>
Cc: =?utf-8?B?SmFzb24gV2FuZw==?= <jasowangio@gmail.com>,
	=?utf-8?B?RXVnZW5pbyBQZXJleg==?= <eperezma@redhat.com>,
	=?utf-8?B?WHVhbiBaaHVv?= <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>,
	<security@kernel.org>
Subject: =?utf-8?B?UmU6IFtCVUddIHZpcnRpb19yaW5nOiBWRFVTRSBiYWNrZW5kIGNhbiBjb3JydXB0IHNwbA==?=
	=?utf-8?B?aXQtcmluZyBmcmVlIGxpc3Q=?=
X-Works-Send-Opt: OPewpzGdjHmdKHFOMr39Ko3YKHmXjAudFqM9KqMqFxIYkEljxBmwjAg=
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64

WWVzLCB0aGUgYmFja2VuZCBjYXVzZXMgdGhlIGRyaXZlciB0byBjb3JydXB0IGl0cyBvd24gdmly
dHF1ZXVlCmZyZWUtbGlzdCBhY2NvdW50aW5nLgoKTXkgY29uY2VybiB3YXMgdGhhdCwgYWZ0ZXIg
cHJpdmlsZWdlZCBWRFVTRSBzZXR1cCwgYSBkZWxlZ2F0ZWQKdW5wcml2aWxlZ2VkIGJhY2tlbmQg
Y2FuIHRyaWdnZXIgdGhpcyBieSBtb2RpZnlpbmcgYSBwdWJsaXNoZWQKZGVzY3JpcHRvci4gSG93
ZXZlciwgbXkgY3VycmVudCByZXByb2R1Y2VyIGRlbW9uc3RyYXRlcyBkdXBsaWNhdGUKZGVzY3Jp
cHRvciBhbGxvY2F0aW9uIG9ubHkuIEl0IGRvZXMgbm90IGRlbW9uc3RyYXRlIGEgaG9zdAptZW1v
cnktc2FmZXR5IHZpb2xhdGlvbiwgY3Jvc3MtZGV2aWNlIGltcGFjdCwgaW5mb3JtYXRpb24gZGlz
Y2xvc3VyZSwKb3IgcHJpdmlsZWdlIGVzY2FsYXRpb24uCgpJIHRoZXJlZm9yZSBhZ3JlZSB0aGF0
IHRoZSBjdXJyZW50IGV2aWRlbmNlIHN1cHBvcnRzIGEgcm9idXN0bmVzcwppc3N1ZSByYXRoZXIg
dGhhbiBhIGNvbmZpcm1lZCBzZWN1cml0eSB2dWxuZXJhYmlsaXR5LgoKV291bGQgYSBwYXRjaCB1
c2luZyB0aGUgZHJpdmVyLW93bmVkIGRlc2NfZXh0cmEgZmxhZ3MgZHVyaW5nIGRldGFjaApzdGls
bCBiZSBjb25zaWRlcmVkIHdvcnRod2hpbGUsIG9yIGlzIHByb3RlY3Rpb24gYWdhaW5zdCB0aGlz
IGJhY2tlbmQKYmVoYXZpb3Igb3V0c2lkZSB0aGUgaW50ZW5kZWQgdGhyZWF0IG1vZGVsPwoKUmVn
YXJkcywKc3VuZ2J5ZW9uZ2NoYW4=
