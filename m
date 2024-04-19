Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05781754
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524929; cv=none; b=rlg+9IKi57gwaqzv2we678C5UOxK8m1TyupMdlTbzd0YOLardmCVV/uiLo2KUn1aUbAlRz8m6BS/oD5TRwG4xwnHpE2at/0AYNyqs0IMFDhPb1OUdtYGpnn0wCsh7ykX/HXEeD71w25Jl2BPxP65ZgxUIWOCp8/INa2BcVdSmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524929; c=relaxed/simple;
	bh=5Ihm49/gOZVBFXJiRL0zEQqhoh6Us3hM99ueJay4DGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEI4hmHNilJ9kNQEwXUMPxDh58dPlITmh4XCS+vUGES37Oc8ccEvea0QMCTjZDbTRWLKU46cHRcHI8fqqwEI3PMSxE6ElwQr8CDHNrdUmizsQ1KyuXgVOy+ra1hTklsObbFoenMbENvNuWvHfH5iIquFvM/Ggfli2MyIzQsUsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvMJtKSD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvMJtKSD"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5287336a12.1
        for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 04:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713524926; x=1714129726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg0pL2CVxV49Fgeqn+qahTZ1Z4PbsN7awrFUvCLM+ng=;
        b=LvMJtKSDa04/ywAtGFh/rPHnqnHuY7RP4+szd+xf9t/p1pM3sht/Ehq2nvYjwRMLdQ
         9Oyn2hKXDQad2LWqRXq+0x3bRexU3HyvMkoHRQmSCxnfwSVRaM63w4aNJjt71OidnSZQ
         bn80IUC8kEhrNEWaxcG6oqcuTp7xGEIF8cXGm+YVENMkBgTd6vdvjYcihrkCPIRtv4C7
         Un+77WHB4pRLDi8qA2wHpPX5bIIGEIsWg/h0LDVn65vTK34lgikDRtO48CBu1EPaLuYf
         7gubcTFzSxftocSdG80s+o213lgJ4eAzXbMXnteK9F6q+Ovjr/Bm4/bW8Smvj+EVFE3M
         u1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713524926; x=1714129726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg0pL2CVxV49Fgeqn+qahTZ1Z4PbsN7awrFUvCLM+ng=;
        b=Gn3zhc3stg09WNyM40L4KcbxtEtQSqfllAQw/jVaTq68aS5WeahwDF00RmnzEl/gVO
         KhXL843s7ZhA/pG5K8qkux5ZVk2/vbZ1vqRi9c0HNgUKyyjf6KutXCqUqQ+H8bDq4Lmx
         DkhPhIql5/3CCSDIRkToP42F/JYqBwNIBErd53h092igCIDEpVGE1JDel6EKuGl3IAYy
         2+58QDZHgtPEf4XlNmK68ZEADA0Zjcp/LS4mAIuwT0mQlTAly0NqNypRx3hKpXNNAh85
         NHx3g0ecQxLxM1mzz0UsjwPejV2rvQ5IDYFrfRIWxdTR6fzXbNH0xcUU456Rxn03Oe5E
         ZGDg==
X-Forwarded-Encrypted: i=1; AJvYcCVVtQcPMKMndwqJ7g30SxXacJ30yQmSlzwcYw7ZqzoC0WB/8RjtkkKLFuOpXnzk6T1JgEKJzG8YLbl25l4QJTBHqQLR/YcFbR21HQPpygI=
X-Gm-Message-State: AOJu0Yyn/VbrNRhgnxXp4g79LNVimLR+WD/gEAngQHpmURI03h4xQgX0
	3haWF96A0fhctR9cpPATRNKuYdVFt4ZPHld7rGqbxWMkU250E9Bk
X-Google-Smtp-Source: AGHT+IGlNNpKG3wGDzOQc1RYm8RL9LY87wF61Oxy7BMYiyIn9QMexWxwwOK9pfN0OrWYDJl4d93LDw==
X-Received: by 2002:a17:907:7215:b0:a55:75f7:42fb with SMTP id dr21-20020a170907721500b00a5575f742fbmr4895587ejc.24.1713524926172;
        Fri, 19 Apr 2024 04:08:46 -0700 (PDT)
Received: from 127.0.0.1localhost ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm2082525ejp.60.2024.04.19.04.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:08:45 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	xen-devel@lists.xenproject.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH io_uring-next/net-next v2 3/4] io_uring/notif: simplify io_notif_flush()
Date: Fri, 19 Apr 2024 12:08:41 +0100
Message-ID: <19e41652c16718b946a5c80d2ad409df7682e47e.1713369317.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713369317.git.asml.silence@gmail.com>
References: <cover.1713369317.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_notif_flush() is partially duplicating io_tx_ubuf_complete(), so
instead of duplicating it, make the flush call io_tx_ubuf_complete.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/notif.c | 6 +++---
 io_uring/notif.h | 9 +++------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/io_uring/notif.c b/io_uring/notif.c
index 53532d78a947..26680176335f 100644
--- a/io_uring/notif.c
+++ b/io_uring/notif.c
@@ -9,7 +9,7 @@
 #include "notif.h"
 #include "rsrc.h"
 
-void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_state *ts)
+static void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_state *ts)
 {
 	struct io_notif_data *nd = io_notif_to_data(notif);
 
@@ -23,8 +23,8 @@ void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_state *ts)
 	io_req_task_complete(notif, ts);
 }
 
-static void io_tx_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
-				bool success)
+void io_tx_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
+			 bool success)
 {
 	struct io_notif_data *nd = container_of(uarg, struct io_notif_data, uarg);
 	struct io_kiocb *notif = cmd_to_io_kiocb(nd);
diff --git a/io_uring/notif.h b/io_uring/notif.h
index 2e25a2fc77d1..2cf9ff6abd7a 100644
--- a/io_uring/notif.h
+++ b/io_uring/notif.h
@@ -21,7 +21,8 @@ struct io_notif_data {
 };
 
 struct io_kiocb *io_alloc_notif(struct io_ring_ctx *ctx);
-void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_state *ts);
+void io_tx_ubuf_complete(struct sk_buff *skb, struct ubuf_info *uarg,
+			 bool success);
 
 static inline struct io_notif_data *io_notif_to_data(struct io_kiocb *notif)
 {
@@ -33,11 +34,7 @@ static inline void io_notif_flush(struct io_kiocb *notif)
 {
 	struct io_notif_data *nd = io_notif_to_data(notif);
 
-	/* drop slot's master ref */
-	if (refcount_dec_and_test(&nd->uarg.refcnt)) {
-		notif->io_task_work.func = io_notif_tw_complete;
-		__io_req_task_work_add(notif, IOU_F_TWQ_LAZY_WAKE);
-	}
+	io_tx_ubuf_complete(NULL, &nd->uarg, true);
 }
 
 static inline int io_notif_account_mem(struct io_kiocb *notif, unsigned len)
-- 
2.44.0

