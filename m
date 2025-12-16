Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422093328FA
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858714; cv=none; b=ejzrIxf1dH1XgZ0SEqCmkD1uGuD+TiKnTtasm+PZwZnVXArWeC+6DPYbt36oVvhRVpiGFMYWPsqjm+VqAbuLidfwKUWtU88UKc0R+XqFjd9tpK+0+dKn7by/zhamrqsaA0UpXnHxHmMcoLCu9SfWUeYBMQvv7AGBxpN4p1C7vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858714; c=relaxed/simple;
	bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qB5VMnARb1gKfSL9TKibFIX6kxm8/hW2fnnjY6Mp2LZGwuTNY5ngAG27+eZqqnpPkXLnpf+VakG0vcW4pycC/nC84nA/ObxjpAY1Nu+3b+o47PEC35asvwLOTnKfBn/rbkoVSKRAdVNlO+udr38xDuBIpRBzcekk4eXY1jtS1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5NjXvGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5NjXvGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765858695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
	b=A5NjXvGDLxOTN7i8uepsASxQWSK+oQpP3F8+IpOowT8SlHQppyg8ggIXB/AXVsF6wvN9Zc
	e4n+5xZo2YaMJ9Jc5jT9MTjoQYNQLN37nWLpWB/8Lxdf3qMrrFknQ+bDByT9jRse1kPp7l
	hfLB5XcwzeaHGrLpxhvy11YrzrW+NsQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-svHowBLaMKmI9h_njyKrcg-1; Mon, 15 Dec 2025 23:18:14 -0500
X-MC-Unique: svHowBLaMKmI9h_njyKrcg-1
X-Mimecast-MFC-AGG-ID: svHowBLaMKmI9h_njyKrcg_1765858693
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so4616715a91.0
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 20:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765858693; x=1766463493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
        b=VMSD4uAjcmR+kvqGD3dT6buU4e54GlFiDdEQbrjRaFDuZLqR55wIrP7VYtI+vYmWqi
         39xKJ3oN2rhfSJLCRQSd/X4K5aBhuFJazAjiunhpHQtZG2cnDZJQ8oRjW8N3Fqhco7Pd
         eKZft7dFLWVL19aSjqx6V3YfUcYtcQuTOJjiSi+fjBDzzGBdjXTNxCkWtgVZH/hkGd1X
         8Iz6gde/x5qe9DjQJJxNyQKQFifgDReojwlqmX2QHEtv10lzv0UCBqls8RxVlUMnAIGR
         wL8hitYfUnvmsKwW7htjRH//vOKBnxTfcyPdA8mbfCGFUvI3BovXn1I1p80/8WTR5mtK
         1Feg==
X-Forwarded-Encrypted: i=1; AJvYcCW94CWFiessKCXs0hvhdrJaE2OxH6TTicBKJzEbSXbFCJfBKLdLRdVL/8pC8oG+YJDcqjl99ihZWLKRojQ2KA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww9koBxJDzr6GWkumwmjxnq7TyMocx5KJn9GQqcSFnWak0XW3k
	x58UofuBrdyU+1NVAeaJaumdLSKA1zSD//PLRJ9qy4KYkghsKiMFODylSXkG9PcX7vC3TbrybdG
	U8d6SNXmOtJP081Oyiu9JdzSb8RnCjxmKM58dqqrttAlOjhelm9tBq/uOWshm6zsULOi3dG4pCr
	HYVlZ9oan9MZUeKhBXyHYczY3xcrpGNF+qvaPto/aZGso=
X-Gm-Gg: AY/fxX4Yse2vTgoujhSsyOTtKpvLPjP4jQXfbQw04QhNGDFkd9qAw1wXyNZJHITE4sV
	8Rc9Jm+Xbj9+jKEZScELsQQPCnwi6BSf1XkRQJxOQ3+G8nMb2rpQxAZJ7EYyN5zTEKlTLF6/1J1
	CiKAfTogeghMFt+FDWT+sj2yfLZ0ZP/zMqqz/osLZetv4B4/5DneiH7kXJM+grpb17EA==
X-Received: by 2002:a17:90b:2ccf:b0:340:f05a:3ec2 with SMTP id 98e67ed59e1d1-34abd81733amr14699556a91.17.1765858692963;
        Mon, 15 Dec 2025 20:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD77DQk18dayngXtbIw3fsOCk15EBfDyLwaFsEN4158FtjFJzrWxy8+rjy6tA50q0hvVxRQAeZswAuqcmTXkc=
X-Received: by 2002:a17:90b:2ccf:b0:340:f05a:3ec2 with SMTP id
 98e67ed59e1d1-34abd81733amr14699535a91.17.1765858692536; Mon, 15 Dec 2025
 20:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-7-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-7-bagasdotme@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 12:17:59 +0800
X-Gm-Features: AQt7F2q1idGMqOnPlq5afbA61NEyezJumJNhfdWiFdPMuPeC3DZ1U_cOOaqg6iI
Message-ID: <CACGkMEtJt7Df5kXWex8EoKdakdB8_xLjgCXQt5pUvk0dkGzVMA@mail.gmail.com>
Subject: Re: [PATCH 06/14] virtio: Describe @map and @vmap members in
 virtio_device struct
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Linux Media <linux-media@vger.kernel.org>, 
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com, 
	Linux Virtualization <virtualization@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>, 
	Linux Networking <netdev@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, 
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>, 
	Cruise Hung <Cruise.Hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sunil Khatri <sunil.khatri@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, 
	David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>, 
	"Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Alexey Skidanov <alexey.skidanov@intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, 
	Shaomin Deng <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, 
	Jilin Yuan <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	George Anthony Vernon <contact@gvernon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3WdW3pQLW_D7v8sSg_C0Xi7A7bv2q4BNQaIstjwMleM_1765858693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:39=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warnings:
>
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described i=
n 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described =
in 'virtio_device'
>
> Describe these members.
>
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

