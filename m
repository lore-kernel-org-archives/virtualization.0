Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C434C98
	for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912466; cv=none; b=K6v22HALGg/vR4lUeTK8jZP1lKmlGRLlp+7ZCYVYHp84iui0PZfPwFfn8vEmHVAaDE2FnH+ib32domfgGp2ioquHCye9k6CTdamwUgvu6nhr9h8o2yDUhfXZnz7bGVq0mcQARVMOJZJuV84xyvkDaMa4lsjxO/idWlBB2xRzzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912466; c=relaxed/simple;
	bh=lx1JoZuyAOvH+tAWIwuUhi8eFxOhxcAC6JbtgL/RLvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK+HDmmKJsKCa+SbdN37B5O8xbdDhXB/LlnT4GyprvNrg5gGWWVvbyh2WjTocPUgQ/jTogjNzeofwwagJy2KejpxdNgT5dL8sdrabf+OUlbZqpCzGqMXr3zwZ7XWArX208ZLvDzBW3BjxymByifabddvo5+5N0yCb8IZ6PQvm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo9JaBuY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo9JaBuY"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso11148570276.1
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 19:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912464; x=1737517264; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=;
        b=Xo9JaBuYq2jofZv181ej5po69wB+AyHVNDUoCvCKxQCdJ2sTvI1Ug7v/csnbw/2tFD
         9cEe5GUauFrb60Z6MQPwUm53X9IO0EGI0XO9w+PEYgAZ415wN4KqKuH+KfuuZBiasxtS
         Pw1MByDG+D2629XC17xGh1QdvEtD/jDAkkVNQniPMHPk9Z7dTYyS/9xhcu5rF81/gP8m
         sXQ1aDGpxWAbn7zKjbOoYgNofYhfKZue3tKJahy/Iqs2DttOy6ZntVfHxAp6HuxX0Bj5
         aDNVjUK/lgdVMon9ZfAJ+1neir4C/xjcwOWYzoXKCG4XFQsr8pdelzUfHZVJk83Mtxb5
         WgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912464; x=1737517264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmTK2k4vF2mqctoCssOfytU8KQ/2i1ya8c1dPxSZwZk=;
        b=AGprx2weVPfLCpFtd090uNbykjuB0s2WIy7AiOj0FUpRFK/0StoXx/6/PFFMRmUnHI
         Yw8f1zhxaFbkimxpmkVKg1pZKJGo62b4I7vHL1f3oeUG5z5Pni/MtN41KnuyPRXlf43J
         YOSn5IbBGjIGhQBqSZoAgS0pWMpRwZvfxBpFuZ6He0wymrwnWO8EgRlUrxUfIDVYaunJ
         8DVsN1pfRnFJtX0aC4ghLwUZ1ApRQi9X3ps1MBWxVyeWDmQ+XUYRQJWxlKYMbC8AX/bN
         NgjI/zll7KQIWem9xbNDcLjnP5QklOyNPxUaCsv9nVJC/PUrsFhO6awINRYI6StLhfOF
         bBhA==
X-Forwarded-Encrypted: i=1; AJvYcCW9hsSuQxBp8nX+YOSwsE/fr4IS5IAaBWM5/ifCmiiX9Op3r2hSZ9SWWq8pZnBfje7J21nSlGVXaMv4gaXrYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbLYEt0R/qPzSdv1t5gfB7VT/URJ3fdcNfhOQHKOYrQQ+C8SDu
	kVXoqR/xXXwsgczeZZuRaZe5zFyFnub+ecEol7kdBkzG3sFyJmwC
X-Gm-Gg: ASbGncul2rN3RDajrdKqWLFbmpMjfWlL9RnfnyYcY7Xswc1CGCRk1+MJmVWuTNdpoW4
	pk1mpFdKnF0CJRr1St4DGy8j21zKZk5cb3xKiYh3f1pyQhte3OXm6CPs7ONIGzY3Oc225G1CEdX
	HYGFITJ6pHgmPCq/u9/zQCTSeVxG9vzHltn94HdgPX5HmC7kECjHLpFWV+K3mllaV42KDgXZEin
	MrvCd2wD1L1W+Xj1MqmAAr+isQpRJt78AeEMRegf6Qck/2ULrBrgOYt
X-Google-Smtp-Source: AGHT+IGlCnPNZfANCVJooif/vwR9Wcfdn14fNs9Squ/CXSzhwHBTvNfC1cp1ga3/es5eAiOB92QKfQ==
X-Received: by 2002:a05:690c:45c9:b0:6f6:cad6:6b5a with SMTP id 00721157ae682-6f6cad66c84mr8171767b3.13.1736912464441;
        Tue, 14 Jan 2025 19:41:04 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6c93732c9sm1796417b3.103.2025.01.14.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:41:03 -0800 (PST)
Date: Tue, 14 Jan 2025 22:41:02 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <Z4cuTsHbO6yiuFKA@thinkpad>
References: <20241228184949.31582-7-yury.norov@gmail.com>
 <20250103174432.GA4182129@bhelgaas>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103174432.GA4182129@bhelgaas>

On Fri, Jan 03, 2025 at 11:44:32AM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> > cpumask_next_wrap_old() has two additional parameters, comparing to it's
> > analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> > historical.
> 
> s/it's/its/
> 
> Personally I think cscope/tags/git grep make "find_next_bit_wrap()"
> enough even without mentioning "linux/find.h".
> 
> > + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> > + *			   @n and wrapping around, if needed
> > + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> 
> Is the return really > @n if it wraps?

No, this is a copy-paste error. Will fix in v2.

Thanks,
Yury
