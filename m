Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2841D20CCD9
	for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912316; cv=none; b=f7wxRTgAFFf2VdmmrMhhgdhpcEOacyCTtiYpnKPTo71jXl7FpOoaLej6QE7/SR2tIu20Lwy7oZdiCYDNJ+Q+Srhn3TFD55V8bNvZ3Aa17JRclGIpIIQ3WDRKU7yQ9aHubHoVwgBR12groakqgUfjbrLEBfdeeoqOku6l56T7P8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912316; c=relaxed/simple;
	bh=gN06EUNT97ngcgK4V6x/fRnJvp2euBs+cFhJIU8hNis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Srkdjql+BohBgCKetFGinkVOFIj1gj0Hkmhql7t2SeYCKBkL4jYWoAHXlOq15IBz3FK5aW23qSMaf7JNHV2J9PBQ8AHjA5Qn+KxEL+OFrfMj4rictBk8S1W0iNR/LrRC4tdEmspkGTaWgX8t8ARRpEGziNvk7OKWetg+bubGs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpXfA3R1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpXfA3R1"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e46ac799015so8654974276.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 19:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912313; x=1737517113; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=;
        b=GpXfA3R1JGUQyISCqsSWMkRVk9MAjfAN1t8Y2sj3RFcjY5uGZp2GJlf5avnt92NEA4
         fjufSWpFIdNur4y2wb1L1KLDS0Qsq+lBuFZYNODLbepWYiwcVzqDRSRF++tnVV8Y0mdQ
         R50Ua4G7C/zPmH4x05NDCNBbiaSlBNam1TcvxDajrmhPVXaC0TiFkLoygXxAY8QV/MQG
         Tq+In2xa55+q1ar8evtffP0qPnkKIfUmWdYVgU/6Nz3kk4vF3JJDhXy2te/1F5Ju5vyU
         6SM/HggyWvbUTZFQ7eZTMJW6wTRUrO0US3P5wYcdPFN/DTJle3PNm80ULPSevULEp1a8
         pVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912313; x=1737517113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=;
        b=Q/iNjQKc15EcA16P7FHo4wJVs40NvXOrceq2BHveTJQZ7JrSTgpWl1A5unEd1rkdXF
         sadiXqV+4gxbH4SoU7K+4CLheikpkkmQcsjqmZPK4tR+JWpyAA0mimZASEpCxhSsoQXS
         /mb2GDpWX+aORyPYUlRyOIJ7ja3lgHorG8Bd6w6JOTR0wBKATuEYZwz+7ojk3uEOQsox
         ly2Xv5mOc5R0t2LDvGNO+xhxFG2DzpepIwOpTDNQOFKN6k51ihz+7T5cq21jmkVAOKeQ
         2Y+UKzcX8XpmqaUs79DwveGNzmL7C+aMG0Td0zzgEERikfn/rB+IQyCtb5qY0XWTvB4f
         QY1A==
X-Forwarded-Encrypted: i=1; AJvYcCWayUEjdSSj/bOGtO4kTg03grYRiRkAMVOtHuY74pclIjtCPHX8EsdyTs89r2UbcO0aEQLdWLh/iJyCFqNpuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweC0JRXiWqZ+SZ4yXK0eggGNuBbAalsTsYASkVQkFx5Fc2eNlU
	TYxsHHyGNrig1Nx58nRB2uagkQZFVLA0cFmYA5iZodysUzd3aAaf
X-Gm-Gg: ASbGnct8huD26agxVL2f6JUxAxMikLJpq7KxcKmhlRps/dNGRkahe6BEfZcHLTpn9PZ
	4G8v0NUaR2+zlvSEbSushVCGIOdmDRFBsD23qrMHf5JE5ZfPNZnch9AfIdCY6dRYH4NI0ktScJW
	nLRcaq/680kYdS+kDm+XLtdXhD5dwVdiPsNewAyzATgy2A90m6iU6CDNNCeLDqI1RNhnTOXRUmg
	PaEkLUEX9IeAnyNUlC7iodsCfHhRnU5Ygx3Ibof/Dz8Z8eqnCX+Oyeh
X-Google-Smtp-Source: AGHT+IGcxF5UAr9VMjmEWcxKQm1jPE9VpwQlX4HhGZHkGGwOlZgKnKfAZqEBywSv8uk39tmS/FGABQ==
X-Received: by 2002:a05:690c:62ca:b0:6ef:7d51:eba6 with SMTP id 00721157ae682-6f5312a8384mr216747977b3.28.1736912312722;
        Tue, 14 Jan 2025 19:38:32 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd712esm23854477b3.79.2025.01.14.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:38:31 -0800 (PST)
Date: Tue, 14 Jan 2025 22:38:30 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
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
Message-ID: <Z4cttq0dfHnapkUI@thinkpad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-7-yury.norov@gmail.com>
 <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>

On Tue, Jan 07, 2025 at 02:28:31PM +0100, Alexander Gordeev wrote:
> On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> 
> Hi Yury,
> 
> > cpumask_next_wrap_old() has two additional parameters, comparing to it's
> > analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> > historical.
> > 
> > Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> > macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
> > iterator. Now that the iterator is an alias to generic
> > for_each_set_bit_wrap(), the additional parameters aren't used and may
> > confuse readers.
> > 
> > All existing users call cpumask_next_wrap() in a way that makes it
> > possible to turn it to straight and simple alias to find_next_bit_wrap().
> > 
> > In a couple places kernel users opencode missing cpumask_next_and_wrap().
> > Add it as well.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index b267a4f6a917..18c9908d50c4 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> >  		small_cpumask_bits, n + 1);
> >  }
> >  
> > +/**
> > + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> > + *			   @n and wrapping around, if needed
> > + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > + * @src1p: the first cpumask pointer
> > + * @src2p: the second cpumask pointer
> > + *
> > + * Return: >= nr_cpu_ids if no further cpus set in both.
> > + */
> > +static __always_inline
> > +unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
> > +			      const struct cpumask *src2p)
> > +{
> > +	/* -1 is a legal arg here. */
> > +	if (n != -1)
> > +		cpumask_check(n);
> > +	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
> > +		small_cpumask_bits, n + 1);
> > +}
> > +
> > +/*
> > + * cpumask_next_wrap - get the next cpu in *src, starting from
> > + *			   @n and wrapping around, if needed
> 
> Does it mean the search wraps a cpumask and starts from the beginning
> if the bit is not found and returns >= nr_cpu_ids if @n crosses itself?
> 
> > + * @n: the cpu prior to the place to search
> > + * @src: cpumask pointer
> > + *
> > + * Return: >= nr_cpu_ids if no further cpus set in both.
> 
> It looks like Return is a cpumask_next_and_wrap() comment leftover.
> 
> > + */
> > +static __always_inline
> > +unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
> > +{
> > +	/* -1 is a legal arg here. */
> > +	if (n != -1)
> > +		cpumask_check(n);
> > +	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
> > +}
> > +
> >  /**
> >   * for_each_cpu - iterate over every cpu in a mask
> >   * @cpu: the (optionally unsigned) integer iterator
> 
> Thanks!

Thanks, I'll update the comments.
