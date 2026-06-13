Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A230AD0A;
	Sat, 13 Jun 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387175; cv=none; b=DTepa/UDEEtn2xm/c5H4xPULC4L0umQzC5pFqHJHmDnD6GE8xvcNqLTlJ8pt92qCqfeE6umYwxgrZ6H0KFgs9kFtwuMsYHoa/BrjSF51ugd/+rN7jXL7XyzmxnuCcw5xqrDe4yflshN9Er/klXJJqbzNwkg6LNPHBZ8vH3QgB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387175; c=relaxed/simple;
	bh=zqlV0V63IbKpxbr9fwwmyONmhCfojXlap9NLfuONAkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCaRRgHe/ubmS716jrdO1liugJ++353OyanR54pZCcQKVKwoVIEc/CdmeVqJJNvWV2oHCLy/mLgNuLZZq+RGxqu3hfBpfaK3RSVjQ3lH/23e0VqjHPUKBzBNeoSwdHdaNAF4OLdcAA5mOB7xUXVdyOY7RjY+GWeeFgOK3Pog1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp7mMl9Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp7mMl9Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF2B1F000E9;
	Sat, 13 Jun 2026 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781387174;
	bh=DHPUWFhEc+P/6/WSeaEK4iPlDI8nADtP+PJ07MwcJaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hp7mMl9Ym8tJ2XdfqPdZGfo+vykzjQxng+7ebjZLaKO+jELHcJR5FU/7Dsowzz2aH
	 0aXPcZRSft7MmlaZsk5rPU5hXCM+uC7EKuizdEd6Mzu5YJUB4d57b8sdysaOKJWsyw
	 UDRC2Hkwm8C1gtm1iba2ZLXPv4DFWP9mwiB/A9Hzluy3oMePKyQQINigmvdCF098UQ
	 KRoRCEDZBnQcO5hIFn9hm3uZsKb4ZK7C2YrmF+EVd+q3ukr19WwvnXOy2vDgr9Jiew
	 mR6nBuKxZyYpFqw2FyGAcFTTRctiDzvz3ALm4jOJAQtuI1VmPQVMDBnjFGu1YiToxu
	 eYCzJEVe7xR1Q==
Date: Sat, 13 Jun 2026 14:46:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com,
 mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
Message-ID: <20260613144612.0c5b7ba4@kernel.org>
In-Reply-To: <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
	<CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 10:27:28 +0200 Eugenio Perez Martin wrote:
> And the From and Signed-off-by emails don't match, which I'm not sure is valid.

It's clearly the same person. Please focus on the code, not trivial
process issues.

Quoting documentation:

  Reviewer guidance
  -----------------

  [...]

  Reviewers are highly encouraged to do more in-depth review of submissions
  and not focus exclusively on process issues, trivial or subjective
  matters like code formatting, tags etc.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#reviewer-guidance
