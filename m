Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF5218E1D
	for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Rqtka/Y6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e760e5b49so15101145e9.1
        for <virtualization@lists.linux.dev>; Mon, 15 Jan 2024 11:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705348127; x=1705952927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DEN/kfezDxdwFbQ4SlzRu09sYlvOCv1vm2x8xUmb78=;
        b=Rqtka/Y6HWBvGNoR856xezPNeb9j3zZRQPOa3jRV9rzC4r/dxSel6winIQYwJn1aR2
         Sm6MMbrfzA59WBS0Vhab2E3K0fZ62OXNe3tOu2N63KkjPAO+WGr5Reae+AT3Q3/B5TsD
         0ZjLb/BJ9ulsvu1TvAaStiXKAfSkBeWmBkipzBbJ3TSIA3wWobJ+7TlK30Fn+xOJh8Qp
         nMZR6yuovnSffEkoLQJsR219XjjXrj4z/B0+gJP3ibbTrpEInrj5k1jxWADU060Al9/F
         oFYM6cOBmEKuuZsPmyWPSR8qyfuECM1ih0GNsAtU1VjF2Q5yF3blGYJd9G2zd2SqZHgH
         HIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348127; x=1705952927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DEN/kfezDxdwFbQ4SlzRu09sYlvOCv1vm2x8xUmb78=;
        b=IHrz0lKiQdd5MyI8N+kePPKzqRpf1Q77nMwmC3VQliTmClVaa6S12gaedJ+ViQ/FZy
         vaFoA8qw0oiXEPV2nQrWI8lv48g+kFPzW+KnaruekXDvrlZdrpl3wq28ce66KIEMr8Xf
         FOa1QN0jcLs9+7fpLjw2wSggptXMSAJ5x43j2lI/5MA1uYq1z3hGnyYTeI5LX5oRdzWa
         RcKP/ItIw3KK7iNFDOr3fKOCeI4nmURRXgUJWoGYnG02Yckapl0JokxUnVNMomRWseeb
         fUybAYje0NJJm3/au/I4c2FkapfnDaYBK2ao6XLD/OmcUuCDPs42OVpByw9ShMreuxV5
         FKcw==
X-Gm-Message-State: AOJu0Yykgcgr1b2+jg785z7nMAzthghYZeo5cJjtOx2yrgZdeREA1tGN
	/6hGVwbVz9OIKbZXcKXWdCr1if6idAm6+g==
X-Google-Smtp-Source: AGHT+IGHQvohHr6QjMCI0MT7RoVWkT+LEI7gQrcEtT0MX+h3XouC2orBPtN6UWXuW+i4Otwhj4e9ug==
X-Received: by 2002:a05:600c:450f:b0:40e:66e0:976e with SMTP id t15-20020a05600c450f00b0040e66e0976emr2021293wmo.89.1705348127562;
        Mon, 15 Jan 2024 11:48:47 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm1957377edb.45.2024.01.15.11.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 11:48:47 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
Date: Mon, 15 Jan 2024 21:48:40 +0200
Message-ID: <20240115194840.1183077-1-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Qemu launched with vhost but without tap vnet_hdr,
vhost tries to copy vnet_hdr from socket iter with size 0
to the page that may contain some trash.
That trash can be interpreted as unpredictable values for
vnet_hdr.
That leads to dropping some packets and in some cases to
stalling vhost routine when the vhost_net tries to process
packets and fails in a loop.

Qemu options:
  -netdev tap,vhost=on,vnet_hdr=off,...

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/vhost/net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index f2ed7167c848..57411ac2d08b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtqueue *nvq,
 	hdr = buf;
 	gso = &hdr->gso;
 
+	if (!sock_hlen)
+		memset(buf, 0, pad);
+
 	if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
 	    vhost16_to_cpu(vq, gso->csum_start) +
 	    vhost16_to_cpu(vq, gso->csum_offset) + 2 >
-- 
2.43.0

