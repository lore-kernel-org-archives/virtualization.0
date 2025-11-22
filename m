Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BE238C03
	for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763823434; cv=none; b=ENyEv9oDfC0tKcpa5k1vAUGDAqkmVOe9Y+/fVmRTr1/QJ8SatTXgPkwUpfvLBrEHRVytjvdap1KsuhnRlXMuKeap3sK2LTVAuv+16sSNzi9E9jxDyr7z4brLWJiKPivXtNBHGwDmSInKgRy7slyHSgbH5PaPiCmojFVjGgigYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763823434; c=relaxed/simple;
	bh=hFzOPcepuM2226lVzyXCQ+m40VlkuCq0KyoZ7KBoHiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2H4l6drgnBLtM88wJbVJ1z9AT0SLVAG2YRCUjx/8RS6m3jX2VqHwsZeRR2Bs8ns079QBrXwWtFnH4zybOp1RhDZoN2jlzS5Re1feTi7HmAbEl+7zcKAwvRqg4RLHo6d3PD8fDYXYVr2GqTDMHeJNy6ehAqZajDqHPjrIEd0zhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ww+pl2V8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ww+pl2V8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763823431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AoeYwuTA2OCKqGileGsNd+ysqL+d5N6ZH/jsAbQy4b0=;
	b=Ww+pl2V8p/Ei8G2LzFV0Deobf6rlBBVDxLzff6He1jfpnj1M04DKWVfZQ+XqvRbOlZmz8t
	kFxRioFV+A5LnAWmYpehcfFaoxVPGIGVPu3qfIfviRNQhDPPwrdEm5NP+R5X1ZzY9CuqgT
	8rhuzLn6Usy+xBddmA8twGr0aR66cNY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-UBs7VvDyOdygb73aJTHZIw-1; Sat, 22 Nov 2025 09:57:09 -0500
X-MC-Unique: UBs7VvDyOdygb73aJTHZIw-1
X-Mimecast-MFC-AGG-ID: UBs7VvDyOdygb73aJTHZIw_1763823429
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-640dd6e322cso4748603d50.3
        for <virtualization@lists.linux.dev>; Sat, 22 Nov 2025 06:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763823429; x=1764428229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AoeYwuTA2OCKqGileGsNd+ysqL+d5N6ZH/jsAbQy4b0=;
        b=PibihUgdPkdQDWSDLcHtow3+p+wRKQebOMkJYS7+IWEcWChISadBk8ygMSdjlRLvfd
         boeB2D3/Y24YUHXt1GYMXFwzeZ2bCpG8iw5eGIxzO6pQStlekZayusaO1o0sAWj4ffoQ
         etUT+0/PfrhqiVCyp+I3P8HOasHqolcRXOdoY7MndISftog69fCsFtm5GK7bGj3uQUIv
         FPc5ztL/96zcYKAjfwoDH8aCFE9l0x7URvJqNvN+BGRLLig/w/r1FRao0vQ2hPcvBGZq
         z/8vsPf9qFWQcZt/925zdOcJB6sgqIudrM/Da0GvciPVwXkzylSflQxmpxga3apFVtKf
         9+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbWvHUxPB4jYemhH5wT7v1yG2nK3WyQWL4b1ZSpfuS+U4OofN+iqqBCv6csVpR1V85xuq5FMMFd/HjDK4rA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYNBAumAk3alwaG5j8wn1CXka6DJrfdmSUPiRQYQcAHeYToC6a
	ClmfrQ3jyGCbiPuAkhFV45isNPtjExwOGSy/kdXjiBqOe7370VkSMXyri2y0hnxMfHHLpxVEGcW
	z/F5D3KpKHF68mReNTWB5LdZ79Rjs4Ohe5Hu4hswIi3XvqK3CZYUNk6RSosdQYslWKA7DB2Sh63
	4CXsfEf4IAiTLk8eaotcsuSCTA6UfwJTR5kGkIVH96hMM=
X-Gm-Gg: ASbGncsKFgnAU/1ucp6jkXEbuTpGPQpsxE4KmCnwVU/bS4Po+h/zrWr3UcpP+J7AW0I
	0FMsG+z07DDWa06CIAS7/azLtbrPW27E5mdGOiHbnl37Bs8GtMmWjAb/QV8UjdYgoQx6pCXmj1Y
	q9SuSLhxGuOoMzL07pPRNlxuHzfg13taNyAITqYljb+1VIHa8dxS3IR22vEsFech4O
X-Received: by 2002:a05:690e:1511:b0:63f:a324:bbf3 with SMTP id 956f58d0204a3-64302ab18damr4335096d50.42.1763823429380;
        Sat, 22 Nov 2025 06:57:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJA7IrsaRMoz4Q/MV8XxAm6kxOszSooFbnuk2I2D2sSCVAvxGo1WW7Hp8NfZ+CGh7b65wTnbGGciN5n9h/Z58=
X-Received: by 2002:a05:690e:1511:b0:63f:a324:bbf3 with SMTP id
 956f58d0204a3-64302ab18damr4335087d50.42.1763823429039; Sat, 22 Nov 2025
 06:57:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSEvg8z9qxSwJmZn@fedora> <CANubcdULTQo5jF7hGSWFqXw6v5DhEg=316iFNipMbsyz64aneg@mail.gmail.com>
 <aSGmBAP0BA_2D3Po@fedora>
In-Reply-To: <aSGmBAP0BA_2D3Po@fedora>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 22 Nov 2025 15:56:58 +0100
X-Gm-Features: AWmQ_bkhaeO27ks2qTqUvx9zYAyPvR45fmibJyAeax_P7fjCjfN3MMivydMdvis
Message-ID: <CAHc6FU7+riVQBX7L2uk64A355rF+DfQ6xhP425ruQ76d_SDPGA@mail.gmail.com>
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain Handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Stephen Zhang <starzhangzsd@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K-jrA8abX4hJDhNZEsO9S6Un_j5Na7cVeKkzixjftPM_1763823429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 1:07=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
> > static void bio_chain_endio(struct bio *bio)
> > {
> >         bio_endio(__bio_chain_endio(bio));
> > }
>
> bio_chain_endio() never gets called really, which can be thought as `flag=
`,

That's probably where this stops being relevant for the problem
reported by Stephen Zhang.

> and it should have been defined as `WARN_ON_ONCE(1);` for not confusing p=
eople.

But shouldn't bio_chain_endio() still be fixed to do the right thing
if called directly, or alternatively, just BUG()? Warning and still
doing the wrong thing seems a bit bizarre.

I also see direct bi_end_io calls in erofs_fileio_ki_complete(),
erofs_fscache_bio_endio(), and erofs_fscache_submit_bio(), so those
are at least confusing.

Thanks,
Andreas

