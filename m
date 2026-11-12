Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460934;
	b=b1uM7ZhywTbPiB2fnAHeZdlJs2kwN11p+JgindbE/EQWFmpHWa0H8YdREf/heXbyDEdn
	 YgLsgp0GZvY26rpZGBwCvxMVrsO8v/m7n75AwQdpdX858ufpMEHModB8WYxh58IgOIqs9
	 M/eIlrQc1rCsEkMwUBympmgPo9xLo/LHBGS4XpkXcGg0heU7jJ52+8zWUM0rq1UmvO3XQ
	 UK09+LxY0WpizcNGN5Zh7zJX4cBNdjadFEbj/XJTFhpFl45CztkyCiTm2tZ5NlJYPfmXf
	 BBQk93MjVnbLCvCB1OnfCTeXNGZwwxRxqziBAsHRydm4fsYROVfHo73IE9iW+e0ME0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
	b=JF1GCDs5ip5mYYiuwJ8txaRG30pVncqn+ozi67QNQ747s7YHHxl9al9+Zk8756K92Zjz
	 MI6LiZxRL5gFKGEsotJwCPQbmsXh5FEqb7Hvpc/VTHSlB1tc7VbnlC9K6crSwRlfE97Hl
	 mfa3yJm2FH8FoW5XMVout0M7e3tugL1TePgZPvcKKghJ+UnpsXy6y7Gw6lWpkvSJql8Vg
	 MmxRsCgD0mDLCK5aYEp4tnToWScP2voaqVq1UV6c3y20ywYdBvzcJh23zjix2ize2i8t4
	 O6qSAZ4/0WujO4iirw/psTDCdZEx4Jiyy1hids+VW8bmNvE6Hs9hquw4t1zyxGZXhrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgR6gdTy;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC10606A324
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FC10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tgR6gdTy
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f1e5d7450so389472685a.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794460933; x=1795065733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
        b=tgR6gdTyBZrXeIRZV91kL+EqLSFAvNK/cDAjzLAS70cp9nwoeBTKQzesAxHww2snNr
         Qq2t833ZIxcxDTNT7HoDuXHo9epftoiy9m0owsboNPFDhSZaQAYrsx3ISs0MBtOV6fbc
         0X/YQnhhrUOlM5DPzyWYpzumyaUHFw/LW2VsgHUGb8Bd0Q6dIVjjheM4fDNwhaqQ0u4S
         oUKHtGJHhbU9UqpBfQSpIE4ajl0SdrKR+dYZrh1VK/tP+/dBB0Z4Z3a1+Lnm5CqEaIo7
         NvI9QxtWZ3dErOHgCU9Qg9gR65OtGTDJ+dCOwwtso7Wh+5uiunaFHAxhS04ncxthREGw
         X+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460933; x=1795065733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
        b=FGAywhSAdY3shMSBnm0zgeW0MivKqRntQoE48237vQzhUJaJkpu3dXXI71cHQ36MO5
         bZL1cdgbxsMDbCSu6iSKlEVmZGu47UA8olsWWarN//Pp4Mw4/BCqQmctNGYsL+ftOyiS
         xnQ94EXKLCgvECNpYuDGaqAJ0gyeI8VJ4e1Fse/oLS2xgJhHDMWrb3kNiIQGyQ3UaUkn
         +7uyqtbPAw2uodOC8u56n5M99yb3x4/V/N6uWtYPjldLCe1IebAUzdfgF2efwFMJQXqi
         jx8T2tW0GDH/lZGqu6WGR5yQNw9JkIkZ1FRAwcguFbTRT8DKGJkbD399gQhbGtb57ZI9
         zZhw==
X-Forwarded-Encrypted: i=1; AL+hErE6fH7l0sW0o0AfaY41MzjgmkyfWBpGyFt96lT48dpNMUnHIsBRgS40f0gCJb7ufuS4w3R8mmj0wW/LKFgllw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/5nBOH6c5+S2eXYOjMfK5vJaPS4MrUstIdixB83jgbqQc3US+u
	l4Ti9Kqcw9lhV0W9qSTTnr7RfznEp3dxr/wQQfO9u+4+4uIjpnrjX9Gl
X-Gm-Gg: AYBFou2oh36hqMXwhJlg1K6jby3dPg2NAZw6dCUeWXDCCUJu6XJum75OvFtxv4hJdBO
	AwOvcBJelNw6etoCmEE0EYLwRrTjHU6Xl3s228x4nsS0IupC+oh2dmpRLHPj3Ryc9VyOq3r5wwB
	56cagrDnxwbURlte/CTDMfoBZtsy99yDcobyODtNH8/+7yupS/aF4EuMitQy+uG8vt5ptCgfZhh
	O/Kx2QS68IEW+1oRjD1hOFdql33Vev+ofkRNwCp5+pfUi+pcR4rWJE3dcMBcJSOaPXMBNIynFc7
	I3Gk3aruJj3VNMrv4kJ6tbgLhO2wUNYgX2s2paqE+zl2n3BGqMQWm1uCbI5WoGl+695GTOhH6BN
	M9a0+5aWy6DiCA9tzT4qW2e6c4I7akSHbRTT9MLn4sTiZ4kMm48SicttDWSmi2St5djUxlfjGOP
	Qm2dqDBuB6eGYBaxTFXW00G56zxEoysFYeo8XOZEvQfX4eGg8zr6fEiv52g9tSOKcJmc7/lyaBd
	EZJkLAr7yeIgxA/7mESu+fEMhJuvFpb1+S/ORwF73HRx3qYdKV8EndZO0MFsPFf0GvRAasKiP2R
	aOQzniLbnmsMq85zd+OavUiLklhdiFIYwl041zk2uWd/PcpYFaoO
X-Received: by 2002:a05:620a:4693:b0:93b:d7a3:45cf with SMTP id af79cd13be357-947affc2972mr765476985a.56.1794460932899;
        Wed, 11 Nov 2026 21:22:12 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f03ca6548sm37340956d6.9.2026.11.11.21.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:22:12 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] fuse: Don't use request timeouts on virtiofs
Date: Thu, 12 Nov 2026 00:21:50 -0500
Message-ID: <20261112052208.1248312-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtiofs cannot abort a request once it has been added to a virtqueue,
because the device owns its buffers until it returns them on the used
ring. This is why virtiofs sets no_control and no_force_umount; see
commit 15c8e72e88e0 ("fuse: allow skipping control interface and
forced unmount"), which says that "virtio-fs does not support aborting
requests which are being processed".

The request timeout added by commit 0f6439f61a6e ("fuse: add
kernel-enforced timeout option for requests") aborts them anyway. When
a request takes longer than the timeout, fuse_check_timeout() calls
fuse_chan_abort(), which moves the requests on each virtqueue's
fpq->processing list to its end list and ends them, so they are freed.
The device can then still write the reply into the freed request and
its pages, and virtio_fs_requests_done_work() later gets the freed
request back from virtqueue_get_buf().

The timeout is armed when the server sets FUSE_REQUEST_TIMEOUT in its
INIT reply, or when the fs.fuse.default_request_timeout or
fs.fuse.max_request_timeout sysctl is set, for example for other FUSE
mounts on the same system. A slow host is then enough to hit it.

Don't arm the request timeout, and don't offer FUSE_REQUEST_TIMEOUT, on
connections that set no_force_umount.

Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for requests")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
I used no_force_umount to tell these connections apart, since virtiofs
sets it for the same reason. A separate flag would work as well if you
prefer that.

Tested on x86_64 under KVM, on top of v7.4-rc1 (6628e7d4c6b2) with KASAN
enabled, using QEMU's vhost-user-fs-pci and the C virtiofsd from QEMU 6.2:

  1. In the guest, set fs.fuse.default_request_timeout=15 and mount
     virtiofs.
  2. On the host, stop virtiofsd with SIGSTOP.
  3. In the guest, cat a file on the mount.
  4. After 50 seconds, resume virtiofsd with SIGCONT.

Without this patch, the cat fails with ECONNABORTED after about 26
seconds. Once virtiofsd resumes, the guest reports:

  BUG: KASAN: slab-use-after-free in virtio_fs_requests_done_work+0x7be/0xbc0
  Read of size 8 at addr ffff888005176020 by task kworker/1:1/29
  Workqueue: events virtio_fs_requests_done_work
  ...
  Allocated by task 81:
   fuse_request_alloc+0x19/0x200
   fuse_get_req+0x153/0x2d0
   fuse_chan_send+0x4cf/0x840
   fuse_do_getattr+0x23a/0x4b0
  ...
  Freed by task 81:
   kmem_cache_free+0xbc/0x3e0
   fuse_chan_send+0x4af/0x840
   fuse_do_getattr+0x23a/0x4b0
  ...
  Oops: general protection fault, probably for non-canonical address 0xe012fc11a000000a
  RIP: 0010:virtio_fs_requests_done_work+0x25a/0xbc0

Setting fs.fuse.max_request_timeout=15 instead gives the same result.
With this patch, under either sysctl, the cat waits until virtiofsd
resumes and then returns the file contents, and the mount keeps working.

I could not test the FUSE_REQUEST_TIMEOUT part, because this virtiofsd
does not know about flags2.

The tests above were run with help from an AI agent.

 fs/fuse/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1341b681d0ed..f1aae9b5475c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1451,7 +1451,14 @@ static void process_init_reply(struct fuse_args *args, int error)
 			fc->no_flock = 1;
 		}
 
-		fuse_init_server_timeout(fc->chan, timeout);
+		/*
+		 * A request timeout aborts the connection, which ends the
+		 * requests that are still in flight. A transport that cannot
+		 * take back requests it has handed to the device, such as
+		 * virtiofs, sets no_force_umount for the same reason.
+		 */
+		if (!fc->no_force_umount)
+			fuse_init_server_timeout(fc->chan, timeout);
 
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
@@ -1502,8 +1509,10 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
+	/* See process_init_reply() */
+	if (!fm->fc->no_force_umount)
+		flags |= FUSE_REQUEST_TIMEOUT;
 #ifdef CONFIG_FUSE_VDAX
 	if (fm->fc->vdax)
 		flags |= FUSE_MAP_ALIGNMENT;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

