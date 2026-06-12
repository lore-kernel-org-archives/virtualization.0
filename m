Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D7C381B1C
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255968; cv=none; b=X16adzuymrXMbFTWDZFVqmeLTfA/MdpghXniHkq5gST/squBvIx9AFwIA4VBJxAeFyOk2eWP61ShOGYOdSTOlkPMycYu5PWHHzh9Wc5jxgTlpow9Q/j19SFVVPhZi/rMa5eTrERCMfsGv0b9ygi7XnxlGh8ME4MCZF/0xsDeXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255968; c=relaxed/simple;
	bh=XBhUm5oNG/4V5XFaz/nHzJDBTbfZxuhuiSzQWvfQZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr+eL2zUlmhYriyKZNK2XGHn/HS0NQRh+GAxyvptuh6DQUxzi1fdo075DdxCDaL5Eh3HtvbNxRHrn5d1Wd6Tf9ICnUIsxFYNIKeNaLU5OLVUildz0GJL9z8Sm63yBTxxvJLdO7dONmNsH/T4hN2Gg6BaPKheZUz5rSxjLwhMWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1a3Xcgw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1a3Xcgw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b9033d230so484577a91.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781255964; x=1781860764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBhUm5oNG/4V5XFaz/nHzJDBTbfZxuhuiSzQWvfQZH8=;
        b=F1a3XcgwCu6ETZR84lEO+wl8uUmN650FBUEZQoNVT3wpTiP0T29hYm/t0/g7ILf4CI
         j7u/hkYHyVaJ8+KPkXCUgUy8Jm0TuajMyKZ8QZAR91Ew5VKYrGOkeIHeq2o1euXA7JIZ
         byg3EzhH+OaODLKwgJf8xrk+VKNO1tAeiZU1W64Ou4XjY+bmp5U4f7rGTFK1Vp1+5TYv
         zeqIXbtK+hK9U5Cj03vgKDLEpjtA0P/VaYyr9FCGBDLn+ujn+1ANqfoxGu8X1el0vcaK
         3X3giGRyw41KFH+z77Sdl8sMkcoxvUq8eT23KlRQP853n/Qey085ZmHge+oJ3vFtD/tC
         gfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255964; x=1781860764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XBhUm5oNG/4V5XFaz/nHzJDBTbfZxuhuiSzQWvfQZH8=;
        b=p94Eqj7efafqMJE9st++M0aJZYe3BZu/5vX8R7Ix1cJsl7i7sbFGjSCKMDr0qcz36U
         UjN/m0aCkYHnfjUQrao8y9nkJzxJ6RFcIWBMLDb0D9F2ad78P8Wp2SNpRJQiMu4YmKbe
         UGpOt/mGUD2xY9YUaxRgelrygu5CpuBQFFO8/Bpqm7s3Pwhwpxl+AOWdNqueX2Uuo23K
         SIhynwCthS9yznmqz1+jpkIW4n+WXz6QfDtqha4l61Hc5BwU014XFCqQer8Piz7iT8oU
         Mj6ESKsIOdw7YMYmrC1C4/nJamHHyxTr8XuXw58GSMKgLZuO/gY5ynWI6CSc+kl4hhTi
         DlXA==
X-Forwarded-Encrypted: i=1; AFNElJ8F7S2S6Rhng2my9uHnVGO2WB3nlJGDqTbASf4PnnUgT5As5TEajYax0uNQBwlyW5oJzpERcTorbEWv4D1zUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI9XGUKWOMIdOPPzWNRqOk2oX5uc+2edLlCwDA7J7KpT/FJ1+1
	3HC/pB/W6jeY9UDyO9tg7zLSIvD9NwCynLmec8hV9V3kKhxknQ24Wrg=
X-Gm-Gg: Acq92OHQ2xTjUEOpqT/6ULvdREqAMSafbkmlF0fZy5ru4DmtAV5prqS9Z32vgktP/+R
	bGz/95UuY+XCcc5ZXy1NqLa3T9/5VxsLoICyDyhKJTqWTs6fNP5VRBmuAWJv5Od1U8ohBqW9pIS
	m9KgVDvXMQostNjPyB4Tsy5mtrhj2hhbtmzpALMk+HPm7bnQ0VZXpHAEqDzs5czcDJkDuhUCyzv
	i1xEcFrxsDJAS/Lztt2Xm+tDFfxveJA3L8HhRqNsTKGQ+K8lQGS0+6mDfkbh7XLBNU36j9N3uLL
	Uo2uyuWEYuSBcLGGsOdqwnLqe1V7uysNUMYeSpZqzG73I1f/n9zbWmGNN7tGJamxTgIN2tKMknk
	MaR9fYSQGYkXq2AfJzMepT9uSwRxpC9DTTiwHOBLOmMrE2KCFQ3bTFRlqi/e/fXdl/CseFyXPf+
	AtLxfXZIEIyHGYjl7PCBk0H0bnKiDL8nVImcBd2N1rdHk4Q0BkXzMc5yJ6LNcljywHELTyaL8Pu
	aUrhQ==
X-Received: by 2002:a17:90b:2249:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-37a1d730d3amr1317761a91.3.1781255963615;
        Fri, 12 Jun 2026 02:19:23 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e810f98fsm757816a91.2.2026.06.12.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:19:23 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	bryan-bt.tan@broadcom.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	leonardi@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	vishnu.dasa@broadcom.com
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Date: Fri, 12 Jun 2026 09:19:30 +0000
Message-ID: <20260612091930.466896-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aivKma8mRjTXV0BM@sgarzare-redhat>
References: <aivKma8mRjTXV0BM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 09:03AM +0200, Stefano Garzarella wrote:
> nit: title should be updated since now this is not just vmci
> Wait a bit and in case this is not queued, resend with the title fixed.
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks! Will wait a few days and resend with the corrected title if
it hasn't been queued by then.

Raf
