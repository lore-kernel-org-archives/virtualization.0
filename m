Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6BE342524
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789865274; cv=none; b=EASe8+/kZwf5TZtAn1Xg5cENibUryrP+VfyKa0bYTj2/3Rc77RJeNXpFtQJ3mrf99NWYRwxb3/BY0XIbRKXHqP03H8AVNGNdphYjYZlpAm7o7N97fnH1NtIiNk6kJFytLhX0Mc0M7Zgu0YzpG5j2HMra37KG9OlWc4waQAtkjJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789865274; c=relaxed/simple;
	bh=wZF2qGAioUkITwtAve0FSWVizpc8AkxtsGOY0RjV8bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4po71dfgjhIbFgqzIM/RjJZPcTJxGJA8C8vHfk/m9jqSvBhV5/Y+ljj4Ek3uTfSN6ZGF2ukrsXe1SY1T18uvHAava6Dm2C+2jMvwYI2qVWT9Vwe9mKcqCsIrIJ+r4D7+GqI/dR0MAgBM7Ju5haySFPB8QQhkdoB1gjkKZoxO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUtEfRhr; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUtEfRhr"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910a0cefaso176225185a.2
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789865269; x=1790470069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=spIPE+evKRjnl976ChlZC7wECJM7DIX26kp/xsswnVs=;
        b=kUtEfRhraEQd1up+BQDA/P/r4RqmxzsgKjs/A56QJQMAsX8NWSUGiC30BLhL7ONjBj
         EE1QHZf1Rd/WfyQFu9tnAFoKraVLNyu9cMJAS2Kzx6Wh4GunUxdPxTMZqi0HO5oeCHeb
         Rh+vnF2eNJElQntkuuRDE6ss4Gpe3AJZpWayz2ua+3SaKfqXUNoei/px5G+ArK4DzHN+
         VR1iwwfTUwoqF7kV2UTxHuntm9X9C4PG6uPIjTF128v0niLnfDCV68ugNc41cP4IjRRT
         PBa5zLMpM1MHneD1Ag8xV9OAqfsFzRSrcJdPZUYMiWXqonJktaw/AyZEQpZ6SvvAlKAD
         MQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789865269; x=1790470069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=spIPE+evKRjnl976ChlZC7wECJM7DIX26kp/xsswnVs=;
        b=pU/tesP/70vGnWor5GZOQsujlqnrg1M5dIuyR7r2rPM7PQdPK8nv4cnGw/94T9pHa0
         OYqrTm6SZnrg3A1OpZZDJvREY+A7tKrKQv5IUO6+YwWq2ObNdNmLOZcXUFPqf2t+UP1G
         kZkGTI3Kr4zOcAKw0A7S0rcx2sLxWAXaGL1QpZTq6XzWlMxVfsfNgApGkeDhRQ+PxAb7
         +zc/nxhp2C3eviYjiV4aI7xNDvEXZ61rlDQLEUn1tNJ55E/k1C10ne+H1D3mzCKgMXr2
         B/sp0n2HUO0QiiAFXNv/xFT4WBR5rJvwc/JpDIyTgL87OO/4zsy3BzaWm50Y+QuZH0Cm
         F81g==
X-Forwarded-Encrypted: i=1; AKwUvBzRwxY3VPwTTWE30aAIz95n/13VVeqVANf/zMwRNrE1HpptpM1qxgx3NR3+Rg5SP4xX8V9mC4axrBHGSPZLsQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lkK94YqreaL0OUI4QCAXZpXWSeFnyxcRXXosWDkzz26N9KGc+y
	OOaF7+SXct5xF2h+Q0cd1A+jLgk40+tvqENvrUksb+kRAv7NSLEKMf+R
X-Gm-Gg: AYBFou0wd7z6/PlxkIKVaBSijFVhedRETWjgOsFzbkmPG7woowkQQCDS9pmB7eolYdB
	FMrPaCMFS7HIEs4ly5D74R2lYHmU+x7fgpd7d5nFKRZx16/kMBQZJl9OlJMflpf+lcDKU7nydxC
	R7oCO41R/V4bto8qqG6Y9phuJvi/uzlZa7MHsSzISX1B5BgkgGWfvJInalMANLILmP9KzUmjP87
	+5PCYWeGUcJ/PDKMp1ECTeYXfu2mqQVVjZQKQwaSLWqoWExudok8SBAjtEoO8IcWXTSiqjJUQ3U
	HmHSf2kAkonKerANy+NL55HnrprvkeXPZ+YZWINVHsUBp3E6MvgTMFdfuvm+1wCPJGrEQEvHZ51
	xm3QL7tfyY4x8FN+Xr+Tpp31l5BR8fnmf47YtoGL7A13y915rT7hARXcz+Q/RZ2ZeF4yA6yp4f+
	Ojo4guiY8QpDovWPRWgikw/fphMrjD7Qw3oushUTcqLaVQ6ni4c3PIlp2/Qgs3J27EfMslooqY7
	jANwBHj2UnV6FmscY9TLojAAtavRuoViUPqvQhLi95WWiFzDbVzFJnNYu5rMvxSr/NR7okH
X-Received: by 2002:a05:620a:bca:b0:939:1483:55c with SMTP id af79cd13be357-93bf552c2e3mr403046385a.19.1789865269267;
        Sat, 19 Sep 2026 17:47:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:c8b1:39dc:7ddc:dd0c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9126078cab2sm32122436d6.0.2026.09.19.17.47.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 19 Sep 2026 17:47:48 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	hannes@stressinduktion.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/2] ipv4: reject partial checksums covering the IP header
Date: Sat, 19 Sep 2026 20:47:33 -0400
Message-ID: <20260920004733.6473-3-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260920004733.6473-1-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip_do_fragment() completes a CHECKSUM_PARTIAL skb before reading the IPv4
header length. A virtualization interface can supply a checksum start that
still points inside the IPv4 header after link-layer removal.

This does not require a virtual-machine guest. A TUN device with
virtio-net header support is sufficient to reach this path.

skb_checksum_help() can then change iph->ihl after the packet was parsed
and routed. Fragmentation trusts the changed IHL and can copy beyond the
skb's logical linear head into transmitted IPv4 options.

Read and validate IHL before checksum completion, reject a checksum start
inside that header, retain the validated length, and reacquire iph after
skb_checksum_help().

Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs in ip_fragment")
Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes in v4:
- State explicitly that a TUN device is sufficient and no guest is required,
  as noted by Michael S. Tsirkin. No code changes.

Changes in v3:
- No code changes.

Changes in v2:
- No code changes.

 net/ipv4/ip_output.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a24cc8e..ff902a2 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -770,17 +770,29 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	struct ip_frag_state state;
 	int err = 0;
 
-	/* for offloaded checksums cleanup checksum before fragmentation */
-	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (err = skb_checksum_help(skb)))
-		goto fail;
-
 	/*
 	 *	Point into the IP datagram header.
 	 */
 
 	iph = ip_hdr(skb);
+	hlen = iph->ihl * 4;
+	if (unlikely(hlen < sizeof(*iph) || hlen > skb_headlen(skb))) {
+		err = -EINVAL;
+		goto fail;
+	}
 
+	/* Complete offloaded checksums only after the validated IP header. */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (unlikely(skb_checksum_start_offset(skb) < hlen)) {
+			err = -EINVAL;
+			goto fail;
+		}
+		err = skb_checksum_help(skb);
+		if (err)
+			goto fail;
+		iph = ip_hdr(skb);
+	}
+
 	mtu = ip_skb_dst_mtu(sk, skb);
 	if (IPCB(skb)->frag_max_size && IPCB(skb)->frag_max_size < mtu)
 		mtu = IPCB(skb)->frag_max_size;
@@ -789,7 +801,6 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 *	Setup starting values.
 	 */
 
-	hlen = iph->ihl * 4;
 	if (mtu < hlen + 8) {
 		err = -EMSGSIZE;
 		goto fail;
