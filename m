Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623121A00F2
	for <virtualization@lists.linux.dev>; Mon, 30 Dec 2024 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735545119; cv=none; b=VbkAZof28MzJmTXZRaYB4Hada4cZdBU2vR8lcOB1frLDM6gZxFR9QQJYj+a4+lOFlTFVrLi6tT/iFQvquFdTOU5r5k14m3GeBDiZYMmHuO+edOENPhoDbbG1gNXIbjQykKKtsvScPR+fCecdB8fYn3b/pN5CCs1xWT1Bf8pLYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735545119; c=relaxed/simple;
	bh=Ty0odp3SjgUTqexMbjUfQ7REoC5DutDQisZcBKmlUUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzSthtZBfN/K1toCRw29hSJmoQvSdk7WV9GpzCF6ZnZ8U5hQU4FYCQLCvrWv8Dp25wa77KEHIPW2qduI78XRjlagUDanJjTU3j+n7FkiwYo9GhKbMI8TB8gl0A1dpkqAMfgK751vG2/cZMlIDXPISVVveMGlie+jhei4AI/k7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbNF4J7D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbNF4J7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735545117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0J0AYhxmNDrE+hV/0WPbQ41cTnDC3xZnCg8iwgLqFn4=;
	b=ZbNF4J7DCE3zB2poNETAhaYgeH8btqJtfQVr5vsDUzC3E7KM6fEdcxARmTUzNaphduCUbu
	7wgTH9FckuhD+dZBdJTNLZRzSjw6kA5e9rQxfbQUqgbL8BcW8VJE3wqXw6JOOnpyr01b6k
	4YV3/fPpaVe0TWv6KZtkVLhTarJaaKE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-ZSfsdwF5ObeOaCUc0GJJvQ-1; Mon, 30 Dec 2024 02:51:53 -0500
X-MC-Unique: ZSfsdwF5ObeOaCUc0GJJvQ-1
X-Mimecast-MFC-AGG-ID: ZSfsdwF5ObeOaCUc0GJJvQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so12379419a91.0
        for <virtualization@lists.linux.dev>; Sun, 29 Dec 2024 23:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735545113; x=1736149913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J0AYhxmNDrE+hV/0WPbQ41cTnDC3xZnCg8iwgLqFn4=;
        b=SW5PcYvS3sOHcYepfBdcv2bt+fV8mlbFPIyJKZRnNfdX6k7dDvDJpqtuRRmn/KH0Ee
         4WteUyoPChGej+S25rEWhaYu8Bzxs2dE7q7xQJAdDI7Lg9V/xZvZeuZGhOqxM2XYmNrr
         tK68ynHWTzEndkC1U5mOL6DXcfZxx1PG/Isn3i3733Nw55TZPd4Es+E8vyJtYZkRyXOn
         LLggPLHsk3xmuCOWGvSVw6wP4GgiXMs7wOJQJqtTScm4RmRGUykS+pFjITJGW3duZJcw
         VCKIm1fRtxdkgdko+ei5x1FDXq6F3XqseEJppMQJLKKs8gSKg+ee2trxlolHW3bLwb2/
         o+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqu7dxlT75B+rDsyUfQrzGba9qjvQ1sGDoxlkwo0x0+8ceqb/Jt3NXT+CJIiBqwhE88IViXdPGtoGKdAWtWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeVvC7fF6H2ACqXyoDdnP8Q6JOaw4f4cglCDRYAqBCsGoBM48K
	c3KNjQL5xDdF6JneFCxUBhWw+HMSUt23ItsFHIjx+wP6iJXdNR6zanRfw5OKJuysD3k4KgErwX0
	a0f5G1JoGc2B72LMSf/D+G15XcSSEOaAGKvdfBZ1mWYdUxPcalerjo8UAXUtOfFnU510LzovCEz
	zOUJ6wVStXrOqEiaMRcvJFYSL8L3CnoaeX9tAnpw8=
X-Gm-Gg: ASbGnct5QY2Y0MPkvboPEkVMX0DzYNYHhmldcy69lpx3nFIaxCziglZs+1bsCdYKFTx
	9m75aWlPvg4FR7mNqjHPERnAPFNMIKpSUIqpx
X-Received: by 2002:a05:6a00:4391:b0:728:927b:7de2 with SMTP id d2e1a72fcca58-72abdd7cbaemr60529622b3a.8.1735545112959;
        Sun, 29 Dec 2024 23:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrRn8WcYwv283lLqZw/U9xGQjtM/ypQuHSDfUoQ2eSZRdU4bKS9WRvBDuEhHDV4a2t6IovfqPmrMjsRDPQDxs=
X-Received: by 2002:a05:6a00:4391:b0:728:927b:7de2 with SMTP id
 d2e1a72fcca58-72abdd7cbaemr60529579b3a.8.1735545112567; Sun, 29 Dec 2024
 23:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241227191211.12485-1-chia-yu.chang@nokia-bell-labs.com> <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241227191211.12485-12-chia-yu.chang@nokia-bell-labs.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 30 Dec 2024 15:51:41 +0800
Message-ID: <CACGkMEu990O+2Sedj+ASv0P5TnZR9THiOdHmx=L0hOxQRXPcsg@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 11/14] virtio_net: Accurate ECN flag in virtio_net_hdr
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	edumazet@google.com, dsahern@kernel.org, pabeni@redhat.com, 
	joel.granados@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, 
	horms@kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6w09WrhUabQC_yzkG4wnknwzaAXIR3Q1qJgGuLYx0OU_1735545113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 3:13=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE
> field to count new packets with CE mark; however, it will be corrupted
> by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by
> seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
> changed within a super-skb.
>
> To apply the aforementieond new AccECN GSO for virtio, new featue bits
> for host and guest are added for feature negotiation between driver and
> device. And the translation of Accurate ECN GSO flag between
> virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to
> avoid CWR flag corruption due to RFC3168 ECN TSO.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  drivers/net/virtio_net.c        | 14 +++++++++++---
>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
>  include/linux/virtio_net.h      | 16 ++++++++++------
>  include/uapi/linux/virtio_net.h |  5 +++++
>  4 files changed, 32 insertions(+), 9 deletions(-)

Is there a link to the spec patch? It needs to be accepted first.

Thanks

