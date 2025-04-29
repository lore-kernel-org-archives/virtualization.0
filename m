Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11A23C501;
	Tue, 29 Apr 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970781; cv=none; b=rVZZF44Vsn//0vpR66NMI+nRfSKhTiWnYlqZ2jAE3ZVBgbPRkYig9ukil7kKVQC5kTnb3aIiFlz4tA1yCmXmgDhAjRUYpW/QZqbPOQa2F7CkBneJ+wtPHQklGwP3geYJ+uLfOWo/sGyOt6Z9u+6DzbqjKedRZypCPcw2DBsmCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970781; c=relaxed/simple;
	bh=3MOEBFzFO7/aysooKzH5y1R6gbx8Xi4AfTz2KrC1bjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XukrD7LBtGVKDbDDY/rmwL+HF+/QkicKYXNM0RCS9CrvT0zCP/CTEX1sRxjsooisLDujugfHzmAKzZX6DkYzf13BFtxeiAPN0FgoU5sVtjPZMkbB70Q3LFYxSFvIOCErFZHoECw/ThgQgr+x9fABsi6ndxkSWBW3bWYgswCXdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9sEXz8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9sEXz8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9878FC4CEE3;
	Tue, 29 Apr 2025 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970780;
	bh=3MOEBFzFO7/aysooKzH5y1R6gbx8Xi4AfTz2KrC1bjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9sEXz8JwINUhoArEs0uq9NtUs+ETngfRZpGUvYePcpDOP3Cvrfo+x5/lem6RRfBd
	 fOD4Z/qAKJsPu42rmx2jsMoJ/p18QCzVV0Cqk1XbkwL+HI9yh4zzKarm7oTYgbki9f
	 gDEpLi08anMc8wpgx6MoIj6PMYJitGSaW0Bp1NuL2FvQBWzGsc7/MytXoFRPD8CSYr
	 VWZBjAj8QeJ1l+hIlbEmVk5MQdgYc3ocIkM/RyImJXdqYJhbs2ZC9NOUtwxrG/4Stu
	 tssRzHGcfTZ+9icUsqBPF1j6U+pwsi1Fie69emW3FDCpqDeH7Zp6IDX9BCfWprXJu2
	 mSi1LNeqwLsDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/21] vhost-scsi: protect vq->log_used with vq->mutex
Date: Tue, 29 Apr 2025 19:52:26 -0400
Message-Id: <20250429235233.537828-14-sashal@kernel.org>
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

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit f591cf9fce724e5075cc67488c43c6e39e8cbe27 ]

The vhost-scsi completion path may access vq->log_base when vq->log_used is
already set to false.

    vhost-thread                       QEMU-thread

vhost_scsi_complete_cmd_work()
-> vhost_add_used()
   -> vhost_add_used_n()
      if (unlikely(vq->log_used))
                                      QEMU disables vq->log_used
                                      via VHOST_SET_VRING_ADDR.
                                      mutex_lock(&vq->mutex);
                                      vq->log_used = false now!
                                      mutex_unlock(&vq->mutex);

				      QEMU gfree(vq->log_base)
        log_used()
        -> log_write(vq->log_base)

Assuming the VMM is QEMU. The vq->log_base is from QEMU userpace and can be
reclaimed via gfree(). As a result, this causes invalid memory writes to
QEMU userspace.

The control queue path has the same issue.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Message-Id: <20250403063028.16045-2-dongli.zhang@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/scsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 8d8a22504d71f..724dd69c86489 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -560,6 +560,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 	int ret;
 
 	llnode = llist_del_all(&svq->completion_list);
+
+	mutex_lock(&svq->vq.mutex);
+
 	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
 
@@ -593,6 +596,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
+	mutex_unlock(&svq->vq.mutex);
+
 	if (signal)
 		vhost_signal(&svq->vs->dev, &svq->vq);
 }
@@ -1301,8 +1306,11 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
 		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
 	}
 
+	mutex_lock(&tmf->svq->vq.mutex);
 	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
 				 tmf->vq_desc, &tmf->resp_iov, resp_code);
+	mutex_unlock(&tmf->svq->vq.mutex);
+
 	vhost_scsi_release_tmf_res(tmf);
 }
 
-- 
2.39.5

