Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C16476CC5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780365; cv=fail; b=VpOpxxDe55OyclRjIamqYFmyoO6Cr9xn6NOYzf429UdhF5X/AVbXoYo0PQNODSGCZ4mUjk9w2TObUbOBUnUFhrtdiEkdzsSzusgglygm5BRslwwYH8c6LdPl0eRavS4c+sOUyKhVyB0qwHMo21M5pzHls5XtDhrf8WHJaaG0Ick=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780365; c=relaxed/simple;
	bh=ZEMTfsctivsx9BHRCYbwUHlg/kjfE3N0XMnAg1ydWd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsHCeyDS9aDEVQUCPbCheWH6ve3i5Mzreg+70RvU5EzSFzY5aQvaYekKdpeYkdlvDse06nwOyZ2u0dhm0F/9gvH1UscuYuRkaLegpXzyzFCXRaZtEkxslNxT0yAYdr7AqFPn1K44+B4dOJOy9hufqkvpvTWrhdRbyvtERDGdWFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JONHbwGz; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JONHbwGz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DEE540105
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 11:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.751
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9_uzgJPpFaSI for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2026 11:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E904540103
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788780362;
	b=Ap9XJZY36IwHGbWaSi5aUKdNWKX3N+gT4OMKm536+QgLDnTnRrciKdmV309aHjTGZm8z
	 l4igxdc1Db3sv7LFHRu5tMtI7S9FmQLUv2DMFxvGuE8lvCO+Aw+Rz2vv3P5A/ySC9MUHs
	 J9bZQNNUTcCNqd3egEU0y0WFBNFif1mgcebKckKMzfn6s/z5NqChhAM5Q1zVK3AubFqac
	 530vDqVhYENhkW5HJZzY+HxrpAdqCvWxnAJWUXEOX57IZKChgwta5ppuejUmzVJHoBr3J
	 jFwODJBXv5o9akBkwLkch3YzIUj0S7wRCtviUteNdR0P5DyjiHX/PF8jwVTVYEMqkbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788780362;
	h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZEMTfsctivsx9BHRCYbwUHlg/kjfE3N0XMnAg1ydWd8=;
	b=U0qdsATprLt0BDUEZ4jxZ1K5k2IiXDJ3y+xurX1BjVgWH64MofxK9NPVEMhz0s8QWJUJ
	 6IJz5CY5/1729V7WKPgOgtMw+39Zi2s6z/Gz+26S8Oi5RxUd2/4XKSRj1anncvAOkRVDB
	 95Mmf6DfcWtN7TIJUu87xKWkzQ2FmQzAEUQPt3dWQEupj85EuhzqxcylTPTMEW39gVbG2
	 lUCELRmwAmHRlqG+WzCdx+nCu71kSUj7G1gKiZIHwlrMzSVfhyQYowkiUJ6c1APiMlm7I
	 GYiC3PTOkLHWb84kGmNSz+tud6QGKCVstDC6ZqFZRAfD7MuCy35r3lyAugzSSFSIMaQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JONHbwGz;
	arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=matttbe@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JONHbwGz
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E904540103
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 11:26:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E3633601F9;
	Mon,  7 Sep 2026 11:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E701F00A3A;
	Mon,  7 Sep 2026 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780359;
	bh=ZEMTfsctivsx9BHRCYbwUHlg/kjfE3N0XMnAg1ydWd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JONHbwGzEgBO2d9t1tO0hOs5IgjRNPjfL33DruxCD9W8uZikJtZnR7p4kQP/5WccE
	 lKFfU419a9phXjfEW/63+8ae8SkjXdSZau0NOnUnIW4HcnaYYCuPvMlu85BwP85baU
	 xMJO5oP0dZomWEh4HpwLkj9b07haWDYl1I0i6XYqjBIOHhe1Fdfqlf4wqebyHdaQWv
	 PjXWOPXDoBbdDMKd6/x8DyDQSv7Qtut8X2H18n8wiuxJGWLSX93j1+KNh5YD69ByEq
	 8DyHULbM1585VQL4QDN9pTcAqsCqxBU0X3WiIUHWeMSuLRQaSa4PMTrA6jeGrRVj2B
	 PdzQWMz1T3Wlw==
Message-ID: <22ef726e-d89b-4f02-91d9-6d42f9cf2bbc@kernel.org>
Date: Mon, 7 Sep 2026 13:25:55 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: How is sashiko bot deciding whom to Cc?
Content-Language: fr
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sashiko-reviews@lists.linux.dev, Chris Mason <clm@fb.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 virtualization@lists.linux-foundation.org, ksummit@lists.linux.dev
References: <20260907055646-mutt-send-email-mst@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260907055646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 07/09/2026 12:03, Michael S. Tsirkin wrote:
> There doesn't seem to be a Sashiko list, so I added ksummit as the most
> likely one to catch attention.

Just in case, there is a Sashiko ML: sashiko@lists.linux.dev

https://subspace.kernel.org/lists.linux.dev.html

Cheers,
Matt
