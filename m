Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6223358CB
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799324; cv=none; b=sPXfea9oq92dvxovu3CPR1kQkJSlvMhf8RwEmukYzqJ4mCce2XmwZ8/hei/kuTxpTR7VhsMRikZ/8m12AKynXmLIQDWJdmqdLki+2mWagG6fW/6l8naxOvJQzzGr6eclHnV0aAQ9csVlF7JuFWAWPb8gd3YNkM4Q4NAh+bWHWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799324; c=relaxed/simple;
	bh=UEs/C9BYSnit6YUYNsXI/TPVZ8wlbVWtOoMfZCt2Czk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJBrxAyd56BVptGIW/Opr16cKnqfGNVRXXal6z5j4Dj2Tx7jIPMI7Z/JqHS2MhaRqNCvSy9hN+keSsQrFCntC6h8prB97LADW5bO6/E0a+ol85fmmNLL7lcGmB/6DKKZxed86CLHOcVMwZ/fJ2roccEkF3xLYCCojYsWWJG/E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEJip3YF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEJip3YF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f0f875bc5so44083615ad.3
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799322; x=1766404122; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HauKBmXABfepG7VVzo5pWgXSZcUBePm/ZvLfsSGC9U=;
        b=IEJip3YF2cxHozNV/K1RMtKlPsQK7iV3MUgZTG8jceYDI2aFDkbas9F520ql6acAn2
         6OvqE4fnqOU4wnRWQQENpz3RO/aoXSoPlX9oUQoBDXshutEiwPwB84lSVbapVlIEfTU+
         3FC26y+zi25nbqYlO97c+hM6jlo1iO/TNVqXi1D0bLcaVUrJ0lBzS2XK1nU0hspj4lxv
         nge9COjNDdKiyb6Ji21l4YHPzn+CrbIe63pnk0BzQZa7R8HxLzC5TQepY4xV6ubsEx6p
         WVVgexHIBBf6JMfx/2RQDWXHNFI96iRKzKTExirPJ+BGHzdS/TmA0rArX+aKnwimTWfN
         UmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799322; x=1766404122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HauKBmXABfepG7VVzo5pWgXSZcUBePm/ZvLfsSGC9U=;
        b=RR7BJWZBz0laU/IeUDCy9DsWI6g+jmkr3qneexxDUIYXis5BIzVGGeMTeFm6Ad94bn
         FOgeYSoiH4OwGD5kl9f2WNQ3Z0a0OCF7i7OdTjuKINO5l3HxYakYh53wUSn5loo6Pt+m
         z3Pb+gcheLBibLEbK4cvbZNHcxZTUReYL/gWwILs9Iwsa2eqT1BOWPtuo1/YKzNzp52/
         66eBy4apAyaYWb3fnKq/repA5SmwpIyMDx1sb+Q3617yxKFjV9cBDemodrUc9d/mWuKc
         p4T5tTvgXEC2MiZ8RUSpI+DCiLm1i4j6Dn0HulOKOkAl51Cq6FqU5d2Sj12703Re8Exe
         fIgw==
X-Forwarded-Encrypted: i=1; AJvYcCUObRrNWjBuM7wHxhG9HLnAkBejDA3cbNjgJZAP3D1H2xYaiyamaGwC9+WyvUGZ32G1EHh1mXMU1grUX59JNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfcEzLaoNvMJkz3gTSrifRj+kacyq4EN6Y5Cv4rQLXScAK/SXn
	5owW2RFIJBDNE6bQ783l+C8rO8pW54kt1F9qgZ0H9dYwhSOmjynOG38G
X-Gm-Gg: AY/fxX5c8RVNlxa1ivEuiu1Mso134gvpMJEIwMSmvaVJPlZm3M5nvgeZYGFLOf5nGxd
	LjDeNGoYb4NyGjaAKQapyUVijnJ5vaaMVeksqENISk53COFYW0Ad5SfvzqvxGOJD8RDAOmkgM2R
	p4QV4rmO95qG0Q67iCY1jTDL4DEfxQkzWG3Vp4YUSQMD2nMXssUYtmmNKMsXwmlmyHbibqjJAYj
	HBSt5DP0gRWxtGDRn25JrJuxRrdxY1UHPW1Z4z/Cz89D6adQyhJ2FmYIfty+dzdsxuaTlA9bmmn
	vwKZDUiCOO3hiTq8qRY0l7C+YRZc2x+BpiesUM+01R31GXTnCU+TUZUtDY2SLk8ZEwZpm+eGbob
	xkuwoTHwZU36QBRlboISlVoy8feVvzQmcdXz3EawVh7Vmr+/+ru61b6CIFvf6JdfTX8bY6NXli6
	13orkLi3mGfqg=
X-Google-Smtp-Source: AGHT+IHfPz2x7Vw5nYSquN5rdr59IqpuimzSW/oHADfYTkii49T/33BfFck+CRU3WD2YFqFgGY1MBw==
X-Received: by 2002:a17:902:ccc8:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a0823f4e6bmr66287715ad.50.1765799322057;
        Mon, 15 Dec 2025 03:48:42 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f271bc8a0sm97458185ad.92.2025.12.15.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E64B44588D7; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 10/14] drm/amdgpu: Describe @AMD_IP_BLOCK_TYPE_RAS in amd_ip_block_type enum
Date: Mon, 15 Dec 2025 18:38:58 +0700
Message-ID: <20251215113903.46555-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=bagasdotme@gmail.com; h=from:subject; bh=UEs/C9BYSnit6YUYNsXI/TPVZ8wlbVWtOoMfZCt2Czk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4P/rZd71fJeeea2Y6ze7l+/BUWfvZxbPVvJ7FLhc b8Ca2nfjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkQCXDH065v1Nu7J+SJNXm fKBEpbzzpEZrbklCWe8WSUFLrulTkhn+J33s75ffwvJ3fu98iUql0+pnUqJKXmg5a8ursxTsZFv IBQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/amd/include/amd_shared.h:113 Enum value 'AMD_IP_BLOCK_TYPE_RAS' not described in enum 'amd_ip_block_type'

Describe the value to fix it.

Fixes: 7169e706c82d7b ("drm/amdgpu: Add ras module ip block to amdgpu discovery")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 17945094a13834..d8ed3799649172 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -89,6 +89,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
+* @AMD_IP_BLOCK_TYPE_RAS: RAS
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
-- 
An old man doll... just what I always wanted! - Clara

