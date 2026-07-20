Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C392FD1A5
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591066; cv=pass; b=ghvR5yxxj2A9s7YOzs1KlDX2tzXqyXJSV8IacVUVI1nDwc4iIaUzwpxGS722f1MsZDHOoRu1PgcQq1OUpCrnJvqkJlVTKxl/uM9Xt+N6eoJwfCe6DihMdU3Dr/PjM+AS8l9/76w23cit6Z5bjHLraWkLL4Lf/kFzkrZZIT7Sg7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591066; c=relaxed/simple;
	bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEKv+Tp5F6RGEGfH06va9zGdT3Jjh/RaXdk0PJ3LRIvNtkUvjIUT5ndhmbhyC6+TlwZwMcqzhkTx4kzoA2kjdgOHvOA10diZFtgan8+Qx+AhihOvy76ati46Vs35gaFdr/sLltqFJTLnfcucDrVeepQRgRjDh9xRZbRuv4I2Uzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEBxawxh; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEBxawxh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cede6375caso386785ad.0
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 16:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784591064; cv=none;
        d=google.com; s=arc-20260327;
        b=dwbB9CuUIuiuKz+CW3hRiV2CwZxPXWiOTEa+v5+ENlBEFbKD8c/86obnlOhRBIpdQy
         XrjfBbZstzvCqKlu3GJ2ll3yWHvQ4BQsxEIVpop8bs9bG9rlTdxMZdobDVMGqgrZm0mH
         F0Z0qG67or5Cge2qCjk4wU14JvGunxkZ6hIuKar1cB9AdvfDmpCV8m0nj5NYCKx4Bj9I
         jVfN9WXZ8GJ9JJuFwZKBANdaFN9t+Il/Q8J/EJrY4CfRr4rGN9lllUnXYwWtntCJSpNy
         c/RXpHvW1RnpsQnEAOYZKq4Az4KrBXiRkt8/mCB5gz9XpEXl92pgiyeW839Vy9TrJ5mC
         qJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
        fh=SzSyoxRPHia+PdIeNk2ENxVi/0kbMYtLKh1o2Lh8a98=;
        b=hfp0PbMpTgYLlzonuTbajqXpMWJWKTZtN7+Rv/xC4nHZk822GOevu/oi0RQLJWb+4g
         +pDAKrEk9/z8CYmjravxtHVbd5RDS5N05K4BVRbewl6XObSjtDCuZzsZtN3ewjPb3H1Q
         FsCpTAH2ZKPXTDs/PgrkNgL5M5lg7+eNtJpHinRWBuzLRfyX2EybaERFKeWQjRotOLg2
         dxVq0XkqPnreJLuFRMDt8M9wPd0uJiuMaW8g9ExQfheyfT50q2uRr64COV9MV5nF+saF
         vrzP76VpIZOYV7pni/p6vmF56mNTnxYl8RCcf0kD7rAhDyfYhC4LtrPFz9GVjU0xut47
         BuWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784591064; x=1785195864; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
        b=LEBxawxhCTcdRdwJJjnxmKusu+rf1b2IkQuSh3ZwKiPRIilceqcA444W74s7DG0nRy
         CgQqHZQ0l1MxFDmWHOqAqJ3NA+JY2ia61cKfxrkPoVxyYC1e1rRC+gR4UHFeEfO6E9kU
         d2UpSZk6euy93Htjehh+vXAraf8w8TmdXCFGCmhdzSENFj2AfKXl7o5WcMfmHm1Gh1+s
         iB7v+zWgbex8L1wl7kwtRwSpmA2uAjIYvoeleVX9M7WYP1VfQnZQJjx8UHtWE2vAm49R
         XwmDEzhmT4EPscWVb/JvLffxuwWdAsALWEPfW2cS5DUyb5/cil+UKvE8zraA1w5F9nzf
         z0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591064; x=1785195864;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=riG3LbV3k8BvVbdgieZV9J6mlRu1bGRgQczBpq3mS/M=;
        b=CSr5OB19QIC1D9sfQ8hhGvzUnKrNl3iKyAMykCR1W7YSpGMMzkQyymqyIEb48NoR2n
         45Ro3umt+ub94mt1znWwmKvQEle7HDEkjQSdF24k8wO71eng85OkfItXXukO+ptY4Mha
         kEEPRe6W/BIrsFhDveQ6+JXyyiAh3yr5sN2kZhtWcaTbHbgEBjhoyYUvsqeoGDT1mrBU
         F0ICNmULuzNSWHEBz0rvjr1lq36YJQJwEBYOmll0PzVQWomnGIzL2pSfNYaa6LdvUt0N
         yPRGn9agztBhDw4kqCFej08Zg2TYO0Tn4m/10D91/236gvbLHy/Jfz09oEFd5GZaPuMl
         qeLg==
X-Forwarded-Encrypted: i=1; AHgh+RpFM3ViAVdH+c32H5bjkmnZgjuj+QxeJ1okSn96zBYQhpRzcVC7JtVaHmOf5yCdKcWMx2x4hVz18OnI7HGr4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj7SDDo4svYE4ACig/IPFcb830BTbLNgtQeChGcTMJG0UaaB5E
	OV0Muy/DI3yF61eza6rgKhcuub38ZqyaDUx2qupmMBbdhv8eAa9ramcs9mUrPi9xCZOczHudSrP
	bK2Ph82Ds1o8r9RBjldIbKxGiyqH0PpigyLGUZ1Wg
X-Gm-Gg: AR+sD10ousRAC3QDMxsndRbM4yy9FPB3uEV3q5Z1x/nUbexAh80ZjftZA3XrPcXynTF
	8jwWhkwH4PfAjHuklbOVigkIMYUjKg9aJpbbB0DQod7UBjEFTu+eaf+kAZ/Ikmo0Rl1nmUUTjwZ
	9Lxr5z5gRhd/M7uqp/fh5rYHoMjwwD7euyl5GDAXdMSXr6qEKIzVWRmL9gaOEgzBurXXO9G2UZ9
	Gzod6MeDq3ANakhxrqTyLOCJxts53khTrosJ6DE/rK8EvAwghPDzHLJO8zb4pEivUauRi7a2nco
	NNFiHE+ThjLk/lZy
X-Received: by 2002:a17:902:c94e:b0:2cc:a859:d404 with SMTP id
 d9443c01a7336-2cf7b6d3247mr3540335ad.23.1784591063975; Mon, 20 Jul 2026
 16:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260717002311.681748-1-linkl@google.com> <20260717002311.681748-3-linkl@google.com>
 <29457fe7-0fe6-4bc0-81a8-9e67f85b3a3a@kernel.org>
In-Reply-To: <29457fe7-0fe6-4bc0-81a8-9e67f85b3a3a@kernel.org>
From: Link Lin <linkl@google.com>
Date: Mon, 20 Jul 2026 16:44:12 -0700
X-Gm-Features: AUfX_mx2yFU1L9Gcg6BFQSpQ6hI0WeLlvWjDg_00zh0kZZHsctUEsZJDtTWk7bI
Message-ID: <CALUx4KT_EPWmKhEb5hTD2tk5k+WU2oT+q9Bwk4z1sHBKi0ZJ7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: avoid shrinker execution during PM suspend
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 02:17:24 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > reclaiming free pages under memory pressure can trigger page reporting
> > which might access the deleted reporting virtqueue if it is not yet
> > frozen, or interact with other parts of the driver in a teardown state.
>
> i feel this is the thing to fix then? not the freeing itself.
>
> ...
>
> this is remove, taking locks seems futile - if something will acquire
> the lock here, we will be in trouble.

On Fri, 17 Jul 2026 11:30:44 +0200 David Hildenbrand <david@kernel.org> wrote:
> Why not set the boolean immediately after this, and call it "shrinker_disabled"
> instead of "suspended"?
>
> Then you can keep calling "return_free_pages_to_mm(vb, ULONG_MAX);" here.

Hi Michael, David,

Michael, your intuition here is exactly right: the freeing itself is
perfectly safe, and taking locks in the teardown path is an
anti-pattern we should absolutely avoid.

After re-tracing the execution paths based on your feedback, I
realized that Patch 2/2 is completely unnecessary.

The FPH shrinker doesn't touch virtqueues itself. It simply returns
pages to the buddy allocator. While this can trigger Free Page
Reporting, Patch 1/2 migrates the reporting worker to
system_freezable_wq, meaning the PM core natively guarantees that
worker is frozen before virtballoon_freeze() ever runs.

Furthermore, any asynchronous FPH hinting work happens on
vb->balloon_wq (triggered via config changes). Because vb->balloon_wq
is natively allocated with WQ_FREEZABLE, the PM core successfully
freezes this worker prior to virtballoon_freeze() as well.

Because all downstream paths are safely frozen by the PM core, a
concurrent shrinker call during suspend is entirely harmless. It will
merely return 0 (since remove_common() safely drains the
free_page_list anyway using ULONG_MAX) or safely execute without
interacting with a teardown state.

David, thank you for the cleaner `shrinker_disabled` suggestion, but
since the asynchronous workers are already natively frozen, we can
avoid touching the teardown paths and locking logic altogether.

I am going to drop this patch entirely from the series. I will send
out a single-patch v3 consisting solely of the page reporting fix
(Patch 1/2) shortly. Thank you both for the rigorous review that
steered us away from this unnecessary complexity!

Best,
Link
