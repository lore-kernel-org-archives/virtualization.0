Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8D8528E
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596903; cv=none; b=Wyr/dIm8GQydCEaVgeVHU4sJE4/ogs2UYMhci5LL02cKQgDPhtvxxm0xwkbBAcPjYyv7NdWuXcq0bnCd8g8Lne7Vq8m2PzxNrlvc9xgTDYmUb3Ys6qSiWE7MVPxZqwgrsNZNAm7szuRHgMsta+OrqOar/cKQW6gAXoV6SHWr6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596903; c=relaxed/simple;
	bh=B63eHeRWNhXGoZMlIjO0/cWMhWAPSUOnw1mXi2+9rhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUDwW0odB3ZvCmqvRy+3qwKzXQMmZpVvb6sNpMHMFlkCqTHkmWAL9d+iVLfmsZJZMKFJKcN33Ob0ChKy9mRM6G7TxKaExACHPQLW62ciEsPGcjiiEzdwAMwcTvks4VfcmbiT3QDYVFnAoKF+5NZfyEV8GvSwxNvzuNnNEDURvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChcyKM20; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChcyKM20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737596899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B63eHeRWNhXGoZMlIjO0/cWMhWAPSUOnw1mXi2+9rhQ=;
	b=ChcyKM20GBs66EmZPBp0W4vx/0odlzPVgJ0MqTVFZb6oZXVcWQm1R/+iUSROCqzyT+1p+O
	XtSvHC+xZAx1cCiPHYK2Eqj9NOqI7A3KzgHQYLukMudHdcse6zqyQnNiTZn7+Pt0TVBKgh
	42ecctLxA4WvXzYKofQj1NTvUCXS+QQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-U5QGRRJ5PtWGkTt7-MmXsg-1; Wed, 22 Jan 2025 20:48:16 -0500
X-MC-Unique: U5QGRRJ5PtWGkTt7-MmXsg-1
X-Mimecast-MFC-AGG-ID: U5QGRRJ5PtWGkTt7-MmXsg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so880149a91.2
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737596894; x=1738201694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B63eHeRWNhXGoZMlIjO0/cWMhWAPSUOnw1mXi2+9rhQ=;
        b=mnznfB35FArKwqULu/5SxqYawC+DTm4iofSsRPw+eB/aj7v5ndgJss/S8aFVr9TuNo
         Ew5bMU//DoMXI5vXQtDMBAk4DbGTQeG/TY0bfRWnG1Sd2zfdECgPCWt92/MuB1p75+UM
         04PXkVhKukOQRPKkXmWVIkJoVjfObi0GvQWWiZquXzoInLF0JMVS09BrJwPQkudKNXzk
         udSzKi+ICxPulRoafkyIKDzl/4KznnlThTOASXJ/wD9UOmFPg/5PUlChkdNbN3U6CEWS
         e86CHTo8/atR13TYM+sdnKsVrx4VEjC1A7+nI0YWFM6XHWQj70mzg7s1froCZ5JfVcfN
         pVXA==
X-Forwarded-Encrypted: i=1; AJvYcCU9tLcEW0Uzr0Ei5Js1ZwnGFBGMfSB6vSfodnfcmFdqJRRauVZI1G8T9ET2uGhvUktQrP5MhlU/ppTMBiHpPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLQeddLRd1nmfI3tUEhlSOfb2cz+2hyckLZQ2RQrQEagzKvjVy
	/FG8VdgLhsfGI2yRUfjJJuBR3+2FPIwh2+GZVfu0PnoZqPyAc9DDArcpzkfJf/4lsPcHO8778YA
	1LV6uzTbYIZ3HdPLOHSud+tAgZbpmV500EuEBqzMoUjobKyb4EWWYOrjqVV16xcr3zRVwxTU3sm
	mGgHm0X9SlcxMg98Bsd7K8+J2PASv/P7DJ1OD+uX4=
X-Gm-Gg: ASbGncuLQRkQwyx2K7ATCPAfTcqwOMSqUT1E86Ul5+LM3sWKUobC0MVLi6Zlue149b7
	5QK27RxLPpMv/dCj/ov07iG3b/PZZtOzZhKPCfmeA/10uFkTgig==
X-Received: by 2002:a05:6a00:2183:b0:72a:bc6a:3a87 with SMTP id d2e1a72fcca58-72daf86eb81mr33752147b3a.0.1737596894742;
        Wed, 22 Jan 2025 17:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSK6H+eL2ekLeIrc0ScLWcz0cKMhYidBx2yNOfQSRNQN4FwvvLt2xp8lNsN63bWoE5nvU8d6FvcqD0unirHHs=
X-Received: by 2002:a05:6a00:2183:b0:72a:bc6a:3a87 with SMTP id
 d2e1a72fcca58-72daf86eb81mr33752107b3a.0.1737596894349; Wed, 22 Jan 2025
 17:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-2-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:48:03 +0800
X-Gm-Features: AbW1kvZcKMwaeZiw_kG1-QtQLZ_at00KR13FKyGmGWK7_0hA02wiFkHRJRH5CI4
Message-ID: <CACGkMEsWKq396u7bpD5EsGnaWoMUTHL2Wj=86BG8b2ehTLuBMQ@mail.gmail.com>
Subject: Re: [RFC 1/5] vduse: add virtio_fs to allowed dev id
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5mAsOPl9rjifCV8AKVVHYzr8vY-bSU951AZKXU8jQyo_1737596895
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> A VDUSE device that implements virtiofs device works fine just by
> adding the device id to the whitelist.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

