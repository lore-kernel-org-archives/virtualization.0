Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66235CBB8
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898497; cv=none; b=n5DO/VLbJcFqUvX2AMwr314WYlnZSd4hNck2axWuRIYQ+Nr/5bkN2XJwrPanMqwrodMmoMZ+BPJ36inhAxeRX5pMPL9M13ebxWm8/fAXtcPYtI46Cnvblyustcxd6rX7C3VEO0Xe20PpvWn36sgoP32RalmjJ4oRRoAGgLm0KZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898497; c=relaxed/simple;
	bh=kUqJrtaM24NDu8J1LFBz422ot+phR2OLYLy5w6GVNNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXyvn04/CycLTwoCrKDSSRGHoLHG6ZAr1Zaj0VIVVu+2X63KgfLNE2WE3zhC/HWHFfDjS0300iW6qG0KE7nhNSrgBD6qG5np0hNEOrU44fN1f80GWcHmIU0QmdWUUe3aP7tMXTqp4xJGr/HNajXxuW40pC7IcqiymmdJ/D68jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc9y1yTx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc9y1yTx"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ba92341f07so335923b3a.1
        for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765898490; x=1766503290; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6A3FJy1wSkXfE42mqpxDchsxNCyuEhZg+omH3hGmm4=;
        b=Rc9y1yTxJMZKy1jKvYd6jTBlUIx2a8rRkGHRBznnCdfM5+NM/aZ6p6w1g2U8eTegE+
         CIUhNb2/pdKD196/n5U5bieFxSKy3+hU/txKD4W45FAbVrqbXSTZxYTkcT6kkQ5xojeB
         yTDWQ0cjboGguArwwjwAwyx4P/8Xe3J70nMpH11XuYymRmj/w9wlLdboA7oIAxi5AYVI
         jiNN+EUQXoW9HzLzYFllw2zAx6bTKjmrpFoXUz5GzDggfVVBfl1x59p5GdgRimhnleUW
         4yuuJyhevVNz5AvQR0JLnUW7k1guH1nTYoyyVunRHOsk3jIixN34lBGP74NVKPsme8aB
         d3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898490; x=1766503290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6A3FJy1wSkXfE42mqpxDchsxNCyuEhZg+omH3hGmm4=;
        b=Fv/1/6AhdJtbuuklNULYjYcxOJPaWzMSM/dYpGqeq4idGgSw6RJql0tAI8FUUgloP9
         frIJ5oOOqto7RtRcD5uITsbxj+NznIJ3q3mxMnvXsO6OP3zO+TVspqHtGYuhMUoaKUMw
         NcOhgdsPnjHSmcL4ZhXFxZNHeEc0oNXUq9zcL7NgLkCPcgG/6KK+DGFYcte7HWHEkQag
         GOZUjU2z0tn/EQ6KPrSn/+Lz3DHFQmFdwI4R+0f/q2CtDZnrrAsFNIUsTOzu6jnDRdfd
         8F7jOZyuf0VeOF+/A2Qzf1xLOSycRWTRvmVLcja8pP8OXDuB65g7ph/BD6b0bwW5+4/R
         vKtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaCdrXqvGk8LqZkZeRYEa0O5tE3HbeAr/xtuiYlQn5rY04za6Z2epRWcNWDZmIsN2tOVrtobtIkjFqFd/vPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsKBHoA7Di/BqzJu1qY/rYDXjoxJRnsN2IWcnAnooziR7K07Ga
	dUL9HV7ULQk1e1yrSXRvchkwwnb4YKdH/GbAC4o2Rer2wVhbfGV0Yg2g4+nc9mcV//+CsgqBXa5
	l2hEKj3CoIPPHn0sTxNXcQSggSPRhaKo=
X-Gm-Gg: AY/fxX6OArT1r+o930upNKJFB+w95gxl5lbElsI98C4J5MK1m2ujHOBXbZKWN3g27RN
	UF8qgPl+T5w1YAlK7ovZ8wow32tTPhw0gkg8qybDguST2TuyVTZqx/ifobEf82ktj2NnWCXOYeK
	bEMsh2jpuNlhTa1+MBFoIRXcsb8fW88e8jvjk32gd6ZhoIpl3U9f1EBKn5M0RmQY+eekkyqimgv
	1OGrDYxQi7d1wkVWYh/U5b4dvVVOaQTlJAOok4D/l86BrE5pwodlx1rg5+jZnzGlLOzou5O
X-Google-Smtp-Source: AGHT+IFq0qaYbGK7y/3ERMab5mfBMJZm2RVpJeQ2PDWWvVrS9uWYHKl8nJo9NGLv/zMgaMY45LKm9slZF+vnfJuCU/o=
X-Received: by 2002:a05:7022:b98:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-11f34c5d690mr6648024c88.7.1765898489968; Tue, 16 Dec 2025
 07:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-10-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-10-bagasdotme@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:21:18 -0500
X-Gm-Features: AQt7F2rE8ID9d6NCh1LRY2rQdA6w_Kl1ZhHVictIiyXPuu3Pg_xadHkkj9RiiLU
Message-ID: <CADnq5_NsELxchDeka2CX1283p9mn4+P9_V9Mi+SNiWwM_sQepw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 09/14] drm/amd/display: Don't use
 kernel-doc comment in dc_register_software_state struct
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
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Dec 15, 2025 at 6:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warning:
>
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2796 This comment starts w=
ith '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide=
/kernel-doc.rst
>  * Software state variables used to program register fields across the di=
splay pipeline
>
> Don't use kernel-doc comment syntax to fix it.
>
> Fixes: b0ff344fe70cd2 ("drm/amd/display: Add interface to capture expecte=
d HW state from SW state")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 29edfa51ea2cc0..0a9758a042586f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2793,7 +2793,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc =
*dc, int primary_otg_inst, st
>
>  void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, st=
ruct power_features *out_data);
>
> -/**
> +/*
>   * Software state variables used to program register fields across the d=
isplay pipeline
>   */
>  struct dc_register_software_state {
> --
> An old man doll... just what I always wanted! - Clara
>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
