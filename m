Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2951917ED
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336613; cv=none; b=YbGdMZOMsFA7wcMZ//bLaVLILaWKBGxcIH1q8rDFOU4AWz3lc4G0sMrX79UJfI9oSWAUywdx1c/A+7MCwFYaKIw7u8jwiWKVaqAxhpLAq8dcyIzLMUWsCiByXxGRJ16y0coMlPRDcieQ9geU1t25JdlmbsDfb5h/vKQilEXOFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336613; c=relaxed/simple;
	bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INCCSQ56QxesWIjWCvh2EjiJZzMtAgnmoQ9z+aHacsHxUOXt8aRdYJBmeFUr7p/JciGUXzNODg8b3CbTIQqRTUHFN82uC85hZ/vwR7kDAExaTriMUo1qB2pTsWowXg45Y6ZTii2qUpKs1hQvBuKjhQCCSILt+73LRcRySSvMSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A54fC3Us; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A54fC3Us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
	b=A54fC3Usp6IAEXfjI9BhNmg6Wg97Ae8qnkVGyCZf+Fl/5dJNbVXPUXyjhSNfbLKY4Dv1G1
	5xlqYj7HbIl8jx7tm2DQiIWUNdTztaewCaPn/lxpQM1HHHHmXvdhUnkv5dWmccaj0gXnCn
	uThczIaGgz/iHkYpn1tWBalU3tgllSs=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-UGSl3RLdO6agilaMkyq-_Q-1; Mon, 30 Jun 2025 22:23:29 -0400
X-MC-Unique: UGSl3RLdO6agilaMkyq-_Q-1
X-Mimecast-MFC-AGG-ID: UGSl3RLdO6agilaMkyq-_Q_1751336609
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-532d32147f3so1382136e0c.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 19:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336609; x=1751941409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzEAJUUD9OK3W0bVuYO+NSmpMMWNsePaoIENu1gvApg=;
        b=Kl9cThYBPcjN7YpxYZX4iwz1LNp3ZrVWoen7mzDkgggZupDcPHqWoj/AaRM4UcUe1M
         1Y6oMNK3V1t8H4zcBKWTusdrlPJGXgQYcmdH7quLnQoyn9OuyeXvf3J8d6UZvLln8pFY
         DHpNY0C4UatP9pvichAo/TeWM4ilwMlePyehCpfOiCqUBgpJNvwY61LxJGkQSxLClMAa
         yv7teCtE5dNZ4x4SaBRNXg3dPVSp6EOTOr2tZ40Cd8ccskmrfffDNmv8vBVgf9tIs2C1
         Rm85eqrXNEe+ev0ys++bSJ2YAHqJAYvU6Wg6M7JvxNNiTIvp7TapmvXQURBkD5WgN0+u
         pa7A==
X-Forwarded-Encrypted: i=1; AJvYcCXMUf33AbH02SKI1/MyCqPss77RyAUiuAYyACsOV+v2jepW41f/Jxhmy+j4fj1KOlhhv+EJdZgViiBlrny2dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYHjoF8x4hXtbGQ9zyKWeePSaRFNl2v33WQa0GX+OBRUKV0++/
	Vp73XwmSwuCYpJJSCpmbopAPUWqhekYIQizFBPzvSvGzbNUsGG+ZilzBkoNzByQtEjadNASe0/5
	LjfrUVIjWktEfdeGs7fHpKgVPM+6YWZt94Z0lU+C/b7nqj3zJF7eoU9WcEDrD4TZl+TJL2JEHy5
	RoI/177/b3VP6qVUcOWgw+iygYBAycVnkw8QtoNygmNjk=
X-Gm-Gg: ASbGncsU5XQ3vLPXyWHl5XVmBijC4RV6QsfZuh+02Zu7x1hxlIaoXKk/fZ9j4ebVgyc
	FcHGtIIum+nbaZbXFcPE9uzEfyW4bm0hh6sk02E50+Mx+F6moGDoNhFMDu+TfQJeNX8iotjnVHp
	fp
X-Received: by 2002:a05:6102:5123:b0:4eb:eedf:df65 with SMTP id ada2fe7eead31-4ee4f55fa28mr10132601137.11.1751336608766;
        Mon, 30 Jun 2025 19:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYUKosjg1xV3/2kEIImXNwrpXMZl3+XgrJg900Mb6VAWhQ1VVykJLy6Rp+l/68SJ/VfW9TfhDDb0JYqP7DqAE=
X-Received: by 2002:a05:6102:5123:b0:4eb:eedf:df65 with SMTP id
 ada2fe7eead31-4ee4f55fa28mr10132595137.11.1751336608477; Mon, 30 Jun 2025
 19:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250630151315.86722-1-minhquangbui99@gmail.com> <20250630151315.86722-3-minhquangbui99@gmail.com>
In-Reply-To: <20250630151315.86722-3-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:23:16 +0800
X-Gm-Features: Ac12FXwmRMP0wrScNXo4jLviRavx1GRKuzUNyZLulsaizoOGTdjbvUZnQk8mBA4
Message-ID: <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YrdEPU5jOpDWlwBOs2lRrKhkCslQdCrkHWT-HYjJwtQ_1751336609
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 11:13=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.

So I think this should go for net-next not net.

Thanks

