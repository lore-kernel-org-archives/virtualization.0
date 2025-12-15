Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A9331222
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798759; cv=none; b=TGnPpvzpKClFVY3pSMhhJ/l8Bg7T7amWffSCzWN5OAX0UemCx5Ib0nmZkJXjW02i2FjuKN+x3qSCDp1q+EH8VMFVF5R9t7y/bVUNfGzOjHJDAPTWbjpuA6A9P6YJGefWXrEzC7Ei3a2wH0rvQR5eMx9r226fRox4RtO07qhl02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798759; c=relaxed/simple;
	bh=bVwk3E00Ao0/BsL4XlONNDCfpFF0qzpzGvJu4GqJ/kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBiIH3VK0BV5dHzacPbW8cGNB4eJ2p/406piiKuDgGO0bPPLGnbnsDKq4XN27UWk9OhEbnYEo3fpjhElgoH+cYSiCXcWcpd8hMURO1sj612Oxdz2qMEyCojkQRjBGnkOVWOEaYPfA9CvowCt6xmcGGXqotacpodWxqJ4Uc/qOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmJisHTo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmJisHTo"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso1703644a91.2
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798756; x=1766403556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thXFyBI9wECeAoZwvjVxFD8Ol9j6G4X/I1qZGpsX1M=;
        b=HmJisHToIavdOK7WGBKn45QrlGuULD6u9UNyvfxOJzu7/6t5DJDQws6pGLlsW9XfI9
         c3QD1f5dV7yye1IdtCMHLLmSrjDCxVR9WbH4tlm5qDO4XSisl9OgwWEivgey6sv+7Ody
         NmsUb6Frl3n3l7QGs6U0oGMkcpIWUxkG+RBRLDRHVI56nDR316jP93nc/Qtqd11vEKJZ
         XJVZK60GrRTJfD5R/nmVhq1u5AdEOXZ1Rmtso7Hz3Cb+I4xUVKkcYvng2X3AewSTt6L3
         tZ/wYcJ0JHNX+KDBSAuKdjmWtGz1puSVMSph+PhR9RfrkdLBzAokOHVqb/K46dld+3rS
         U+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798756; x=1766403556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9thXFyBI9wECeAoZwvjVxFD8Ol9j6G4X/I1qZGpsX1M=;
        b=gY72Yy9rZyYEWZrSY+sMt2RjQq5pPsp9+2J8RMg1p8FcRbsDiWSHXsDTQ8rQSfmAne
         QvnLYil5g9i2LyyTUjTihHBu8B5f7wOvcd1GLbEhzAzAhpEWcadqPs0CoI98t5DbhgPr
         x+MJUu5GLJqbSg/76ziojX6yEPOY5vv712pg27Y/7v2KPXLX34ftrDR83ThsAIe8xWcJ
         6gSTO6NKin9g37z2h/gXOCKkXyHG1Azxd63YerKD/X/r8mKgXYMfpFb4lGsyY5gVwY6P
         Xwz3PsiRWvKOepAWZxOhjAr3vJqYyRVjg+VPChPTyVxBH10QssHgOtVUJ55YHyQYHTSh
         m76w==
X-Forwarded-Encrypted: i=1; AJvYcCVbAWqvZNWJ9RHzG0oPt0eq2SGTKNn6lkcgK4USzHOv6PjPd0Df/LUYF32ReYYJzevq9vY8EypWPDgAvU267w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4rz6AsJ+xh2/OZJgxtgpJxjT+yGIGizHMmmzvv96g3pudrF5S
	lD2rm44ZsdSWy1qWd54ilPEsm7UYXK+SC5U1aOoDxPmlH47rPZWJU31B
X-Gm-Gg: AY/fxX5iEDZbXjpWePa440ZaL/N1jGUMZnEVmzf59MdWJyrLAs1EkOMZ4Gku3KNAKEK
	Sqvi90hM1sACbL/Yyf77JiSt1CslEuHaZwmcQKm/GSwDoDpHlIwE5/Aj2Q4y49JtNW6Ya2FyLLC
	GuEKAM+8ENjmYqVdMFhh9oQA9cRnkVr4h92eGON6vqAN86KPz6m3Z8YCUEUYRNkIC6XGzHIh1zc
	R+fIl2SGeCPRxQ5VIBuUKjIfJcTbBm13VZ6jYx212P7iujw0fSFR5fSUiOBdZrIlgm81PGMqVXC
	AeEvaM/PGah5VrtnPdcKwEAegDucbUtKC6QbkO4B+ErxRXFgH9odQ8mQ16H+FGQxSmYsD0A+ETO
	gk5Rr3FurQgJ9VSN06i11AQJ7y6s3Mctwef5QtnSNRng02t1LXwr+SwRnyoF2AQ4WTLJ8Jwq8lo
	D6LB9TskrHi14=
X-Google-Smtp-Source: AGHT+IE3LQMlInYBtZW6kVYJLJE4CFzfJfm+/f5olU3OmDWyxxykzQlHP1rsXKl8Sxl863J3gFT+2A==
X-Received: by 2002:a17:90b:4b47:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-34abd78051dmr11974090a91.35.1765798755860;
        Mon, 15 Dec 2025 03:39:15 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe294892sm8918293a91.10.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9EFFF444B395; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 06/14] virtio: Describe @map and @vmap members in virtio_device struct
Date: Mon, 15 Dec 2025 18:38:54 +0700
Message-ID: <20251215113903.46555-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=bagasdotme@gmail.com; h=from:subject; bh=bVwk3E00Ao0/BsL4XlONNDCfpFF0qzpzGvJu4GqJ/kY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4N3qByLSAtcbrWEYbHxfzPeVTVyK4Naco81fnbf9 sGw4M+ujlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk4Ckjw37unJpIS7sDggaL LUJm/L7quGjlN51XE6JFNZoPynqvOsvIsMhqy5y4fbtebC8768S8lM/yytfC9QdFWExtD//Srpa 6yQYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings:

WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'

Describe these members.

Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 132a474e59140a..68ead8fda9c921 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -150,11 +150,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: configuration ops for device's mapping buffer
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: device virtual map
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
-- 
An old man doll... just what I always wanted! - Clara

