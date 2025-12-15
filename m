Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CD322B6F
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800506; cv=none; b=U0YltihJq7EbjjG6aOjriDD3YYJy7KcAQSzwwu76U36XtO5jRkGbuieTJJk7oFj8B81QfAmtpRs822Xy2sPn0t1ZIhXw2GzTdJc8dMYqKt0xakg1VHGFlMv+9xY6KyGHFJLmchEBrd7bPKhI+mzTstNeZouiToSofYCC5FK5zbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800506; c=relaxed/simple;
	bh=Ov8cS5KYxzY2mYfh/O4WmV6Fp6bmcasgAm++BTdClYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J29CHIKpUC3vZP2AskG2DLKQMGIr98dof5HWmPyfJBTuk5ohRH2KspIZ0m25ZRHEMAwIXPOTIYT74GOhOhE+uPg3zrvTHRyvDJP5Cby6HrVdKscRepAwNOTecE4yIWu+cAZ7yA70MQnNY5UyCC0yy6ozy3ZTrZrC8bg2xL2KEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcaM67qY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcaM67qY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso3609258b3a.2
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 04:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765800501; x=1766405301; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+DGkbwvSveRrQtSlxFukYMul6SfDciYSPOsqEu5ZQPQ=;
        b=BcaM67qYzOtvPOu1DwePiaUjdXpiD1/gXSgEyl/lbfeH0Oeg/td3/LliAlj4AlXs2q
         XTD7RulF1gYeGGpt4rL4KgTFEfbAo+uPge93OKrMJ/xDcy74T4pYRJuIXzVwaBGb3YgT
         VK07W9GRNo9AEOtuwXzCSYxiS1AViUXFM2/X0wbS9Sse3yK+lqW8jerdUf+ZL+nUQBR5
         4HBuS6k+YIkDiSWYtm6yJggzXKIGglx38zNW7DboXgEdJPALAekS1C9IfmWbcJfCvZQt
         mruVYNI8lw3i0AN/fFhkbR1hy6GnWUZE1RLqEjjSTLgkooLE0Y2lM3CldMCFyMJDV4ne
         a/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765800501; x=1766405301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DGkbwvSveRrQtSlxFukYMul6SfDciYSPOsqEu5ZQPQ=;
        b=m7qHcI+Fu5Tukyvc2cw7iQqQvAudrEkxwiNlChxQHFHkJPQgI0G220AACjjUSj0u2h
         tdhiFo9o0HusP57vkyJptaa1LfM9gGQle1A/iVI/IC2fLI8Bzd3UtaovPc5UPD0y0Db2
         Arknl9L4UjFPMC5uJ49oO5dOnwpud+jtExKrGz+PYaqakvibqbhBKEtO7bSwvj3tTO9u
         U6PpyVQcp4reqKMAm2rEQyPDGLm49RKGNwy5KoHfdIOXQT+es1HQqtfjfd0mr6JDC3IT
         xMo1N8sZ+8OUxo4EMXWJfMQCrtTGc8TL6TDC5Jympi1LzRECYYel/NmFPGNR4VCY1Iji
         KnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhxmnsAyyZiTrUBhVHivJNTbAnspOw8eA//rOJOs2hWSeshZWeC1jDxn88Jbm9zaZ8vZ/t98Zt8NGhL3rGJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsEzY7pfcCiwctqVcCfIRLfCBJvLAMmbdEu3ToXaFtj/AWda5W
	LyserneLGIB0UYGDL7i/N2JtC31fYK7bU63QAmknoNOyI1jVNKxa3p1sOeLRrWfC06K9P699xL5
	GCOACYSWITR1UvHa0sptFMyRYuUyakIJxJK1Ol959
X-Gm-Gg: AY/fxX7MSoyLH351S89ozTL7OhosiENBr7NAZE6E3aOGLXP1qhOMzAGO5Vy4vtfLEPC
	aJwtFljNBbHjqy4aWf2qIlbsq3Ei0zWyJtRj3x9gvaQf5zeNAv7L5Z4FbkaRFL7tiWbjgh6mbA1
	lVCU4nEYe6osqVcfRYd862ON3gZo2egfPM4TKCoaughmKDR5TtA8knvGEhR3S+lGyM6yvi3d1nf
	tVG2qPuFCPjTCFiyCotr0OinwSlt2pJ0O8/ZF7AGln3pz7u/WvrmEhHsBZw80QP/ZlZ78gKvzGe
	Ox5l1pciOsudRfurbKnhY1oLw411ZxOmt/Hg
X-Google-Smtp-Source: AGHT+IEBC+acRqtjaBBJQBmhlbonF1wwGFrMO77Zlp8D2bmspUQHM2nItV5HpI3KRFKcy27LH5o2hYak0ysa4tYnvE8=
X-Received: by 2002:a05:701a:ca0d:b0:11b:8fc9:9f5d with SMTP id
 a92af1059eb24-11f34c4d15emr7306064c88.30.1765800500924; Mon, 15 Dec 2025
 04:08:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-6-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-6-bagasdotme@gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 15 Dec 2025 13:07:43 +0100
X-Gm-Features: AQt7F2pEt11ob6m3jn_EvmNyiM9lcI5ir1gIqaEopvbMbWpYo3dEgZbn6PIAiFk
Message-ID: <CANpmjNNrHYCPp19A_FPeFY1kSTuyS0W_zjo21AUrmjqjqcYa0A@mail.gmail.com>
Subject: Re: [PATCH 05/14] mm, kfence: Describe @slab parameter in __kfence_obj_info()
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
	Dmitry Vyukov <dvyukov@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
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

On Mon, 15 Dec 2025 at 12:39, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Sphinx reports kernel-doc warning:
>
> WARNING: ./include/linux/kfence.h:220 function parameter 'slab' not described in '__kfence_obj_info'
>
> Fix it by describing @slab parameter.
>
> Fixes: 2dfe63e61cc31e ("mm, kfence: support kmem_dump_obj() for KFENCE objects")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  include/linux/kfence.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 0ad1ddbb8b996a..e5822f6e7f2794 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -211,6 +211,7 @@ struct kmem_obj_info;
>   * __kfence_obj_info() - fill kmem_obj_info struct
>   * @kpp: kmem_obj_info to be filled
>   * @object: the object
> + * @slab: the slab
>   *
>   * Return:
>   * * false - not a KFENCE object
> --
> An old man doll... just what I always wanted! - Clara
>
