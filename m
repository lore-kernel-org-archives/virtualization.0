Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F803451D9
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110368; cv=none; b=NlXmSHuU/K1aSLE5ttGUob31CguFDor90DBFCm5fj3wkmgsJPRbTuOdR35mNjmg6DfGTR5Q2nCgD2VSTsgF0ULmDa5k6uwcTw+2DZCFz+guYwsxkn32ZReZUqNgjKMd746PmKKlep/dT9XMnzi4DVCGziBk7MmOycyk/2WXwhAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110368; c=relaxed/simple;
	bh=KmTueWUjZn0G2ApEVq9bE5AxQTl6EyL16mGxBo3CtWQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Mh+1yeHsXpuzMgldo5j0Fy147aZq6B9PhCJiJTe3tTS30FOLxKjG3iHaX5DME+SHzBcITUp13CdZlM+ST5GUuzUtI7XYRI3GI35FiJVVxPOKmTTwDx4B3pZ1PuqTPrjXpWOkA/tTdWBd6/bJqHUWxCTxyYbXmyiI/lXHGtfivGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnzgbzDu; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnzgbzDu"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6495d592b58so14621d50.2
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110349; x=1769715149; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmTueWUjZn0G2ApEVq9bE5AxQTl6EyL16mGxBo3CtWQ=;
        b=DnzgbzDuxezhXIr8vLqTi5u3k8LClrvStrv3wHdZZHjIg0Ul7GmsQsLYf+zpc9tWmC
         bRXdjgtTVcLx2QYR+v5SiolrnbgjoMmGU+vjHgXbCitCbeJdTdPTiVmPZkooPUaEr/85
         QhvCat6KKEHQR0S8DoXnHNis2e9EWaTatoPQ2zQTLCMP3RRWDeSWUjYUDIhhLc7uEiVn
         ls+BPifB0a5MutKxYOTuvSHSRJIACN0IuG6qsRI9P3kcrc7x+PeTibO0zps4gFLLi2Bk
         vV/VBB7AKdHU+04NnUnsWG0i4aRRFVf6Cqr18uDxyNWOcH1iu2qlpg8rt2rieSY2K0jM
         Z0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110349; x=1769715149;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmTueWUjZn0G2ApEVq9bE5AxQTl6EyL16mGxBo3CtWQ=;
        b=Mp1OsU6xscxX0iYElYLF/UZWxVHbLxiQJMemgZzzqvUgEDTziN3r0SawsiA1E6rEI4
         0KfbsLXSYkn2guR0SY2jvD/9u8nJJyeaYwBWC55/Mi0YjOb9Qf8jnKgQhwRIdP9N1ayn
         fw9Tix/gvTiUGWuUttH9e9B1Y0JtAYJUSKx3Cidsj+Bi1igS9nuKZG7ijAY/ejHDBKeS
         KUOdUyD55geBczGZJyMDeFXugjZ/9L94PVt/ttvLtyPv4T4I9H1086yEpPi6ihFNW46g
         EWJ3ALhILD5z/XtkmX+Jw5k1WxuD7p0vP7fdqaNNNwJ08EAubmQSN5GUHfynNTFSUe3w
         Zegw==
X-Forwarded-Encrypted: i=1; AJvYcCWUrGEMfWR8t0QakFd7enMFzVjTFCP3hMShfp209738HacMr+x/sQ7HhevouIn2TzHu1Gbmir9AkZ6qmh443w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYgMtTiFUFMjROlzkmNsRnbUdhxnyMvTgjOlzP0aMv80EPH0aH
	rQHGIH6/BdYZL0l3yu2ivbaWCuL0wltoT31vDasWRl1Ph+KGW8exc4Fk
X-Gm-Gg: AZuq6aLSiVDxE96weMM/unKWrBC5Q1wYpvh4psCjLScjTtXGsDy45//dhfhZvKFZwTp
	6yjS4qZ5l+02D41rdpMN5hgGGgKnA/dxm9iDLQftfYIKxjYpeikSzYCwoq1CTfiLuWVG+DsrTqB
	6fNGu7LlDmM/9MZyjELZdQdSIJ71SJwS+RGMwy3ZyJACYdQ6EXBsUq0hpdJypI3O6dtz7nN3xKl
	5tr5lxicCH+YPibtrqlCgJLi6UDVNowhrjU2qG47OC7k9UWbcL5VFSWYrxTC1NvwOlGaaUp9oAA
	T+Lh14pUQSSIJrOKl+O7LC+7kj1mt9y/9LOoQ0I12WNuOpHaTuXJGZMN97Q1U9TmfENM5f1A7b9
	J8KO8/Z2kdveN4X6L2AztBnX3c+m7PFS9t+cdI12UK52YmO4PLGiT/x3nIFdtbpCE4beRpU14ll
	IMsJiVGDu7/BY6aZ398948A4Vhfl5pzdRTd5y/VI+twdvbyIHwsI8yQI8cxFk=
X-Received: by 2002:a05:690c:610f:b0:78f:f32c:39e with SMTP id 00721157ae682-79439a42de0mr6172907b3.67.1769110349495;
        Thu, 22 Jan 2026 11:32:29 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943af149bfsm571447b3.5.2026.01.22.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:32:28 -0800 (PST)
Date: Thu, 22 Jan 2026 14:32:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 ndabilpuram@marvell.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.113a625cf37a9@gmail.com>
In-Reply-To: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
References: <20260122091527.339180-1-schalla@marvell.com>
 <20260122075206.504ec591@kernel.org>
 <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >
> > On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align w=
ith
> > > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.=

> >
> > I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> > Most modern drivers can't use netdev_rss_key_fill() either because
> > core generates a tiny key. And the devices support hashing over two
> > layers of IPv6 for tunnels.
> =

> Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all know=
n NIC.

What is the purpose of extending?

The current length is sufficient for standard Toeplitz 4-tuple hashing.=
