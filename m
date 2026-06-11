Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD3306741
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168157; cv=none; b=hU7aHj8lG98apKaekO2RbsfrPs7Rl4xsSmqn9VJqfKSiSSayApGqy5x7jzfiZ8FFtE1EVuwWHYQF86jOe9r+C9d1I5wojGb3SeDGl3wndCb4g2rl9+W/IN8gn2h8VnWj4y11LnRfIB1SnYQgbS+ahg46tGN+beT0PUOtg/VD7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168157; c=relaxed/simple;
	bh=cdf6zOQ68rkdfy+2UIkAzlZ/8jxopWcx2C9dkL08eXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8IXqR/23h6vJy5Jz7qorqiMGDjZnWRsqrYDilqXpKMFe1b9xx17OquWo2fjBsXDhll6xx1BKu3YHLuxJs/vCst3MWdA+KGPHi4Krse2SkXIFJcN8JjfxNj6hznR6p0aoNSTlw1ORbMw66NKiV/I9/NRX+OwRBpDasidhkMgrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owSL+qwC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owSL+qwC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c31212104cso1507805ad.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168156; x=1781772956; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIc5aGCRuh/WNyXNC0AmWEpzTu7IhjAFmIuMhEhGp7Q=;
        b=owSL+qwCEMGTUnjyVxzAS9y/FoKMDz3O8TAmqYRYGZa+37zlAfr6woVXvKuOB2rf5R
         oHsa1bl61cIdvLo3Cj9Y1VjsVUHYqgMndehtqeClYblpBBa8IBiCYCovbkMz7BB/TINX
         d7o8sLEn1BZ1In5CPAU/jaw7a1gzSl0UXx0fU7OR3iBtKAem6lS3L1fwsn+DdARaZZUC
         vffWdseFEbc+Smu1oI9Xp1CSgB9jWIoRknFEOYAcXKKsQ2TNbbnAGaJhQxpem/03a9g7
         BXLWw+otop/cc8uVWpF3Jvk4B2y0iujvBYTmFHJ3j/IYr/e0kH7Hii3saSLd59KcciI4
         H+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168156; x=1781772956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIc5aGCRuh/WNyXNC0AmWEpzTu7IhjAFmIuMhEhGp7Q=;
        b=BkG3irEMkOWDs8pgtMgcSfnVSH3wT8RxhJL5uy1Pgu7n7453uYAgNwrdNyy7AHVMZ+
         J47KMukKpUfIoVoj+SWlgmy57Pv+BSyHYS+jYFPiUIx0AnlRvyGA2Y4EwjRDtWESxxYn
         99u7ggw0xPZxAdEcqqs0vdGEpIs1CYIe1Wc+TQCwIWn+sIe0V5gXPsWXOUJndZOFwIqL
         SdhTAvcb2xe35JtTT21ybs0f24PlaJLumzVWR3zU3imJBb3P/qCkZZE4LiZ3qXkZgeyo
         yoekmDkaFR376Z7O8L63QECopqqgHtTQ58zTNB6xLt+xUJ9LKgu1fAmq4i1XXgsRDNIj
         aQcw==
X-Forwarded-Encrypted: i=1; AFNElJ81BZVdHM4bJigBiee67p7cLnbafFJZwH3N9u6eRnYvXHLdAz5dVlpN57u7qqkwOZG5cZ5J7t0FmyC+lzOxyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxujt78W4gHoOUumGdIPDrt6qLn+CumMB+e5Tmlhi5MP2ORKneL
	6qKrpizhydOP6oUg538NA6OoP7Y6zBckjg/GDRoo+I4UoTaEN47SYnk=
X-Gm-Gg: Acq92OEd4EsFbK3Ff0rh0tO2RWQEQkiv5l8qbORfFecLCz180/2Kx5v+3OfbwVAGbW9
	Sr3cAYHjb4CbJNj8C2sS9g9WfHaovo1rmCWxQQOYn5h1cwferN6ANiEyTOylCzWgruaxIe7hce2
	J8gwvfQg19GVcC6/aBmr8/oGTHSdFK+pZXF9xwFKaPHRuZPJFYOhKFxXHntuuOnx6je5tCH62hl
	CedoaeoGA8bBawL1W6tZ/pe2jn7VePtpAVjh+GDmT6PW2L3TMuuanB+nex4FEbWQmyK3h5U5q9L
	i7NKihBWcp59J9Y4tnkfQAytR6VcROnccydPXTYUPnpHzY73ZG91zHUXuz0kfiZN3YF6XLY5ZXy
	oO6kpUbb7GJM7ca8ztI7XlNHjEC/KC7yL06Ez2Uqe47DF8MKmyaE87eTkq/JdaZthpl6xraw7S3
	ye8teGjl/sSsO5E4w9zHhOlgjTJWJQXNcQ7nE/rlUIe5hshl8IvvBNbqZn2jzQHGyrIklF+83Ii
	tecjg==
X-Received: by 2002:a17:903:2ece:b0:2c2:7e17:39f6 with SMTP id d9443c01a7336-2c2f2f5dc47mr22090075ad.36.1781168156009;
        Thu, 11 Jun 2026 01:55:56 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm140758755ad.38.2026.06.11.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:55:55 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Thu, 11 Jun 2026 08:56:03 +0000
Message-ID: <20260611085603.626387-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aipyNh_qseEUxj6Y@sgarzare-redhat>
References: <aipyNh_qseEUxj6Y@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 10:35:23AM +0200, Stefano Garzarella wrote:
> Maybe we can keep these patches separated (which I like) if we
> introduce the vsock_pending_to_accept() I suggested with an initial
> patch of the series.

Agreed. Will restructure as a v3 series:
  1/3: introduce vsock_pending_to_accept() for vmci
  2/3: fold sk_acceptq_added() into vsock_add_pending()
  3/3: fold sk_acceptq_removed() into vsock_remove_pending()

Raf
