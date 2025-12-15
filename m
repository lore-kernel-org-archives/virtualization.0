Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4153321C6
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798762; cv=none; b=Gt6wNedKd7ZEu6lhW00QcdXNJrDhcdSyFVsFAsgG7i5hXoDTl05sKNq+MW4Tlnas5fDTIki+dQHu4UbwBST0Q4DzHEU1sUYCQ9SUQxHDJceCGQiuxs/GevgAM5eGXCRRkGoZOCfuVfrbWwGVNnrbSLKxBd0PUgaW5peBGBg/3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798762; c=relaxed/simple;
	bh=ZF9oIk+6VfTU18bKiromuOjnT5V3QoMoKRjEOTmh6aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm1F5c9s6ehiWixOnq5QgqkoYX8z8WbuZ6EpFWAuJ9fVpkn5Jaa9xU0c3TNazsxeJ8m9y9TLb2vZeKgY6I65nXgNr9HZH/GoCDBYQyXFPeJPxIju/yXyRDEADqbzFuRZuUOpNeMS1EsYbWNohHgZ5UTrkz182LykVZyuIYKTs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO3+Yk2B; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO3+Yk2B"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so2681221b3a.1
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798759; x=1766403559; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhdWc9MI61x0CV5VCAtcSDjXy8TDKlNky9k0yGxBSF0=;
        b=dO3+Yk2BWGcWaru3G1rGYyp8ivc4xZE0PMLTjPbz6dAsvt2RBFbUuMCMICFN0oZE28
         sntTvrx9Qy8e80k3YKYGx859fquEhzZW7S5/ForMJ3qCThybyezJrAmSu0IumUssxQvp
         OMBSR0x6oxmJTLsIc7SvD7JouPP/BlX+VJPSb+JGC94a/d44F2GfyB4SHgcn0KpqbUvA
         qffcHB4/eMXuOr6XflufPajCTjci34cNUoAgADR5B+IZIFW+pDQtbm9Y5NdXx6hUOtLb
         oc8Noq92lpDbn9QfHtnhDVH6rkGS5bWnT29jAs6c6dUvHMMNkivuXkaX6j+gdtCJlcjs
         KODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798759; x=1766403559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhdWc9MI61x0CV5VCAtcSDjXy8TDKlNky9k0yGxBSF0=;
        b=NOHoUfZ8++AN2scsVmOPuBb69IzIAXvVR3Sez+a/GNvNaSGoLAIzNYs2KOYBjKRpza
         +Ddy+lrWxiDzHgG745w2MiPy7UXGIDCSW6797lpptLwGXOqA3WoMNAbq6WWC2zryJsMf
         QSnq7pZTvvZeMmsytu3OWqM/mlZ56wmZnRL8y2O7S79ieqCoYNwSmm02srclPAlgqEN3
         yKt6nqNSVStQczS/pwzF0U45okFl0U+/3XGDnGnOiWisKcdRaxEN282DhW/NB6RnXnxX
         bXXw2TB1RrIUv90cWWYvJBA09i44uIgMw+80CIVZ5E6ceb8OnIJYtnPArLwBHCZvcAq7
         OndQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTxeiN4vxLh4E9u/XhSBhTRD8NoeRDSH5Fr4xhgJqFfbkzkqjPNOPS1Z3Z/1tpICCGxqLWGHCZCnVxeLk4VA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3FtnbOiOICEPxu/3qlebdhIhmByQmNAckXpZsJCGq2/ljV1WC
	eDB89FJYp5LJkqjBlxDUwrgW4+9ex0HnzF2n/KlGwpekZq6i3J8WFbAS
X-Gm-Gg: AY/fxX6+XxWEfxpzyjrIwIJS/oauvyarrnbrW5jeweuFVEnnf8jpR9h5GOf58pPg76I
	4r1JEJn9JnbaUVXrakiaDoR38+1nwMDbkNirMuNglTp9f301Hkrx3krNrR33lgBY5r7jktfyxn1
	WYINGW7mUVqnLfmiUCI0dTQeaGGqA70UV+9xXXAtPLGUADe7Wm2WBKOPKZB/cdZd5b5fSC8ZHtM
	H3BJjJZ2mAn1excEmE1L4o9+Ii4dfjF5AydxmvvZrTYory5LO0xjiBXqxeTVvVRsdei8b1UK3uF
	MIA0EIlF8zOVVHmuQHbpGcQoIS/C2kKI1ZEMLTp2VX1HSpNoQyzxv6czcLb+X5hwb88XbtgwsUS
	ePm+gnxWFLL/jatlUXHmT2+Cy2uQypjYP7nGivz2ntt0TtuAs4YYahvOwLe7mhprQjxdlcUtvbP
	ELbYM1q1dosBA=
X-Google-Smtp-Source: AGHT+IEml9qI+VrrnmRfetIj/W3ZZs/y3fpGJeeY3YNSfL1Lp+Ud1G2wHo5sReKCb7zM9fF8T1soPQ==
X-Received: by 2002:a05:6a00:4211:b0:7e8:4587:e8c8 with SMTP id d2e1a72fcca58-7f669c8ea65mr9926386b3a.59.1765798758916;
        Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c566c7cfsm12487742b3a.67.2025.12.15.03.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id BCD48444B396; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 07/14] fs: Describe @isnew parameter in ilookup5_nowait()
Date: Mon, 15 Dec 2025 18:38:55 +0700
Message-ID: <20251215113903.46555-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=bagasdotme@gmail.com; h=from:subject; bh=ZF9oIk+6VfTU18bKiromuOjnT5V3QoMoKRjEOTmh6aM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4NPZboGqi8J0lGIEPx09J91+O5zYvcmVc9uCnNeq KyqY9/YUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIloczEyXFE5FS25V7U4nF3s wsyajN23tv7S0jlgc8jW4LrtPJ7fvYwMd203HZvEp7U3/4W850Q53mn2BsnZf49w2jwWklnFefM GBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./fs/inode.c:1607 function parameter 'isnew' not described in 'ilookup5_nowait'

Describe the parameter.

Fixes: a27628f4363435 ("fs: rework I_NEW handling to operate without fences")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a45..2f4beda7bb8841 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1593,6 +1593,7 @@ EXPORT_SYMBOL(igrab);
  * @hashval:	hash value (usually inode number) to search for
  * @test:	callback used for comparisons between inodes
  * @data:	opaque data pointer to pass to @test
+ * @isnew:	whether the inode is new or not
  *
  * Search for the inode specified by @hashval and @data in the inode cache.
  * If the inode is in the cache, the inode is returned with an incremented
-- 
An old man doll... just what I always wanted! - Clara

