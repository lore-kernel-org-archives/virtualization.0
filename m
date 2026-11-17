Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965915;
	b=iOnLhTVJnYI+9yJILVFQnadt1WSYWwcw95hiRxQz/N7mYxrTOOHlYSFZ5sXU1TjSSGrt
	 EXHheejanzqqtHBFgNxHGEbdZ8zU1Cif+5/4nn/lsXlmIDnl/sA7AnUTtMkalGtJKX/Co
	 eZLlhGGPjl7uGIrAwwMciAQ/Mvrzt1/+QajyAWJfyaMkIsjZn+q19gNirDQMmz7AxMoBz
	 LiNv7/1lrgzgsrt/YtgxR1iZZH2+U/B8ZapU3PvO6ERlMuIHWVemg/Trdm9xiz3gP1Yhn
	 7rUrEJ3zoGH6TTotmK+tV+X9t70m0Bq9j+r1e5wb1z5OE7A7n62s3GdH0WI5x2ZJnqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X4FNYHTT1LKVhYoSP9CXX5H2kEYFt4XaTxI0OzwyTm8=;
	b=voYV/Dr5j5B9TF92QJ6d8sypeSrfl+6mOim0MpwdZGVdyalhv3svDsR+FFWhQoyS0mwK
	 uB/EPVbta/1ewqhJ0s/S0eS318Q+1CtQG0PEaOhuEWw7GbojvhqQcb0qjaNbrRMjQr2sR
	 M+HkvZIOI8HG2pv/1mR7B221S3PsFxmRBlsDGn/TVbCgF7xxWWnxIk86/zlHtw7FxEzSD
	 H3ZaQ3VLSsE7DEAKSfQ6dpLpDhcc/dLHNbawzKEYLQ5daDmmmgOLlizkA831JxP3WVvx8
	 CFCKH8ULH2HZ2mEj0Lpw3zjQBGbSkAu5lljWu1oiWZSVS2uSI+Id5gy6JA9wSvjQPvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pg8HNXQc;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA6606A32A
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BA6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pg8HNXQc
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so749611c88.1
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965914; x=1795570714; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4FNYHTT1LKVhYoSP9CXX5H2kEYFt4XaTxI0OzwyTm8=;
        b=pg8HNXQciooCPokH66dll3QhgUxYEAAnWW/kwbs1py1qCgLtyIuU3wenh2nd+LpIT+
         aGgmcFar+yG6IILEJVIKc5Wg+dDd/ORfFdpb8e5YuuJU0tZUul7D/UdQlz7d4rOkzN/B
         kW+AuYGPFN9Mm2GHDK9bXIkMPlfQLZIKVr8di23BJ8E+x/9J0nPoCFPBIxGpqK0egmv/
         f8j9/lwB1WEiCOZFDIJyjK7fqkt0Z5zM13yESXpZGc3PNdjYliwv/JR+l+MdpZqAdN2N
         ctnQsplYwXIYAboUBQJcEJ4BMMMDkXpLJeCWu0FyGqea4NjjcgIIUocSCCaaN0G/oN8r
         IIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965914; x=1795570714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4FNYHTT1LKVhYoSP9CXX5H2kEYFt4XaTxI0OzwyTm8=;
        b=wJbj+auV2ZLBNs5j7JHD7hJrsEX9oojeyoMtu0TJGFA510lQybMJ2R5h+xdsttOFSd
         3O0yIeA89TiP9OxxEhH9dHpQ8YcjQAKSyNNKea9VboC79wxBjIJnNuD2p863S1IF9gK3
         EpIe3AP4c1gYHd7LAk6b1aIT4P1C/dVJETO5LG/fuCde0IFK5W8kk7dCsv6CRs9GkxPr
         Vr/JvKhZICUW8SZJWz9O62r0NcCw+2TMMhcLSsTV2/dqpWe+XoS86ybGS8EasQ/9T6s+
         5M/PdH3UjHnk+CqxefliILMAFA/tLNfDvE//RJXr3pueDk/dxOqA0130I7dxkmSalS83
         ZNXw==
X-Forwarded-Encrypted: i=1; AL+hErEbx92yW9roAcsbQcIJBMg763vQ20L/SGo450eXerKAvjAhD666FAtVMErzOG0qkoUUBkYKq2ZAyGDXrE3ONg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9CDINXltykc9tRCDQ43qO2aPhwXh+K2eBb9NSt63xybhYRwfca
	8DmC69KzK2t/XlqiDiDb8NXgE/mGqrWEL1DDEbCZvTTB2AbTZX18u2nP
X-Gm-Gg: AYBFou1juZx51hFJRqoy6AN0ZPLL20KZXyZNaSMjX9x4jAUxqOPwxazvwbM7+uRKaye
	eZ0DQHaRQiNMT/WnISiZNeFgsuWUMkPIkGtRKfnaXVdezNIT+0vGme6zPJGo5NsLHvji4geVtdY
	5ooeD0fUeUaJx7LHMxDRxOPDJ2HrHX7ydZHPkrmTw7UgKi/1WNAuBrWigpFxCw2yM8PoawD2qnH
	EvKVTvPw+aeoAP4TFkeASE/1im3oU/1E+63QhshHmaCpxvcvr4AGHiWBjGC5FsQWHkO2lQKZGwg
	Fj+ZFnZea+zrp1g2wYyqndj6tDaqL3aQI6tB0b2OjJxtcDBWjQoQ9b7YY0iDr1RDx2F9Pl7GE10
	ixAXtcktGF5dJvvYwTQjtzCEBehWMAZW9e9zUR/V7W3xPlaPA5dMwRWZrWybNKEwUfXwVSrGmeY
	KWsaT/NaczzRgtQsyqWUWv8BGdhcWYsW5lxJ/YP2K3rA8Rm93leor9deAeyB+kghMJcPBmwg6ob
	/75xdV+drvUIeUyrrrGoVnHhLVKSjCVWx00yaKMxY+YqoyQqJvcppdfTx0urhUPiUzBdRw0V9kZ
	4+xS9ylFUsrE4+DmW8afDEFogmGTaA==
X-Received: by 2002:a05:7022:170c:b0:1b5:3819:f8a with SMTP id a92af1059eb24-1b543bff8bdmr1034444c88.38.1794965913693;
        Tue, 17 Nov 2026 17:38:33 -0800 (PST)
Received: from phi.nguyendp ([116.86.30.120])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c5b02sm1909602c88.6.2026.11.17.17.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:38:33 -0800 (PST)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
Date: Wed, 18 Nov 2026 00:48:43 +0800
Message-ID: <20261117164916.2332953-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
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

vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
vhost_vsock_mutex, but It is also read without that mutex in
vhost_vsock_handle_tx_kick(), and vhost_vsock_get().

KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
ioctl while the device has TX traffic. For example:

 write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
   vhost_vsock_dev_ioctl+0x25f/0x720
   __x64_sys_ioctl+0xc2/0x110
   x64_sys_call+0x299/0x20a0
   do_syscall_64+0xc9/0x510
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

  read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
   vhost_vsock_handle_tx_kick+0x41b/0x740
   vhost_run_work_list+0x97/0xc0
   vhost_task_fn+0x98/0x1f0
   ret_from_fork+0x2e2/0x3c0
   ret_from_fork_asm+0x1a/0x30

  value changed: 0x0000004d -> 0x00000032

Both readers load the CID once and works correctly with either the
old or the new value.

Mark the store with WRITE_ONCE() and the two lockless loads with
READ_ONCE(), so KCSAN knows the race is intentional.

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 drivers/vhost/vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 88a310390eb0..f26c59013075 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 
 	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
 				   lockdep_is_held(&vhost_vsock_mutex)) {
-		u32 other_cid = vsock->guest_cid;
+		u32 other_cid = READ_ONCE(vsock->guest_cid);
 
 		/* Skip instances that have no CID yet */
 		if (other_cid == 0)
@@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		hdr = virtio_vsock_hdr(skb);
 
 		/* Only accept correctly addressed packets */
-		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
+		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
 			virtio_transport_recv_pkt(&vhost_transport, skb,
@@ -859,7 +859,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	if (vsock->guest_cid)
 		hash_del_rcu(&vsock->hash);
 
-	vsock->guest_cid = guest_cid;
+	WRITE_ONCE(vsock->guest_cid, guest_cid);
 	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
 	mutex_unlock(&vhost_vsock_mutex);
 
-- 
2.53.0

