Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E3D21D3E8
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844365; cv=none; b=u8fzwiczoNVmkb9XeOst2bVTKtB7or4M+SSVYE5TxBHiLnbyHSsDj5UFH4Rjf8q67EN75vbu//EJ3pnQrelPu1Ve/uIgELqxdD5LFI9793qgrbo4GsXNKMHRuOId4t03Y6bivbCEJXR9UdKtquxB0p2qV/36FbqikIL1JnXRvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844365; c=relaxed/simple;
	bh=2xBU63nTJiakTL8J+GV+JbrGyJ0kmCpFFyI7LldHPv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBhmaGKw9Jomk/i2Wfksz6jKmdjFnAqvZ56Wi2tlMpEK78owojjDWmxJQOp5BKJQOoi6QNL0FOMyfxIecGlQjPOdSjrhXSitimWBpUpCQwQ4k0SR2OCyX37Hb6B/YJUS/LEFzFE745NP9dHklRucokk+dUgcgNI9TouGesu+f7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl/tt3ip; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl/tt3ip"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b553412a19bso3719694a12.1
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 16:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844363; x=1766449163; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk1yhdZDsbmHyAUXRbfG+BCb5AaoOf6d28kSsthudBo=;
        b=Kl/tt3ipJKJmUwNLQN3dmAFaXBoNFjs6UmJNXeCDA7od6GHXSGASPfTMjZ2KWGnTFD
         t70nUuZGF7QNiXBvjTXC4QuR5YIkZWv6bFPd6/oG+Gn9n7Zfe0muk/Axbe6apZXCG8wH
         jy8UBlKueNLm3/HQfacx+ZPJD02hBHJ4HM42X2FzZ2sxSc8Yqz8Bs5IHcR2XPC4zJtum
         /TjBKIFocF3RDSq3rrGd/bzuuwBoMeVD8w0tHuqCuEqPTZmBOGAWQ0DOHPpvxHoKn+5R
         Q6KAKtKXFyaiQ6AW9QB7ff5gmOYhk/48J7t9/6Tp4eWiFzauELuY2dV8SutTsD4VhX4F
         XHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844363; x=1766449163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk1yhdZDsbmHyAUXRbfG+BCb5AaoOf6d28kSsthudBo=;
        b=JZIdU42fbDoOo0/jMXoRI+S5nUcserJpzxmrESoyYRYmA5IrEZSZMhG/AO4zvebg6Q
         maocBzr86RaVNSQonkndCK6ZZheGvhExntijlPX6MkaQBLbe+kYjFqbVgZ9/0hwK/Ixb
         934pAoL5rclUv4qH2iUC9V/S2oXWQYLaVPj+e09V3Iu1flNHckxLI9l3F8uaN+a7mAcL
         NrSZPIePDHwqzTdocb0qPcFJt6z+X5Lwd395O0PVf8MBH+N9acmDh7nkzI1PugKLSK7A
         CY0m0CCUDMBy/lJ1m465bGfO9rVMFw4k20+IYOH4a0UrBdD2aPfhrnJmdbBkAQUXXbKw
         AXOA==
X-Forwarded-Encrypted: i=1; AJvYcCU199vLjxxB6HuDNL97eBSb+pyxP3gwf/KYaKSETYnliSUMwob0XlJKwUoRZ7bNh4ddHfGQomyGBIgbhx5Gvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxATdqN5gBGCUScL4c7YQryqI1Nzxb11m1nSs9/+TPPy+qAJw5t
	IwsLtG8erWb2/2sHVIpYtfQggqQ+HQdJ7D9iZWaqxp8ypr3YO2YlV0jq
X-Gm-Gg: AY/fxX6KY7ooB2QEDVULCuwe0mt6i4DagHbcSj4qG+3h+Qs5Jtd54Xo4F1jrEeBwSjh
	jgXL92wJJY0JQeHRvsdPtWlejablDntu12W4FMVyI+RNXZ6pMlqEQQMdFxc4rgX37IOjRBcNx1Y
	rBZ7l2cizfjz9bcMn8JDtialWeDU3fds8m8eSx3o53BPCq8YmvCYmlGmDQL2VnthQWgdG6PcWPP
	VZDlGlcFOJucXpV8G8bZPXiwuQzBNHFxSWld4N1z9SnWye04s1jBFWkF5R0gp4ooQoZ55qyaE6w
	mPpJmWjvQcDRvBLD1y4m61CN9nKvvTYaUOUWzA2rQ/SDSfE+z9zJna+uyyRLjqwnHcPR1ikd2S5
	/snpiyMHxFcNaIcXVQW7+xn1lJFMn7cfJe8UtM0+gpxplBJ5JJ3kPVJhczyMs8DKebUWw1pOxBz
	TFZKgH5q6P29emeNGpl7GPrJE3x0pZhVIP3Ja3Bi3ruRg=
X-Google-Smtp-Source: AGHT+IHmrytMydYNAgs0qRZg7qEjrXkSVHGK3fUWY6ADeu6KzKqLiLcf4Z3v4UGHQ57LoQ8XnYjK1w==
X-Received: by 2002:a05:7301:f84:b0:2a4:3593:6466 with SMTP id 5a478bee46e88-2ac300f729dmr7381219eec.22.1765844362545;
        Mon, 15 Dec 2025 16:19:22 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30491dsm51066947c88.16.2025.12.15.16.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:19:21 -0800 (PST)
Date: Mon, 15 Dec 2025 16:19:16 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
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
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
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
Subject: Re: [PATCH 04/14] mm: vmalloc: Fix up vrealloc_node_align()
 kernel-doc macro name
Message-ID: <aUClhBdwQb83vN0o@fedora>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-5-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-5-bagasdotme@gmail.com>

On Mon, Dec 15, 2025 at 06:38:52PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./mm/vmalloc.c:4284 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead
> 
> Fix the macro name in vrealloc_node_align_noprof() kernel-doc comment.
> 
> Fixes: 4c5d3365882dbb ("mm/vmalloc: allow to set node and align in vrealloc")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

LGTM.
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
