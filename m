Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA33126CD
	for <virtualization@lists.linux.dev>; Mon, 13 Apr 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074435; cv=none; b=b3+YTnVrwgZTTw1zYFZVDYGXtEbEWmsIzDrAzpUq5NVAz+3XqBR3B0gK43kWE+BjzZmcda5yEyjfej0tz6aOqD58cEy8zLGq7e1yXYB7UGWBr62oORvaMbCRvtrfSH7MR1md4vs/v2QVZiXq9GqxXh3DSw/qsjZkRo+08xc3+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074435; c=relaxed/simple;
	bh=sWKe8HP0sJXd7QJHbXK3WGN04TBury/ZKJX233KBMoE=;
	h=Subject:To:Cc:References:Mime-Version:In-Reply-To:Message-Id:
	 Content-Type:From:Date; b=rf62hrVxvAc4q2BiRlFJAjh4s+ZH3iyY/FqjL1qT9PZNLKAhuBuDk2PXbhfaOtqKov3t0YEMy9tfrkrENtlEI2A3HAAHlFrgQUzxnNkzIvY1WnxBs3Uqe0bEHByeWrezohdFGbbz2PXuzsaRafeKZik0V+nPXXD8Gl5B29iEFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WsxgqwXQ; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WsxgqwXQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776074428; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wXZHMvOtArXocx/kVEUqHny6lc21xP+IWbJSc6coTew=;
 b=WsxgqwXQIM/n9h/qLGIKmFZ6dejNsGjIsLiUNiozddvBoyM/JcruqqJgEkTforlEEaszDp
 pY1fNcO9YpdSb87fbGdaWG43LEf+qrvTDIysqcbbk0qQXSFIUup94LNqlXZudbdqZZUiLN
 mvqxnAOyf5mNPteLVH7iGAgmxcAWITXHo0c2qyNkqcz/yNEk2HaTmkVFfmT7X2eaUeoTWb
 e+z7NqlHrvl6++WQ4ChJ/BH2w26IQCRIi+u7JlyrsfhkEBsQ9g75UjtO/JC9vGCBS2BCUT
 RZbakSIFDCIswYZDI+dSjSJcnjtxMxwhQUKu2clHUh1HcV3JPe0diF9oPkBY7g==
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave held in virtqueue_exec_admin_cmd()
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, 
	"Jason Wang" <jasowang@redhat.com>, "Jiri Pirko" <jiri@resnulli.us>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <virtualization@lists.linux.dev>
References: <20260413034046-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <20260413034046-mutt-send-email-mst@kernel.org>
X-Lms-Return-Path: <lba+269dcbeba+673457+lists.linux.dev+guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Message-Id: <20260413100013.32399-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Mon, 13 Apr 2026 18:00:13 +0800

On Mon, Apr 13, 2026 at 03:45:20 -0400, "Michael S. Tsirkin" wrote:
> GFP_ATOMIC allocations can and will fail. If using them, one must
> retry, not just propagate failures.
> Or just switch admin_vq->lock to a mutex?

Hi Michael,

Thank you for the review.

Regarding the suggestion to switch admin_vq->lock to a mutex:

The virtqueue callback vp_modern_avq_done() holds admin_vq->lock and
runs in an interrupt handler context, making it impractical to replace
the spinlock with a mutex directly.

I considered deferring the completion to a workqueue so we could safely
use a mutex, but since this is a bug fix destined for stable@vger.kernel.org,
doing so would introduce significant code churn (e.g., handling INIT_WORK,
cancel_work_sync during cleanup, etc.) and increase the risk for backports.

Therefore, using GFP_ATOMIC with the existing spinlock seems to be the most
minimal and safest approach for a fix.

However, just replacing GFP_KERNEL with GFP_ATOMIC isn't entirely safe
because of how virtqueue_add_sgs() handles allocation failures. If kmalloc()
fails under memory pressure with GFP_ATOMIC, the function falls back to using
direct descriptors. If there are not enough free direct descriptors, it
ultimately returns -ENOSPC.

In the current code, -ENOSPC is handled with a busy loop:

if (ret == -ENOSPC) {
	spin_unlock_irqrestore(&admin_vq->lock, flags);
	cpu_relax();
	goto again;
}

If the -ENOSPC is actually caused by a GFP_ATOMIC allocation failure under
memory pressure, this cpu_relax() loop will never yield the CPU to memory
reclaim mechanisms (like kswapd), potentially leading to a soft lockup.

To properly handle both actual queue-full conditions and GFP_ATOMIC failures,
I propose replacing cpu_relax() with a sleep (e.g., usleep_range(10, 100)).
This allows memory reclaim to run while we wait.

I plan to send out a v2 patch with this modification:

--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -101,11 +101,11 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
                return -EIO;

        spin_lock_irqsave(&admin_vq->lock, flags);
-       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
        if (ret < 0) {
                if (ret == -ENOSPC) {
                        spin_unlock_irqrestore(&admin_vq->lock, flags);
-                       cpu_relax();
+                       usleep_range(10, 100);
                        goto again;
                }
                goto unlock_err;

Does this approach align with your expectations for the fix?

Thanks,
Jinhui
