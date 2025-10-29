Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E72E7F07
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761708520; cv=none; b=Qkb7ujM9k3Ov2jVv3IDkHcVA6fudxxenyZqYsFKqF7TvAMjLf7OnSPpAiDWsFE7YA5IocoBNzyr6M3Rl5yl8LJG/vOuxJxUUT2/QT9xCSxPY8dxJkDbMUjFgMb+l2j24ZDhvdBaMLabFuscDR7tQOA0k1x34amcvpXhI6tJOloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761708520; c=relaxed/simple;
	bh=uK0Ge79ImFTTS7GqiWcbUy+z6bqmI9L8dyHzWiVaw7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKY3n3zII0s/HMPV2lfrqqYCvbtnBUFyZMW9zpNwWAl5qbss3lgh6onOXpR3UVh4YKPqt8dNChPsbJ93DVqMy8wZbh6pywNqIx+hYLQsBFAMXqh91xCTDxUo1UGPu7IMfqqthFvR2UB2lh929swJmLjFTTw1lfIma7gZRH6iIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNIXpTAz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNIXpTAz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33d896debe5so7472653a91.0
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 20:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761708518; x=1762313318; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=myjSnTBkH1I5KQfjqAoij4FYA0X2tqCwC7K0bbUx6vM=;
        b=QNIXpTAzs3ZeCENJzctpRgZLUHt2OGrRrSAaK/T6kW6LymPL/IFOqwjlzrowCjcPvO
         4TDaEebAuNXp63uBAUdZxX2ClRgkBK9TtZon0Fs5ATrHWthpG2NnFCcsefAOUszVJmk8
         w5RMM0sjdyVmptVFqfToRfWpELzeGI2F3opNQhvFRlKMiPsSpCVaQGBOJKyo1I3l2XFe
         uBHFMQpf8XkjHvXMSucQBJN7q2dNot7wRdvQn0MVb+427UNDo9vluU2NxQoDICcY6M6f
         GjJz6r+v4WyEEBepvp5MpVWxsdm43QSvepzkoSNspfc+YSBEhjX+7k+3ggG18AXXr1xr
         oFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761708518; x=1762313318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myjSnTBkH1I5KQfjqAoij4FYA0X2tqCwC7K0bbUx6vM=;
        b=oKteq2RBv3I72xrTtU8v/hI6NKLQQLfoT3Xl30C19dyP9XxA6ADDWERnpy3CJKyyK8
         LGr7LGJzbmxT+NB3jG+a95hEVMM+byTeZDxRdvE7qsZhYHo+Lhwrne9JfkEcFOTATphX
         lskxzCpyxbf36sUfFBcb3OT5HyyPKnR4USUdLRDACgSxZozEkbbyOg6onxj7cuhMtZ/0
         BzgK3F87ayATAb8W0Kv4mqfhelWOGKp2PWPKHvsMUHGXHTfKqaW+T7XwMhGQ4YN/2i7G
         c2f2Hi+zI9GUeXzDoHk9VI17eoQXHc3VFWvOawXltbBKAOIMmLtR1OG6sRZr1SxDYOfT
         zDlg==
X-Forwarded-Encrypted: i=1; AJvYcCUmEOhMGQPkfYvqLp2qjmRn0fotZHnV9lD+hm0OHVNTQmypwZsYd3KTzob0mUzKdUfSNrPVPNm4NT++D/N0hQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTZA5oeLSKRyYZhPCAFoX+JPqISuTUJoWPvcu2WKX78/+3R2h5
	+btuJJqsVAtllrdk8hmnifo+AQUiMxv+fqt8F5BE72I8AAXsYOx4DQIJ
X-Gm-Gg: ASbGncuIubPJvvLgqHb74FXgHaE940tVmbNvQDWf5HMTDO2hEsDdWWRg8zMy1UO0sOj
	/od14JfoU/XyryMiF29KQxz8KRy6dGSs5f0ni1ak7DOvbqQ4kuRiBuq7xt2uuhp/Uxod6sBkcPJ
	TtmmlMKOkY1ORk2I72nggSu6KGIhRBtwIziaUHPyU2SmeL9JtCMm/rFpIbtCpUaxNPtH4z3xJvj
	UAdbn728uCQ8iaivoFuvw9lF6pZkzhVRHfasiHWg+k5irpRLFRII5IKgRkoWlT4FDsct+dsLCx1
	V3Rc5TI5a5mcYThO4YrTG6mDtitm2/QauXofEGrgPe1wFNNH3E9GpNebeL96Bp68nAzIkFB1QIV
	hKe/g6NdMhwKomZm0/Khb0kJhNpE6TjSGl3FZgqq6E0qSy1PycS2gaqkHJg18eRtYBipdtD6vnr
	psC+lX4Mt/NBopzHCobdGBNhMkx4Pu+8vaahoZaLcl09EiVA==
X-Google-Smtp-Source: AGHT+IE+shhFrtBhmLuIBVFI3puPOu377u7uarNKu4E76VsuPFISVfuzPCA3UmXQVUS6K+bAe4aLCg==
X-Received: by 2002:a17:902:da85:b0:262:cd8c:bfa8 with SMTP id d9443c01a7336-294deed21abmr17081115ad.34.1761708517614;
        Tue, 28 Oct 2025 20:28:37 -0700 (PDT)
Received: from brajesh ([2401:4900:16aa:e584:a673:aa72:32da:dbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a7esm135335605ad.70.2025.10.28.20.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 20:28:37 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:58:30 +0530
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, virtio-fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Message-ID: <c7zugpb4pzquasx67zypnuk2irxvb7cp5puwuw3rncy6gb5wdn@qigavsewium3>
References: <20251028200311.40372-1-brajeshpatil11@gmail.com>
 <20251028200755.GJ6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028200755.GJ6174@frogsfrogsfrogs>

On Tue, Oct 28, 2025 at 01:07:55PM -0700, Darrick J. Wong wrote:
> On Wed, Oct 29, 2025 at 01:33:11AM +0530, Brajesh Patil wrote:
> > Add validation in virtio-fs to ensure the server follows the FUSE
> > protocol for response headers, addressing the existing TODO for
> > verifying protocol compliance.
> > 
> > Add checks for fuse_out_header to verify:
> >  - oh->unique matches req->in.h.unique
> >  - FUSE_INT_REQ_BIT is not set
> >  - error codes are valid
> >  - oh->len does not exceed the expected size
> > 
> > Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> > ---
> >  fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 6bc7c97b017d..52e8338bf436 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
> >  {
> >  	struct fuse_args *args;
> >  	struct fuse_args_pages *ap;
> > -	unsigned int len, i, thislen;
> > +	struct fuse_out_header *oh;
> > +	unsigned int len, i, thislen, expected_len = 0;
> >  	struct folio *folio;
> >  
> > -	/*
> > -	 * TODO verify that server properly follows FUSE protocol
> > -	 * (oh.uniq, oh.len)
> > -	 */
> > +	oh = &req->out.h;
> > +
> > +	if (oh->unique == 0)
> > +		pr_warn_once("notify through fuse-virtio-fs not supported");
> > +
> > +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
> > +		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
> > +				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);
> 
> Er... shouldn't these be rejecting the response somehow?  Instead of
> warning that something's amiss but continuing with known bad data?
> 
> --D
>

Right, continuing here is unsafe.

I plan to update the code so that in case of any header validation
failure (e.g. unique mismatch, invalid error, length mismatch), it
should skip copying data and jump directly to the section that marks
request as complete

Does this seem like a feasible approach?

> > +
> > +	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
> > +
> > +	if (oh->error <= -ERESTARTSYS || oh->error > 0)
> > +		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
> > +				    oh->error);
> > +
> >  	args = req->args;
> > +
> > +	for (i = 0; i < args->out_numargs; i++)
> > +		expected_len += args->out_args[i].size;
> > +
> > +	if (oh->len > sizeof(*oh) + expected_len)
> > +		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
> > +			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
> > +
> >  	copy_args_from_argbuf(args, req);
> >  
> >  	if (args->out_pages && args->page_zeroing) {
> > -- 
> > 2.43.0
> > 
> > 
