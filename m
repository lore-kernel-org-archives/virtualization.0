Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2802D1137;
	Tue, 29 Apr 2025 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970779; cv=none; b=evpGNjgkKLUlPeoQ6JW4SVE8w4Ct9a9+6YXlPDU65tYLrJGaxbj8S4a/eKskpClc6FwSkmM8LbQPT1cPcWjVbiUdPAL9db3Uls0FLgGQtDrB3DwUXXKM8+lGieyGXzBBKClg6HuAHNTeAJ7vBSZlXKkF1MpEwmo2ikjvW1y2oUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970779; c=relaxed/simple;
	bh=IU5oUGeQA0HAqUnzFG7WU5qIJZssUQDL4n4434GobzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fj6ETD4PeUQWWETca+sNam3DSfYNYwuLh9uSpc3dO37L2W7Y47/JXNpRSghszKvnQdaC0/++Vq+CTpV5NOD9HzQR8vaL6jBac0xKnLWUqnM3SgAa/vlPoXRF/1AfTiHhyom6LfbA0ctNBsAKwuDD8vYLQCsEJ7Q5RNGvo+Xv4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih0YoR+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih0YoR+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B63C4CEEE;
	Tue, 29 Apr 2025 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970779;
	bh=IU5oUGeQA0HAqUnzFG7WU5qIJZssUQDL4n4434GobzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ih0YoR+DN6gFG5hYfaI6mXRNo5tV3gRCsU/Htrcdose/pc7JSg3btkcJnbaXJAKmQ
	 9W64ZqKTF7GvWZcLzszCISyh317csOXdxeXhJJHt5FO1wMCuPysglvRfgp8mFWicju
	 tm2GNdzqy3uUVYHp40C5cJBkuIUyBLTc0aG2gYYgiGlfc6ksH87UJ/7ki6Opr9hniv
	 Gy0+oicM6eOF8fS7KlFZm2alNXNzr6DOp1KxdoiQS4uejrsoPf8o+xFTCnRa3fOvH1
	 rJx/EtozCKSuc/btZ4EbadzKp1h7FWCkWVcpsBzIvk5MFpOzYCy7lwEYR4ulIhY4Gx
	 TJD+OC757Vw/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/21] vhost_task: fix vhost_task_create() documentation
Date: Tue, 29 Apr 2025 19:52:25 -0400
Message-Id: <20250429235233.537828-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit fec0abf52609c20279243699d08b660c142ce0aa ]

Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
changed the return value of vhost_task_create(), but did not update the
documentation.

Reflect the change in the documentation: on an error, vhost_task_create()
returns an ERR_PTR() and no longer NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250327124435.142831-1-sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/vhost_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 8800f5acc0071..0e4455742190c 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
  * @arg: data to be passed to fn and handled_kill
  * @name: the thread's name
  *
- * This returns a specialized task for use by the vhost layer or NULL on
+ * This returns a specialized task for use by the vhost layer or ERR_PTR() on
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-- 
2.39.5

