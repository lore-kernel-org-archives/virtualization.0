Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66491D5147
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832897; cv=none; b=WCIv2CUNdmsZOln+T/Gz8MiKksi+67JaPPaP43Y9FemQJMQiOT/CR8NH48fL1joStt6u2dHovEpHxmzR0sLvjvqqPxlVR3OFQ3piEQHN+kFTb3JaqAMheqmOFu1sAW3Y6H3Dfq4l65nG8VpTZNAWEdFenAVYdOzbGoidpWMhAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832897; c=relaxed/simple;
	bh=9g0zStzKQeS3+N9tmIKzZx3owOLSnCnzmMh7XbFrzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LltaebGkNIrdQWW4+xfZp8YZ6siST89ze2MqnVHm+FzBj8K+5ILtMr/zXB4o6hj1R7dAEOAy81Y6Tpmyw0eu1HmQ5/Ed07z9Za30by9Prp5vy+z34YQ32GX8WODdtE1htz7CgwKRma4B4rY32ePJBNhLl0QMtq4vK8uNX8SKYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1485F2n; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1485F2n"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6467ac59e16so2077092d50.1
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 16:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767832895; x=1768437695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrenqTp8E4tDkOgXs7eMnB0GiU20rX+sxdLI3fByfBk=;
        b=J1485F2nnkqUZmW36uRd8s1LjATgJEssjVoM+6+d3yQVU/c78FDg0EznZhkMMHoRKe
         wYqQJy6pGwqBULqVA/XJQxHnwcNJ6A3PLxZHhy4Qi+i76aEf0j4lpAg/mntURi4nRXnL
         bdeI0YMVi2fMeFutf7QSGdx2dvMtA4VFKrZMN3vczbrbrNXZ4FBBhXsPtEyZ6F0Azx3c
         jg69YbYlg6afT6D2SW+KhU1kbig0/H0aUVU587m47n5D+qcEiFWiXHJOhpyG/JZMFu6H
         vwM+ODVE5pOHvwsvRwO6ky01rW4v/HsYvh6J8gwH4SbBZP6Pj2uhHFY7EL6sfnAc8CrH
         RogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767832895; x=1768437695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrenqTp8E4tDkOgXs7eMnB0GiU20rX+sxdLI3fByfBk=;
        b=Q6g917d4IDtHMDQ5G996n5QYqHBRjRb64tmvY1AEFnp7n0CYkp1TbuDcDgdjrIuXrC
         aQ0Z7vaA+SUstSSzQs2Vpl12zitwH4zQUAR61IpiGKAwKBP18LmP6HRDVBa6ho+cSxgE
         bsCxaAd0xMCWEqtScTGTL6gmp0Bl0q5PdxeeRogg2OBhhbhyCWFR2em7rRDpu5lPtz6v
         YINjCwv6CSxNqwZTpWE2XL/Deg5vbayuZFNdEtJ6iEDYS0XxGcWsSXvb/ZmX6Npc6F4O
         hAY5gu0+KGv8ZR1SSJqm6WFCvJ+QP0bFpiAOf1M92Agfpua0kMKTcRhbMlvwJzLn6XVX
         z6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1WCKEXWv7ci5JD1lixWevFT1/n2zXHxPP+BZM2F3mXqFlYGJAkqIzw90O7cttK1SuSXIDyUaYZI9B3toXGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQY5VsZt4+rgj5Y01HnCaUjA6cuZrxZ4P8JPLUZ/6aCgZIBkPQ
	PUyCxmEZlRnSJHR5Sk4myor/hfDbsOfqsxkDw1gsV/gNgMERU2M27Dn7
X-Gm-Gg: AY/fxX6iSsrcnYBrKoFtKg35NB5zMTcocoheafigyyQ65sSKaCIQcCT8MQdGhqufUSL
	pbFxeWOf6TT+bH2PJx7bt5C5x8o5rNNZa4JXhMpTrElnkpLARKeROZUChH2Zz4yObSTsI+2/J/q
	L7b2q5F4q8xa4fTswiPCbiRck1zjseOKET6nydG2pTHaluoLEWfs0yyH7mlxqCfl00bZqPa+VJs
	ueVPFejzojnE+v2vIx5ltyWP/zmTv+OQo+AzvVOCyu9adsMyl8+jhfRAGIa0ER5v7AeIs+U0jjw
	xZlzTkaAIIKy5GeZlvuGgrkSO5ubcQDwW0Zjb4cqQ6IhspRkG6meGFLU82f8hoRdRzzksq0Bdq7
	QA5q2Yhto4OGSOIaG6mNiHRZTcq8RzdHuLTA3ns8j8RRIJ7IBSlV6un6wuHehxjAEMzzYWOEEat
	5k8I1Epn/kgufaW/Tetuh5lzJDPVdT79J7f/QP0IQfkQHbiQ==
X-Google-Smtp-Source: AGHT+IEnrEIlaG9p2xZXsCNaxYstFtQuumuk05m95Q+1JCx1iT0A6+p+K9E6BdjxZvhkaj4OdW4EFA==
X-Received: by 2002:a05:690e:1686:b0:644:60d9:8675 with SMTP id 956f58d0204a3-64716cbfa9fmr3525112d50.90.1767832894483;
        Wed, 07 Jan 2026 16:41:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d607sm2690822d50.12.2026.01.07.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:41:33 -0800 (PST)
Date: Wed, 7 Jan 2026 16:41:32 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aV79PDVBDEqxHlhK@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <99b6f3f7-4130-436a-bfef-3ef35832e02c@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b6f3f7-4130-436a-bfef-3ef35832e02c@redhat.com>

On Wed, Jan 07, 2026 at 10:47:56AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On 12/2/25 11:01 PM, Bobby Eshleman wrote:
> > On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> >> I still have some concern WRT the dynamic mode change after netns
> >> creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> >> see now. A tcp_child_ehash_entries-like model will avoid completely the
> >> issue, but I understand it would be a significant change over the
> >> current status.
> >>
> >> "Luckily" the merge window is on us and we have some time to discuss. Do
> >> you have a specific use-case for the ability to change the netns mode
> >> after creation?
> >>
> >> /P
> > 
> > I don't think there is a hard requirement that the mode be change-able
> > after creation. Though I'd love to avoid such a big change... or at
> > least leave unchanged as much of what we've already reviewed as
> > possible.
> > 
> > In the scheme of defining the mode at creation and following the
> > tcp_child_ehash_entries-ish model, what I'm imagining is:
> > - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> > - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
> >   number of times
> > 
> > - when a netns is created, the new netns mode is inherited from
> >   child_ns_mode, being assigned using something like:
> > 
> > 	  net->vsock.ns_mode =
> > 		get_net_ns_by_pid(current->pid)->child_ns_mode
> > 
> > - /proc/sys/net/vsock/ns_mode queries the current mode, returning
> >   "local" or "global", returning value of net->vsock.ns_mode
> > - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
> >   reject writes
> > 
> > Does that align with what you have in mind?
> Sorry for the latency. This fell of my radar while I still processed PW
> before EoY and afterwards I had some break.
> 
> Yes, the above aligns with what I suggested, and I think it should solve
> possible race-related concerns (but I haven't looked at the RFC).
> 
> /P
> 
> 

No worries, understandable! Thanks for the confirmation.

Best,
Bobby
