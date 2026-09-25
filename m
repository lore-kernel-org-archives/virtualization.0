Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395EB353A63
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318792; cv=pass; b=iQmpxHZXPXZbwScBXVQ2vStDKkvfNxdt+Vz6ScRG1y32vjVLmseslrI6wj/t6vq3TtuaafYymubyZI7Ocm6Mkb2KIevU4Z6LiIPLRV9l1f0Kre5NwTA0LQjq4BVi1+rRBIFcIjcP+qnIncprxcBxMBlckDihHPJWvmmZlDMKBWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318792; c=relaxed/simple;
	bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuM+cevcttu9dKFGkZnOtxBCnAUYbDrvZR6ZKrd1bPd8T7fYcKdcFyWmPn+7byWQ27UiWAcvRdPAi0o0Rs8/+ffLTBWiGPaL0xKEeajVVZe9uOx2IADPQj2v2QV+V/LdrwpvlGLMas3fJg+aEx/ostHNDd3jWFg48tkTRMHlNao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp1lgKaP; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp1lgKaP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so2697305e9.3
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 23:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790318789; cv=none;
        d=google.com; s=arc-20260327;
        b=oGt3vNMeaE2zIo9ZYzXGuUqs0QWvRBmvaZqt8d8FiqNhIJV3ugQYD5WaFyrpKB958G
         ySyB0Q3OW/wjJ9yj5qrqrYMgaI5YsSi6Gy/wgSZtEdXU27NBfHs/CfcSQLjfZQniWh8s
         kpVI20K/XUyyGHFVpT0knwzlb034fFmgNjAE6prD8FFkYM0YSrPq8AkPiWCfvJd+hWn2
         ljs/r4MCAPx6qpt3vpJfM1yUTRLvldfhu1i0mVix81rG4DfNbtfzAPa30ef2/rTn++oU
         ouDDA+sR//XDrI8Ye6ECDjgv18jeXEog8RVwnTQz1ifrZcW8ZbdTvAqj3DzRExZX6B4R
         zGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
        fh=i7DxBYbRhR/Kkk7GcseIex0cZ1H/EDiy1NVeGfN9XaE=;
        b=nhRQI2T30f+1muTgkc8HjupSiYAet9Lc80iM7s9MYquQkTMR1KmvF21zKhxaQ/Mko9
         lkBHSmFCZZvJBb15mbtKe0vfaAAddszS0a4Igsispn2J0Pv8qYk2PccNpUMcB4XNVfpj
         pPn1OHYbPhMyTRgG7BncvBHU3C4ucgqM+v7/OL5veSL10qEq/4xgkMJl7s+xhr58k3L8
         VuJFRQZm7VGnQQedIUv1lmhqhzTk7BipaTKXIfuPea+HuMYEzvySd6JXXeBmH6xaBz6t
         OAXGmh0GHAgPvM6roYxvGlEBoi290P9rJ4KVBFfJSpO54Dvkv0dY+dVVlWwNKpiEhS69
         WDzA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790318789; x=1790923589; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
        b=fp1lgKaPrr8bcg7odCSFR+usaIyqYeqzLf4rdax63dhYRnoQk1wdZl5EJ4Lkt8+eZY
         pNvdCx9ggr00cGPxYSR1MUIjlN2ls662QIm1YzPF+fXwEKhJRDzWDhOF27FW/FyXj1J/
         /opVv0odC36QzoCKS3PTDJepkz/sUs6flVyi2ArDDb2oUwP3vlelXaCjITzV6v+TQcaP
         qOwmWPnZCzZ5b6pOUS0OeHWEgznjVIKXrcgKVm5HJEU6OqdLvOi2TUNNqh53AyKL96+G
         Uj1RVrThim+p7utk6O1R5iHNZszEr7siqs/dJzz8PihAlELPg/tBGTS27koH5RMZL4Sd
         Idsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318789; x=1790923589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMYQeYmwapr9qKJcU1TiAWf7WUGFTHj+8reCqdf/NZk=;
        b=GpebOS8IbZuP0rJE2It17ba0AwsI2bIlE11LtlyomwNw3FqAXdMJE0ayShJDKZsqLW
         SnCBJL6VGgyQuTG6X1MeISdAa0OyhZ525mlpU79yzxjEoRfizu1jQgW+KGda0zcCIfOq
         wuMg0rHGguSibPmdz6Y9cEz14lbl3zJCcwN8ypckY2M1YEFGS15x9Xa+ktETCBdzPf72
         RSt01pVx5wdIM6FxmcmhdyGbSeNEllgvYTQTs3BI3kt7rtp3a5+NGikEfPDl7Okt4I5r
         BWF5AsdWcKQ6ZwEOntvDFAsEpiSPVwHjGUND/DRLqPEsfmxtuBSq9xQzYDwjyKW+oyQS
         M6NA==
X-Forwarded-Encrypted: i=1; AKwUvBxiaeCboMLX1sJoGDUu61fiouf0hEs+F2Lb2DlfTqVk10thqOPY7vUCia/xwFa+pc2hPsA7Af0BulVa9k0viA==@lists.linux.dev
X-Gm-Message-State: AFuF++kkpCKtvH87qRRtbTH2eQ6dk4o0DraZoY/lFnI/hCdLBAKd1rAG
	t+m0n1Dn/RhWNj+PdXP40A5nR2YpaBYbK01RZPxSxkLN9mYvlH6ueSv0SinHLFKQVccp6540WnK
	aGZUrJDlcVDRLyHvZmS645fIhVatwFZ0=
X-Gm-Gg: AYBFou09ar9g7cZ8NR6KfKH4pMQZa9ndMATsX1WGPgtusnlYIqiDNnLfiTb2sJoN6ds
	tJpL7+lXAon2SLsbXrReBkzD4yYZEfRdwuYVkAiLHnIEL3mWsd4KQYR0pZRs4M8+4p3MwMGjINd
	0yFjyxf+6rBE6ikTPaya0XFA2s8pnICwN3D2JnILP7/0telKm+DCsMtuN0ByqjxZJjjxN6QWJXX
	91vw8CyS4p5mSocfjWa+dtFqs9CuFAzkSoZ9EwuaFE6TjVGruA3a6azh5D3Rt0sEIp+gLJMSKSR
	vBvcMmXIBxkv8qfZ1dDLODyXLq3ZOevFFtIPQEg79r1xtkeuf8dmmeCqyIcmnLwl/3K9OV5S0wY
	cYIddRAXxHs8ulw==
X-Received: by 2002:a05:600c:3107:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49ff06e502dmr21437475e9.16.1790318788803; Thu, 24 Sep 2026
 23:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925054408.10431-1-lance.yang@linux.dev> <20260925055807.32678-1-lianux.mm@gmail.com>
In-Reply-To: <20260925055807.32678-1-lianux.mm@gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 25 Sep 2026 14:46:17 +0800
X-Gm-Features: AclHuK_RfCuOCjo48ccB0F6bBk20RwJxdVKVRfQ9R5t7EYWoxDxogjcXf0echJY
Message-ID: <CAN_Opa878W14HLKZHic415SH20dHfJQwxpaZu0LXnLMsc5Pqrg@mail.gmail.com>
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
To: Lian Wang <lianux.mm@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, sj@kernel.org, mst@redhat.com, david@kernel.org, 
	damon@lists.linux.dev, linux-mm@kvack.org, virtualization@lists.linux.dev, 
	Kairui Song <ryncsn@gmail.com>, baohua@kernel.org, xueyuan.chen21@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lance, Lian,

Thanks for sharing this, Lance. I also saw SJ's post yesterday and
was very happy to see DAMON being used in a real AI production
environment and delivering measurable benefits.

Hopefully, DAMON and other MM features can continue to evolve in the
AI era, better supporting diverse workloads and real-world use cases.

Looking forward to learning more from the DSec experience and
discussing this with everyone at LPC.

Thanks,
Kunwu

On Fri, Sep 25, 2026 at 1:58=E2=80=AFPM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> Hi Lance,
>
> Thank you very much for sharing this and for your interest in the related
> work. It is great to see DAMON and virtio-balloon being used together in
> another real, large-scale system.
>
> One scenario we have recently been studying came from Sangfor. In a KVM/Q=
EMU
> deployment with guest memory backed by shared tmpfs and host THP enabled,
> host-side DAMON can report a much larger hot-memory proportion than the
> guest's fine-grained activity suggests. The related discussion is here:
>
> https://lore.kernel.org/all/20260915025514.2434-1-lianux.mm@gmail.com/
>
> We are preparing more complete experiments and improvements around this
> scenario, and we plan to discuss it in more depth at LPC.
>
> I am still actively running experiments based in part on SJ's earlier
> introductions and our discussions. After LPC, we hope to share results on=
 a
> more regular basis, together with discussion outcomes and reports from mo=
re
> scenarios. I believe DAMON will continue to become even better as these u=
sers
> and perspectives come together.
>
> I am also contacting the authors of the DeepSeek paper to learn more abou=
t
> their setup and experience. We hope they can join the discussion so that =
we
> can work together to improve this area further.
>
> Kairui is also very interested in this DAMON use case and may already hav=
e
> discussed related ideas with SJ, so I have kept him in Cc.
>
> Thank you again, Lance, and thanks everyone!
>
> Best,
> Lian
>
> On Fri, 25 Sep 2026 13:44:08 +0800 Lance Yang <lance.yang@linux.dev> wrot=
e:
>
> > I was reading DeepSeek's new DSec paper[1] and found a nice use of DAMO=
N
> > and virtio-balloon:
> >
> > And it worked: time-integrated host memory use fell by 21.2%, while pea=
k
> > usage stayed about the same, with no significant CPU overhead.
