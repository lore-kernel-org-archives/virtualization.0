Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817F140E30
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737483; cv=none; b=gUawyql+1KVN+C3cB0TKlN2UvnHNOcCxt/oPIfo9/HbcPASmLQN7sS5y81hfc7P0MPr8lNPGC6/+KFtYEvzculO9LevMu1xzEsMq4kBmQlepC11aSb9pcCJcvpqFrEGKS0seRyYY+fVDy8rV3LqL5bkA/PPkw26AsLXFs18Ag+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737483; c=relaxed/simple;
	bh=yRJfycwjDy0VxrwiaDvig/uV5jBkPvBFTkhNp60TiSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmcgqRwh62kTxr7wA67Y47kCyK0DglU844HuC7kRyVgGLNPjEAGgIf2iiqdWXA0kihkIGcn0ikwO6mMzZrIfuC9WS+I76/5z06MesFwkLF9Hb4kei9cZ39lnSwiWaVnEqw0sqMpYi5jCZ8pgqAKisD5Cuj46f1XI3XUvJ1+ziXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHOC1D+u; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHOC1D+u"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79DA44070D
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 03:04:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKxOSj68h4oq for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jan 2025 03:04:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89DE540707
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89DE540707
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GHOC1D+u
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89DE540707
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 03:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736737479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRJfycwjDy0VxrwiaDvig/uV5jBkPvBFTkhNp60TiSo=;
	b=GHOC1D+u0IEHBbjOq92TXQqGxMe00MvmHf7gUbOvQqn6RVONkZff67oCQO5X+IhPmIKWM/
	w55F2WGxcgQQ/Ww8RD/g8H8H6WAEH1iO7i9vZIszaiMNE1Sx6hBtUt2TvrS9s+yPythIRD
	lbokg5g4uRieL58xE/Cb+NWpjI0j8IA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602--7NAdGeLNSSw62RY4geGOw-1; Sun, 12 Jan 2025 22:04:37 -0500
X-MC-Unique: -7NAdGeLNSSw62RY4geGOw-1
X-Mimecast-MFC-AGG-ID: -7NAdGeLNSSw62RY4geGOw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee8ced572eso6922200a91.0
        for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 19:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736737476; x=1737342276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRJfycwjDy0VxrwiaDvig/uV5jBkPvBFTkhNp60TiSo=;
        b=P7TMRxvYu4KdmvaxkWOSf8spuaS5+ohvC+sFWGefZEBy/clLJDl/IWxhhC9NqFqv2K
         J6kREgbV16x9GuJPxFiwvfG5VvCzKdbNqbxcX0BvI8GBpaHl9STVrME4G9SFqaEJ4NK0
         q+yLHrMXofuq09JzlwgiMlwXGnpE5OF2l5wrKk8o4kwsX20563yyigxzA+Fta12fy+pv
         8MrCqa+bJhx2X5fOP0UPopnuE3bulgT8pxlQ20uL2YVVLzFtGQlVSPKnQ6y5lnU+ouAu
         +S7Hj2aW+99c9rLYXMHFpE/RGu0tT29twHKy+AJT8khe7Yn/tOKeL+aYbP+ZAquz/bb9
         t47A==
X-Forwarded-Encrypted: i=1; AJvYcCWYTkVKK767hLiJT8tD6FclqgFT335YdJ/UDmLhYe5GDjOcCf7y2ut5A1WljfbiEqxHvNK6SCs82KfvhUDcwA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxPhV+SdqJ4i/t5pXeBp2nEMEMc/aWJpVxUobVBjdRN7PGPWoiF
	RT7WiuZiIZhJ7WOSKP0GzUs32iPb47ALB3h0OG5EkpOnRmIvziQZ2YocjFuz3uZe0AYlu5TeSdW
	6WY/JiaT+wMTrGcAb+BfRVOrivZdmaHacXmvSbPETrp1JBvEtw1go5f2DPxpo0cnwcYvHqReYeW
	ubS70qD96HjCNJgL+DGYHbbgamtYa61vHETp3sQdWHl4s4kAA5Ma8zNQ==
X-Gm-Gg: ASbGncuKKRoHgVzdNV9E92ZxXfcXz2K2dfj+FEuGksIWuKjmdkPkE8PyvGynrfLbUfU
	EqEnqTHr7Yb/8KLbcOER6k3H3cIJ5qFsHRmJ3NKE=
X-Received: by 2002:a17:90b:5145:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2f548eac588mr28389798a91.10.1736737476513;
        Sun, 12 Jan 2025 19:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3vQ4vRdPBx0guyoTg5ZpyZUQ/sA/eheHAAs75pTrkZhjd2AbRMvv82RBzJBTsua8lQjGaRuJEc2TbijFE4yM=
X-Received: by 2002:a17:90b:5145:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f548eac588mr28389757a91.10.1736737476052; Sun, 12 Jan 2025
 19:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org> <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
In-Reply-To: <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 11:04:24 +0800
X-Gm-Features: AbW1kvZHQU9iIwkWwKeABYuwHLZExY2G4KWx_BvVBrd2ec7v_BAcbnTLlgvVmZE
Message-ID: <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iXCz4_ZWSyq_MDe-_feHcdFVtx4Jbf4SAZdG39wz6Fw_1736737476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 7:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
> > On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
> >> On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>>
> >>> The specification says the device MUST set num_buffers to 1 if
> >>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> >>
> >> Have we agreed on how to fix the spec or not?
> >>
> >> As I replied in the spec patch, if we just remove this "MUST", it
> >> looks like we are all fine?
> >>
> >> Thanks
> >
> > We should replace MUST with SHOULD but it is not all fine,
> > ignoring SHOULD is a quality of implementation issue.
> >

So is this something that the driver should notice?

>
> Should we really replace it? It would mean that a driver conformant with
> the current specification may not be compatible with a device conformant
> with the future specification.

I don't get this. We are talking about devices and we want to relax so
it should compatibile.

>
> We are going to fix all implementations known to buggy (QEMU and Linux)
> anyway so I think it's just fine to leave that part of specification as i=
s.

I don't think we can fix it all.

Thanks

>

