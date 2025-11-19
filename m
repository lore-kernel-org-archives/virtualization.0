Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F835BDC9
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555409; cv=none; b=rtXuGTuGazvGRXjQ26heyfG6HLX+tf4+KqfNDkExP5jOXue8IePqAkVvDM9GfFFIfv3b56p/KPYQNU1Yy6IZ18HDrYv91KPhiQi7flEKISeIUMlv9wNnLaLdNiNcGAq7t/Pfd20PpwcVRK1F9YbI4vYb9n0ynz3MCjVFHONkf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555409; c=relaxed/simple;
	bh=B9Hd45HezP2oyNR1nvgyt+XG2H3dwGTxC4mYxN9sC/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YenNPqAtM10jD1UdaqSj7UsuLpIKopSnAM3mX0Z7B5fQoc0TGPxLR9WI8w0oyTXHRaVBbthRhOlwIZ4ASPpDuGLDbd/lBiEs0W4SHG1zxeRa1zRQ3aS825vNRNvAaV/PDAN4A1UTb1uHqppAYyCJuLjIjdQer6d7NtAy9ojyh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBgVHF/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBgVHF/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763555405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18z3Rp/qSfSuoAWshJjuMwA1IwB2JmsxvWb+k0pXveI=;
	b=EBgVHF/lzG/tmd8Zk8PMk6B3AsdeIcDEKwMOE+FlsJtUzwUxXyofMcNWJM8fjSK7R/mW2w
	47PmTjGSc9bsVG5HqBJyLQ4wg8OlLVoQfDPq66wRF/oyUFfXHhYelYVB8Fmxbz6m0RJSnn
	Cm1E3OxlQiGQroTCNJ8ZvvnmO4XPE90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-blu77EUTPyu46Hp3HeuZqA-1; Wed, 19 Nov 2025 07:30:04 -0500
X-MC-Unique: blu77EUTPyu46Hp3HeuZqA-1
X-Mimecast-MFC-AGG-ID: blu77EUTPyu46Hp3HeuZqA_1763555403
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47106a388cfso42663375e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 04:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555403; x=1764160203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18z3Rp/qSfSuoAWshJjuMwA1IwB2JmsxvWb+k0pXveI=;
        b=jwiT611zLZQUiMCTaSNVTzVCRuu53ofefCgC8p4HqIYGJNEJcFswY2B9q8KNwOi9lk
         SO+bWBDSB4CPN5Yc27foma+HiGl0KhG0fVfWvlmeyyYyWLPvSFXDNcjaSs7tn/f/XZwg
         dX+fYh6j6KN0m/Q1K11arN2be9fBG/iHFzT3hi/yPM2m4KI3rrnfbpXcvstKOYUzTMOu
         IdE3ZKiYJgdNSExKQkvlZyMogESGpm/oAoelyRNunSh72snhJsJ1DEph+ae1jVuxElBH
         3hiBFiaDj0oeyOeESDGiCeaLMivLRTh+DqT4Xl+yTUfyz0iMgHzFq2Dmwwzj8PyR9uxq
         x5mw==
X-Forwarded-Encrypted: i=1; AJvYcCUF5SJIHGNtI3ymi0lyV8jjaUbsj66Lm22s3WUHOwV7zdmLnDzkGjDtdCulp3eR77jP0KKDSJaJdJnBAHa3uA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj4Cxa4xJEN89j3aaQi2mfXbXxUOUiCmttz32TRWcE7mUXCHL5
	MqyvbZx1nbWTk2R3dh3YCo07xp9M4OW1l2b92yfdwZE59+BfQCNFrlYu58/n9AYrkQDd3/9+988
	jHmvs6pDEtkbdS8Hh1aYRhO7ezMcXlsK419iY14/C6ivF5cmcZNV6/7CfOJK2+NCje85tTo3bSU
	aq
X-Gm-Gg: ASbGncsjhoUjerJWaIwtbph6rUJwlYjXzDpdPAaUnzFjSxhDwGPYtkJJ4mP7ONeoDkf
	bBMYVJS/GKU6FF82h2bqAsa1gkWojiCO5IUAuahuH5LcHHJklIH/BEwMp2lTMlkXVZaOLIJiSEx
	c88e4iQSmw8gFCei+YuOQvURHupMub6NW76Eu2kGfUyJ96igLQ7HaQUmmAT50mMgctDtBfHELS9
	+kzAR+lg7mfgizMRb9B9ZeYE+eC/Ap79NHZRgj1PeflLZkmR/jtXbxcSL8gxv/DiL0F1VQ1QVyz
	gqbDOTZjWg1uQCaSCww2BSfwStcZNDLo9mfwbMbosMmxAyga+wZvlALCADtQvG0mN+/YJYPMGlx
	j9SWDSWKGNgxFJ6vdjml310/n+E+37w==
X-Received: by 2002:a05:600c:4594:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-4778fe9b281mr195112465e9.23.1763555402919;
        Wed, 19 Nov 2025 04:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxlqO5Fv/NfwlSqVNAM5or6LYkWN8dNS3H2JehIcMpwsjRD2voPi/TWaWzWNKn0QKk1a/cKw==
X-Received: by 2002:a05:600c:4594:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-4778fe9b281mr195111965e9.23.1763555402467;
        Wed, 19 Nov 2025 04:30:02 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10173a3sm43844595e9.5.2025.11.19.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:30:01 -0800 (PST)
Date: Wed, 19 Nov 2025 07:29:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
Message-ID: <20251119072555-mutt-send-email-mst@kernel.org>
References: <20251113115558.1277981-1-eperezma@redhat.com>
 <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
 <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
 <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
 <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com>
 <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
 <20251119042923-mutt-send-email-mst@kernel.org>
 <CAJaqyWeAoVzmWaAwcK9kjj=3VuRmYc1fco7a1ausXB=z-0oK=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeAoVzmWaAwcK9kjj=3VuRmYc1fco7a1ausXB=z-0oK=w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v4v2-KJ9_tnA3EXabfRnn0y8WGtg0LiRXVtAM31Lz8w_1763555403
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 19, 2025 at 11:38:32AM +0100, Eugenio Perez Martin wrote:
> On Wed, Nov 19, 2025 at 10:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Nov 19, 2025 at 10:26:43AM +0100, Eugenio Perez Martin wrote:
> > > > But this is not the logic that is
> > > > implemented in this patch as there's no synchronize_rcu() in the
> > > > vduse_set_group_asid_nomsg().
> > >
> > > We only set the pointer on the writer's side, we do nothing like
> > > freeing resources. Should we set the pointer before or after
> > > syncrhonize_rcu()?
> >
> > synchronize_rcu is called after writer makes it's changes.
> >
> > > What do we need to do on the other side of
> > > syncrhonize_rcu()?
> >
> > Presumably, return so the caller knows the as has been updated.
> >
> 
> I'm happy to add the syncrhonize_rcu() just in case, but the caller of
> vduse_set_group_asid_nomsg does not need to know that the reader has
> been updated.
> 
> The first caller is vduse_dev_reset which has its own way to avoid
> being called while vqs are being processed. In particular, it reset
> their addresses which is way more dangerous. I could call it with
> dev->rwsem down though.
> 
> The second one is set_group_asid vdpa callback which is called from
> the ioctl itself.

This one for sure needs to know that after ioctl completed
the new AS is in use.

> Moreover, rcu_assign_pointer is WRITE_ONCE by itself so we know all
> the readers will get the new value after it.


No we don't. The words "after it" do not have a meaning on an SMP
system. The only way to know that another CPU sees a value
is to synchronize with it.


> So what's the value of
> explicitly waiting for all the readers to finalize their DMA operation?


Read Documentation/memory-barriers.txt
If still unclear, read it again ))

> I'd understand if we need to do modifications or memory management in
> the now unused ASID, but that's not the case here.
> 
> > However, user-triggerable synchronize_rcu() is almost always a bug.
> >
> > If that's what is going on, you want srcu.
> >
> 
> I did not know about it, thanks! but I think all the code that can
> sleep is out of the RCU critical sections now, isn't it?


what I tried to say is that if triggering synchronize_rcu from userspace
is a problem, srcu is one solution.


