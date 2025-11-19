Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916F288C3D
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544750; cv=none; b=Gn4jaa1R9MCgFAGFAAfBUKspAzBOV0Vix6EFAxuVjojUTqs4Ago2bXsug/jW9YHaQysI/Y8GgHtCPad4qxT2bJ+uwq5ZAchfjLrIxSONTlTy84rOF4EfFPMXqOJtRrC5qbCHoOc/GvKcFoiUTQP9rmcUmlNLhobBA2Ilv+o6QrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544750; c=relaxed/simple;
	bh=qizVz6OAcBZcQieJwh1wMupucYYktFUPSKA2A7lNaPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SGysSzJ9puYPNXQSbY4TMUJ5hHDO0I+Y0zDm4vA1blGroZU/JjN3hnnh7Q0wgVt96j8um4rXjJAWcApWMmK8yVZT3ERflIWz0Wb3KHUJOwxEjW7L5Ty3QbHf/53ydP4jZlS99mg6FxwOhbZhmglxyo4+xCuoW9jc9R2X4lGUl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYV7eUqF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYV7eUqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763544747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM8az3zDOpq2LCQxVENo4XqPwFjRB0EfFmjl8t0ORVI=;
	b=YYV7eUqF6TuFU9Ml8kjk5Bnf6778Xl0ICWaVbuoz5ZQYXMngNoSfiKIlScQRsuLb/n0ynF
	7kGyz3v0BR1u3O1mes743MFQ3zjeV2SqWnFL6hlRk3UMfUvMoCYmBDGU7b3HwwTzSZwXYX
	cqkIU/SB8cx4D9FKC6RS7zLxODSGZU8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-Ohh3ZIOTOuu2auubWEsaNg-1; Wed, 19 Nov 2025 04:32:26 -0500
X-MC-Unique: Ohh3ZIOTOuu2auubWEsaNg-1
X-Mimecast-MFC-AGG-ID: Ohh3ZIOTOuu2auubWEsaNg_1763544745
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429cce847c4so2893944f8f.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 01:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763544745; x=1764149545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM8az3zDOpq2LCQxVENo4XqPwFjRB0EfFmjl8t0ORVI=;
        b=W3aFOnoOm/aKbUXOccSkHNeNCcOZqUTNHgJ8/iVLkFkjnkHfh5OIABM+CPk179hS08
         XXi4p94sUB5DuENLIsnymH95IWVr1HFFKeO9LxrnL0qe7v4JvgDk0CLLtEaXtIBQW74t
         4HK77zpWLRvaEtStnSbHmfftK2fxF6ybtbdpp120gm6h1HghsBph/KyT889gr3Xvp3eb
         5QZtX0Kp3v7dXQd/Up/Nw19+GJXP3jeguU8Nxs7SufQQ5f5jIbWLYxdgxfBRvTrIon2t
         TvJxtpGs0L+MKXbLGGVDbOfjfQ7BuJDRb+ov+PgTRRuz14wtbT1cMGHJEOmVU7b61PzI
         ztDA==
X-Forwarded-Encrypted: i=1; AJvYcCUDFARPs0wjjmm3FIZY7d+xXscZaa0X1MFv9jL8G2a502Ub57OKAu0XrfU3C1TwOsj5KdwOxIHdV/YcXW/5Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3NfRoPgdpezKOPqtlMO90nMn4JOwmR83ur0vrpHR0pCuB7MSC
	5wRGMaFag/DSmDOF64q9vH2V/QouQpekgpKtZGPhyTPiGJjp4BCXvDxiUchuPqaWV+S69n5OClI
	fgxAWqHI0p7LQWErHNsdNQWmJtibXINOKwy3X26kF4CXEE6CqKGnwtBMcGHEN3EPT45Ru
X-Gm-Gg: ASbGncsA4O4oOjVyIwdWa90Y/rKCRwmYdPCDDcL8RWbuYcRpMiB9/kE0TA3c6xSG05x
	YgIqBoEO9sTn6wyGAoA2x+YizGGvFw54IeCfZSeGwD2XL5mjKeWB2JH+Fe6kdQFM26VJO/BU03p
	lCjwDZPoqZw4Zq+Q4IAZ7U/2d2lEFs8j4FQ1zL9raOhVWzrWOa9JKFl4ixvSkQXBeykMa3hP6Ad
	l5R0HK6HqolFlY6lHk6eQO+cSuUYOAd/b2J5VLQ0BHyh3qJwerNo1JktvsKUTZx48cQjpPZssfY
	pdPbtZSXQFskykJmO9o2pWhsQ3HTgWlgn/SLh5FK3ANJg72xmlbpWs+7vfchjExKbuRcSEX5eCn
	KSONNtCZ+JSWTxeJeCLzmouKMaEbqnw==
X-Received: by 2002:a05:600c:220a:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-4778fe96332mr108074305e9.25.1763544744674;
        Wed, 19 Nov 2025 01:32:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR9qYc95hO7ZwtANedSKv32drmVFqTL5gKNj7ei4Cx41gIKQhcQaLvGhlq+dXyA0tMeXvXhw==
X-Received: by 2002:a05:600c:220a:b0:477:63b5:6f76 with SMTP id 5b1f17b1804b1-4778fe96332mr108074055e9.25.1763544744035;
        Wed, 19 Nov 2025 01:32:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a96aa472sm40401155e9.0.2025.11.19.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 01:32:23 -0800 (PST)
Date: Wed, 19 Nov 2025 04:32:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
Message-ID: <20251119042923-mutt-send-email-mst@kernel.org>
References: <20251113115558.1277981-1-eperezma@redhat.com>
 <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
 <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
 <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
 <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com>
 <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4z44cRUU7taYBClLLURxo27nuTY1MGSU7SqV3g0FHKU_1763544745
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 10:26:43AM +0100, Eugenio Perez Martin wrote:
> > But this is not the logic that is
> > implemented in this patch as there's no synchronize_rcu() in the
> > vduse_set_group_asid_nomsg().
> 
> We only set the pointer on the writer's side, we do nothing like
> freeing resources. Should we set the pointer before or after
> syncrhonize_rcu()?

synchronize_rcu is called after writer makes it's changes.

> What do we need to do on the other side of
> syncrhonize_rcu()?

Presumably, return so the caller knows the as has been updated.

However, user-triggerable synchronize_rcu() is almost always a bug.

If that's what is going on, you want srcu.


-- 
MST

