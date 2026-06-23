Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CAB306B31;
	Tue, 23 Jun 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206511; cv=none; b=dbt3vzMS8PQBeoN9MfapwHZuk+hyeGlqZ1xjZAbHLxfn828wEFEqd11SvSPfeW25HyLrY5ugw26x0dlyF3ByCUHTy0RGjZfv7euly1UArfLDeNujFx+LqA8zJ0Nx4EsKDh0QVIv23QFAODZ9LFGczF/AX8hCN++f3Ryh5hKuXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206511; c=relaxed/simple;
	bh=IjNBBEvzGvT1CHn+mNC01Y9qA+qhCxa0ECAak/Uzajo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JhSnJkcFO5QAGixBWbioME4fIBMiiCsDl8ClhVG1Ls4YdavV0UuydjjAErmdZx5vgCkmD/1UBjbDjMIBA6WYSRJ6NZshNuokVqt4yOfHkjhsdAzSFpCyPTbf21sfthV90eoAmIPtewdxCp2439Z6WuPWXH0Cb5Q29vnWLBQX8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=fcfhCuru; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="fcfhCuru"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=ZvqtKB44Gwqr1cY+2fw3o5m3hUIQJbS6eE9LEV/4G3s=; b=fcfhCuruCbQ3vc
	gaQKfD8KrQTerNWjSzYYKf+7TTXWHHCOl++0rTCg71BHqtEOhlEvkCTxlY58VRazZV7U7IMHEqaqG
	A/KOhbTT8BlVFljCJwlN65DW5z4wwPDDjCdy4wz2Cv7MunuStLS7yOS5Ukd8eA4Qh300HYFn2NKV8
	NHB5Pw2crdVnfI3GoRS0L/PCS/B/IumitqFz+YJ7jLOfJzdiNJ1IK6jkLPZSUyPuDWXSfbshHyLhL
	vd8N4/LIwwSNv5lQpByJtaxHQtlzjdh8Cz8+V3BrFv2tRGCeTBTUIfiArBobqkTuRhouWFDEz2L68
	jrFX1z82MdPcKkYle0pQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wbxKA-00FpDN-HI; Tue, 23 Jun 2026 10:21:42 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wbxKA-00000002eFM-0zAi;
	Tue, 23 Jun 2026 10:21:42 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] virtio_console: fix endian conversion in handle_control_message()
Date: Tue, 23 Jun 2026 10:21:41 +0100
Message-Id: <20260623092141.631355-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

There are a couple of prints in handle_control_message() which should
have converted cpkt->id through virtio32_to_cpu() before passing to
a print.

This fixes the following (prototype) sparse warnings:
drivers/char/virtio_console.c:1538:17: warning: incorrect type in argument 4 (different base types)
drivers/char/virtio_console.c:1538:17:    expected unsigned int
drivers/char/virtio_console.c:1538:17:    got restricted __virtio32 [usertype] id
drivers/char/virtio_console.c:1553:25: warning: incorrect type in argument 3 (different base types)
drivers/char/virtio_console.c:1553:25:    expected unsigned int
drivers/char/virtio_console.c:1553:25:    got restricted __virtio32 [usertype] id

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/char/virtio_console.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 198b97314168..cbdc497f5160 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1536,7 +1536,8 @@ static void handle_control_message(struct virtio_device *vdev,
 	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
 		/* No valid header at start of buffer.  Drop it. */
 		dev_dbg(&portdev->vdev->dev,
-			"Invalid index %u in control packet\n", cpkt->id);
+			"Invalid index %u in control packet\n",
+			virtio32_to_cpu(vdev, cpkt->id));
 		return;
 	}
 
@@ -1553,7 +1554,8 @@ static void handle_control_message(struct virtio_device *vdev,
 			dev_warn(&portdev->vdev->dev,
 				"Request for adding port with "
 				"out-of-bound id %u, max. supported id: %u\n",
-				cpkt->id, portdev->max_nr_ports - 1);
+				 virtio32_to_cpu(vdev, cpkt->id),
+				 portdev->max_nr_ports - 1);
 			break;
 		}
 		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
-- 
2.37.2.352.g3c44437643

