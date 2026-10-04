Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFE3B47DD;
	Sun,  4 Oct 2026 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791099506; cv=none; b=NBIX5AzbQSS6CmQ5Gmvln/f03B4mxOdaUo6WZqLmLmC+2toDLqqsS3oWHP7CIN23uVbmx1e3yA8jW0GwoMO5UTxHJqDlKlntR6S7plfMQaX3vYBd4NGCMxYqpCP1oncrnaaAsDh3vGjaICfTGaXx4mIR2ajO4EnJuWv4eYU1oXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791099506; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxCSMGMsMY3h3dwHKeguWrUL7vBA+rChCxpAsbFLUFUFR1pMfFheb1eAKXC24wycHtrRvOBsYstr5+EONmMfSENRoRDfl152ac6enzcMFFQIBZdsYm/rzLWmTNBiaPexRExtzfcteugHj8HG/ptOrywo1Y2IYdh5H0absaFH+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB3hF4nR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB3hF4nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18151F000FF;
	Sun,  4 Oct 2026 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791099502;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OB3hF4nRRTDE9HGQMu9tgrJ+03IosrXfm14FDQrOVB2pj9eIRDI3eW/lCYRzQCwwh
	 MdOSjMO/BZRIw04GlDgKAFbxbrwVofvPrIjrVtKK2ZLkuHc1pBs818pGsCgze0d5mS
	 4rClTNRNOiCocDHUai9HyHvSS/EpRtFoyNlQpbCB3mzPT0kwvaLijp3pj+OxgSNOxH
	 Za5DCaaHCZ4KwNwH63siVlNKBi8ATpihSapunwqoz1qIfGCCkqRXr1zIy31F71O9BX
	 xXzkqhDsrGXktgrpWTpIgk6XsJ2s477KkvyIHwTXdMnubGTCbFQ1J5SiY7oGVOK0j3
	 2wDibTNGi9T4g==
From: netdev-bot+sinfo@kernel.org
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] vhost/vsock: size receive SKBs from declared payload
Date: Sun, 04 Oct 2026 07:38:21 +0000
Message-ID: <179109950139.1402591.1046148962104624000@kernel.org>
In-Reply-To: <20261004073419.4039011-1-4ncienth@gmail.com>
References: <20261004073419.4039011-1-4ncienth@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
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
