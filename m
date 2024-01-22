Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A954A32
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 04:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897488; cv=none; b=uOKGHyUMo1uS2Q63+DEI+zxtOCMzxQiYYU+5UkF7Kgs/juIJKvpI/6dASw6z/SFkwYqk/9PTFdAI3Odf3LnDxVYz6gRhzdq7dXTy1WjVBPslBH8BSBFXa/R1sACgMB3AruT4/tp5v5uDEsil7TtpdXhi8gqP4yO9ZYpbIkYPSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897488; c=relaxed/simple;
	bh=LqF0BZq+X2S8Q8y8RU+vztBdmt2VUpRGis7MC339kg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZPDn91lqytUM+/eH23uy4v6/F+bkdL0Voj4dZkxZ8JoQ52AxbzxboBATE5xIuCCvWxGmfBihrb4eH7T+DHRV7/Ly1IeKepCye+bZp2Umo8Brwi3sSbM+Wcg9gos7Aaz5zC/cobJjQe1X+sLPfCzuuVy1Emj6rtAwuCczHlCpkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SppPol5y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SppPol5y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705897485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqF0BZq+X2S8Q8y8RU+vztBdmt2VUpRGis7MC339kg0=;
	b=SppPol5y1tuQxjluybfJ3zqZRX9lHX2qIVtMH8WvU2/ESv01WQd3qlogJizbcE4dXQ1u58
	x8ZsvkjWv3gsnLDCDithW1IMkMXZsFBL/eIKKbzlIPRddhn4x2sA7UBw1/JVClWM0sxkCV
	YUsfVjyJOsW7L4YQizs3zZ+Z5n/o1Iw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-pbcqJA0aPwWD14A5ffSZTg-1; Sun, 21 Jan 2024 23:24:42 -0500
X-MC-Unique: pbcqJA0aPwWD14A5ffSZTg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bda48b93ffso3458641b6e.2
        for <virtualization@lists.linux.dev>; Sun, 21 Jan 2024 20:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897482; x=1706502282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqF0BZq+X2S8Q8y8RU+vztBdmt2VUpRGis7MC339kg0=;
        b=jFAtIa8ezdgETCmjLPNh5szH8TFZusxvOuXRZpbkoRkejs8KcyL1INZXElRFf7w45o
         +8yzXIEfOThaITEQ4eTXTSC43hMwbvEIhzYyiWKgsFZgah+uHHLU7c4hFPnhsuql1bnB
         n5HBAgZnPF6GKF0HI2NUhfY9zA4BOVZdCM48HNp7Ik29SBtZZYHuEAH9EtLB+my3sdp4
         1EAVV1SPzmxaSJ+KhHxR4G2kaQsUQc8j9HQqjfkRr2CK5A6S+7H+hGeJhhv9xFHM9Pm7
         O8sXKfVH71jdBq5FszdxqkWm/cX1Ij904G8XMCGPhId4j4MSCE2+vP1ldL9SHohI9ZUM
         B2UQ==
X-Gm-Message-State: AOJu0YxOTxi18M6STTbghQsVKtpBfT3a2xW24RgOO2Dnc5O937V1NbkF
	ppWCwr9hiw6BoVc+TeZOww3Gyj3eiRVs5l6/pMb+V3Q/zQwszj3o5eogLrlxlcSjYOPXKreKCJN
	I0JXeWPcKh8/SNXlJpqk+C6G35XtFnlnSwLbl/LHvI273CcuHnoCNBnDMz9XoT/1CVaVe16Gfin
	b4UYsor4I2UuCV0DQLf/n6jreu+L/9BdW4oDTCHr8=
X-Received: by 2002:a05:6808:2894:b0:3bd:a931:1ef5 with SMTP id eu20-20020a056808289400b003bda9311ef5mr3928381oib.102.1705897481922;
        Sun, 21 Jan 2024 20:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcclYxoVeJMQr66ohKfMqG/HqQhC8z6Bv7aCKxODnkszFjbS5NTwWx+X95pACBk9h1PlJs6+xsmHV/vDibbAk=
X-Received: by 2002:a05:6808:2894:b0:3bd:a931:1ef5 with SMTP id
 eu20-20020a056808289400b003bda9311ef5mr3928367oib.102.1705897481744; Sun, 21
 Jan 2024 20:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org> <1705470932.7850752-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705470932.7850752-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:24:30 +0800
Message-ID: <CACGkMEuc=F46N-3PRZrnOT17byWVqt5AZc=pc6RrHNLj-uKN+g@mail.gmail.com>
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 1:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 16 Jan 2024 07:07:05 -0800, Jakub Kicinski <kuba@kernel.org> wrot=
e:
> > On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > > For future submission it would be better if you split this series in
> > > smaller chunks: the maximum size allowed is 15 patches.
> >
> > Which does not mean you can split it up and post them all at the same
> > time, FWIW.
>
>
> I hope some ones have time to reivew the other parts.

Will review those this week.

Thanks

> In the future, I will post one after the last one is merged.
>
> Thanks.
>

