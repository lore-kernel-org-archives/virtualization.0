Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837037;
	b=gd3Kc0C7eYE28FQ8g3+NgYR+vOifFBBRkksqq0kCvxBk0AFVFe1rRLKFrpah0S37Y2fK
	 u3afypuu2LHphMWsgDJ/65+sBB43R5niTjFP90RKmWZKMeea6YjO2wcpEN8rgKZlCBNED
	 JmPmP6Vrk2eIjl77NHyBI/HScsFGGQPH58WXMAAVshCZSGqywS85+rD7WqhY9ApowdnLl
	 aU8MEowgpOR+5zY2aXy2xqhxQZJcxGPVnHdyg/j+1YHRHgBWojaxtwOD4dCDi7fT9nerr
	 IDFhFhEei0pLJKdV1Yr6VbhPLdpKYgUg7w365mK4ua21fBBe+BDuV9UvbuKZG+ELi6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837037;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=w4volzdkQ4CAvX2QNfSoP47O++Y3rt5cp4l6Pqyv/DJQQxpuXjt+xipGputYk05eD+7m
	 8IqVF8vHH8xy677NDakFjee8+sT4hszsxIOgtmLayhu6Igpayy5p2gGPHIzvBg572SDMR
	 nU2725UPc66vwHQZwrrRp3is1FYk0uNxEIa9ugwxy1o0io73mqZGaj4/nz6LyZ+9qxQcP
	 ypI0ysfJ0zchHyDfIvYPseSbEq03FyQdReeELryDEQnXDyXbCREg138rCQw7mHbcKMY2B
	 lEE4P6d2rSDYEXGdVV+8C3TbnTuBoy0I/HU9xpBy+Fd2R02v5rnuONgy/esfL+9j90A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzRAKHE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8F606A32D;
	Thu,  5 Nov 2026 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzRAKHE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5111F000C1;
	Thu,  5 Nov 2026 00:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837036;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzRAKHE+7ZiibyjQF+cOdZmpp5lFyoytcPXo+EOkn4KFNgfQkeLP5ZT33Qdy2PsOQ
	 Ttf1piDWilLBKNhkYJB4BtYdNLX9JOKRPTkuhY+F7IJAHAPrnrRPaqMwZQPp4RYIFD
	 nAsPwJk7v4W1fUwIo1InI1l0QIkdvJfvyEBemNR0miBK+L1mS2u7mHSOxvFxuQJYZV
	 d1K7M+5bsy1pf2X3P2JCpKLpMrwHI9kwa8CONz8DuCSeHW20VX00MzTWYKe9Ill66P
	 YMyBrDnWI4t46FTYj5rNrEW4GQixZ29mxd8tluRz6BuCTzuecjI2pWzb/i4pYLkf9M
	 guBTuuY5DeB7w==
From: netdev-bot+sinfo@kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: sgarzare@redhat.com, stefanha@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 bobbyeshleman@meta.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net 0/3] vsock/virtio: bound what a peer can make the host queue
Date: Thu, 05 Nov 2026 00:03:55 +0000
Message-ID: <179383703519.488859.4429490517306926733@kernel.org>
In-Reply-To: <20261105000141.3617241-1-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
