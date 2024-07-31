Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A23D96A
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449674; cv=none; b=rVuNZeQhhughXL9xZ8Nz+yABPP9HlzmvO9k/Ody7i598erZyoj5Qo8l9IeBv1Iu7Ub4zx63iUOvEZCym4JGHkQyUyTES+ZoAZpA26wgN+qH1lCwb0ahbkkrPAdFtLi6ZizZrJtgl5QPs4dEGVKII+cleust9WnhaJLbJzsuAmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449674; c=relaxed/simple;
	bh=Pp0vWyL7VeDKadleGOEHNTdhDMPNVXeakIX5tgvvsCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5cXv0CFfIuWTKgBURXbCUV6jNQ8yuMOsiysmwOiXYk7D+Oz2hPEkbJLfEXs9i4pQJL0sPgKtagVG7dwjR8Qhh4WB4PaetWPGzYcccs8Dz0WG9jrqsbamoVhNfq+E7NP7pBTvLhTuHnIQDJ2q7DISYmDt0fJISSELkt/apR35SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEEs/4Tt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEEs/4Tt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684e8220f9so695958f8f.1
        for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722449671; x=1723054471; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp0vWyL7VeDKadleGOEHNTdhDMPNVXeakIX5tgvvsCU=;
        b=iEEs/4Tt1jBK+QTcSjLGXP7RA6g6prUGadgfVY6D7HbJdJPJt5ffmBQXf3tnuVVFuf
         YRWy3+nyLo/osA0AbVKKKh67jdsR9D5bBINQKOsImbw9hmMLapxVZWnV3ePPfUb6NkYS
         E5LOZf3hTpLic+86EH1iPYSUrd0G6AvhE7D0e/Rwh8SlqpXmDxdO2qwJRZlzqq4ZfjIJ
         AUIcji5DK+epYnpRM3gQJzk7GuQsEMO70Dbg8IU6yityyMBZg/sPhJfyrQNCNRdpzODL
         ARHZKZwHr+kyQ2w/gtU49VkzYyJMt0bmJRoSQbgmS8WiqD4xTy6l25b+oME3pf2xy817
         ux1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449671; x=1723054471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp0vWyL7VeDKadleGOEHNTdhDMPNVXeakIX5tgvvsCU=;
        b=ancKGTEGlHdUHVoVjoXztmmc0GIKi6laOX8Y/XbMCxc0rGYpqDdkF+/8LWQd4cJ7o0
         P1ToGUmmteC5IPHc6wxggX/k5+qBxIMLsMl5yA59ecoLl8fUxbTtCbTdTCdRH7FsHNya
         v6EZGfGaCjuGNInE/huIZ0MlptJNLNHuwZFS36kl7fo1A8chq2lFSswr+b9TjMI6AGGz
         +E+oCv0a6MRmKrRU2mNlEHE00J8897cQjRJ8pz3B7PlvnqwKi8NGjjrN8UoduD2+BXXp
         TNq/VypyxxbqJO/Kago43MxYttXuoUgxm0z+M8XCq65HBhWQ7G8j7/h4ZMaPCuK48uPa
         Wz3w==
X-Forwarded-Encrypted: i=1; AJvYcCU+jTc/DTfZBtQu9FlX5qBy1Sg5gTBOlsBGCkqJpF+Lwch+eLA3NpHR6KjaupFou4bD7F0IKoOFCz5FhCm2I1bRIje633HFmhudCJcXGiw=
X-Gm-Message-State: AOJu0YzKPwu7i2HD2jBcRfezeWcBWAM1v97JmHmOQw/DC2E7eV5jh33h
	PxVaur1/ksn+Idiy5YVmbSqDVCrW4sBBi7+63priypVBN3LwLw0mif7AmRuglNbH5/j9uqHGdWE
	RZGQKkjPR25RQXlQgQf7Ps1ptTGE=
X-Google-Smtp-Source: AGHT+IGv2ta3BQ/aeYaFuo6uJnDIs2Oh1PDBCcZrH55JaT3W4vssxSHelAFkF3XSYf9nggWCe12LvyT/WHK2KvkPs3c=
X-Received: by 2002:a05:6000:4582:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-36b8c8fdbdbmr4052808f8f.21.1722449671103; Wed, 31 Jul 2024
 11:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com> <20240731124505.2903877-5-linyunsheng@huawei.com>
In-Reply-To: <20240731124505.2903877-5-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 31 Jul 2024 11:13:54 -0700
Message-ID: <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
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
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, intel-wired-lan@lists.osuosl.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
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

I am naking this patch. It is a pointless rename that is just going to
obfuscate the git history for these callers.

As I believe I said before I would prefer to see this work more like
the handling of __get_free_pages and __free_pages in terms of the use
of pages versus pointers and/or longs. Pushing this API aside because
you want to reuse the name for something different isn't a valid
reason to rename an existing API and will just lead to confusion.
