Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8706248AE3C;
	Wed,  1 Jul 2026 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913021; cv=none; b=Yl4rcN6I977UZuOwbG25ayyH5zy68dfpPtWPMBSlU7IEwg91Bc0YiE3GByZ3Zy4ukdxHIFxKlWknkEaGeQKSJUllVWj3W5yjvi5Iu81Ysw9vjhSxuEcURd+Sd9tZKXzi4W5BxEtTFDu5pG7C+wui6DgqtXt3/v2K4FWXMpmSKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913021; c=relaxed/simple;
	bh=NwGSdqTaP4ZXnnBxO2ywFqRooIZC0B9rkEoCCDCFzSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jn4HI+uEmxKR4wr4EC+h2e2WY2eGDBJjLRxRPCmiIJhOGerI0fCDRyJSSjhHqYRzEwCyyYNkTzbHWq62zBtyLB4XCMK1Rij39SlVvCco/G1NgFMgRwbNM0LZFCzJGwflVKPXeLV3QEENEDPq4l9VZpKAJJrlQiQK5JWt6Nop+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR2vILCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR2vILCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F5E1F000E9;
	Wed,  1 Jul 2026 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913018;
	bh=X5gvaHOuX9GV+Ui1w2GFmghDgrrTp6lqOfin9/MymH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AR2vILCEqbdQzcPkcSjXZxBYVOzobevy08pHrGMQLodr6iClYbTx+bFyMAb3G16VZ
	 VW20Ul/q0fE2yomDYPSCzXalobClET2rmXXlXz/XShXoDQD2ac3xVcfjAHbyF3M8kC
	 tPx5sRPcsMzYYS+9uM1ch2D6jMoOPE3Y3oYM/pMjK7rEbAOxfXEGCbJS5Kf9jioo3G
	 Z3rOaR2HU2Vz4tqu7Bx10xU2qjlbqUPzXdiU2Z5PfBkqTxeNHjQ1KK1/bBsjS7XtoV
	 sm4z7knaAyf1Dc+JA+pXbc9lRcUuYtTBGW400YVkZ5HBt8SJ9nAJyVrk/SaA914++H
	 k8sMFwPjp5UPw==
From: SJ Park <sj@kernel.org>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: SJ Park <sj@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/2] tools/virtio: Add missing compat definitions for vhost_net_test
Date: Wed,  1 Jul 2026 06:36:55 -0700
Message-ID: <20260701133655.59115-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629022124.131894-2-chenyichong@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 10:21:23 +0800 Yichong Chen <chenyichong@uniontech.com> wrote:

> vhost_net_test builds virtio_ring.c in userspace.
> 
> Recent virtio headers pull in helper headers that are not provided by
> the tools/virtio compatibility layer, including asm/percpu_types.h,
> linux/completion.h, linux/mod_devicetable.h and
> linux/virtio_features.h.
> 
> Add the missing compat definitions and the DMA attribute used by the
> current virtio ring code.

I confirmed this patch fixes the build on my setup.

> 
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Tested-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
