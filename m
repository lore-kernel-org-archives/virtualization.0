Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5E3A63EF
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307813; cv=none; b=kZjmmlVDCafLJ/4zRFJySU3b31o6s85DMe17X8ngkMmkIDIdMNCocii3SO0fsHHm06lPtfbBN1I8lPqVR6kjqfbxZJCJeSAm3A5aqVTTxEIVsi/4xsGA47LZpxKeck4Inil/hpu0vBmRnjxMo9Ra6GRCQqXhr9gFo6GUAknBeuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307813; c=relaxed/simple;
	bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tedV5iWSALK8gaxY98DaGLFyf02bDpKkmGKhIGsUe/1PRTqYbEdQx2mrBN8la9vcl39hz9EtKF1woUW5EQYigDVRTyDlx7sJAhsOtFRhhsbb4eJJAFiq77NqcU3gi/F2wQ7eDsJ7z+fM9aEcdPcvnjgdWb24IqHtX8atrbH0w4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7KB6kr4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7KB6kr4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso22168355ad.1
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780307803; x=1780912603; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
        b=W7KB6kr4OMrL9amAuU5sS/gu+nAl7VnjMoUJbNThP8Q/OcPlt4OzMa3fnooSV4Ltdd
         4K65An6u/dGilxiQhth9bRrYi9t+1CtI1Fjcei1zNDdzQKAej0+H2CSZzSPL5Ctorx7e
         RV4VMYde0PjQpl/Qb2LWThYa/WhoBH1oC9SMTMXZEFox3SlpJRELcSsgrcEOBboUJ7sZ
         EZyzO3+mOvQKnhXLoP27s6GMCg/4p2yiBD2s8OtDydvt9Ph2YaxWJOfpy9btVW3lmcGb
         y7FAS151te55G6AouuTP7U/j5cgByMkhZEYkRPTUsovUGA0Qaj9Qidb2biOD7PMM6NGd
         x78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307803; x=1780912603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTyuv/4q8lfTEk2MTKANVi4deoOAEf8o5emx4pw77kM=;
        b=FFBbX0Hij3Gay95rNWenC8gUNJ/4XOHtrANyZpBWvsItL1Ajwz08miNo1bAkCZ60JE
         Tg+UFJJHLOIw1UDK3tjWkZwTnNaqTNLxdSYWGYjkyctpWih864klOnNaTGrrsRGSFNuC
         QmO7TX3TRuoAUNjbJLB9vtLFYpseffFbg46Ns6F6fljRNCajaSF2hA9BZlFnlb8XK8lh
         fVNQMds2zrJbpcCOoUUlFnYQFx2z0fzfM3POvLI7QO30BPpnT1NOF2bI+YDd/hP+ULQh
         CNjhpkGf0Y0KD3xXKqjE5g8EZSFJBqi6AK6BNAwazLSbtga3i2Z2hGlg64bNyFsCH/KB
         dhSA==
X-Forwarded-Encrypted: i=1; AFNElJ9oqDwihcwaXYcIDISxr8OaDwL+CH3WS/iwlwdKADMzEKyfq0ggAwyxdNfDbzpko86vvyS8mkx7K3JJlR14BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeHRQmqbKNVQ7eBy8OBNuzpoIK4XC8G5HQEeafmCsslFctdYO/
	iNiIaPKduwIkgqvGx29BZ9FC9wK4MSInkohE/nOzIX+jjQgMetZk3G4=
X-Gm-Gg: Acq92OEsWxeJqC+qbHT3ohckB/lqGApxOIwwrnxqTB4MrGH61w8HHU9qCzE0R86Rxyy
	MV2gXm/ZIYPu2Xhp1XJxYPEIrIxY+pNaKSmFA7jkSoPuW6cU/kXjQmrVF2rWn6KNDlk01kQj8Qi
	eoRZ4ibIcqB/LfgZTV876cj/rFxpuxmW0kjWQtwWwIjJc+mNx0hNFHegx4sE+0BvV/S4e9fx0SW
	Uu3K2fY86Aw6qjqDXkx1Un1FGmn2Txr3MZ8f5TbnvtcfKn0ZCiDjRH7XzyhyL4Voyfm5Mc+IvwL
	LL+6wML449Oc+LwsMW1QBCtEQsAuUDscD0u8nAP7OUPLosXAg2E6LgvCz8LLYg8cNrj+snay5ki
	dkJPR7a4w7uz9qliN6E4CNj39wB+qzJ4iYee0bHarAzfmL+nVhfMyJOWwqlEsu7ZkMcxa2AExsZ
	wXHwJIbro07oSDVlk7+vX/If/MJK6oGdfH6rZ+6CJh0QZwkFRe4cN/y230UZz9T/Mmsw2CwfD4n
	524BQ==
X-Received: by 2002:a17:903:4b4c:b0:2bf:2243:d4ee with SMTP id d9443c01a7336-2bf368021a9mr119460275ad.18.1780307802630;
        Mon, 01 Jun 2026 02:56:42 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm102143265ad.78.2026.06.01.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:56:42 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: pabeni@redhat.com
Cc: sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Date: Mon,  1 Jun 2026 09:56:46 +0000
Message-ID: <20260601095646.180085-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
References: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Jun 1, 2026 at 9:26 AM Paolo Abeni wrote:
> I'm wondering if sk_acceptq_removed() should be bounded in
> vsock_remove_pending() ? (even if that change would probably be
> net-next material).

Agreed, that would prevent this class of bug entirely. Happy to prepare
a follow-up patch for net-next once this fix lands, if that would be
useful.

Raf
