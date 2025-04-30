Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D8C253935
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009277; cv=none; b=XHilkY84SSOeDDY+QS0kzgWWdI6iicKJyjsZsstd+gOylo2U32pYIoD5WZ9f4jmC/pk9ewquKpEGbzLlYdJrxNKPUgw8ByNsgPkxEIgOfcScsgnm1pnHN46bzPh3zJ/NIwrFs+2G+4grEkiDNxM91qO04AwR+P9Zhu9o1sQpJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009277; c=relaxed/simple;
	bh=57iokHmYjdcAZayIvqdZd5fOEHDPDI/m5Ok9KeY3rFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9pbw/kzS+nl3WVSdqa9dUinfGrQKlgIs91UOzdsu/lqDIDjVpJ/z3R7zDnJFHEWbQxmZFJ8r7gb1PGOwBLyBTunlcb8QLs984IrzF9gaBYiOg+9xg1v2gV3b0AmcQOpSswWqk+FLe51DUE21gv//JVNRadN2LjGgeBedZOvHeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIKKsLfw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIKKsLfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746009274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57iokHmYjdcAZayIvqdZd5fOEHDPDI/m5Ok9KeY3rFc=;
	b=EIKKsLfw4CP9dpmdh58UdoWiQDzXyBT5248aLwL8aqD7NRfkw2EX3E1dfCxf00t0pYqwTW
	5C8O0ZOYEuiX2hbDf2np8QlHMVa2vGvVdaqoaoOkNwjEbzxBmqal6WVngDShIQQzhISxnd
	tfbcumi1rM1/F7P8W9mZGr4bYQSGUto=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-8qYpHSo8NsCEjcKiBaQEMw-1; Wed, 30 Apr 2025 06:34:31 -0400
X-MC-Unique: 8qYpHSo8NsCEjcKiBaQEMw-1
X-Mimecast-MFC-AGG-ID: 8qYpHSo8NsCEjcKiBaQEMw_1746009271
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e72a02f0e5eso8326851276.3
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 03:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009271; x=1746614071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57iokHmYjdcAZayIvqdZd5fOEHDPDI/m5Ok9KeY3rFc=;
        b=aPBk0xB6o4pl/++ScAnswFEH4TS1gq7GgoTTQsSj29iZ+C9n8u5gS4DArc+l+rTsQk
         QyuUcbqEcFsMmgMxUN5fjnR85eV1IU8Q5wNi8UG4h7oKFLHgJKBtK3FnUY5Xj2ZqRiut
         GUJ4jEhDXf/1hASkiQITeAVpcZUKraAHE7ggumdiPJQtEhKnCXt9JOBaHDeDwsdRXsJW
         Jc1qjJjFsKiYkGsXUhU45qHUOcY8pohMulDMBmLrwF5YSH547ZOrsJ266Cw3waAOYrqm
         V1b6QUH8iydFfA26Iraeho+WqPMMrgBiED4FlwZNkvEQXwolMNWKT+bI0fYfYyKSHNgY
         +G0w==
X-Forwarded-Encrypted: i=1; AJvYcCXzrYMnCvgLTvWYGmUeoIqNUDaucs7f0+Hyz+7tA3TX1yirvZesLl7uE++fHMf6x8ukchzB2sj8SCVmMC0FeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+ukKbGdYUdUd3/38/8WAmJ4NqugUHuDHoMx2vdTKefUjTzJQE
	O83Tj55T6JhP2ZPawye0+UWjK1WAvAAq5mEa3MCHmZLWms7uVT3PvlaGk27RFmexVwn0C4dTBI2
	kVfNXjdi1F9921zy8efksM1v+R1gohbsROx92SMv+BVPgBz+Bkn2BHTtLQUpDNBsR0gXT0smxZ+
	zscLLMEKwqIokptngb86LcV+e1Nz1jAioTje8uX+s=
X-Gm-Gg: ASbGncvhbQd5yG/5rGdCwbH1Q5GgfB61lmbxmm5RxZoL3lozdvgfTKXMtV0iiLAmKUx
	l6XSY1qfxn53jYXWvusgehcqvv1qIcOgXJXkAY8QmkaNUS4glRAETc0Dd4IU0SmolTz3ouCs=
X-Received: by 2002:a05:6902:2e04:b0:e72:8aca:d06b with SMTP id 3f1490d57ef6-e73eb1e65bbmr3488704276.25.1746009271077;
        Wed, 30 Apr 2025 03:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2PrL/8Qtn9RsZP8gd5PYBcNrIX0CThPxJuTbKkfEk6rVR0kYHi6XEOL3ZZcMQ3Xfw0mqQVeC6RSWHmdB1B5w=
X-Received: by 2002:a05:6902:2e04:b0:e72:8aca:d06b with SMTP id
 3f1490d57ef6-e73eb1e65bbmr3488683276.25.1746009270736; Wed, 30 Apr 2025
 03:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-2-ddbe73b53457@rbox.co> <dlk4swnprv52exa3xs5omo76ir7e3x5u7bwlkkuecmrrn2cznm@smxggyqjhgke>
 <1b24198d-2e74-43b5-96be-bdf72274f712@rbox.co>
In-Reply-To: <1b24198d-2e74-43b5-96be-bdf72274f712@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 30 Apr 2025 12:34:19 +0200
X-Gm-Features: ATxdqUG9mjYJydPSVQyHlnDymiSRul3tknhI-VICJUQQ6q1CyA6LPz-wMS1FOD0
Message-ID: <CAGxU2F5_vZ8S7uoU4QF=J0jh11y976+AxFKf94dp01Fctq-ZwQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: Reduce indentation in virtio_transport_wait_close()
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vLHIx9iG1BzIGvsxH9GdYM3frNPp7JoKWZwVfwAXKzQ_1746009271
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 12:30, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 4/30/25 11:28, Stefano Garzarella wrote:
> > On Wed, Apr 30, 2025 at 11:10:28AM +0200, Michal Luczaj wrote:
> >> Flatten the function. Remove the nested block by inverting the condition:
> >> return early on !timeout.
> >
> > IIUC we are removing this function in the next commit, so we can skip
> > this patch IMO. I suggested this change, if we didn't move the code in
> > the core.
> Right, I remember your suggestion. Sorry, I'm still a bit uncertain as to
> what should and shouldn't be done in a single commit.

Sorry for the confusion :-)

The rule I usually follow is this (but may not be the perfect one):
- try to make the fewest changes in a commit, to simplify both
backports, but also for debug/revert/bisection/etc.
- when I move code around and edit it a bit, then it's okay to edit
style, comments, etc.

Thanks,
Stefano

