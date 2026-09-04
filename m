Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF463E3169
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531208; cv=none; b=N4Yrit632iRK+k0hB8QOGBXE56vTPomtzeMSsIfl6AJVYTptVWVzHXc6XK/s6FXgWmVwX8wKenvd9t+NPy1dVujRw5Nvyr8dYypz7FQHxg2VmgkuQB3z/LY0Oah+nMg8YCUfyFQnn8oAh8e6vTel5YnwQwxrHw3qi7NamZN4cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531208; c=relaxed/simple;
	bh=vMueACiGC1q4rjqD2bksa/EDtJQRCWH+HapwBBqFDZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGzt+Fy5svxk0SebQiICSyaN75VqTRApwArBdIWgXgFfQeVs/zVC3VFlLyVwb9mtRxPYsycnkJ0jvIs49DJdrvbwGGmlImFisO3kMVlZHj01KSweqF5Wf545VxKhzgmlk/8Z5KujyU/ZE3mpECQxc8rUbD7NC7kObyYvQbsuyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn2yiemc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stellman-greene.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn2yiemc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930f618435cso115982585a.3
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531205; x=1789136005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dk9pnlg6SvIAGqoJPX46s5o8Gmgm9I8OPIZtQkBklA0=;
        b=cn2yiemc2PKaDd2rjHvK435qGQ0n9eprzew+NqHWTEq93aLt2letkFw+7ACjpdHjZY
         91kTdqQFPx8VHbOnUZ3VONbOZaZjXD74/Kl9zSrnzgoUeMxiIp9TWbl+2q2hgDphLkw/
         H6vPSU5YemWcktEdXAPkjh8x8Fcewm2iKUrSsZFjHNWi/zuzHyWM5DMtvJeDKPxdG9Wx
         gUj6h5gJOApfOHruVm1xnS9OWNhNriL6m8EeQPQY/R4Ag1+OAc78aeTssBRlMN5QrG62
         R+aNXFJufnOAMy2ES6UhR/+2r2+zkfqAGmk6CYAoKSkx71stw8uE00PJIwj6mRAbXhcl
         XSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531205; x=1789136005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dk9pnlg6SvIAGqoJPX46s5o8Gmgm9I8OPIZtQkBklA0=;
        b=eW9wPxwSd+eNV9aQQ+we3YQhDts80KGtIjnzJPn1QyWpgpmDq9HztLTK7knK5fvI+x
         hGa8imeBgv9KJjtcW486/af8vhOjQl5DmqoZ+JVn/Vl/CF8XcpJgGEQqMzcMVQovdjLZ
         c+Xub8EB1KAyC6F1ML8+PcaFP6QO/kVG1xmG59FxCxvA4+2rZdzO1ZEDebCbqFnyHBPB
         WpQk8a4Dy5I1Cr6p79fjfR3Zb3yh44Vyi2LcuuP6dVnUMTTPKkFICPl8tKcQXLanLBd/
         j9beDG9bmnpSTo/wg73k9XQ4hggaiEwrSoj3byVoKPVdo2Y4xnz8fxv0c8Wqo2Gv0Zxm
         pubg==
X-Forwarded-Encrypted: i=1; AKwUvBwEn5zRDx0cYDHlumOsk3xYkA+aCi+Zk+IOzZbjxftEtH22T/rlhNEXNuJsYBDp5u+zbs5zO5UfstYeqDOrPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++my7rMsA528CLes+iQrlC228htUKhzeBIXpNXWnjG1SHtFxUsvq
	q9wB+GHO6bxL6vUHwCoampg0cqIa8xifIselZwYVqPsl6OiRzIw9hulR
X-Gm-Gg: AYBFou185i7LeloMiGaVDpjPuDIsGiGWcYjXqn1V6n32kI+Iuqu4u37ziJVvqBBH8wx
	jF9zFgWpefV3uFZ4hbpd4mGrxXBUPWAbAvFaLy61Xb6iHII8al02Sdb4WT1IR4pEW5nLATjXJoh
	ftqXc0GlLKdWSsxaXTKI5Pr105EOs80jGVjkkMSlilMr8j/O3JJ1FFWLr05RhRxuJ7BdB9qz+3g
	0Neisfe3SO9GECH/uTLld/NRs0tGAA1nrrrGDdhLG5s1YenrYTHk4hXjp4bb74XWELpnpCQrqTm
	kkKiHgEokFt/mfvFy6DyQHRCjIHiP1ir2ivuAApst0JPhd4ueTGHJjnT/cBM6o0qAo8Wicl+btf
	aNU7nur0EhiwoBi0irO9THHdmosyaalGOYqES1e5npNXkjVwe6gMTh10sqM5lIfr6jiTDwEz4jq
	gnB6QBOMWv3yrXc+AACA96TLdbO5RydZ9F7Oti70qdtmbrj8Qpros8lsEejOeYu4hyPW3ifcK3E
	RBNqL7svaJvPvyALpZsgvO9HTyy7MCYxhDApQeof1byClAD+60CY5FCa2vTbDBQFBJdlqFIeDdu
	Uu7lvo9wroFRNxzibUnQ7Z9CPtW4B/MssJDOn3rcmEjDpsI5r98klcq5PtqvrNZa9IYeL/t1Sg=
	=
X-Received: by 2002:a05:620a:811f:b0:939:6dea:374b with SMTP id af79cd13be357-939804f7c81mr480625185a.47.1788531205179;
        Fri, 04 Sep 2026 07:13:25 -0700 (PDT)
Received: from Mac.mynetworksettings.com ([2600:4041:5c28:200:bc26:3e94:1d7f:e1ff])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397faf927bsm217736285a.8.2026.09.04.07.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 07:13:24 -0700 (PDT)
Sender: Andrew Stellman <stellman@gmail.com>
From: Andrew Stellman <astellman@stellman-greene.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	astellman@stellman-greene.com
Subject: [PATCH v3] virtio-pci: return IRQ_HANDLED after non-zero ISR
Date: Fri,  4 Sep 2026 10:13:18 -0400
Message-ID: <20260904141318.30278-1-astellman@stellman-greene.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_interrupt() reads the ISR before dispatching config-change and
vring handling. Reading the ISR also clears it, so once the read
returns non-zero the interrupt was from this device and has already
been consumed.

Currently vp_interrupt() returns the result of vp_vring_interrupt().
For a config-change interrupt with no vring work, that can return
IRQ_NONE even though the ISR was non-zero and the interrupt was
handled.

Call vp_vring_interrupt() for any queue work, but once the ISR is
non-zero return IRQ_HANDLED.

Tested with QEMU virtio-blk-pci forced to INTx using vectors=0 and
pci=nomsi. On an idle device, 200 config-change interrupts were
generated using QMP block_resize.

Before this change, irq_handler_exit reported ret=unhandled and
/proc/irq/11/spurious increased from 0 to 200 unhandled interrupts.
After this change, irq_handler_exit reported ret=handled and the
unhandled count remained at 0.

The issue was found during an LLM-assisted Quality Playbook review.

Fixes: 77cf524654a8 ("virtio_pci: split up vp_interrupt")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
---
Changes from v2:
- Repost as a standalone patch in a new thread, per maintainer request.
- Add LLM-assistance disclosure.
- No code changes.

Changes from v1:
- Return IRQ_HANDLED for any non-zero ISR, as suggested by Michael.
- Add Fixes and Suggested-by tags.
- Test the change with virtio-blk forced to legacy INTx under QEMU.

Full red/green test logs and the tested v2 patch:
https://github.com/andrewstellman/quality-playbook/tree/11ba61d/evidence/virtio-pci-intx

 drivers/virtio/virtio_pci_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 10371ecbc054..b90c174450b2 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -120,7 +120,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	if (isr & VIRTIO_PCI_ISR_CONFIG)
 		vp_config_changed(irq, opaque);
 
-	return vp_vring_interrupt(irq, opaque);
+	vp_vring_interrupt(irq, opaque);
+
+	return IRQ_HANDLED;
 }
 
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d

-- 
2.43.0

