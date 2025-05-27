Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C0253F1E
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358407; cv=none; b=K+Kn8H2cYF53d7lC3lyHszPpZnCtgQHo52gC1ena3o2zJlkjs5mlGR4SJ0AC6gmb4xEwMtzppdfCJpbX60l/qNktfMQW9U52Fpm1xn8HEQKmEcQi8n9gbA7wUudpB6FWTVdBXYjSZFp/1FUi3Tcgn2yLLClB9sni/jN3qmpldpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358407; c=relaxed/simple;
	bh=OeMg/n4s+XUyV+zOygmzjEvKMcK4qz4amGuZH9Z+N+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eGYcN8ldjZwiTHZU1iqG0bKkgNaVGDEEUJ6mb7UMt28fmAkFmVBqE4X4xPIM2q/IDakylHtuvvoXEQwhwKuZ4QEDqQu4+7rp2HmS0kj80qx0Jc5eBXgaKiMS7qWoAeP2KpKP51Vihg6MwIG4DyBdQTAD/SOFZbysjI8DdIvmpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFyrzzHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFyrzzHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748358405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZ29RQMR69m4K9xLY43phEvDycHRnJ7kzp42BGznxp0=;
	b=dFyrzzHxkoOZyW6ONBxcemSP0Dey9W+x5UDev5bjfl9Am++MHoO3mp+zCMRYSW/wf/rSpW
	7JrGBkzd/WR1HAq2+ChTUD/b+fPTdoC44Nly4/fmmqow/bReBHZ4uCMJZISKhP/qGFTyV8
	GJcd5e+tPRu/wZX3Rw8YpFmLlAYCWhs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-DJ3XVVNyMlehAgPu1rzAew-1; Tue, 27 May 2025 11:06:29 -0400
X-MC-Unique: DJ3XVVNyMlehAgPu1rzAew-1
X-Mimecast-MFC-AGG-ID: DJ3XVVNyMlehAgPu1rzAew_1748358388
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4d95f197dso1368763f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 08:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748358388; x=1748963188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ29RQMR69m4K9xLY43phEvDycHRnJ7kzp42BGznxp0=;
        b=nJVmcfVyCSbk4xSFmT+mQkPcy8sMJBsxUAKhZ1+db6g2gNqFMN8UCW8pmJ9M0h2otj
         hMcU/E9dmwYxHP1xnsMMYLwbWj51iUmefy1Dx4vMEjKfYxjDGumauZiaxfHrizqvuJ0W
         JtdNfeAI5th4ZmOOjnJ8jQBo5iOmY5gy0Dil5qVSw/G20Sf2Ccs9BdnItqswUcRHtb/T
         aYb7AwPsgkCoOTUL62lGc4DvYsJSpGCz2t7U1uhemgQsenlqfrWwDvFF1YzS2ajZhhcn
         SpWpgzDIjJ4BMc78Vt2ONUJA0qdrf4aadmhdz6vhCYvXGoW8CYq/1GsDAG0+1jUBYcEk
         YAZw==
X-Forwarded-Encrypted: i=1; AJvYcCWiL7kWnzzcAOlgKMipNOu4Vfu4FSjJ+KAXsb2q1XhQTTAnT1DG4gmK7FVmg0aGwMwkXgKS8uuBgtG3pB6GWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8HJsRBVIF9QUKk71tv2GV+lfdQloBYCKCN62j5nizwg+U/JjM
	QIR4eNGKT5OqLAg3EsIzU4qrwIm+f7J47e0uh/ytwO6+iEIc+eq8QLUFpONdzYE6cjk//brtaUw
	dJVpTR9nlwNkUQsArnLWK2OBdu6uMcqfAnbrAuwns9tRPGaVpb+Rgksj/TDJ002pvfE9v
X-Gm-Gg: ASbGncs9xf7TmMUB7YkvyaOOErnTMUmBNqPYZjQn2l0i6aUTwIjTB4qbRAN3MdSl73i
	ZMpEKCJFCA8E+iHDGqnWBdpsdLEqOT8D8n/uKsS0Ax+Nj/J0KuEAkMruclFci1R94mwRWcfgITc
	vvc4bUS7Sdd5bzCg7BCCwtPT6tdYcBkRdrNltwk26RVtEf3hXdOh90wCNTzuPxaNzFIfD/0cLyT
	RuoVppW1eTuLW7oXOO/G6Hs6RlsO7qjiFL2Ji62BytIrM4tlpTFh3nT01/Nx+o0Z+yIZDl8h4su
	TcnLPA==
X-Received: by 2002:a05:6000:2890:b0:3a4:d7ba:940f with SMTP id ffacd0b85a97d-3a4d7ba9678mr6493708f8f.8.1748358387933;
        Tue, 27 May 2025 08:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnxRACmfRB0RLkxdi7utBGmJ2uHTW6WSbB3UldnlI9CQBfujtwCkHpHjFnwqjC0VngKmP3KQ==
X-Received: by 2002:a05:6000:2890:b0:3a4:d7ba:940f with SMTP id ffacd0b85a97d-3a4d7ba9678mr6493637f8f.8.1748358387264;
        Tue, 27 May 2025 08:06:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e1632825sm2396185f8f.43.2025.05.27.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:06:26 -0700 (PDT)
Date: Tue, 27 May 2025 11:06:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Albert Esteve <aesteve@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	gurchetansingh@google.com, daniel.almeida@collabora.com,
	adelva@google.com, changyeon@google.com,
	nicolas.dufresne@collabora.com, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, virtualization@lists.linux.dev,
	Alexandre Courbot <acourbot@google.com>
Subject: Re: [PATCH v3] media: add virtio-media driver
Message-ID: <20250527110444-mutt-send-email-mst@kernel.org>
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan>
 <20250527102111-mutt-send-email-mst@kernel.org>
 <20250527163927.02924adc@sal.lan>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250527163927.02924adc@sal.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TWtfIteGJMtyzL6gtiXIAOID5HwGqjXXKQKC07dG9r8_1748358388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2025 at 04:39:27PM +0200, Mauro Carvalho Chehab wrote:
> > It's up to you though.
> > I can keep it in next for now, so it gets some coverage by
> > tools scanning that tree.
> 
> Sure, feel free to keep it on next if you prefer so. Just
> please don't submit it upstream while we don't review and
> properly test it.

No prob. I just want to see it get reviewed and merged.
My understanding is, it wasn't because maintainers were
not Cc'd so that should be all ironed out now.
Alexandre, do you want this in next for now or just drop it?

-- 
MST

