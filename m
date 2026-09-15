Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00063A48E6
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481767; cv=none; b=pSRIN1wMvQimNFSpI8G7Jnzg+GxgbZysglvR+KGTlD3pUJ48TZEF4dVctzxrzJGKN4SZ5KJ4lSKApDJjWCEWx4Q70mDQ1ylcFQjJk72xnQ3j79UaRV5LtWvbmwXtE4JxLGUI++ahUVO5oFpxXq0XovrW3XXHFINGoucK4WtYJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481767; c=relaxed/simple;
	bh=fZFg/j3pb6twOqqBfqfH5ANDxZSW/qTsavhnzB5RzzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRUc0Zz0jhOGUFblX3hoc43fTR/TF7LZjZ/B2A2ZkjrUfZiAZa51Gc+xft1YamNbA9RVJEPl/vl9lkZHe7S1wi5qYBvx08qzUam+XTznWGPI/tJTLQ1PnNjXSmXVrRU0JaMHO1fiJkYdSl8TAq6Pyd9YhUhDoE7tdJnUSdO7onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJZrO/O+; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJZrO/O+"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e2ff27eso2603589e0c.0
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481765; x=1790086565; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fJS//1ZgrWfO+Hpg+mD2bvTEqYipgvOVKK1VwTdF1g=;
        b=aJZrO/O+HmtkX354smvxo4BWN8IHbmjreskU/HqOfXJyrGZi40Nje7BMdRcx/0YhSx
         MshtOxiAobsOgLpw6MYQYk7vhRoxQgOTZLvwl+kRhN7G893GiKfKEQkqTckyduXAWnS7
         lz+2u7e0xEZhU+tMTU61oEefvpqry4936C8n2UhIBXqme1zIPYtafF9eMOYOpqhun+Mi
         +1mwtcDzNb/JJYxHTWaCyQUT1JMB17BF8d7DOVB9r58YKm04EEYlfivboEMT4xFnRXXX
         OoW/ODSv1g/TdKz22cMCrhOa4UGrCqUoRC3JsPatGbdNYgAUgf997Mgga5KOHR2FKTOO
         RiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481765; x=1790086565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fJS//1ZgrWfO+Hpg+mD2bvTEqYipgvOVKK1VwTdF1g=;
        b=EZnLyp0PZnd0tuzcmeRwi2JnkBk4jOxjTQ/1GSZeoxJKUo9ZVZisB/X9xXGUxtO/05
         oPZzJvT7+Ia04+wQmNLbFfNb/XGwgbVo/u/tVw1BOlmbI168PJCI/zIjpleOpK5Dw2c5
         oXg2Jri3ramma74kst8LnFUyXv2gJPy5HwvV2gNmuX096hPGKtUJJIJUR01y1bqUug+j
         A3FSEdv64g3uNWwmvCBqG9JgQVXffvfKceZ8wXmvFgBTBTXVrm2L6yoJZUom3bqtjMKe
         zR/4ZT33oXrXEjBpwSr8OQV+T9cNS4nOIbmHeOyPTXTl4Zlnxt93ajmC7tJeytRAkFLT
         tmXw==
X-Gm-Message-State: AFuF++kSBiqJzByUpW5rnOARzVdQjBIGrrE0HwjLcEz8FVucGqLGVPe4
	4NpZi4dxmCT/Y2b0TP27L39APaJBoMDLxDHorzT8BpekgI3G9Tp3sHu1
X-Gm-Gg: AYBFou0IMdW9gZXgPr+QWD++SCdcGmLxBG7PawG5RkxNNmfltUz7b7ATRLy2nsUFsOk
	33AS9SuvS9ZydlhfYAc0iwf8gE0naKfPvpxiNuqWKGZxPJkp3gjajSJB747+1tdJNz0P3HBVhol
	iwOLQ+w0wsVLCy2SUBkMQO3lfIdoWKVOCW7GwdRJ3P5QVGQvgqHB5UFXq+sJPLwosNgR/ptff0/
	5+odGrgu12t7ZZvGFGaSCrOEKV7uQQD9RH+ZnEScfwxWR79Q92WOpr65V50Q0n/0HiT/6Bpnlle
	iiZ3bI1TdHRtwdZ7Sfqh93YLIhFagSHVfifMBJx/bkMbT2wNsY/hF+noiBG2kkKt3fh1CWNw3wb
	mX/nJbDHoc9PTRZDFycHL1MB+e7kBu3fSCEXubWS/X0wlvRBF/BknWYx1/oFw8UeERpHWoZcsKt
	lRTfVQsFObKWU9htw5hB5md1VRz34WuecbCFwdt9RA9pOdgjY6hDC2xSq2Ck/AJ4bh
X-Received: by 2002:a05:6122:2056:b0:5c9:82a1:a6a3 with SMTP id 71dfb90a1353d-5c982a1ad55mr8136390e0c.6.1789481764710;
        Tue, 15 Sep 2026 07:16:04 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c84716a167sm16029131e0c.18.2026.09.15.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:16:04 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] vsock: ignore empty child namespace mode writes
Date: Tue, 15 Sep 2026 11:15:47 -0300
Message-ID: <20260915141547.3010692-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915111417.2726515-1-qwe.aldo@gmail.com>
References: <20260915111417.2726515-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__vsock_net_mode_string() returns success without updating new_mode when
the transfer length is zero. Its caller then reads the uninitialized enum
and may permanently store a stack-derived value in the write-once child
mode.

Return before inspecting or storing new_mode when no bytes were
transferred. This also prevents an empty write from locking the current
mode.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 622dbd0467..816d25b314 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2883,6 +2883,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 				      vsock_net_child_mode(net), &new_mode);
 	if (ret)
 		return ret;
+	if (!*lenp)
+		return 0;
 
 	if (write) {
 		/* Prevent a "local" namespace from escalating to "global",
-- 
2.43.0

