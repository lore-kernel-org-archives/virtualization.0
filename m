Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D231ED93
	for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562620; cv=none; b=Q3yNC/danwwwODPJa0vlo3i+KAIP5tKwDkOvwY9vnsqIODd6Z2YlSEShmHPrac8zP25w2zbxD6DdtgEchyqztfGTYXBXFHp8KEWA8MFuEAExQOECGLX2LCev3uut6QT97a8jS2gnC7G9LSwJaIlebmBnX9VGkH6uJkKQu2I0R+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562620; c=relaxed/simple;
	bh=/0I5PlNTDmo42F78lIX7rXVUcj3Vn1T+pJs/PmebPl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PUMjlGcJc2xFUT5tmhUBXTwMhR8RGOAkQ+ZyQdDhdlvwk+YKjF8GFpLoZzH5bNAaxOpJ6VJHthfbuYGdojRWn/7NBkhUfEmA0R5gbUj8mjiiUeOumBM0PrJx75FB32J7IINmAfxArtGMedAfRNJhUEzikWOY6Xo7x+jKdAqlSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLoukITq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLoukITq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774562618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
	b=VLoukITqEfezgPCrM+k1DlfwA0g3awFeBM7Ct18YKnhdBPbJZhadrwohKqec6BhRwDYihx
	OPugtfpEYKRPzFwR958z8T4lsyH14lCfstL6rFSMJW5K9nS1GObShoQCBdy43D07qTMo3Q
	jV+wsH3LCat4o4pNtHSp4j6GcvQIcXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-H2JiwwWSOgiE8Tpx5OgnBg-1; Thu, 26 Mar 2026 18:03:35 -0400
X-MC-Unique: H2JiwwWSOgiE8Tpx5OgnBg-1
X-Mimecast-MFC-AGG-ID: H2JiwwWSOgiE8Tpx5OgnBg_1774562614
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852ccff333so12988015e9.2
        for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 15:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562613; x=1775167413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpgob1tvHT4IKRz9W+hPWJKbEluQbBFuXgVxhpqe0s0=;
        b=P23SiypWUl0kAOegLj8FxXHgPevrCahasWze2ORONt4s5iEdxD2r8uUSB8ZW63O95L
         7vEIIR9pz6XAkAl1v4VBdAoVr3eMpZsfHRUmkMuhIqhZqTn3gceQkEAVNEumoq7Bird5
         t5C7LzHjHKfqsWRqQl1zR8WUoXE7v2tdZYJnShIprHlwQA16usRQ9m/dhxhAI8KLvZVq
         dswxaPobMOUtoyQi3Bwnj9rSAly/wyGVP0hL7eNKp3k+EBTQ/4f+m4Z+mn9B6p95OoCp
         dxhoomdfQ999PV3i1nSOgH0LOQKckL8AnPB9TGy+N5yv1cXHocHDzudEhhhe/lZvMdKZ
         s3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXa2v7Xp/LAgltWwVtRKlwkfnAlH2W+GVjgIoAU++tl+6+5tIwxvLRL8+k+Z6vCjXC6h6oOnT/1Wsojqnd+Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMpWRT6iGZsQoJyz/dXYA2k5Ld2rWjh//0WswDvGedPndFyR3H
	WwXeCEVwWZv+ndmWFpYY5l3DKtpdRMwwf+3jgKaNXvNixQpQyJwHpPiFyhA58RFgGvOeRSXiYIo
	CVCb3rcauU8G4X+3VZYAdLz+PojwNxtGq5vlpOvWgJmrUZZkjmXug9iYJEWCMfKZZ2emNfpQ8lZ
	KI
X-Gm-Gg: ATEYQzz9rhFSLhQSXtdwIYSS6279Cj1fnjqAExaOrO+xKuIy18xye55fw5JZdYIMfYh
	Q9nbe/J+gBL/qjF63qvotQoGgUf1ZJCJai7vB6IFi9lEr9/0QNpZ6mhPhv5C3jofTwHZI3rTY06
	e1Jm/5Kqzw2iwUnuoPl596eVN9KHzuKsa2a8/KlqrQdqVKe4vzN6eziNLYIfFbESHMDRFlMrQkb
	DJOS9DR65NvUZKSIxesmopJidJ1atbDw0qsfSMXwx74KLlQbK3YFtfECQkUXL/Y6kZ5KztOUOPy
	KZFHA5949dgW+VBoH3ZtZDNmmwX3WmrFDSkZAkHaZUjZgHEVipU981gk7WwJG3Q4ST2OASXwSiC
	mGN1c5hRq+o47cba9
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr4643745e9.1.1774562613590;
        Thu, 26 Mar 2026 15:03:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3d87:b0:487:1114:d42f with SMTP id 5b1f17b1804b1-48727d59da0mr4643465e9.1.1774562613107;
        Thu, 26 Mar 2026 15:03:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm90811505e9.11.2026.03.26.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:03:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 18:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the
 header
Message-ID: <20260326180313-mutt-send-email-mst@kernel.org>
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
 <20260326181736.GV111839@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260326181736.GV111839@horms.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fYAV6jkF0R049pVA9g9czCo_-eNLT7ZmM4Gsr8W3DAY_1774562614
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2026 at 06:17:36PM +0000, Simon Horman wrote:
> On Tue, Mar 24, 2026 at 11:15:54AM -0400, Michael S. Tsirkin wrote:
> > receive_buf() reads the virtio header through buf before
> > page_pool_dma_sync_for_cpu() runs in receive_small() or
> > receive_mergeable(). The header buffer is thus unsynchronized at the
> > point where flags and, for mergeable buffers, num_buffers are consumed.
> > 
> > Omar Elghoul reported that on s390x Secure Execution this showed up as
> > greatly reduced virtio-net performance together with "bad gso" and
> > "bad csum" messages in dmesg. This is because with SE sync actually
> > copies data, so the header is uninitialized.
> > 
> > Move the sync into receive_buf() so the
> > header is synchronized before any access through buf.
> > 
> > Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> > "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> > path to before memory is accessed through buf".
> > The result and the commit log were reviewed and edited manually.
> > 
> > Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
> 
> Hi Michael,
> 
> The hash for a patch with that subject in net-next appears to be 24fbd3967f3f.

Thanks, will fix in the next version.

> > Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > Tested-by: Srikanth Aithal <sraithal@amd.com>
> > Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> > Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ...

