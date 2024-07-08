Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59A12E4A
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419519; cv=none; b=S6hcNF3U9/5j3TuUaVn55xUEnXL1Q1csxY+4STmqH4Pt0y7iHHKys+vPoHn3POqX5KN6EssPEVYN4A/29L2IlhJs7Akjj2Dd4NRqp9TXUMWAHNJa066W7SEEgHrTCroaxGdz1+6B06uR0017U7YmnzD+SYtuYPJRnMmaIEeOLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419519; c=relaxed/simple;
	bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYNnFzYOwigmThicBhX+MT+Wh34htNeL7OtPg24YEx3jrtX6Cygh/weExSwt2iNtm6yp+Pe+hvYPUqaqN9c1uBabUe1FNqzyFCqtJvlyn4UQwn5uDIhMb6N/Q7VS4jLs9CTzKHUdrcsWIRWoUjZwRf/M259tYROyNUway2GYJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkegVhdX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkegVhdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720419516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
	b=TkegVhdXhouBsYUYdbm7TdMPSiy3pOsTOO/qkEu9jceZKhC34hd1N/nyAHEXWUpCVEMuwk
	d2keaHLGgr8nP9fGYqoQ+F1bxCzAbH9YLgqWkbXFdDECQ0s3pxg+N2vx01q4Mx7H9j/H4m
	anlQtO7S7vYXxR8lcmDsQ5u70ualg5w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-3xC-mulwO7ij3S4loKWtkw-1; Mon, 08 Jul 2024 02:18:35 -0400
X-MC-Unique: 3xC-mulwO7ij3S4loKWtkw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-70afbe5ddbbso2468286b3a.3
        for <virtualization@lists.linux.dev>; Sun, 07 Jul 2024 23:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419514; x=1721024314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
        b=d8AX757MOrzt167drRfxZTkRrSSeyJAUWfznOZc4KZwu6rEJkuZot3nPafyFof1KNq
         W6zWgEXsm0Jz3g6rEpapOxa36qXs+xYUUJIgN1hi3t704/udBJase6GcWNHfpz8fw0hA
         3hL/eN+YvfDM89EkavBL/OKMTINtMxHosDXZJO/c5RThq/EKRDkuyLoY8oTtbAdaufV8
         DI1MF3cR/Dc6DqB1+dAids9TYtkg1J5l8/v08F1GFTa0R2wtRKCgRZHZnW8E4ys/8Wq1
         sBOAzsn+yBt9iqrx8NB+V+Div59ggff3vjZEQpOXTrnD/diNI8S8DwaYZx2hSOM8rq+E
         jXVA==
X-Forwarded-Encrypted: i=1; AJvYcCWEoF81mGNTHD3jNyAiuVlpXTJWEOkBZ4LXuDqmLfeCaGTb9MGZApsFIuy5CAm2jlnt66DeXbl+VyCQ2dtRLxOgaVs/XWVGusIaKTE1zmg=
X-Gm-Message-State: AOJu0Yykbq1Czj9By+UDHNpHGAgaUkvPN9JoTGk39ZhWnotHfjGqtZC3
	sdblJIy9Rs3PgSzbNCOK1MDS578CAv5zx694FhlKuEuwBWl/BlSVDif4ZpFmgiX76mQjJVfg4xl
	rumY1pWSXBHv7pjTehIKKkIynNs6XIFQEaAwujcirquDiwSatltyRVEsx67I5dzN1ip7yTo8OZS
	YGUiuPaHvTDhZNSInfVGTWqiXdCdaa/tMiNEb8lOM=
X-Received: by 2002:a05:6a20:2d10:b0:1bd:4bc4:754 with SMTP id adf61e73a8af0-1c0cc74d964mr8965815637.27.1720419514340;
        Sun, 07 Jul 2024 23:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFayZpPEg9Vaky5HR/PLqBUvW+SazsbNfG/BvLurCEgyFqG4nbfYr5z1CFXGnmN81flNu6bpN0+rmCr78Y+LjM=
X-Received: by 2002:a05:6a20:2d10:b0:1bd:4bc4:754 with SMTP id
 adf61e73a8af0-1c0cc74d964mr8965797637.27.1720419513986; Sun, 07 Jul 2024
 23:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:18:22 +0800
Message-ID: <CACGkMEvr4QYNBX0fQAkXYUuKn0JvZ2dZtwsqh+0SCJBCsxMVnw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/10] virtio_net: replace VIRTIO_XDP_HEADROOM
 by XDP_PACKET_HEADROOM
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> virtio net has VIRTIO_XDP_HEADROOM that is equal to
> XDP_PACKET_HEADROOM to calculate the headroom for xdp.
>
> But here we should use the macro XDP_PACKET_HEADROOM from bpf.h to
> calculate the headroom for xdp. So here we remove the
> VIRTIO_XDP_HEADROOM, and use the XDP_PACKET_HEADROOM to replace it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

