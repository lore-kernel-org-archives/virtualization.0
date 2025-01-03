Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26A1FA25F
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917693; cv=none; b=qvm9A8ea49OOrJnAQnC89dEso1/defA31V3gIQFGXVpCHLsPVQJ4EiK4kZ76/Cj/m/zQeZYwFta3j/y78dk+OiuAIlxcLtCi59OZqRfGMuV00epAI8Uwv4webjGK8hLZTh9syiq4X4IgdcPp7kg413DAcbH96sO3FWzyl/TJF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917693; c=relaxed/simple;
	bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4K8OBuNgaJYIHGUG2dgm/PnTOW7/VSPVBSHyIAShgeGs4rmUQ7EF+EW9GiZfEYBy2AlX04GCzrpW+Nua2yZlT0iGQbI023FymvinG0rnIPFGYPj9Y17NAdAz3iylZDHzenbIqi7yp0+9VzcXXcM/CpNyBiQls8lRclfDyhemoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPRZp6h2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPRZp6h2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21675fd60feso226964775ad.2
        for <virtualization@lists.linux.dev>; Fri, 03 Jan 2025 07:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735917691; x=1736522491; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
        b=aPRZp6h2WdH1+A3ZMs/+XmcWCcIFeWvPrEhz//BovumrSbfI0+GM510XIBASM1bAIT
         HeOC2xsepIaz5RZ1t3liivOPh9ARFwOi69JirRLeicGFAUPVQkNa/yP8VJYszE1s1QtJ
         AqM2FlbP31xVVWd7MShmlLBr3238LD7+PB3kQpLB4nCJ7a1JhylY09MY6pbuiIooej8U
         KgQvxgUgZayWX5vpQ2TSCfQdYi3utz8HAGepene+qmHQxBd7ycQJbMbP75GGxXm+1Y0h
         H3qSrKGfiXd9J22jrldmPqJvvtiUpzDOtFflIlAc8sl/vdvlNH6ThRwEJNRKuOH2nF9/
         U0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917691; x=1736522491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf/9EHK0+H3LQnblB2A3eP443gcgVGZGGzaT7TX3muU=;
        b=bYW4+JVBJBef85r8VvzV9/tFtth13duC510XQB77+Vx595xKzdx/yHOKoK8eqdsJuX
         CZqN6SS9+dpx3ygc58DscbvTH+RlV2vYrCaM2d7gzepltQ/Woj88m9h5S1n0GfGL6AAx
         Q9flKAdKDXVD1r2QHXrORKqAL5hAfKqKPTTzAGaxP8mLy7zPTFoWAu/ZBlIy2V1HwwXf
         WLE9qIr5H8s4tPZ0oamvxMbCc0iyig/ZLtLeGxIv6Jr1Cw/OfNhiwdM/R6S3E1qPm25Y
         ZjU7NnBdARWdc4CgiEiaN36BWx3aGoOt/d1V0IdwWK88iul9h0PYilER4+6rdJVZQG1q
         OSFg==
X-Forwarded-Encrypted: i=1; AJvYcCWTZZFOrePngBQqmF0e99yRKhZLQehE6VqmqvQkhyi3GKnvl6917e167f0kxmZGyPvkFshycZ9+2agMCNOSrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDXvV0rNjA4nqxVooSK8PkkrCgVP1o1g2dbtCnRfacUc7edu6F
	59wJ+HJcIAs8EuEkcIhKN23Ytt60bES0z9nN6kYASzg3aAqAwMVi
X-Gm-Gg: ASbGnctYBAxmL9phjcxyUfFqenf18s/fYRvkxpV+V9vBgvkyH1dETuqaPpyWk5A5cwk
	3zJ9jnst9mokx6dSzDxx60eZOHnoQluqipSsnN3RYkaqtt9Zkc6E3RwtJ2fZvhvsfLuGf6nam4u
	H3XXbYMLwT++I5jTRiZeafHWlzLMuYjWQFVcaFVVpuX2m6uVxF7Ebz3GYB9E3Cp82yl8AwLSxK5
	/spZ9Ij+Bgcrt9wgQmkJ7v+sRtoPpccQr17qXS09ZsTu0weozyxVajJwXbd0kOWvAktqzVWHCL8
	AKlJ
X-Google-Smtp-Source: AGHT+IG5A276qFKzsq0vRtD6GevOEebgjRTwKom2lvuNWUTRxP4Uq5vYQN1tUnp8ZXMDpu322FblbQ==
X-Received: by 2002:a05:6a21:3a85:b0:1e0:c77c:450d with SMTP id adf61e73a8af0-1e5e044ddfamr75802412637.1.1735917690845;
        Fri, 03 Jan 2025 07:21:30 -0800 (PST)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm23948804a12.23.2025.01.03.07.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:21:30 -0800 (PST)
Date: Fri, 3 Jan 2025 07:21:27 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Christoph Hellwig <hch@lst.de>
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
	Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH 00/14] cpumask: cleanup cpumask_next_wrap()
 implementation and usage
Message-ID: <Z3gAdy7nU_-DAxhq@yury-ThinkPad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20250103070229.GC28303@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103070229.GC28303@lst.de>

On Fri, Jan 03, 2025 at 08:02:29AM +0100, Christoph Hellwig wrote:
> You've sent me less than a handfull of 14 patches, there's no way
> to properly review this.

Hi Christoph,

You can find the whole series here:

https://lore.kernel.org/linux-scsi/CABPRKS-uqfJmDp5pS+hSnvzggdMv0bNawpsVNpY4aU4V+UdR7Q@mail.gmail.com/T/

Or you can download it by message ID like this:

b4 mbox 20241228184949.31582-1-yury.norov@gmail.com

Sorry for not CC-ing you to the whole series. Some people prefer to
receive minimal noise, and you never know who is who. If it comes to
v2, you'll be in CC for every patch.

Thanks,
Yury
