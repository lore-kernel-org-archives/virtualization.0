Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C156E062
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087669; cv=none; b=ZIYLXnHJbYvDO3uttYxOhK8QhnDHIO3A2IqDHfdX/xD56ctYsNheyxGp9WZHCh4//47bKv4jDD7hWQtuFYIpCHPcEKSIeeZ8MVZ7eEBMu4KvOuSppKZ6L5WZ8DFQa1FwjCNDLsAnS3ByamFg2YC7UknTMXCGaWbirBeeFNjJ0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087669; c=relaxed/simple;
	bh=xAk9jUZ4tHEIPjhowarDu1pLkojlKzRtPIaVJYJ41As=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aHw5jAvz014MgWYN59NcczEEloInyUnnpLq1PRIYiiqAD6+lzfJoe/Clr75XldS47oWsVeAWpCLIcf8HQ4ityM5DjAko77I/Bu3qEWBRxrQZlGv26lbSp4Iy5nkaX8e/e78R2KUVMmAr1KMKqMge1Qq8HIjhEzRVjE7ji/jJKCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9esajJ7; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9esajJ7"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5e94120191cso3559053e0c.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 11:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792087659; x=1792692459; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nq2p8yOce4bNMEA6ygRhHxutRNrExZqu0Cd/fcqSm44=;
        b=N9esajJ7JbVjToFQ7/SvWrPlPmEnOGAI1isTRaqZ78FaBFW+CdgMF3tix0Xs1DaEOy
         Os+25nq2RntBaOqFmDNPnN72jvxNehXL2fZsKfI//1m8xtF2/AB33Z7/qdvc0YCDtG+9
         msjL/uHECaKeOtEYVugiggJeWPZX+LKlGS/9NgdbwJa0BUVqII/pgw+JP2XfRAriRDJi
         JICzJDlS9K6EZ4iHgUt/0Ew2Uoia+KHZYEMNBSw1E9v1Gw+vPPvVMwzb3YKEscBaJiRK
         wQL1QaGyszOuvumiVo7ixjDCYdDQ8XaECGsd7bVW/P90eH8peRnIhPPbIW3HNbIjPFCY
         gzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792087659; x=1792692459;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nq2p8yOce4bNMEA6ygRhHxutRNrExZqu0Cd/fcqSm44=;
        b=wBXSM/XCq8owZGkWvWFQiq4O4J7rfl5yAlghAYJmyxhiHReFKNLQ+c3IVdodm40Jiw
         lcoRO5KiJsdgoaaRt1BIGI2EqyjwxEvKXnFj/jWLNq2uzNuC6qcm6Gd06UKOaNqO4VSU
         q0nNte8MdJJf8DgsNUWkAp8IWpgHn+gnkYVCFGFImGbp3Hkz2x5DxRkC1IsuboXjWwZb
         6srWsygOzhCc5g1LZq0Nzg/RdOl/9elxXAsx+HWbRB5EnO28U/IH/LTaimppkQlYSkcW
         uAMtdQHdqRlgKAt/JnhZHWDknt1E9wP/kNiI/Fk7GeBJy02/B8oO0LYl0ZXcBeosm+U5
         zdDA==
X-Forwarded-Encrypted: i=1; AKwUvBzWBDO0HnmScr4VjVOaM6mdU2U1Xt5CuBn/gO7in/DQBWGFFSDfMnBw2Aelduds4blqPWLm5yGD/HleFov0RQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJjdFJNCOtS9pZ8g3J0mWVIPIL/BWv3IjEcOZBGLZz6im+OFPgk
	jPnBvfvKqjZLpohKxIcuJcgkGGRTI10KkrCrUQx+tS9fawCJq8tojOAO
X-Gm-Gg: AYBFou3jgx3oDRHm9AH6bmdwF3HiSj18XGDnxJwQFPCFvQsdsEvhA9C/cDs4PsQDOnZ
	3PnjGRCDCFyEuqfMKE1OJs/dh2yu+/kqYwGH/eL7E/vKWyhYF/kiNOi+Uv/xrB1pPiOGKL7wph9
	7Z3JqC10Xk9PzvgQ+Lv4O/IRt2EThITNgtOmEh19PFHZyjrf5BJCKw1kzRZgif0cgm4ewDuC+Ek
	oRXTSYISK3kuzv6VZxq90yTB0Ahw74N7YzAwLxsqWzgCppNXUeL65qr7evC+MthLMcYcMQjLZkn
	X9Cq+0h2V3cQKyLAuKO/qDL/zH90tLAb6fLFIxZ02G6wj1NENJRPlT2lxlo8EP6JlDxFWl6Um4O
	19b4CgaPdsNnLziTKqDmt/HlvVR9PIIZumwyKfs+zaa2irUfjJwVX+eKTncAqp8456pYbnYiMor
	XAZQjuPySqjoVQk6rXmJGkF7E/GZSe3HCdj7cuLm9iKcRakQVK6vVavaSEwDNOX//pPA0D1LUdz
	NShzpLiLbFMfJyJzMR7sTHG/X29JPOFvV6huQmIrCLoRD+G3bp0/ci/ypZT+nMKKMFj+jq6DdhD
	dIF8tVbSU+8ote3IqUVAgFEDWle1Xik9lC6uEQ==
X-Received: by 2002:a05:6122:8b83:b0:5ea:389c:51e4 with SMTP id 71dfb90a1353d-5ea389c5604mr1033114e0c.2.1792087659373;
        Thu, 15 Oct 2026 11:07:39 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea99491db7sm304799e0c.10.2026.10.15.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 11:07:38 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:07:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Paulos Yibelo <habte.yibelo@gmail.com>, 
 Chris Arges <carges@cloudflare.com>
Message-ID: <willemdebruijn.kernel.18c52b086550a@gmail.com>
In-Reply-To: <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <e66f7984fdeb8168e07fd7d0dad3deb8c30ead0a.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 4/7] net: resolve uncommon partial checksums
 at ingress
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
> others, credited below, found more ways the bug can affect users) a
> virtio net header can place CHECKSUM_PARTIAL at any in-packet offset.
> If that state is retained, later checksum completion can modify the
> packet after protocol processing has made decisions from it.
> 
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
> 
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that shouldn't happen.
> 
> There's some risk here:
> - non-gso packets which can't be parsed get checksum calculated in
>   software, adding performance overhead
> - gso packets which can't be parsed get dropped

The biggest risk I see of valid packets reaching this path is packet
sockets that are not bound to a specific protocol (ETH_P_ALL) over a
non Ethernet device.

Iff proto is 0 we could try to infer from the first nibble at the
network header:

+	iph = (const void *)(skb->data + nhoff);
+	if (!proto) {
+		if (iph->version == 4)
+			proto = htons(ETH_P_IP);
+		else if (iph->version == 6)
+			proto = htons(ETH_P_IPV6);
+	}

