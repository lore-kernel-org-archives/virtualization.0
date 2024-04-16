Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE773130E40
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283937; cv=none; b=DUlK9zb0IEx1T4jCaKP0hdYyZd+qI/DSAmqOP2KSA1VcafhdASZgEoGoUgDGOOC9BDQ3DMsDOPikEMfMgfeOp5BpDXPEe+dyq4u3MWxKsk5SoDA1/PcBzBPa6GeqmuiFqU4AN6rnhWfX5uZwG9anUU3AC/PKMKLeQtJzALAKc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283937; c=relaxed/simple;
	bh=EKrDgIJgNXo/R8quzpUy0yW7erzp8PxvHvcTe/50ujU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TA5HpanLI76mHkuRBQ4ewabp/Jldey6ccmJ/IwBLeA91DizUJEjWQENCEoCPGnGZbJ9torl0UKp7zn7uOtSK5/9IRbrapxbwvY3aZYHNsz4/+lKRRYvFXsYFxu4BZGhCcbqZPR9aniB6Z5QPSA7BB14hgB0cho8zuoxuXSxgEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjG/IWAF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjG/IWAF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e5715a9ebdso36956285ad.2
        for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283935; x=1713888735; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EKrDgIJgNXo/R8quzpUy0yW7erzp8PxvHvcTe/50ujU=;
        b=WjG/IWAFw4apeiKBBCpDCoSxZIXfFdZyTJCt0nXL7HdKNejLvMJLDIFkyrCN/OV3Ej
         sTCmZJyOu1IaME6D+VjXuGWrmjrd4FHiYdh4YaG630odFECdkGMK7mDHrUy+fKZrclkt
         mh5oqPi8nGxUcLJmpcnrs+kSSJ2D5R4nc0Mp0RL96yN1hZgZjWQ+2eY0tuyV/CF6DG+H
         6lLuFz4JUbINJBjncYZwb/QtfPtLqVqjRxllVO+sM2ILXODgRjXIp/CZ9GlLIeftfLTk
         cj0OJXJFbnwfFWKi3gvCAM5F8gaww03doTb2L6TqC1oD1zTa8SD2q6tXLPIYVwse6M7N
         nc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283935; x=1713888735;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKrDgIJgNXo/R8quzpUy0yW7erzp8PxvHvcTe/50ujU=;
        b=tIYlme+rAfOWaFZw96FshIewdxoeRFajydlobUy4FX/x8IpBhxQN7RgjJRcBcB9Pf7
         oUgHgP7m5b1s3Cikbjra2sFYSAe29LgwZaedED/HnhEkKOSuX5Npbhpa0f8LfwNdsRap
         SoiOk0ZHPTJcla/fAqQBlfFrASsafHnj/TYQhyLdg9rBhNlY9saKaziyvdqaQSrFqRHq
         zvXpSsdNjytI2TvlGwY6pNzM/b/Y8cNubr0YKuVxUpHilKPpMlZ8Ipe7dSao843bBmZ8
         mQIVrd97ZSS4rvEIW8D2anSwOPftqTLjy38NW/t2StDOqxVJzWIXjJ5bfFi5nYyqkhld
         kntA==
X-Forwarded-Encrypted: i=1; AJvYcCWF/IiEUsXUrLezVgvuvrStU/Db98+mpCzPzM2n6GT7k8mEj5TrRQ708X+rDn92GcHeSSDUMxpImjk00cwejhlBrp7XN5jnDYwdKRWn0GE=
X-Gm-Message-State: AOJu0YyaOKsQ4xyiZoiULeKuykRTQRtXLF2CbMCdc+N+JcRgowfDnWpy
	eMPYEJnatOpmSyge1gYnN2HUTti2PXdP206JPRDfDbTg7K4RIv0/
X-Google-Smtp-Source: AGHT+IEaBhKQrtE4y17EN+JRfoZ0nAtlgq9TOIgtvD46kDZyqFoPetYC3y2iMwccARAF9quBrezxcQ==
X-Received: by 2002:a17:903:595:b0:1e3:e4ff:7054 with SMTP id jv21-20020a170903059500b001e3e4ff7054mr10328895plb.38.1713283934861;
        Tue, 16 Apr 2024 09:12:14 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id lf16-20020a170902fb5000b001e5119c1923sm10005822plb.71.2024.04.16.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:12:14 -0700 (PDT)
Message-ID: <18ca19fa64267b84bee10473a81cbc63f53104a0.camel@gmail.com>
Subject: Re: [PATCH net-next v2 07/15] mm: page_frag: add '_va' suffix to
 page_frag API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,  Chaitanya Kulkarni
 <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
 <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
 bpf@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org
Date: Tue, 16 Apr 2024 09:12:01 -0700
In-Reply-To: <20240415131941.51153-8-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-8-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
> Currently most of the API for page_frag API is returning
> 'virtual address' as output or expecting 'virtual address'
> as input, in order to differentiate the API handling between
> 'virtual address' and 'struct page', add '_va' suffix to the
> corresponding API mirroring the page_pool_alloc_va() API of
> the page_pool.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

This patch is a total waste of time. By that logic we should be
renaming __get_free_pages since it essentially does the same thing.

This just seems like more code changes for the sake of adding code
changes rather than fixing anything. In my opinion it should be dropped
from the set.

