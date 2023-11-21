Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1054BE7
	for <virtualization@lists.linux.dev>; Tue, 21 Nov 2023 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5il7C9t"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1cf6373ce31so2154985ad.0
        for <virtualization@lists.linux.dev>; Tue, 21 Nov 2023 14:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607418; x=1701212218; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHi5YlXCcsX/D19JuU9Nw7CLS9+F6yhOBOO+wjnP29E=;
        b=B5il7C9tpQP0Em74K3xWMW8x7m/Ewjh642VHUJpMdXU/1aQIGPu3+c5g0yMB0WJftA
         1tINGOjkbTQRAdkoa2F+rH8tny4xc1Byrg8LxkLd/g2JWSkTfCfetC6OvtqblKHqwQG+
         rnuDyhyu+J+uiQRpvwVWpO3/K/xuXw1eXMOi+BGPf9Rym0bSCauBJ+tnhfBDyYxxuXfc
         NuSeyjauJtSEtyI+R4KLenWv7gPi7k8+kz6aEyXPWaP1u/QKVitboqMno7DfFl5DGlDC
         RJgC8+QB9eDrY5bF6tP1IITc9ULyZMPdns4Oc3fEbYU4KQd/DthrInuu69nSJj7B8Kjr
         zaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607418; x=1701212218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHi5YlXCcsX/D19JuU9Nw7CLS9+F6yhOBOO+wjnP29E=;
        b=WbsjCd5r5vp4Um9nUdiNCaWLT8dZOhWS79NXOh9WmmRYApzbkBQg8ZHzGVqh/9dCDk
         +1stWq0BS2yHxuSTX17+cXDXEEJ7nZTr08HEZ2PlZwWcKFVHt33xuCRwkp6XbtXR6hxl
         OO1464dvxH00rB/V5eRxxp7Ppi/Tdqs8BI1lGzlL/wFRaQME5IOwPt1XV8660ng/epyp
         h+7UYmcWZWLo28upJ7sanW1LxeaGjoDckJrpjjZoQv/EnIkfmDrZP/HrH73o3+PAp4or
         1ygKA9PrZHqwtZlA4plmw7G4zDhHpsMIE54jMcxN2pNGzErZhfFMRQ0Njbmj9e8EvArx
         G4zg==
X-Gm-Message-State: AOJu0Yyx2gbDIsWwAexju0tiDm8FOZdT0W46bXVv8+2fi9YHr7HfCUrW
	AJ47Nbl0lEnQlp1Io6S0Yvc=
X-Google-Smtp-Source: AGHT+IE6s57NYG7jptMBdy5DVewa70KWUQtBlIN7PP5AfrSGIy85Ot97zH3PYYTC8wgjLQNl/n6VtQ==
X-Received: by 2002:a17:902:c94b:b0:1c5:cf7c:4d50 with SMTP id i11-20020a170902c94b00b001c5cf7c4d50mr1008200pla.18.1700607418027;
        Tue, 21 Nov 2023 14:56:58 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:56:57 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH 05/14] tools headers UAPI: Update tools's copy of vhost.h header
Date: Tue, 21 Nov 2023 14:56:40 -0800
Message-ID: <20231121225650.390246-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/vhost.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index f5c48b61ab62..649560c685f1 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -219,4 +219,12 @@
  */
 #define VHOST_VDPA_RESUME		_IO(VHOST_VIRTIO, 0x7E)
 
+/* Get the group for the descriptor table including driver & device areas
+ * of a virtqueue: read index, write group in num.
+ * The virtqueue index is stored in the index field of vhost_vring_state.
+ * The group ID of the descriptor table for this specific virtqueue
+ * is returned via num field of vhost_vring_state.
+ */
+#define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
+					      struct vhost_vring_state)
 #endif
-- 
2.43.0.rc1.413.gea7ed67945-goog

