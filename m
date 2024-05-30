Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBF482ED
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039483; cv=none; b=sJ+VFLR8szuwlgBYXkQI+Kywdr0zxhcVvtPYBo0YgEgAaXqIlec856rG78CbS/7tcJb91qr3PkkkD1Y7RjZdFbLevLnb1ds7PXv/ZS3Kza33jsUd0As7aNfW2j2vcxyRaF2ViiN8rjR3zlVH1gEtBTFHAU2bU31SdSwcHYuRJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039483; c=relaxed/simple;
	bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9rPcBkMOLNjGCfkL1YDlzIHt7Gbjkl9mXFBBFWM2+gztUp4L7ARtg4pVI97jVySPgDxmcoSxZGWXe9TrCmcSJn4eYzrSrAxfIBuufDrm8BSToCGXZj7Xj1JFHhZHGVYLjU5ClvpUaL3pfrHVSu67xPVe9CTbISVT403w9kCzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqs6ZtL7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqs6ZtL7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
	b=bqs6ZtL7NGeQcXScXAZRsk5PmZ9X/x4Tbq0May9i0aSKNA1I3XVCEFxaOUkuiU8Bp+HhOS
	I4hT/t3CGOBFTPDmAEOhFWPMTXVeOMvB039MTIb8x3dCoUHKXTJn2ix0WVhdXShHgUSHes
	1/3k636PAcLoauDGnsw9HclzKwThWcc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-kUEReahRPuuDb3apvQYaLg-1; Wed, 29 May 2024 23:24:36 -0400
X-MC-Unique: kUEReahRPuuDb3apvQYaLg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1aa8d19bbso333114a91.2
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 20:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039475; x=1717644275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+8/wSWGurAyL1xP57PH/iWopIzIysBpD7hmI2WgIbw=;
        b=Bq0+jbAq1VRn9oDHj7B+BYYleNyssTecObbgEsHDNJw4zBgxvgWHlxQcGpbgRKzfIX
         6FY+LGZSFvoxHTkG/CtkO0yTMExaC6ggcdMaufO8+AoLe0vhclpy1ci1lVevSw0Lfs9B
         dYiZnD95jRVfbP7aH7LNxn8oTnZ7/w6nmQX8C/S/vct4KnWD6qPpHDS2CeCvhhvff6jg
         84op2Mx8S/bxCFhqVto3vnI05AfZcfHLIZ/NXkFnhbJ/N9CgAvmG9QGEdjSzwh59dC3+
         AvhJUFsQysvY7jLcfzw3b2OGH1498h+GiK52o77AM7B3WZYah3b1QVcKBFoXMGWxkfgr
         lStg==
X-Forwarded-Encrypted: i=1; AJvYcCUy51F8/nUTyKDP7z4KxtPBanimqTe+SdIG5sReMDYGww+2+E/o+8peUOK/q65j6WUWMKo4Nlrvgie8Onw6l3GL5fSft7OgzSQycAoQoV4=
X-Gm-Message-State: AOJu0Ywh7DGEVlQzGyi0uu4laXkOCKzVODZt/Gp94jioYHNdSDdVu3U4
	9xPrnyaZi/9WGQNUpY5VcFJhry8NXUVd2KphrIl8AGuLpLwkh1FZ2KGyGo9TxZZmVzRi3Bz985P
	nu/I1E8hxW1pWxpeOxPohCkTQq2TkXSJYI8h/05lYJBA4dfwpJqfIoyvrivw5BFAj8djLc0VrGb
	UWaB37nzqC6A5o9XCxEdiFv2vnnl20zzCwt4Hb+FY=
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id 98e67ed59e1d1-2c1abc12489mr1001955a91.4.1717039475234;
        Wed, 29 May 2024 20:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnGrS/Tpu0K+sc6kW8BJyvn+oBs4u8ZwjRYuo5hvIzg+1YBpSRBjPcptyuj5g5pFuW4H/euGjPq4Ov1Fodj2I=
X-Received: by 2002:a17:90a:398a:b0:2af:a2a:ad67 with SMTP id
 98e67ed59e1d1-2c1abc12489mr1001935a91.4.1717039474765; Wed, 29 May 2024
 20:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:24:23 +0800
Message-ID: <CACGkMEte0SF-Mo=y5knNODpAtB0jra3rst3rR1kGNPZLY23hjw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] virtio_net: separate receive_mergeable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> This commit separates the function receive_mergeable(),
> put the logic of appending frag to the skb as an independent function.
> The subsequent commit will reuse it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

