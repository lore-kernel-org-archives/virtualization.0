Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860626;
	b=l9eElLK5REJcF1rW47ui37xYbLIcuBfHmiDdNeC6O7IAg1ntKmJe4ESOLSPs/HbB12LR
	 /SEoKrSYU74w3gik7P6ESNNc/gfxNoLEf/C4I0SYnSJUZv+1RfGRgHaF6H89r5ngFpF4n
	 iIfPXVyKJ0DURhXAnp2/T9kcl9Wy5fHSgsV7faeSWlXg2MiFDV5fvnTtb4CPQogCYk+zK
	 3NfREq2CpVc9HUX5WvICqnjfX23PAHK81/zMtlq+bJOkgCxYjYPatyIUHa/nvgHv24fpg
	 c+Ascuisbp79gzhbwZ6OCz+FfqX1HnBHmPXYqJ7a2OuZcbjPG/q7z7pRIsMGYz/6vPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ri6QhTI7eIqC2wOgZnfY7LlsXr+RKpA1hIBgc4QsOtw=;
	b=ybR7NPzm1ew+/YCQ1Hl5WNETRPmyVg7Jw7l0DS/A1gR+29S8wWEXIfNiRRideok4HAnl
	 Blm7WBGoJ2xgzUVmoFTdsVR3XnyQf2dKGxBxggEnLY+7vgGr44cSLxKmgtsGsUpzN9fyp
	 WaQReLDQvSD+WbfiUg+1Q5bPRgtRC/7ZRPAcJn5mIiqoOwDxSy4E3p4lFpza4j0vEZO0p
	 4Rs7MEuEKQ0henq7riIai6+SJ2a6UemnawSXnhe/JR1Hg0vPL6G+IpVJ9NzRp46XC46yO
	 n+3FJDLKBIpPzpvONeSk8VgG0XMwplDKyLSY8GW87cPSKQRgs2UiGVWIYbDyF2EyfLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJjO6DX+;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825D606A32E
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 06:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2825D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJjO6DX+
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso2085526c88.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 22:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793860625; x=1794465425; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ri6QhTI7eIqC2wOgZnfY7LlsXr+RKpA1hIBgc4QsOtw=;
        b=sJjO6DX+5wT5in0Iw35P5PK2JoxXbUCxrK1sDlq+cOFkX7sxOMPd4HHnm6sn63NM1D
         a8qol0ppbfVkHjd78ii94b5EwlCbrc/i7tqhe/89AVr+pvg5d/AAH4o4bmyO/gZw+MIk
         qaladwsDV5QSCQvG3HE1vu+SvIRFoY/hKa64kmF3zkLaDvfB8lKaq/KXsg/oTFyHHHdM
         x1m5HZxsm1qn+bQlJ6Nq2bsDLRVHHlqHyqFITKfx++rUgCZKBTtN+Y0t7KvxNDk/WIH2
         LiJDm3++YBtTivCPi7VQeMVBQIOlJH11D78rXAKBJFlkMG19mPuxCsuaCYg0xM33pnxF
         ua/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793860625; x=1794465425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ri6QhTI7eIqC2wOgZnfY7LlsXr+RKpA1hIBgc4QsOtw=;
        b=M3mo8c0t9WksE6YJ4xRM82vQxeukOOzsDifnQ3VgDDZThRr1dUEVS0W0q7jMl09rdA
         fyF8V4Hfu8u1iCepS3rjnzJGrRdlOKAzG3Vo+oI0JcKVXb570z+xal+6o1cg+Ux9PSS7
         EBClFpFHMTjxsChuSLOGvSllyKGb/jmErn/iNOQSaiOuxyaar1QEXy5LqArWezAjeb6h
         9PzYXxQdBVrI4ggQKMG3yrqMkOl6vL/ARIIETCVl621DZ8rECZzpP0Weg4yhf+tYi3gT
         O/H731dv1O05+RdXjwSrjfsE8CU7MHeWoKs0F3PGqJC3BG4SlnTlLDcciJERIWQXltCH
         5Vhw==
X-Gm-Message-State: APuU4Z+zhzcSvWZoUhIRrcCuSpJqAPMEpiUfvwU6mm3flZWktNFzoQ3L
	mtYKcbw8AhrapGGnhcFLVtncDbDqEw9Lyk9RTS+bNU6OKLbgNFxbjB5n
X-Gm-Gg: AYBFou0x50kzaSZX57L1oEZBTPyFN3vFW3cDU5GbcnINzVh7AVSVHie/g27sNxlmuzN
	yHNwYgaSltgMcC3UMKHpK545QQuqe6KCh4PeNcSNJxPsaLWB0+yBd4HdOq91qSiAYqfrW3o/h3R
	d98em/UHln7eDzQfk21Ico7BQrAW0bBu0a98dbRysjkavlMaVMR/8SUvN5247gVV+hwAWlX7k6j
	aZiFhD2dpFIsawdkNPOPiohILdbVKaTAu6PeMrdB878FmEtNZzJgO3BhvoOI2h6dNn6kk2oMgDi
	jayZTZ+83mHGVZpSZf26KbEhBkvRyZKUzKWCji8eGM/hxrbwcUvJGw4BtgE75JAyTSdAjO2k3Lk
	/w8hTKXZ7n8z2RA+ud2FinT7tUD3UzNbpXBIFjSX0XKI2JSPKzKmINvvJ/h+yxmmw16GmaP7Eqk
	K3BF2pqWCV5sXTPCtsP6y/26cyanVxA9+QeeWU8IRtz2VzFZaR+dbTL7kQ5Q53yPxCXow0c5zNG
	y0BJRrEvt9SJzfGNeUnVCAZS9kR2DdKcMhR51E+giFwy3hPp/F6iWOBhRdijHQhFZ0DToWB23Vq
	N1ISJ/FfbdriwX8U2SLJhPbLbveDkRhsurX6MTbd3kX/OHbkfTw+PB5Pih2IJrq9PNhyd6/C0Qk
	E
X-Received: by 2002:a05:701b:455a:20b0:1b2:42db:8a54 with SMTP id a92af1059eb24-1b242db8f29mr8683525c88.23.1793860625118;
        Wed, 04 Nov 2026 22:37:05 -0800 (PST)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm13148900eec.5.2026.11.04.22.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:37:04 -0800 (PST)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] vdpa: alibaba: fix typos in comment
Date: Thu,  5 Nov 2026 12:06:53 +0530
Message-ID: <e68b7938e19affe2b18ba0ba9711e079fe1f7084.1793860522.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793860522.git.hemanth.selam@gmail.com>
References: <20261102043526-mutt-send-email-mst@kernel.org> <cover.1793860522.git.hemanth.selam@gmail.com>
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

The comment above eni_vdpa_set_vq_state() misspells "specification",
and "ENI is build upon" should be "built".

Link: https://lore.kernel.org/all/20261102043526-mutt-send-email-mst@kernel.org/
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 1288402d3dd8..af163b4f9259 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -276,7 +276,7 @@ static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 	const struct vdpa_vq_state_split *split = &state->split;
 
-	/* ENI is build upon virtio-pci specfication which not support
+	/* ENI is built upon virtio-pci specification which not support
 	 * to set state of virtqueue. But if the state is equal to the
 	 * device initial state by chance, we can let it go.
 	 */
-- 
2.48.1

