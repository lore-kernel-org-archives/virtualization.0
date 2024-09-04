Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5693211
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725421126; cv=none; b=d86a7d5wqgzruaeg6QCjJhzMQc9Z7zwRhvntyJQL5K31y8dEjIa+ptKAZlbGJsRx6hMs5dWrTMuH/mlHvuMmHRmCcedvIWifwfFmC4hzMErz6BkFocFS6GWpnHuY4AmWUIcvYcXlLz3W0UPNoLUXUKyHh2eq+Uw7+EeFcnFlZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725421126; c=relaxed/simple;
	bh=8LggX3uN4M7m0h/bm9JWl52ManAc19NR9Lnhyf3mcUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZh+TJNA7hPnESmFIpp23/xzf1SiDX0J+xWEO3pNRFEuBYFO3L/bi8dbcAbVrVV4J59jdmAn4H8i+jWHSZ06zuorgth+yH4XI1imn5egn4YtzoAcZETkiXo6GqxRJoCBEDcajxmoqYLyV5Dj29D0g+cgRJtHRzAmZASilLgagZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6f1IGnl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6f1IGnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725421123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LggX3uN4M7m0h/bm9JWl52ManAc19NR9Lnhyf3mcUM=;
	b=U6f1IGnl+cVC7S2axRJqEZfEtG4hPYQ8YArQGC//iHpCN6mF+pwyOBWSoOy77ZRL2a1a1H
	BX5VC4PSj/sERKd6eejVLk1VcPU2xeEsSQCKtdux1tvjuGGWB0YJ7/DTMwiqpqhIgJDvwf
	ZImkNP4HZYK4ZXg8gCPPnrTwUCIc+qs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-YsaODXbwP92XGVe18eaaNg-1; Tue, 03 Sep 2024 23:38:42 -0400
X-MC-Unique: YsaODXbwP92XGVe18eaaNg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d878377fc2so375158a91.0
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 20:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725421121; x=1726025921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LggX3uN4M7m0h/bm9JWl52ManAc19NR9Lnhyf3mcUM=;
        b=PedHXruk368tOlKvLljDSAWNDbQtfi5NUznCS8thWVUoKONC3pBhv62wArwI13v57v
         IzJqOxPTIHoCybSnonhlcEyvtTLVhqxl+LTyGgESwQI50gG9F0r1KSw/eSl0HyEGNDMK
         OiFZXBlyBkBTb+4V/ou4im9l0HmPjNqBXs02SjYQsx6IkH3bKm54fk/sS/bKnbRBajbo
         UsiEECzKcxESldQJFYpPhiEfnCGW3aKFCfqAxDWEjFjU7DbC94tGJ7tEwXvhlB6CMTJh
         Vk3NGws1uu7CpVI2JV+mY9QAvDc9kUnRIPkkG8N2uTjs18dn0ZkTV/99qnctebKovcrN
         Qaew==
X-Forwarded-Encrypted: i=1; AJvYcCXrAvm2fNITO1n18zBnR/NOS2m1cFezquHRwb810FZj6NZ9OXxgVYCClSVwKxooaVlFZlzSUmAUd6pqb7Zvug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKobWU+obKdNNgl00tcSLyS+ecAMp1cADkd5LA9+FBmnfgZBB+
	nBnn80VEtr5L8oAcxYt/SuKvWcB08Xt93sfNLZJIJq8j9R/FM5ZJ4ieZG5XQGFf0Qc1RaJQqtIR
	BzBKMpXeNw8A2HQcRqpt/iVtMwrtdBEXcIjywvIyB8l9TfrZdQ5fMm9m2+7hWbR7dRuT+avRewH
	Kh6laPsQVDQzSTfWWZiEIgDLsCM1YyQLaXfnJQi80=
X-Received: by 2002:a17:90b:a51:b0:2c9:7343:71f1 with SMTP id 98e67ed59e1d1-2da8ef06ddamr1214121a91.14.1725421121687;
        Tue, 03 Sep 2024 20:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlGyB9HKL34arDASkgE7Wmme3C7Z/CcaPhQaHiR7JfaCCZ89rNpkhiOJtxSP3M0uKmOv0+AQdjpKz3P+KDyJk=
X-Received: by 2002:a17:90b:a51:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2da8ef06ddamr1214084a91.14.1725421121098; Tue, 03 Sep 2024
 20:38:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com> <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 11:38:30 +0800
Message-ID: <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:15=E2=80=AFAM Carlos Bilbao
<carlos.bilbao.osdev@gmail.com> wrote:
>
> From: Carlos Bilbao <cbilbao@digitalocean.com>
>
> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
> with vdpa_config_ops->set_config(). This is needed per virtio spec
> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
> configuration fields are read-only for the driver."
>
> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>

Note that only the config space of the modern device is read only. So
it should be fine to remove vp_vdpa which only works for modern
devices.

And for eni, it is a legacy only device, so we should not move the
set_config there.

For the rest, we need the acks for those maintainers.

Thanks

