Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196136;
	b=iYfkbVsozMl2LbDlYOAj2XDpe35/JkEPJGpQ26/eyXorrfrnf9Ml/mjo98nHEA7hQIaj
	 282qitBIbDkWVkF+33M7T4dLEx4wEb/juVCAaLspp/BauBNuRnIIwsY9se61vF4BUupD3
	 O1BIEx6EWCi/VpUB15s2GDTGvOLWMFSxlw/RTpXnLTTBfaY1GTxmUlrLEmLezs3n6rpPK
	 PkCCWrZUNKTJnPH612BIKH67vNQKeTkX0BNGjR/I+MnP3bHLz9fah5IMp8E48GtI5TDxc
	 Ye9rF65qndKFTOtNtCoPN9qi3wX38Ny8SR341TEJYhmiNUPSxePmSYlyYNNRE1U1mDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196136;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=GegFZN/i+0Qb2Bxilr1Km+wa96tgPPaqqRX1nymM8Ts=;
	b=UbTru0z3wzlBu3IiMYwj+am1q1Pju1YPMWbw8lrqtc6XvSTk740TY3e8z3Hb/KzTUjfd
	 Z7S2s3B3a6Ohhct8z962wokhKpmao6WhIJkgcr1ugGhg25ACGYnB0vWf8G75OnChuqJ/j
	 kErFKQbyrsyFOkELC8d5zxvzoLGPEfV/2Drsmow8n1WRZveLmEsyw+MDXiVe+EcB0MNLc
	 TWK9E5c4Tak+TpLtOQ3eVaRXdt5Fv3pV6VLX1MGku4J6h8dwXJsqaRlT7D4j2Pdnw1hy5
	 2ySICjygCjbiC0mmq/6TijR7HnnJsYeLU1OLubu3NrSUbLDrDyxS7/OQrKFUpV92EVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DBNbd9vk;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6ED60A2638
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 17:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6ED60A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DBNbd9vk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795196135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GegFZN/i+0Qb2Bxilr1Km+wa96tgPPaqqRX1nymM8Ts=;
	b=DBNbd9vkNKfP5oVT2g3LUgP6Gd4cPvJHlB/xIiyT2QQ1sn/VlHZmuJ/vg4esRrqa1xygha
	uS9ovo/5NcBIu11vGBigNR/rOMgJcoUSUoUit2wUvizN1sQTPhjfp1N3MfuLQVIZ4vEGS1
	TNOoqMnOFu2YCYceZLh9GVgOS6sZmc4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-R91LWcluMS6nQLs3MgkTTw-1; Fri, 20 Nov 2026 17:35:33 +0000
X-MC-Unique: R91LWcluMS6nQLs3MgkTTw-1
X-Mimecast-MFC-AGG-ID: R91LWcluMS6nQLs3MgkTTw_1795196132
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a370217dcfso933155f8f.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 09:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795196132; x=1795800932;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GegFZN/i+0Qb2Bxilr1Km+wa96tgPPaqqRX1nymM8Ts=;
        b=vX7rpDXDM5ZK1cJgsanJVre7uKH6+niFnzH2gTyl7thPpgDT6FD/KIxa1+6s1WLgZp
         gxBJaGYxSytM5zQ80oOI3iaKCKykG+8fga6xVbzhIq7zxu8Yl7FCKbdBOHXX+Fm+HIzH
         JUB43DvndHuThfm8fElTTb4pD7Yn3YDb31CGHBnV08bm9yzhDh/yZh96N0HNzXjUNQ5q
         tCG/wFANXDyZB/S20GIicMxGmOB5impnb+kMv3vXDCop7JAeHxviYvk9a0zR2j916rKI
         10hf38kmLsmrZZKOzOEAWcmF5vc9EvDCv14ylVqcIlpqp58BPbgWANMKp4DL8VosYv5Y
         Wcsg==
X-Forwarded-Encrypted: i=1; AL+hErEmHUPkotJX65+3T7tUPClKr9zuU2PjixPjk/tHA/CUwcV4LaVFTW28bQARf3lqoJsKvPrBb4vVf7NJjU3TUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+yjRT9/AeAet/LHwVHvIjxmDhJ4T34B7NcVfyvpSoenknTQPuB
	zrEB8bOru0ko7D/YUFC5hOhbaVv4v8NfdRPpShAlfxAo/bova8GLR2rlWYK7P2r3OVsnjwcqWEO
	8PVYP0GWen8GphTXXePg7c2JoaHo6JNA/O1CnDDmT788uZgOR0kC02CgifvMt1IYOylRh
X-Gm-Gg: AZFdTZfd4kY4KpzL1p5wB+ZodLbirudPDsGn/q09GD/38PJLiHLT71zhKzEeKLtT7WG
	jIeezzSKIMFkpDKPYhtHlvZTSnhymiBAVX4XYJIwvCyjG2EN/qcCFCW0vT+hH5LkNfhtR2Aq0Z0
	+7Gn5X1dVIZfNcMgPT73Cqk6EXjItChLxOckbyFSzpGZZWRX6JGXU+ld53PA6oRRQ4NV5hoP+7p
	ilLeLA1vUwopuPjFUDLese+j+lwgef+yjOFeAgJsxYu4oElxSSeOdWzWJXToJOlWwM/JE4IRKCf
	umqECPhM00ZVvndhN+VJQPmOrfDmXKcacdmmtsh7IkX5kSfzuO/sFyxZJlSbr+VvaHKzphjmuM/
	ffzgnEq1icCMXx9mTLsCo0tmy9+rZdw2untc890BoiWt4
X-Received: by 2002:a5d:5f4f:0:b0:4a7:35af:c83c with SMTP id ffacd0b85a97d-4abb3e21218mr7875106f8f.43.1795196132110;
        Fri, 20 Nov 2026 09:35:32 -0800 (PST)
X-Received: by 2002:a5d:5f4f:0:b0:4a7:35af:c83c with SMTP id ffacd0b85a97d-4abb3e21218mr7875038f8f.43.1795196131642;
        Fri, 20 Nov 2026 09:35:31 -0800 (PST)
Received: from redhat.com ([2a06:c701:73c1:fd00:6c8e:5a61:f533:519d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm7150988f8f.31.2026.11.20.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:35:30 -0800 (PST)
Date: Fri, 20 Nov 2026 12:35:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: vlad.wing@gmail.com, brett.creeley@amd.com, eperezma@redhat.com,
	jasowangio@gmail.com, jkkm@meta.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com, joao.m.martins@oracle.com,
	si-wei.liu@oracle.com
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit
 DMA
Message-ID: <20261120123500-mutt-send-email-mst@kernel.org>
References: <20261109184253.531677-1-vlad.wing@gmail.com>
 <20261119200654.1048266-1-vlad.wing@gmail.com>
 <20261119181557-mutt-send-email-mst@kernel.org>
 <20261120171435.83458-1-jonah.palmer@oracle.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261120171435.83458-1-jonah.palmer@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UZjwniMCO4_fI9pM_zwS8n5rruk4kItrGY_rMkjdeUA_1795196132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2026 at 12:14:35PM -0500, Jonah Palmer wrote:
> On November 19, 2026 at 6:16 PM EST, Michael S. Tsirkin wrote:
> > it's in my tree.
> 
> Hi Vlad, Michael.
> 
> I've been looking into this issue extensively. The proposed 48-bit limit
> is a suitable conservative workaround. My virtio-net testing for this
> issue shows that a 51-bit DMA mask also avoids the mentioned issue.

Do u want 51 bit then maybe? x8 memory with no BB?

> Full 52-bit DMA mask support is planned. We will revisit the driver's
> DMA mask once the firmware has been updated.
> 
> Thanks,
> Jonah

