Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6A330B15
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798766; cv=none; b=cP0DpO1Jz228jOdjUUz6d5gLM6fGguM5dzBoerSvoS8XNuqNTqgVfu6gvapQa8BKOERbYhoIlv23Y7Nb3YBdLamaBgrmTzGzP1iix1BNeT2xhg16c0DujA5U5hv/uxa4KU+W8RrPQmnX34c8hQiFzuo7QEZSbPY8+L97lQfWJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798766; c=relaxed/simple;
	bh=g0JdaQypaND4lTcW0ZqbYUYcFFa4BCtHp67rCXQ3qdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVk82lBe/kvO/b+q9FSWZeydiBkLdcVXc2DWC/MdPv1rJFMxYemZ8B0fZntDpjlCbzVN5UTKdHJE0dRtx6ADh0z9Zy0UCnIJGvN6GYbck8EYqecSZf1dRk1alu3hbI6iJTNYeX7YRX/yVYS3jP3U3Eh7mCrMDDOJkaVdLBTred4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfg1FihI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfg1FihI"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c868b197eso920361a91.2
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798762; x=1766403562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1jHunOtVkIwedmQvRsrzJgL7loZmMhygmTOE5iX6PY=;
        b=Rfg1FihIbVbt80pRXgyZ3mLsbuBkoQW+cIdYJLnZiH+wNGtzIn20X13Kyz2Wv5mHI/
         X6AnQYYj/ptTxLF/347YB8vtNbJQVAzBnxbPR5IngXrlKPC7Qo5lokKdXubGRnpr5xZ3
         igOydEjeZGzWRJdO8krO+tU6jSvF0hZLk+HobGyzWKcgDGotdX2ZWPRma4377UPZsVa5
         rb1AUVRBHAYNSamVxmc19BJURLopxnjUFLugA89rb5aeAAtDoI90rEvYbDHx+K7WPUq8
         rtdIFa8u9gm+bhMaOSLawZHEnd0MBe6Zf66+0pw1eErX9ybRd37c06Zo/wr4ZNUOft5u
         Sz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798763; x=1766403563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1jHunOtVkIwedmQvRsrzJgL7loZmMhygmTOE5iX6PY=;
        b=TPZOyo47Wv6Vj8OE5uo/jg+nodvQwMcR+1NPcqgeC9IDXe5L2Q8wAz+1i6V+C1Avej
         4mKAwklPpPbRxeN06lkXDY/jKzW2CBacapbi3clSnIv9uBRXIk7mp/P2DZPz1fB0rJKt
         nQUlThs65FSFQz7PKkBY5SY2N25duWrK35o7tAZsd4lZ/a89JH9U/Vx6ctVfArONKPUA
         2q7uP49/qvsMna2H8mpFooihejiTkgUCmItexwXszJTMHYLRUBX49drIWiIXZpqBVQT5
         OqKLpraM/bvdr790+ohY7QTbbYiGNJg/h3tpjE1iHIIISz9AMHcNJQPcz/CnAo2lt2dT
         jjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU93Lq3Rm9t3jBmjZvJGLevObYIDhdw07FFC/bQVBJLsVy/Ebwh2DtZzhiKISi8rj7/9vS8vWpCl/pn8JZFYg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7zHtSp/ksdcn+e/fH2pEsM56jOqGnHTnNev6l2zBlZJDB4s+T
	ubYE3m0xMRlo3quMuy/sFAHZlYzDJxsM9ARUdkTvExSsCk57vmXb1ZgV
X-Gm-Gg: AY/fxX7IQhmuu7A/dTgGaKAAD822IFAUMfvxjo9V24zzTgwsYid1bW+Prt7kt8bL5RW
	oo8EVRo/YtgRzVNSbHQSyHsxr58uSZCUj4wY3f4r13uoHMGVTXyS9zwNCeVSlsxCao5Raq8bdFY
	Hdr8ZZkrm9epmsdVOGSbwmTfhv+TkA+WUBXzALw183pML8/Gt8K4HRUdMj5Pg3TJqypyoicXnmS
	RIjzja4sVx+Br5FyiyDeO1nGYYVcFSYVCHS1Jh1t2VtSPm8DXMnuZiGSXwFwB12RvwXUWaUVY17
	+i56Q3+cXJcdkmuLgK7L57+5CTAhnwlAFBZQIrXlpWVaz8nMpKap0ZLBnBU7Q8KlwNNE8cTQHkl
	zJj4vY8AmeFjznl3yZYJ0bU3NEKixLAzwpRntdS+CrKd9kKH8p7Qqra1x1hM0hue9Y85fBscraF
	sFxnRK1T2tJk4=
X-Google-Smtp-Source: AGHT+IGkBlvtTJJI36YenJR2Mj5A83uVH+1orPi0BLwAvata7acR5hue/qogcd9VSy03MC0if9MWYQ==
X-Received: by 2002:a17:902:dad1:b0:2a0:b066:3f55 with SMTP id d9443c01a7336-2a0b06646d5mr58199625ad.10.1765798762558;
        Mon, 15 Dec 2025 03:39:22 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d394easm129684215ad.25.2025.12.15.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DE7F144588D6; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: [PATCH 09/14] drm/amd/display: Don't use kernel-doc comment in dc_register_software_state struct
Date: Mon, 15 Dec 2025 18:38:57 +0700
Message-ID: <20251215113903.46555-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=bagasdotme@gmail.com; h=from:subject; bh=g0JdaQypaND4lTcW0ZqbYUYcFFa4BCtHp67rCXQ3qdI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4OZ3cRMgut038Q1Mvx+WnR34qt26aRSjxQZU2vjg 6FirXs7SlkYxLgYZMUUWSYl8jWd3mUkcqF9rSPMHFYmkCEMXJwCMJFN+xkZVrl1e0394/7u+RLu +RrXLfO4ZDZ3GN7cIROa8FQ8sjv1CCPD78WiQS1yNZrTC6Ti9OZz7YjK/sxnP51XNFzRTCM96w0 nAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2796 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Software state variables used to program register fields across the display pipeline

Don't use kernel-doc comment syntax to fix it.

Fixes: b0ff344fe70cd2 ("drm/amd/display: Add interface to capture expected HW state from SW state")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 29edfa51ea2cc0..0a9758a042586f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2793,7 +2793,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst, st
 
 void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, struct power_features *out_data);
 
-/**
+/*
  * Software state variables used to program register fields across the display pipeline
  */
 struct dc_register_software_state {
-- 
An old man doll... just what I always wanted! - Clara

