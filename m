Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52D433BA9
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619427; cv=none; b=braMTvJzYmroxNcJ4mtCZC35fmjio1LDp5DDoLBFaFFplptAq84GmKJlQphtQt7rui7Gb13r/iJ3/tZNsw2fP8eP330X3tN79bBWbeeCe2/bwElQNE94UwsQYEsSQj5G+i+xTmCzEB+T32ndyWH9kVZ9Z4YimaspNLbfj9q4Ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619427; c=relaxed/simple;
	bh=PBJgJTVktA6dk4pRBadGmyyYxpIPFy/6kLS3RcLYINk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1coPjRvM1WVBA1J+IRUA5gBfT+XT9qzfWn/BQQ9M4ZBvt4M9umtGCSjCimMa90jLlIBI8zZ5EsCxVdBzM+A/nnMoM20tOcag1ccf015cGk+w5pKpxEehcX43Zn2z8fNnMYbFyldYAqXXCKXW1z78t4eksV65n5e2AFmfF7eNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFmOLPgp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFmOLPgp"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dcbade417so9161483a91.1
        for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784619424; x=1785224224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=35d5h6tDV+eeR0qT67WDhTn7rqN/E2touheot1irCJc=;
        b=kFmOLPgpXXrJl9/OQlCcza4a8n8oHCxhq0Ua+9WYAiPkAu8ywB1sxhjqVeD+iA8K8X
         IMCYc+ZMeooi0mgSC/2VJ+Jgm0i7N0WdD4Fs0frvOOl+bzttrQdTh/3nWJxtYCFHnhrB
         lsDf9jg1Q3MR303hfmQqN9RjZvXHrEnxIsTm7NmQATzEM+0mxKn75yc3wwCe9EWhQP5M
         logvbJT7uBoslX8LXxrLCilFuZuWoYY0cHh22OWJlwMpfLt7h9W2Vr+m8hxizkytS4UV
         XjjajtGeIEMCExoONZI0a4kUI8QxNwWjVAvRcGaWgEexu28bzhT7U0y9bWpvvoeT2C3x
         Mm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784619424; x=1785224224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35d5h6tDV+eeR0qT67WDhTn7rqN/E2touheot1irCJc=;
        b=VMyYNWW+jL7Sv9pQblXPdm+JZFvrehpm9c+V8nUVZ/ChAjVSihP5AF4a5WXqBB5LbG
         VroEywjH4BU+iBfl5LbQ0L/2dK5ET46//PSvmIpMJ2FjSZqAiykNfwD47YfXo1vj2yLv
         ZgUno64Wc7EJZlx+oIqKejtrWycyv8/aHW24j24/WdDHf+IeMMldbVEJFAiwmJBvTvsm
         zw1PHv14vyI/WV/lJDSnJvZTFc/ZbCBQiDRbCVNONqcoiftmxoT9aGwWa+eTM0GG3Q7b
         UEkMwhw2nuxKrg9k2ncDqw+nlTByYUryYdNSID7PYZE621gKNBM8CAQQXzVB4Ma7zZAr
         n9GA==
X-Forwarded-Encrypted: i=1; AHgh+RqT8UTH4Bceb0P8h4Tys6rYhMcQkWwpW5ORnZ7JYAuqFCRozWyiY9/brSIu0ibqoB+eGaLb5ot3w1BTN4OrKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywt9zEuuMJd3uTBEJbA64DO1mMiCFJhu9qKrn9tTHON80frz6jP
	khk/Z3VScXibKJGc3rdiC48nEh7Be/QTp+L66VzbsJYnXbW1ByVAbLwx
X-Gm-Gg: AR+sD1111NEHAPOMHRmBmtGAjzPdE4iWgpFJAI4p2D79Ssy1vxk0WVLtm0UIOgZJ2Yy
	0t3tteqPMxh7KEhEFXw9WntGjeEP/+qLEGSNUERL9+XCCnmZqbjp9+hBKdkWLL0qaMeYkE/GJHz
	aB5KzT7K7nEUgZkE345p8YAJFyzeQTaV9IRCdsZ46fp3tcY4MfttRaVzLF0UnrdA9wuXZYmYkLV
	RHEuIxGkq8nZ1Mx0ESvoBIzSyy48mfL3mXT6S4cESdGmC6GxWD0OzJzr+JSmI92j4d0mH80BZoQ
	nMouK0/rL54x2iukccOyYKRwZs0xrsnxFAC3UaTF67xsLyX4xujgWIl0G4VTiHPOrcjCMrWMsGN
	LJjDY7mYysT8uG3HbP83UcU1g4g5HvQFLVNtGJXWPYkD1weVmTW732DMpMsGW+5Ryu/ABnQ==
X-Received: by 2002:a17:90a:c885:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-38e4b538938mr18875650a91.21.1784619423827;
        Tue, 21 Jul 2026 00:37:03 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92169cebsm1070482a91.11.2026.07.21.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:37:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Mike Christie <michael.christie@oracle.com>
Cc: Paolo Bonzini <pbonzoni@redhat.com>,
	Stefan Hajnoci <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] vhost-scsi: flush backend after device ioctls
Date: Tue, 21 Jul 2026 15:36:39 +0800
Message-Id: <20260721073639.1532488-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi translates guest response descriptors into userspace iovecs
at command submission time and later completes those commands
asynchronously through target-core. Device-wide control operations such
as VHOST_SET_MEM_TABLE replace the memory table under the device and
virtqueue mutexes, but historically returned without waiting for
outstanding SCSI commands that still hold the pre-update response
iovecs.

After such a replacement, completion may write virtio_scsi_cmd_resp
through the old host virtual addresses. If the owner has already
remapped those addresses, the write lands on the wrong userspace object.
The kernel tree has carried a TODO for this since the 2012 split of
vhost_dev_ioctl() and vhost_vring_ioctl():

  /* TODO: flush backend after dev ioctl. */

A userspace test kept a READ(10) pending, replaced the memory table so
the response GPA mapped to a new HVA, remapped the old response address
as a victim page, and then let the command complete. The completion
wrote the victim page (victim_changed=yes) and left the replacement
page unchanged; a later TUR updated the new mapping instead. So the
pending command retained the pre-update response address across
VHOST_SET_MEM_TABLE.

That same 2012 change deliberately avoided a second backend flush on the
vring-ioctl path: vring updates already flush where appropriate, and an
extra heavy flush would hurt when kick or call fds are reconfigured on
the data path. This fix does not reintroduce that. The default branch
still routes unknown commands through vhost_dev_ioctl() first; only a
non-ENOIOCTLCMD result flushes. Vring ops such as SET_VRING_KICK/CALL,
num, addr, and base return -ENOIOCTLCMD there and fall through to
vhost_vring_ioctl() without this backend flush.

What vhost_dev_ioctl() actually handles on this path is small:
VHOST_SET_OWNER, VHOST_SET_MEM_TABLE, VHOST_SET_LOG_BASE,
VHOST_SET_LOG_FD, and the optional fork-owner ioctls when enabled.
Flushing after those is fine: they are rare device-wide control ops,
and SET_OWNER normally runs before any inflight SCSI work. Call
vhost_scsi_flush() so pre-update worker work and target-core inflight
commands finish before the ioctl returns. As with the existing net
pattern, any non-ENOIOCTLCMD result flushes, including failures that
may have applied a partial update such as VHOST_SET_LOG_BASE.

I later noticed vhost-net and vhost-vsock already use the same device
versus vring split.

This is a control-plane barrier only. Ordinary submission, completion,
kick, and call paths are unchanged. The owner is expected to keep
pre-update mappings valid until the device ioctl returns. Completion
copies the response and signals from the vhost worker without needing
further userspace progress, so waiting in this ioctl does not leave the
owner process stuck on itself.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..c3e8f1a0b2d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-		/* TODO: flush backend after dev ioctl. */
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
+		else
+			vhost_scsi_flush(vs);
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	}
 }
-- 
2.43.0

