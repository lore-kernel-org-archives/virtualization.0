Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E82E54BD;
	Mon, 16 Feb 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221604; cv=none; b=NBv7TWrW3ggDCNBcWTHrjySbxGUXpzQRsyyzVNsmglnohHPYQICBlR24DDRMaMwHs7kYBl0eImuYV6Q42PId1pgFu6ZHp95rqAf5GI+azc4DLIq9PEx/9uOzNSsPfCelzCSrvoUPhMV84jxlhKsMDiP51fDuUdRxXjpJUkLmpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221604; c=relaxed/simple;
	bh=ID5vsTRHJCtPVtdLDDHcMffe+pjgiAq0I7cSsReAjBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky5y1Qr+Z+LGFurBawaFwqfKUoQFm1xn3kN6K5ds8twWv/U2hWNX3hGNiTkeSxz+2O3lPL629E7j9CVYCftrxu+WpE2pmS1A2ZTB8OaYstwHHrBXn+Qlv3wv64b76XiYxB/1DzEoYfTAAw2WOMGLz6tlZcQU2PoVfGts5ajKoMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uUpYpdAu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uUpYpdAu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pflK6B412llDfkQ/DPrbLYZjydPbH1WoooExKw8J/0M=; b=uUpYpdAuWLGdg1pE6JYvQo3AHZ
	kGGga1Cp1J0LULlBLqEB1A8lyAMbcX+drysQJff8MTbP/L/5PNJl0PWJor1i/S8OaDCG429WQ45KL
	8Sc/4HQN1s/BuazEftmDaH1XGkrY2GRJMB73jwe1/IhJJ9h+ARQrjRbLoE0nCoInsZMjkHrGojN8c
	raBR6ZQ8ricql1vCk5bDKYb+zOm9x/wfEykqBdl3OK6uRQVeRHnUEFYw6ZCYtrIqOa0ZUmYRpoChJ
	2KoTQVIWKzbh79HzE7iAvBRBbCF2vqhsM4segoThyAh4E3YKaGKy43P9wPNjvudNvF7YTN9wqpL0y
	ImzoKg2A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrreJ-000000060Dv-0eb5;
	Mon, 16 Feb 2026 06:00:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ALSA: virtio: drop an extaneous kernel-doc comment
Date: Sun, 15 Feb 2026 21:59:56 -0800
Message-ID: <20260216055956.2784399-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop a kernel-doc struct comment since the struct member was removed.
This eliminates a kernel-doc warning when make W=1 is used.

virtio_pcm.h:65: warning: Excess struct member 'msg_last_enqueued'
 description in 'virtio_pcm_substream'

Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org

 sound/virtio/virtio_pcm.h |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20251210.orig/sound/virtio/virtio_pcm.h
+++ linux-next-20251210/sound/virtio/virtio_pcm.h
@@ -37,7 +37,6 @@ struct virtio_pcm_msg;
  *             the device side at resume.
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
- * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
  * @msg_count: Number of pending I/O messages in the virtqueue.
  * @msg_empty: Notify when msg_count is zero.
  */
