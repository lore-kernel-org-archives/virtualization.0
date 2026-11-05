Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860630;
	b=L0DU7aWyvLAlJbyader5IzbZTxnAOAVdwhGWZn9qfnkQSzHld/emPkj8LiDgI5EcQbVa
	 3O4Zlcf+hBtxBlz9+pxSKt4aT6x7TaIrw98/7AC85s4mqKlCYq+E9zLBhdb9tygCRFloJ
	 GjWFrjUCrF4O771vAlK0Ed1LrItVfRX4ErLjOlvPhrGMWN9JoonHmwOniw4XIL4huaG3i
	 N+6PicPQ1NlwNtKPUnCH+V7GtIyuhJMIw3wp2I/RbP8gZ/Nny88w6lgdOkoeD2KLGXU0j
	 vbXZYz0DR41Zbex0OOsprr2CwluHmzeeKJ5+jiGmgSuoHxHIn9/dUNaLS+5JGXTEOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PgBKQLIR6mQBdDXOIGUuD/EXxFIBtVanX8mMwu7/ytQ=;
	b=3RVzKeg83G5AgRiIX9MkfmzuWpEf2ghWFOTUoINYvuHsjICy1bNEI9Lvblt3qmkbI5eE
	 lucazF7XuVQVoA5cIT00btLwI7p7ahh598GW1nKF9wPKRAY6/vAWNRreITicvEqlWrUKV
	 pgMxpGEWS+nlNHh+KMtGFYnyaOMxuJ6mV319q0geXGA0SxPtzIr7SDsvbl7QfgEvPV26k
	 QUf5kmrtWOKQ+UaTl4fxzkxhL467oLxa8/cwcSHGcIVbqUVs0RcWsKFZdlXjc5Eah90eR
	 A1/hGUM6G90Veoyu/qetZTQe8dVWkx7aSTVxMNHTKmOQfOnKnfmX2jnGafvCk3v/0ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WirzNEC9;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AD606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 06:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D8AD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WirzNEC9
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36d6765756fso1633316eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 22:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793860629; x=1794465429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgBKQLIR6mQBdDXOIGUuD/EXxFIBtVanX8mMwu7/ytQ=;
        b=WirzNEC9SHGmSUVOJwOqE4/AdMBxjiDU4dThEDgMbKnOae+A6+hj+Y4Yw+wCZhM457
         xJYLpQ/Tw+TlHRXdBhA1KpgpWOwgXz4clLCrH2/PEmSpDOV3JcApRSLmWt6HAPEiHfbG
         XlWENRvHcSzcFyISTewjLfOJEYHP/YpahLOnIWxcCzLeLaB3SfwSCA8EM7DPBjZqWhHG
         ivMz3OdD5r2j/FW3KaFowIez0hVuTJXPoU9VFsCuQL8GTLkAT/xU0bsUm1uJouiedGQ9
         mSjFQgzhgZLdAcM5uiEwEkXiG6KTHknJFy1DURDZESwf2QtdiguGQ0/kmIVp00aN3/w/
         bYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793860629; x=1794465429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgBKQLIR6mQBdDXOIGUuD/EXxFIBtVanX8mMwu7/ytQ=;
        b=1RKcVoJtBXRQ6F7hb9xV8rVS4qtboqiNudaclcsUM+GaPEvB/JvttvAQnIBX0Y1yNS
         9MVUDZt+AOQHOuCqblekZ97SU872kpRz/Bn21E6FtQatTY3lqTIjQ+JJ3gwfA/lIdU4H
         8ddrRCVDhi9o6ZULGq4zU8aUzFnUC3pqbxhCgJGVNmnJV3+P4Y8FZgQDg4QH3MK40gZh
         EANlbbCzBNbiKxOCNRPfqY0c1PA47Q0v7esslSUkVYy8823PDpbsuQz2pY4ETw5iydCz
         GpolMkzjnzqoCKZEKUTY9+0sFd7vzAZ/yj1pbRh9DCwxWntvxYrrTSYvnpeN02Uhz6PR
         YkOA==
X-Gm-Message-State: APuU4Z/ZI47GsgKZoaPls88PXL3w1PHAPzSThdxqZ1//0PhgRugFWI2n
	sJYtz3AJcU+B0QUfSOl/U6wd8AfgfmnLB2tNzZLr+MLQpP/8FCrYKmMU
X-Gm-Gg: AYBFou1jskCH0H7fVTLEPnezMyrGiovK0LO3w70onf50xSqTo2OytYV6idFzvWkq0YW
	KBXHX5zPc6bovl5EqgtgDFJWaOmwH9vt1NOB9ZkAOevChXWG/K6dihH9PmzJf/5k5C4LQ3nAU8C
	kqC4/05pSiq1kZbE8W8MqSsoxgTGc6EUTMbcEYkSZ+h4pb/Kz6RqfqnIc62Oucc8HZOAiFaSRIk
	mUtRQHACgZG1ozMMVNlqnHpxLmb4vmQn2Um5XaCmMv0OQiT05iAVH2g4f4/+Qzh4T8IcUFXa4xB
	sowqzyFnMA1HMQOYZORWfqK/kwS/uQ32L31KAqF5XpFbZJKfcvd1/j8vRExjX2osgdwCkj0hSG+
	VJlyWXY5lYV8FuEOqIcUBhAgrtzvUavx65THdnP6289Qm3F0i6+FprnrKlmNosRHpgPigM3v1R7
	Dn81t3fgPvkGaA5arog/hWmYlH0hjs3pzr+ku2zwCpNaUTsXh11eSF5TeAwo5Na0qRO8kuKgXXQ
	GZunUKjsJVUZBcKieIJBEgEKYCTkF+ipufDyu/C/cLH1phBLyU2CWJkWkr9gZn5YLUQXPGxnxet
	EXYZTF9jEWa0ufTJMoOIDT92faIpHd9ROdHU8ywehtaKbpxYcvf8vA==
X-Received: by 2002:a05:693c:88d2:20b0:36a:6d52:e16c with SMTP id 5a478bee46e88-36a6d52e261mr15954485eec.12.1793860628633;
        Wed, 04 Nov 2026 22:37:08 -0800 (PST)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm13148900eec.5.2026.11.04.22.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:37:08 -0800 (PST)
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
Subject: [PATCH v2 2/2] virtio_net: fix typo in the ANNOUNCE_ACK comment
Date: Thu,  5 Nov 2026 12:06:54 +0530
Message-ID: <181e5d6e056f326b8531f17bac7f4e138812c540.1793860522.git.hemanth.selam@gmail.com>
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

The comment describing VIRTIO_NET_CTRL_ANNOUNCE_ACK misspells
"received".

Link: https://lore.kernel.org/all/20261102043526-mutt-send-email-mst@kernel.org/
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/linux/virtio_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b..4a458ebb2567 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -316,7 +316,7 @@ struct virtio_net_ctrl_mac {
  * Control link announce acknowledgement
  *
  * The command VIRTIO_NET_CTRL_ANNOUNCE_ACK is used to indicate that
- * driver has recevied the notification; device would clear the
+ * driver has received the notification; device would clear the
  * VIRTIO_NET_S_ANNOUNCE bit in the status field after it receives
  * this command.
  */
-- 
2.48.1

