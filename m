Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EA1D798E
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250046; cv=none; b=WjhOM7x3Ft8MeYwNEg2BSsyjDQbSOuBfVMuH/MVMCqW1tZy4l6CjzvFZmMx0FQvteBzmtQNzgouuELzafeT4bpAh+WkKIqxsiZFLDSuYnThkymXVWFtFoNRAAP5ziW5oureZS7OWYPUew69zjrz6FrrqeHTlDohDaQZwmSk3iWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250046; c=relaxed/simple;
	bh=2w2Xokvxv3Zza1WDoW8p2uRdZXNP1otSV6DskpOG3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdHukn2Lk6nF3YdSM7cgQH2tYBZbiSFENwBfDopAHwBFgvjIodaiOSFVI5Apo8sypn9ez8ODG/Vmyhm/t6EqHgEzzuY9zVWdrKmLxB8tweh4Ar5yr/9B072dvVLw2aRFsXuiwS0w9BVHK8nDGtvbz1nmJa57X9jAkyghZuA11Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=jWcuEUSG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="jWcuEUSG"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so5709315ad.2
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789250045; x=1789854845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LExfl2fEFs87Gnc/CJkjB7Li4LuphLalhWsojqEvmUw=;
        b=jWcuEUSGqzqIV0+fiEPcrjFNizishVQoLLX+koTgdLjYWworuXFqiOxWuWVDp/pyF6
         5DqAzw604Yp3M8vA6laT0zUziosxxs3f0pjn5IRsILPgrKPD0OjbJe9p8EcDdC7ukgd2
         bzqQp4GDZ+GCm1+8uXb0vf0yBjHzVTYdB/k/SEDB4WGNhbantxmqDWMrouLhRgGrPRUt
         rw2O230HaxiMvQO4tXtEpiOHSLnW/i0hzj5743jVrQfS17rAHDO5jWypXHmhYLmYy3Nl
         mhR14tDg7zhocR7yAivLIyp40+2jxJ8cUgBAk1LfIFR5jgxtP1ttOIhmJEKSrc4L7+/K
         qmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789250045; x=1789854845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LExfl2fEFs87Gnc/CJkjB7Li4LuphLalhWsojqEvmUw=;
        b=JEcms3jEq26JdF+EiJT4sOlwlhMKjx9mpGpmtpExIlxK0Ja2Qv0aldr/oRVpoA4NDm
         pu5aypKkC8feJv7q/C0W2OGmA/VCuhmyf+xlCc9+VgkSgFTUwVjizSfbqlDuX+ZCVkyo
         Id3UZSzbmmDGJWzEG1KBPCcGUsEuM+MHsfHb6QbO8T0aA6DoW4smYs7PR7Ednt7UexdB
         bH/V1n97sYz3hB1QAXR4ZA/EMwRAu8GDWnGkJIcaHnaqWCCP/TzAI2mfXCdU0ya2J9OP
         dHtyzoSxPFoHzNHcPTm9Uz3AaAtOndwsbnlpllkWFcsp2FUR3BMUM0biJKjuLH5nAwEH
         eP+w==
X-Gm-Message-State: AFuF++lBAJl+z+chAEw97YEbnV9CoG9ZD9vIJJcq/ESmQZvoagx4VcQh
	oxzQf9jM2Vw8+FzIa3VfF6kd79NUzuA4GLL19F23JlIIMjlFUNj34gIZKlCI4ysIvg==
X-Gm-Gg: AYBFou0apBkVJqC66vUOsSUFu+ACjxByNZLRsvF6nn4tJnmLvYMJbbkKeu33pKEJaRV
	a4l5cL3gINMH2VaW5ufgkmxi19/G39sTYZO1oIvmuoz5BfFE7QuaBkSGjn9j4qTwXJfcSMRTy/0
	4TM1PlkAUhUUlfL6TZj1lMC/G2R8BKYur6clP9WAuqzz+z7pv589QbBdnNTm/yXqRUxuNriLqZ0
	ItqHQH7CvbhPdqIO3hDZ7BakfENttBBO2eNxM9XCMCMD3cgZp6/pxRHJIm8ObIwvM6xQv+F/Qev
	FaI3FW/9V1XJLRAJ+s8GH4jF7OIzwOEQoT0La2mW1EVyXzWWJFW1tQ8iIIpFvbGXfr12Qy00ndC
	AE6vyPxsK6gI1HJbQBtwipOzS6KLAW/RrY4IeNHSV5QeWqR2MgaTJSgfKhDgHB9A+ObUDiI16Zg
	s5VHTIOu2bz7KdtR5lDQXOSWMIXhYqs+V/BxnEt3WtRT2MGN/F5HwCZvsZck9YqE8T1+qtO6p1Z
	AQYTDVpmiv8GauToPOjgRyUH38M0pFfQR7CEV1tCpkHxLmO6xGW1Q/Q
X-Received: by 2002:a17:903:19cf:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2dd2a1ea679mr208126375ad.7.1789250044780;
        Sat, 12 Sep 2026 14:54:04 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm18474475eec.19.2026.09.12.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 14:54:04 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	co+6dcbccedc9ec6452@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] vdpa: fix double free of the reply skb in vdpa_nl_cmd_dev_config_get_doit()
Date: Sat, 12 Sep 2026 14:54:01 -0700
Message-ID: <20260912215401.126194-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

genlmsg_reply() consumes the reply skb on every outcome: netlink_unicast()
frees it whether it queues it, drops it, or bails out early.
vdpa_nl_cmd_dev_config_get_doit() lets its return value fall through to the
shared error label, which calls nlmsg_free(msg) again and double-frees the
sk_buff on any reply failure. The failure is reachable unprivileged:
VDPA_CMD_DEV_CONFIG_GET carries no GENL_ADMIN_PERM, so batching several
requests into one sendto() on a socket with a shrunken SO_RCVBUF fills the
receive queue, and netlink_attachskb() then takes its MSG_DONTWAIT path,
freeing the skb and returning -EAGAIN.

Set msg to NULL once genlmsg_reply() has consumed it so the shared exit
path frees the skb only on the early error gotos that still own it;
nlmsg_free(NULL) is a no-op.

  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop (net/core/skbuff.c:1220)
  Read of size 4 at addr ffff88800d99d49c by task exploit/147
  Call Trace:
   sk_skb_reason_drop (net/core/skbuff.c:1220)
   vdpa_nl_cmd_dev_config_get_doit (drivers/vdpa/vdpa.c:1324)
   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
   genl_rcv_msg (net/netlink/genetlink.c:1194)
   netlink_rcv_skb (net/netlink/af_netlink.c:2556)
   genl_rcv (net/netlink/genetlink.c:1218)
   netlink_unicast (net/netlink/af_netlink.c:1345)
   netlink_sendmsg (net/netlink/af_netlink.c:1900)
   __sys_sendto (net/socket.c:2281)
   __x64_sys_sendto (net/socket.c:2284)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

  The buggy address belongs to the object at ffff88800d99d3c0
   which belongs to the cache skbuff_head_cache of size 232
  The buggy address is located 220 bytes inside of
   freed 232-byte region [ffff88800d99d3c0, ffff88800d99d4a8)

Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
Reported-by: co+6dcbccedc9ec6452@bugs.sh
Closes: https://lore.kernel.org/all/ILTHcT8oe1HP47sY25JVxssvKmkCTjYlX9Hs%40bugs.sh/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/vdpa/vdpa.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 47c6c3d23f5c..6455f837dd26 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1313,15 +1313,16 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	}
 	err = vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_seq,
 				   0, info->extack);
-	if (!err)
+	if (!err) {
 		err = genlmsg_reply(msg, info);
+		msg = NULL;
+	}
 
 mdev_err:
 	put_device(dev);
 dev_err:
 	up_read(&vdpa_dev_lock);
-	if (err)
-		nlmsg_free(msg);
+	nlmsg_free(msg);
 	return err;
 }
 
-- 
2.43.0

