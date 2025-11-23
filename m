Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F023D7EB
	for <virtualization@lists.linux.dev>; Sun, 23 Nov 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763920691; cv=none; b=iSzQHtFhAqJqHSPc4MRUQb3EKa9uqcI6qzwyr5AYsuKRcPO7BeYc5Ml8563QBr/XHM6EdbIMmXG8ayGjYMDQPNUAETTEpA1RHaZR+mhkhyNgqceKC//mihG3xlLbhcvbH5jhzx9MlWrsMmNOifTCpOweNa/2HIl/b4E0My1eFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763920691; c=relaxed/simple;
	bh=eI7EERSkZZBvtpNA8f4QoqbAqdrg9FbUXEE0q5Bxxzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/2y96q/Ear7NUyl56eWJ4p8tVRO2TV0xMNIni1nxTUfHQ8vemvLtK7LrSjM/stVHMFylz7gYpkWbVAzyMadmuyowPMz0qtsSZboUCfneslR7WSUjbAdUa8f6WUU5sEOFp4ohOvXbfcNiaZqOIwUMOpI82MsKJR2hDmZXm0RFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PM6dliTC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JKPBd2I/; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PM6dliTC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JKPBd2I/"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dDxWY16TXz9v1T;
	Sun, 23 Nov 2025 18:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763920681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w/etu9HEZ9sckvJVV7CeKdXhkoUUPPs7IeaPsdq9eMQ=;
	b=PM6dliTCOU4EyV24CvLkc3bNa6VZ3eFqQPRRgBKoe8qII5qLRVqPdGQHUbaC+BAGiuOMJS
	y97qoZ8Ff+MYMXk139uAnClZ4K9EUXgakWr+t8073E+Ptw50APW9M8JL5d6cRfoDX5wIOG
	Y/pJbX9kWplbaRY6tCHFbBzkPm7cXk5/taeErdf7yeYrgNuR+P5n+c1plrDo3Zhwc+y1YZ
	nK1VXLED7UfaROKDHon9WNWS9Ay8dyz02Hjf1lK3hYBQgayYVsIMjfelOd1pFH97Ynx0VE
	B1L2oQfLA0Gqi3cgVrtW8zqLBCqQ0r/3Kbuz5vHJnwoiRjxjgEBUu3ziBbCw+A==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763920679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w/etu9HEZ9sckvJVV7CeKdXhkoUUPPs7IeaPsdq9eMQ=;
	b=JKPBd2I/oIHOVVVVDWeDDWyLNcQoOK0f+xwEMd7kZsVS8qOCjkpGK+bhod3wJNHdM/4nIV
	N+aqum8se64hfGCipPPTXDyJXb/98hwWG6DuCeuDABzDJZ55v6AqqaMrDLFZvhFqDOIEv7
	Gx/97GW/y8Qip97SJxUwdgwwEfG5/+vVetfk0Ywce32TAyxOEhD7vYc4LIWzRzHY1XyRZW
	Ut5eHGVtg/FKtL3XFd8KzvqAnlBinfnQBYnJ0ATEaKYEfO1amJy1qAZCkZ2ZqdgrqUTFVq
	hYa7bC6aT2in0g7C4zH+h8sTaQHZ+n6oGOPzzebEYoMm4B5U/g69RBT4ZiMQwg==
To: david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Maurice Hieronymus <mhi@mailbox.org>
Subject: [PATCH 0/2] Add calls to mutex_destroy in virtio_balloon and virtio_mem
Date: Sun, 23 Nov 2025 18:57:47 +0100
Message-ID: <20251123175750.445461-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dfbccc51d08e74e11b9
X-MBO-RS-META: pgm9wixqjuj7fszfmrbkiyq56muqb3sg

In [1] it is pointed out that each mutex_init call should have a
corresponding call to mutex_destroy; otherwise, it is considered a bug.

This patch adds the calls to mutex_destroy in virtio_balloon as well
as virtio_mem.

Link: https://lists.kernelnewbies.org/pipermail/kernelnewbies/2025-November/023493.html [1]

Maurice Hieronymus (2):
  virtio-balloon: Destroy mutex before freeing virtio_balloon
  virtio-mem: Destroy mutex before freeing virtio_mem

 drivers/virtio/virtio_balloon.c | 2 ++
 drivers/virtio/virtio_mem.c     | 2 ++
 2 files changed, 4 insertions(+)


base-commit: d13f3ac64efb868d09cb2726b1e84929afe90235
-- 
2.50.1

