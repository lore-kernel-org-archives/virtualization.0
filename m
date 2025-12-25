Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502D31B126
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766680074; cv=none; b=oRNZvr8Xe3ruxIrFjXo2cHMa+URVGG8H3Wgb+r2gbUomfqYtHde4buPB0QtjKqYSbQMb2dJ0OzC+l6VTzvvH4HlEswXK4OrdbTSJoE+54flRrtta2LOfDFninVzLhq5CeWtlJfcl/C3vpnlL2ITKatGKORfCIpX3Qhoy1LTF2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766680074; c=relaxed/simple;
	bh=pktztNj0673p74dCRRu3x40mLqPXkmk8e3Tl7TzacCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KrurIJmkt76ZERWr+qK94eU60QPis5I+U4AnoyUrJCBHlpo4RZ8b9XqVIdQN+S5fPQmJi2A+hYGVLmtRcYO9c8yKvQpytzOVqgeXNxUbrtvuxultWKSofZ04pMZcJfpS1cng66PhSFFWgyBHcuCygKqpK4J/f+IX/4VjR+VjBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjhbVFoN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjhbVFoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766680072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
	b=IjhbVFoNVigr3EXVQMJQ+KN7HdcVU1N87pGi4Fkf+t9iT8ihpLVQBzOQuLzQqgSEFGwQDg
	XzODrD1synArRW/sdOMnBsbXeCj8aAVs18NzFae5qmX8zPgQvq4ePjuCEolIpPgFGfstAE
	ete/BAnrtOl4y0S6s0dDAwC51/h+Ti8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-cVWM6a5FNWCXtAHoCvfw5A-1; Thu, 25 Dec 2025 11:27:49 -0500
X-MC-Unique: cVWM6a5FNWCXtAHoCvfw5A-1
X-Mimecast-MFC-AGG-ID: cVWM6a5FNWCXtAHoCvfw5A_1766680068
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so3308084f8f.3
        for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 08:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766680068; x=1767284868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UMUN0jgR/zHl85fjFgxzwAhKsJq+HRQG2BMMWbhG4I=;
        b=ECQKjmv5IPvh1sQX0QlgT8n6MaN0iTi/lMiYFV8wzqlH8+kZFQJW+68b2htNoUf3fn
         bRDe4Yko1d8fA9EArkbHE+mOVEbHb6lCn7fiFdRqQCN1k8htvHFNqNISYLsxj6HXzdmq
         k19/XjQa8DOlsXcgdrgIptzke/YLyTVAVeqLFWSXFLGIYjdg8NTWFrb/e/9a8I9s7DAN
         UHBQZTJZEvNmuYCsI+1KxZv+W5LH5a01xcyHjem7e5z7dGw2DCzYmZCBQWwLGiE54xQK
         Hm5gDLfewzNB6IyxnDKgB36VdhzuYlqnpmJ01mf+vz042ytusLmdhr8lY88xZfmQcP2S
         wiJw==
X-Forwarded-Encrypted: i=1; AJvYcCUmYGMv4bifAqfUS9bJgvpAtBcH59EYKJbLqk9hYrV91uZl7WUwWtJ2jBrTxsQGLrMmzO3RM613PDaCy/ajdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbZQy6JRf4tiNZisYCBW7vK8yTaJkZAoJlc9qH3Jh1uKzRUYZg
	z+lYs2bvXtdvFrAQM3ccj9KcOquzUFmHD9UaoO7y0Us1t9hKZSOjS0Hh9XHexbb0/oCMMbduDUi
	kZYwA7Xc+XhTnup/O3qJS35/HjFXKJ68oXiIl6hpb7LsQCk5Tisj6yS9zxayC1B6zp2Rx
X-Gm-Gg: AY/fxX7Mgc1Jul2tEgTdOIls3hVYge763ERJzKMonmm2Hy4OjRdFyHKCHAPVFCJeO2r
	MN7ciQ9RVmn6WnllSh+emJUKSYp9zftuYmjPWQ8ZMFLGYYDIk6sBQwo592Q9YN/SPftqonlWCCJ
	nkH+dwtKtsRKUeX5t6TFgQ+EfNUtltEeb6C9EybDH7g7x006cQ4iLgKkaVYIbCnlXkfBuq48Jvs
	CSXqqx8/Qi+9c+dV2dg8Jl9eCphPXlO108/swbS++5h3Hk9JiCaeyThdQlxdQXX4Xs6cT4vrcA2
	RjynBI2VRJc4XW/yD6GIdxiMlAz/jZTlyg4Uyy1vhzIjx8ilnlOD8yhl7rr3b0KX98BdcPjbGW3
	Q2SU1T6xtWqKZDLfBd4gPKjaXbt+P5Fqg3Q==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr25713000f8f.23.1766680068273;
        Thu, 25 Dec 2025 08:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0R7k5H0uEZzPtgL/lcx5+ScBj7pHtcQ6qqyBP2A8tSvsgvH85v5c3f94zJFXpkNhGRCz/xw==
X-Received: by 2002:a05:6000:2504:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-4324e4cbcc1mr25712964f8f.23.1766680067805;
        Thu, 25 Dec 2025 08:27:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82f6asm42036674f8f.27.2025.12.25.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 08:27:46 -0800 (PST)
Date: Thu, 25 Dec 2025 11:27:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251225112729-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vxLm-mqDCoggJUk58WNF2V8qyYPDlcoP8RpgpywPHcE_1766680068
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > >
> > > Hi Jason,
> > >
> > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > the refill on its next run if the refill fails? That would seem much simpler.
> > > This refill work complicates maintenance and often introduces a lot of
> > > concurrency issues and races.
> > >
> > > Thanks.
> >
> > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> >
> > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> 
> Btw, I see some drivers are doing things as Xuan said. E.g
> mlx5e_napi_poll() did:
> 
> busy |= INDIRECT_CALL_2(rq->post_wqes,
>                                 mlx5e_post_rx_mpwqes,
>                                 mlx5e_post_rx_wqes,
> 
> ...
> 
> if (busy) {
>          if (likely(mlx5e_channel_no_affinity_change(c))) {
>                 work_done = budget;
>                 goto out;
> ...


is busy a GFP_ATOMIC allocation failure?

> >
> > Not saying refill work is a great hack, but that is the reason for it.
> > --
> > MST
> >
> 
> Thanks

