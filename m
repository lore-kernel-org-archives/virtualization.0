Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6D298402;
	Tue, 29 Apr 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970718; cv=none; b=RtZAWNA/nc2iqhoxHTDOMSyRNFu1O53xbHrnltrXqRY6SRoV9v7YCmJ7wVbzI2pXOSLm7RRSQlg92E8GkkXWynkxBUu9l1lG0bADYfzhzFnkp5XFokOF1K9wKhb5ss6gxLqnCRqAKZZeArNiEnDyW41A8g1SphiwwlyiVF5waP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970718; c=relaxed/simple;
	bh=IzBhOCAVYFmFiUQDsYqBC9p3Z3/XGMlBkDU+3zszrB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBjI3ZNy4ifnoLUs2iBBsYS3W04JOZoIttVcvGqrxgC2mhCAfvCKq/YvGn/VPb8Jm3FnhHd2BVXvZMWBsOvBVs8du8Tiw/b7oe4517z8/ZmTFQGVGEltBi3XGgISuJafZXnyuty8LLs8Pj4Mj1UknqB0aGavIyMzcFn+Ly8Irr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHMJLbwq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHMJLbwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0711C4CEE3;
	Tue, 29 Apr 2025 23:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970717;
	bh=IzBhOCAVYFmFiUQDsYqBC9p3Z3/XGMlBkDU+3zszrB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHMJLbwqe7EKX+PHhUCMJ2Z3jzFlojN2znHDFwqImm7/5xzM2ixb+ouY5weJjcq2t
	 C3SKcps8Ng3qUc4ZwOnhy67iMAGW5lAR/ZSSnhxLN0/dWzmGoIP5O6YqxUMliZDIED
	 fNDI4p4cxmW1+XF0pWVnHPs0FpaO0Q8GHYpV/57+Hr+HSTTUoK5nOP80cXSBxNDHbp
	 BiI5x8yTJlNFOA/ZKzYaoOD6UFJWh/ElkVMhoWP5VAsFOQ0CP5z4BKL0QdvBNUB1r2
	 GnCbPlc45SIpzew9SAr5ZlaYLRZfueYQTv9dZtnfgRo639KewYq9xeb6R7PZJ5HCID
	 geVtxoSoHDq4g==
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
Subject: [PATCH AUTOSEL 6.12 19/37] vhost_task: fix vhost_task_create() documentation
Date: Tue, 29 Apr 2025 19:51:04 -0400
Message-Id: <20250429235122.537321-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
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
index 2ef2e1b800916..2f844c279a3e0 100644
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

