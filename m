Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD832B99D
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792034; cv=none; b=A1KsGK03lx4sMY6aAzsJOy7vU7PtUJC5o0dJssNo88yI4yYTQm7f4PPHpRNPmTOsnnHz5H39VKXKg/t1tKTE5hSrKmpTREi/bKpyWwrJu0s7Eq6GdeJx7Sys+ng53bEYXKSmp77iVS9MHzhfycWT70EBjWK52mSVZK8FyutVdsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792034; c=relaxed/simple;
	bh=dM/PC+xgLDFQa74JGMOEWbPEyQbhx65hYn2Ifshodvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdSSQbZ8157PndF3asKPFNlGIFInP+Ut9EATQKu2YHQKcCOkMRwrjQ6dflUqucLA24qtYEWueO7kj0DMY0Fe2+FAjeZv8BIhH4EHVGt1y2Y/n/Uw5odDKdxHwESET/48Ljrnc0kIX2DQ+FP6vFKjNN77wdbpHqjkccgbX4x/NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VcNzs3SB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcNzs3SB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0s8hKYa9ITmFWQHj91VS7CotRvqtXLR4K9Qz/fibwBY=;
	b=VcNzs3SBWVhJHbK+4wc2yLqcqOtYELv2gaJiCkDl1tSK750JTBOkEoUUOOqNJkMw4PktSn
	IKmySNpU5H2/XdSr8zlgtCRwZiAxnZ7IKw8oWq1G4Dx1nktDvw3geVoX6Wo7l0ddFp7Slv
	8seCFrpXJirjT9+YdNoARrcDiff9DJY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-kulxTXZ3NYeiZpG9vePTpw-1; Wed, 29 Oct 2025 22:40:28 -0400
X-MC-Unique: kulxTXZ3NYeiZpG9vePTpw-1
X-Mimecast-MFC-AGG-ID: kulxTXZ3NYeiZpG9vePTpw_1761792028
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so529247a91.2
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 19:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792027; x=1762396827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s8hKYa9ITmFWQHj91VS7CotRvqtXLR4K9Qz/fibwBY=;
        b=QvhUgLJ79fQqsSxz4YfZu2eU8+wQYF0M0ARKSQbsnpNNb6SLnbiKbdSzM5YoFp2wGW
         HGzQKNlJlsv2fDVJBZIR/LYCArgSjzGeG0uyJbwTSvQMnMgn7XAL2w856tjVBQlkhG1m
         mvEu92TgrqJHPuU6/H0Gsystgv0CVQd47NLOQvKyaMQPDKMy7UwG8+pnFOdXI/W/PHqh
         rxZ4aBR6sMq+b9OyzmnLS0/Prh/6HRAcEgywaBMuUrcueCdL2uNuOy8FbYcFi6Jrkk+J
         Re5MklNfZPwKGKdipnTQmfrkMRcQIzkjUH8Gmu90Ztix6DQRbC3aZZX2TLph8L8mMhaV
         clEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOeBnVWgfACm8DoeT1Qar4zjJ8hxfkMYJKnMN/tdqQkFb4KDEAGeeA7HadXkzEm+SHTuFdIhcGTnx55OwVnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKiWXW0OeOG1GjzOaqeJPIK8xilo0HLin7FcoFbULWRN6TzFq2
	PjxCTu8fQVgVzSy4glu7eesnRxKHN1JnDvvA9i9dA3OOORP8ghB0GyL5U1GdrU4CoRTS+uW49wP
	vAy6jq+A9EEz6vKXru5xjSWCxJJJk+W92e2kNE3UHfDpDa3DDQTU4R8TxXkGT/f7zG9eZA+fYIN
	UawJld/F6yiI5V1/OaqdKk4Ak1jNMugD4RO5L9KYAtZPc=
X-Gm-Gg: ASbGncviyo8sJjF8eyDPHwnhOgfFfhrUqzkWrgtZ8ThICPGsNvTGRck2PRuF0SPwior
	Rb9i+OH+8766VucDf1hut9Ftu/GRrZiLjwjWQGesxohMOteQ91bSs7gp8NxijO5vmnKYA0hRhsk
	VD3H/DedoTwKsERZYPpfDDLB/btEIgcczLQzM9MhaiqMBh7h0QK7pZ6kmZ
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id 98e67ed59e1d1-3403a2a22a8mr5144786a91.22.1761792027564;
        Wed, 29 Oct 2025 19:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdZBU+hUTBze+ZZkKwu5UhZkdiKIT5O7KOjW1YBOrYbWd5C2ghkE1vXaxfsDpwDAAagjZ/xZ641rpd3lEA94=
X-Received: by 2002:a17:90b:38cb:b0:32d:e07f:3236 with SMTP id
 98e67ed59e1d1-3403a2a22a8mr5144766a91.22.1761792027079; Wed, 29 Oct 2025
 19:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029012434.75576-1-jasowang@redhat.com> <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
In-Reply-To: <d0f1f8f5-8edf-4409-a3ee-376828f85618@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:40:13 +0800
X-Gm-Features: AWmQ_bkmfB-ebhx_3KwfLp1OlCEHIG3UAVOBmcyIQzJgycGoPag4AUi2K5pwkoM
Message-ID: <CACGkMEsTd6uCOCre8HK=5G14zu+xVOPOORZ2xcV_n9Kg6w8F5Q@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: fix alignment for virtio_net_hdr_v1_hash
To: Paolo Abeni <pabeni@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZrDU87bliTfOmO6ukyjCmphUjQcdYJWtuhfbN20r1uM_1761792028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/29/25 2:24 AM, Jason Wang wrote:
> > From: "Michael S. Tsirkin" <mst@redhat.com>
> >
> > Changing alignment of header would mean it's no longer safe to cast a
> > 2 byte aligned pointer between formats. Use two 16 bit fields to make
> > it 2 byte aligned as previously.
> >
> > This fixes the performance regression since
> > commit ("virtio_net: enable gso over UDP tunnel support.") as it uses
> > virtio_net_hdr_v1_hash_tunnel which embeds
> > virtio_net_hdr_v1_hash. Pktgen in guest + XDP_DROP on TAP + vhost_net
> > shows the TX PPS is recovered from 2.4Mpps to 4.45Mpps.
> >
> > Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Whoops, I replied to the older thread before reading this one.
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

I apologize, build will be broken since

commit b2284768c6b32aa224ca7d0ef0741beb434f03aa
Author: Jason Wang <jasowang@redhat.com>
Date:   Wed Oct 22 11:44:21 2025 +0800

    virtio-net: zero unused hash fields

I will prepare a new version.

Btw, it looks like there's an uAPI change that may break builds of the
userspace:

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_ne=
t.h
index 8bf27ab8bcb4..1db45b01532b 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -193,7 +193,8 @@ struct virtio_net_hdr_v1 {

 struct virtio_net_hdr_v1_hash {
        struct virtio_net_hdr_v1 hdr;
-       __le32 hash_value;
+       __le16 hash_value_lo;
+       __le16 hash_value_hi;

We can have a kernel only version for this but it probably means we
need a kernel only version for all the future extension of vnet
header?

Thanks

>

