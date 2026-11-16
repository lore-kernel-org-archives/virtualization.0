Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821101;
	b=AI+JMQJ+dK1tRKG+hLuQDOlsnME00p8TRMYnAK5HvsTQrouajel9g9AkXEAaSFJna/lE
	 8BDvFQYDFOqw23hRieU4XgdJV+gR452p7pTuvBZRK4+WICJrwTLxxr2Y7HHWpe28E6OzF
	 7uvj3zKSt78x0tUIU7vBMY/njQn6qAT9Yq17/TBe6wd1Hdf4FwfcwuHf9Z5BBrdyBt2nB
	 zu6jh3r+7NMVHlwqnagUolPehzZ/50Qiyw1kGEJn+xoBWZAD46zINHcDW/v418A1JqDBP
	 wyiL7hhKnmu7DwRNHOFyZ8MB9LoMb7Q8c5fUJdIG6XHdO7TSvlVMUq7ZbwaCsHXrm+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+kzbAXF6Q7HKw8jGGGgdN+4kZFhaf1FTj8cFnPCPCbk=;
	b=dT/1hKioDqDhy9KdGHHd2k7O7cwDYb0hOvNGBAGWzMZkOpud999kzc3ZwxrQtqL44t5M
	 GRNP55PQ754IRxENTQCYHdzEfV+r/eQeefjBBjGWgA9Y0KbDK24WzlikXhdPROqzcbPn0
	 yViNPfgF/2cCRO+1u4Dt7SQHD42BCvc5IiNvCsGmh9QCu/P6GMYfShD4quIfccGCMUsKc
	 /ByKwut0u2A16Q9PejEifkFDFtsQvc6+Ulye8DxqkC6Gwm88hN6xEW+CanDMPT6jP+FRN
	 lDfN5SK8e0QJSePPv2N2HTN/7RO6gq2GAMnEFxS6kpvDp2EZUplbxcxTZ8mAdRfv5Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=J1XjsX0+;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287C606A330
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 09:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A287C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=J1XjsX0+
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso3867050eec.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794821100; x=1795425900; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+kzbAXF6Q7HKw8jGGGgdN+4kZFhaf1FTj8cFnPCPCbk=;
        b=J1XjsX0+cfronFklkQMaOrC1wGRM8BnuThHC2NVxcwMfbez1eZQnm5qFyEL21LKhf2
         h2Dr7ku99IMwLHWOLDAjP+Frifl4pNfzhDV3UTX7IBYr49TwOObYaayLVYdyR5iL+Spf
         rzZXi1ZqrdicItsTa8ZeeWx13wsiGmi8rkRxDNeaL7ZV4cl9dgucyyTfuFbMtTjXbsEQ
         YGPcyQ218aJ8p47TsduKSIEe/OPRRm5jNggbYUkWnuFDvNipGSN9eC17fk4IC5l2y/aY
         1NLsODwwaYZlIBQO6oGKadRUmxsf4GN1JxD7h+UsmujO0rIdl+aCFWRlYLKSoeF/Q2tW
         hpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794821100; x=1795425900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+kzbAXF6Q7HKw8jGGGgdN+4kZFhaf1FTj8cFnPCPCbk=;
        b=XSGrmlwxo16bR+wx8fYnxhw1dpQ1NemvSKhrvyRiKpuaF9R0g54cKvNyQw0Xm6ORIl
         euOtuNPHh2w90P9WxtLOD378cQwlYA+tSFOzff7DMYFgwZkenBrE5RZ/ehOFPC5K3QOw
         +1xFNHlSmvA2yuT7FFYwhVRGEgVxyOZzIzc2Ptbkt1CK/BHtaqDMrFfm9QDhKfTSc+7f
         R6e4uCtpSArD8q+B6xVak6CEH03U1O1lZPYDIujOLYznXhtJNXD+jtNQ9EAXihh6iol2
         cPQxX7AXx+Pibb0D5ehYfB3r8u7aZvAC7gNSaYj6zhn9NZP5kOm0dc8eR8AupvpYljQC
         le8A==
X-Forwarded-Encrypted: i=1; AL+hErGnCjbuVjsjqhGNLdRjapjuhnBoASyCrofKt8in8sOoN+iqwh+GfUehTWdFwGa6LcKwUJn9QNxalrhmbY24tg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9NGwtYMJSMVINa8V63OILyHhRpZboSSTs4O60zb6VjJaht6VN7
	lpwalkoOpYaE9nfmJJ1nZesDolVu563BKnd/2pQCKa4BXu5UJFfzE9eunYvRRfTomg==
X-Gm-Gg: AZFdTZflgFJrRIUqk1Dqs1y6EpCmdq9wTSxlfIm5SNwInvcAqKOa24M5wG3pe81Xu//
	/8jLU7mzkWRDDCVv67+qvBqOocGCqDGvse/Nl0vyum4Pbr+s1aubX9DzGBKNDbyv88+JbfFrxYB
	cbNhsZusMsXbcV6T93ivXQcbbrqDvKRgDiAEo3/sEEtw+SPZhfHV7zty2jVlXjiUoEpnKSnQc5Y
	xx9QKA4o/BKzoaWScsW8TpTyg0GvvU8IhW70hkV9M5tqSgRvSVdXDNDaY04vbfX0da49lTl1yPR
	3l/0rg249RZnK69TS8VoyCALSnuDsaZrNxHR5W/U/heeen/9KzZMr4zM6KcrLxyAmW7MUKWTREI
	LWcnZ4TeT/3fWjuOK3wLR0cb2c42ew2FulapZ5Hy6dTQ5O6x4Z9RIIIzS1EUFcwmBaDxWL4Ttw1
	Uoy/kNl8tqSPGHUIy/FauewvVEmOiLIdzKTlVbgo94twwgy5temd/qCTfjzE6QHJI0SdRt0uqrC
	4ITmAJDCWR3MMkVre2Dfn+GRg+BXSfT4pVh+7xHMhfnT0IVRIw99xlK8eRbAiaQpAXVsiYczbRG
	Qi3ggYP35cWNUCF++uVvIpGZZEPO377qBhzGiA==
X-Received: by 2002:a05:7301:6184:20b0:36e:a179:85f2 with SMTP id 5a478bee46e88-379675fea57mr9358295eec.23.1794821099594;
        Mon, 16 Nov 2026 01:24:59 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm32056314eec.26.2026.11.16.01.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:24:59 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>
Subject: [PATCH net v3 4/4] virtio_net: report a failed stats command as an error
Date: Mon, 16 Nov 2026 18:24:45 +0900
Message-ID: <20261116092445.3391334-5-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
References: <20261116092445.3391334-1-lian@is.s.u-tokyo.ac.jp>
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

__virtnet_get_hw_stats() returns 0 when the VIRTIO_NET_CTRL_STATS_GET
command fails, so ethtool -S reports every hardware counter as 0
without the "Failed to get hw stats." warning.

Return -EINVAL instead, as virtnet_probe() does for
VIRTIO_NET_CTRL_STATS_QUERY.

Claude Opus 5.5 was used to draft this patch. To test, the virtio-net
device in QEMU was modified to offer device statistics and to fail the
command. With this patch, ethtool -S triggers the warning.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261110001659.1654289-2-kuba@kernel.org/
Fixes: 941168f8b40e ("virtio_net: support device stats")
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
v3:
- New patch.

 drivers/net/virtio_net.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b9b6c915b6f3..185ac95b9b1b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4980,17 +4980,14 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
 	struct scatterlist sgs_in, sgs_out;
 	void *p;
 	u32 qid;
-	int ok;
 
 	sg_init_one(&sgs_out, req, req_size);
 	sg_init_one(&sgs_in, reply, res_size);
 
-	ok = virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
+	if (!virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
 					VIRTIO_NET_CTRL_STATS_GET,
-					&sgs_out, &sgs_in);
-
-	if (!ok)
-		return ok;
+					&sgs_out, &sgs_in))
+		return -EINVAL;
 
 	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
 		hdr = p;
-- 
2.56.1

