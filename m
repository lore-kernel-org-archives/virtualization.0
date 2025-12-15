Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E913336ED4
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799328; cv=none; b=VCjJCFJvgPlwXvCb5RN1skyWbHXLJsT+zuTsyXOym02N2ll35+EyT9GINgT8ao7OPW5V02z1HGdMuPXbRqHPNCoZI29+vnOnSp5frGDLkgEneoNZjqYOyoqB+99vnTlLNcO8v++U6go61gOWAC4elAxocH0/grXwYw55p2FJgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799328; c=relaxed/simple;
	bh=j4BXJJMKUhATWUahdKX0lx9i399WYlQDn9Ep3/iweMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhkaGsxwjgCUhLHO6OOMGfGM568u6HpW/Icjm+PSomeBJqrNwfJpIPFgetWDRwK2uyUMttVsJge8mo+oyHcwKaJywJNfUvZlGIdQka4jf6tRIq+A8QEBiN5CYfo/isLldgQiVCPQQk23dRjyS7IiHZswUQP3CF77DoH0mpak4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1oXf+So; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1oXf+So"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34b75fba315so2739089a91.3
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 03:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799325; x=1766404125; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPi/WFWmImBnVQgsxNvJvJyvieXM1xBFzKoWis67Gg4=;
        b=X1oXf+SoI8e67/Ewp9Z8ITuryOc+IcalUG1fHP0/eBaQPgCN6cKkaMxBEf9sp6lUj5
         pVTLqmvYF7OqHKz1GDWbdEC7Mz0/kPal+8CSQ0Gqfjn8mV8pxK6JOWbLKMsne7uLmXwj
         7Wo8kZvM0inbE7NBNpaWNbRMQj9Z0vn+3q60et1yDD6Njjgbd7wVFHV0HEC3PalhkXcp
         t6/FUeOjdTEmrEhr7XzUJ/a1RTHwVcFUNE4NPuAJxo52gLKGYcQrHTqg/NUqtdZo+Nsk
         c4U337pNFxMOzU4Zn1Y0D11Zlhp9EshbNLJFoXJW0GqTJXYnlcsJz1HkvMAR1iK61jqg
         ojyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799325; x=1766404125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HPi/WFWmImBnVQgsxNvJvJyvieXM1xBFzKoWis67Gg4=;
        b=oMt187PO2bSZtbs1n/M//eE7s7nMavJZWrpG5epa+P4jENB1I0aA+6FJuk08JrB+of
         OsYNwItCYpDdD/7+ACiY78aRLQSWK3IHlBj3jpfbOdRtgmKun7dx2k0gtVy2vI8AieZm
         Lmjx2vvu17VRgZ1bYAJ2Aa1ep1jaLGAbNDX+joxCa3H3Dugd9FTJ2+hNcsnE1l062Ffi
         pLPTHADC7hre89FPvie5uJL9xKYfGPy7yUEH5R2LQQvFsS7hrbA9nHWt+fBzcUuGD9Nd
         gSDbCxZPG2l+YSvwvHJamOlHNA4o0wkQ3R6AdWeiFV+DRPdb5zV+WkaxpkxamKqtAQ8e
         8G4g==
X-Forwarded-Encrypted: i=1; AJvYcCVNCoHIyASAbFTTY8xup655X8q+aVq9Tlg21+2kweGWcn6joBq8f1/5jgRj8K34IXK5YxlOrQkjfAxoaIM4/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx35PiOMziiYc0y9LhZUMlpw2j2+mR4BQMZYt5GnMDs1b55D98D
	tBUVqHf/YDwLY8zusU1tfrPGjhZrAQou3H0VA1PKp5vAAmCI237BxTer
X-Gm-Gg: AY/fxX42tn0Y9uIUHTbOZcnfpphrRPF5r8G6pSQjnvVNT4Jux4WEvQ4OGTV5fx/ZN21
	kNIfRhEK+m/HGYLc50sFu8S0tcgXvNM5dSSktx+sHA9GOEn6xhWIa8XWVo9R2aDQcuqT627f0a9
	6fwYKc6VhkXq7hWC5UWGkVst4lpWLvNXmnnH/OJHWJJ6Cjk5+HBs9RbFw0chrqfjuaGda4SBtcO
	zhnMohkoHokqW8LvonBgHX87o9lzZ43B5as5FavN0e0Axr89LgICzjm4eFHex4EZN+38luXBb1I
	D8VBSd284XVTWrb5eUllT+lIQCWgurgmYXU/4cUWmxM/MdZ2IUNAFQ209iBhJUbwHp0u0KjWsu6
	bwDSNJc0aq9aYPtpz3XDYnBT+sOYrJA3OjRqVW1RAaBeQHmbvTJZK5+s7x9vg4k/iq7XXPAXbZz
	5kCgKNjJXB9A2O3S2D6D++LQ==
X-Google-Smtp-Source: AGHT+IHySr1buuGxwyvRmyNwB1yX2aGVZnCno4j9FG3NSChYg8gy/QOhSf79+qyZQv+BzWWdtgvcAQ==
X-Received: by 2002:a17:90b:388a:b0:340:be40:fe0c with SMTP id 98e67ed59e1d1-34abe4a6b3amr9032481a91.36.1765799324639;
        Mon, 15 Dec 2025 03:48:44 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba59bsm9003471a91.7.2025.12.15.03.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:42 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 60C6F447330B; Mon, 15 Dec 2025 18:39:07 +0700 (WIB)
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
Subject: [PATCH 13/14] drm/gpusvm: Fix drm_gpusvm_pages_valid_unlocked() kernel-doc comment
Date: Mon, 15 Dec 2025 18:39:01 +0700
Message-ID: <20251215113903.46555-14-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=bagasdotme@gmail.com; h=from:subject; bh=j4BXJJMKUhATWUahdKX0lx9i399WYlQDn9Ep3/iweMY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n0OumS5gNW5/3GqYe0vV4BnvxdVlFyqnrRPWP9PpP u3FMcecjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEykPJ/hF9Pft9/+BqzKa/W8 rdg9vSMz5a6N4PnTByKYzgTJnWZ/P5Hhn+aKvLS4vrtB9w7NNb77cZZgzZ2+T776O+w93L/xls2 5xAgA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 6364afd532bcab ("drm/gpusvm: refactor core API to use pages struct")
renames drm_gpusvm_range_pages_valid_unlocked() to
drm_gpusvm_pages_valid_unlocked(), but its kernel-doc comment gets
stale, hence kernel-doc complains:

WARNING: ./drivers/gpu/drm/drm_gpusvm.c:1229 function parameter 'svm_pages' not described in 'drm_gpusvm_pages_valid_unlocked'
WARNING: ./drivers/gpu/drm/drm_gpusvm.c:1229 expecting prototype for drm_gpusvm_range_pages_valid_unlocked(). Prototype was for drm_gpusvm_pages_valid_unlocked() instead

Fix them up.

Fixes: 6364afd532bcab ("drm/gpusvm: refactor core API to use pages struct")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 73e550c8ff8c98..fcfbe8c062bf6d 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1216,9 +1216,9 @@ bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
 EXPORT_SYMBOL_GPL(drm_gpusvm_range_pages_valid);
 
 /**
- * drm_gpusvm_range_pages_valid_unlocked() - GPU SVM range pages valid unlocked
+ * drm_gpusvm_pages_valid_unlocked() - GPU SVM range pages valid unlocked
  * @gpusvm: Pointer to the GPU SVM structure
- * @range: Pointer to the GPU SVM range structure
+ * @svm_pages: Pointer to the GPU SVM pages
  *
  * This function determines if a GPU SVM range pages are valid. Expected be
  * called without holding gpusvm->notifier_lock.
-- 
An old man doll... just what I always wanted! - Clara

