Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D633E7
	for <virtualization@lists.linux.dev>; Sun, 21 Jul 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721594556; cv=none; b=YgjvJfYpfb94kA1OOcIISKXC/VxraCDd7T+uSIwLewyRkV/cykltGX1nJxCLARHQrq2Ahdw9wM5cZ3/AlqkgN9mb4cZpWleBmHQ+zfO+j5m67W4RkI+bG+fiPChqjM4z0xxIzKnWIETXAi6BAl0Yt2Oy09izKowTwkybQ07VghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721594556; c=relaxed/simple;
	bh=Y2Prf/IbMk4LMsyq34wH1row2ki7pR91wfPtg73kQoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NINQFvWD2/GSpWV5+uV8EZa9H6z5n6gYwhzy5L2q8PQHSlMgNboB73DZq35j7eWhrNRekHfcCRaxhtWT4JVZzjFcmI0AVvZuG87qizweXKi5X6qQxcS2k47CisUSiKr5sBRry8TNU50z+LQOqAQ5ot0QlbkCEdFZitDCh9t8zNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2EjXj38; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2EjXj38"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3686b554cfcso1568601f8f.1
        for <virtualization@lists.linux.dev>; Sun, 21 Jul 2024 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721594553; x=1722199353; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2Prf/IbMk4LMsyq34wH1row2ki7pR91wfPtg73kQoQ=;
        b=J2EjXj38Y0qR27zDsoEaO7udpZVGKkLC0PR6EWACaN1wb2idQpE1XtVa3dyAgUgYwo
         JcT0mB8s1DwrGrSTxLntvgTtZwrBameueTIhS3VHc1hAIiVg7Th9JBZbUfwwfYVNWX5D
         oGXDP+K1Pg81z1Ip72uFOaOlsAaqqbhtn/UPy2dcAEDwGxE02EdUfegHKkzzjxnctAB0
         Y7vFdWl+7WIOrEhkQUmvAsE7n4jg4/G1xJ8eq/IWRGIn+XEaWY4whyDuwPxJLAy/iidP
         W5TqwEUiTuWDKh1x4ojurXRhygmOKQZ651oCmf+XF0CRHwW+b9uRJ5VDVRkW06gODsZc
         uRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721594553; x=1722199353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2Prf/IbMk4LMsyq34wH1row2ki7pR91wfPtg73kQoQ=;
        b=P6ggYNvo9a4TF+U+pt434kAKDxJg714GjsIkESobWhUKinf59xmMifXNBKxFzjwrDR
         V41nmPBbB5NPQVdzED4gZnHDu1wRXJwWjIniSS3AbXab1wuR4Kwbc7FZvZ3UmpsbVqbX
         pFPuLlXcdueTzzA/Bee1sP1ZAtZLdpbk6K/9AJ/uWJHon9B+xAR1q4XWP9fbJmWQz016
         mf9RXaJAWeWd1jqrArDmvrCjIJhjmZHBoJhJ4VIpbaGzp0G5G/0maxvcBXM5IAWHS+Fv
         2rDnn4q7WYQIFiOArIbYmQE/3atqcbxMgezXZVv55ji/tb3bFlsAx/8zmJzBjko3Yr6A
         Yr7g==
X-Forwarded-Encrypted: i=1; AJvYcCXb00DBXbgzhoMahcQFjnuta1tg+O6+NCDKehOUY5tf72mCWEbN+8OIL/7HTw/n64b8WdfXXE2TihGfsgi/2vraVJ3sxyVR133rhRnB93A=
X-Gm-Message-State: AOJu0Yyd5dwImVwP6mtr1O3j2D1b6KvGmzAcdyLSUSyxsNGaDHb1l6zO
	V/KAxNWJOMZ4NAH7t0eu0bTsTNMPwYcD5/g+wMtOnf2Az/fc+b0IxVBw2suYWaN5RWlaAftb+tq
	DN2KodUDGcTOaZ+i/jeROKUOsVPM=
X-Google-Smtp-Source: AGHT+IHzyJqN1Q0WaIfDKyj2SqhKg2oxhBaiBXCVTaoG5f0KmwGrOsY8JwrfF4zCan/VnZBfTxjvlG6f3HfT9iOc4L4=
X-Received: by 2002:a5d:59a4:0:b0:366:e838:f5d4 with SMTP id
 ffacd0b85a97d-369bbbb4b95mr3333434f8f.3.1721594552579; Sun, 21 Jul 2024
 13:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com> <20240719093338.55117-5-linyunsheng@huawei.com>
In-Reply-To: <20240719093338.55117-5-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 Jul 2024 13:41:55 -0700
Message-ID: <CAKgT0UcqELiXntRA_uD8eJGjt-OCLO64ax=YFXrCHNnaj9kD8g@mail.gmail.com>
Subject: Re: [RFC v11 04/14] mm: page_frag: add '_va' suffix to page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 2:37=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Currently the page_frag API is returning 'virtual address'
> or 'va' when allocing and expecting 'virtual address' or
> 'va' as input when freeing.
>
> As we are about to support new use cases that the caller
> need to deal with 'struct page' or need to deal with both
> 'va' and 'struct page'. In order to differentiate the API
> handling between 'va' and 'struct page', add '_va' suffix
> to the corresponding API mirroring the page_pool_alloc_va()
> API of the page_pool. So that callers expecting to deal with
> va, page or both va and page may call page_frag_alloc_va*,
> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Rather than renaming the existing API I would rather see this follow
the same approach as we use with the other memory subsystem functions.
A specific example being that with free_page it is essentially passed
a virtual address, while the double underscore version is passed a
page. I would be more okay with us renaming the double underscore
version of any functions we might have to address that rather than
renaming all the functions with "va".

In general I would say this patch is adding no value as what it is
doing is essentially pushing the primary users of this API to change
to support use cases that won't impact most of them. It is just
creating a ton of noise in terms of changes with no added value so we
can reuse the function names.
