Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B1426EA3
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013167; cv=pass; b=cPKvRo7qzb6zWtLo7QfUNGTu4N3DGHFGj5gIfD7kBRnBxZ/YgQn6clRh+PGb0bcDJLYGAga56hlDyPCpvVCDZsu8QxQqOhG5cZOULdiiL8XkGW2FcffBIK6N/jWCDJ/XAX8iA/91gOwZ71uqC4qeH4oGGejnj9T814A6EjwO+vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013167; c=relaxed/simple;
	bh=nL5mmGZaBR0KGiW9ByLpesO5BFVlQS4oNBhk8WU8xmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5+ugZaTDYse6V3gDke94fur3lmKUQS4mokf93bSzBZnzcJ8orGOmlOQ0vyT41WpLAphjzoJm8R/fiRX7dXYXHxXV6S7cyBCfglAc4ODCD7d8kvsA7n7S52Xye/W4n2A3nG4vmzjEWFVMXRi/iWz8urBf44QGgKa9Hncafm5a6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=LDuQzvCM; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="LDuQzvCM"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e6e21c47e6so2444755a34.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 06:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781013165; cv=none;
        d=google.com; s=arc-20240605;
        b=Rs72pnBsPTOvbSn/INffj2tiN8JU+6g1uNmbLLnqX47O/JnD+w/+AZ6Vc+LxOfWfWM
         BokAi7+Xy124EzZSPx02My6XkiKmPrk99n9jvw0bvG3TcQZvi7xI+1T+yK4cO2NlGtbJ
         J2pfNvkVN7zy2sv4KYj+5yyMY9lYkr3JgONSYMKk1vhxnW3T0frfxSK/57Kw1F4XihLv
         nwT3+/k1kNYK7clzFFa6567bWX+o9M0Ps27T1oP+JdG6Tu6+Zcr9FglAACB0EhzL/EQf
         OteEdL4GjjonxSpdSAen8VcVOYFLXNeHg4vVtpIsD4xxhFGrlrroICmyGJiTxkPFj/KG
         zfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TPwTixStz0zU1NT3ncpNQzPruivDw+P8CqzY5CxuE/Q=;
        fh=1FpLaY1RfQg1dl63TFogs7i/b2xLVHma8loYNJDzPxc=;
        b=VoRlyteEVPV+GxlJ1v9AaAj152LHgzpb2quqULIAsONa4Kkx2EFMAlIhgHdg/jBu0z
         nLMboOkmI3Hv8ufxgZhcOrChtPyaYwW5eUmpEEX3puZrHfYsRDNAweFZP9mzvkyB8ps1
         F0MQ/Q9mLZ3V0vnMMjZJ1kxDyp9/WhQHnpyfTIoCq5YnUtygsB2AIUhBQwgfGTnOahLk
         YwHt/IDVqXNGzgn4RFUS2vZX9h8ni0F1Qko8+v3/kjqK2WMtC67qhX07frEJBo7GaMz4
         SOQjNE27o1UwcA+wbjXb+3rBr90wDrRfTbjx5CtHVsLZuz3RkCjZkAYb+wcVT3GFfLV0
         A3Xw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781013165; x=1781617965; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPwTixStz0zU1NT3ncpNQzPruivDw+P8CqzY5CxuE/Q=;
        b=LDuQzvCMgEwkeJsxUExkDvkUknj55FSbjE3n9k6EaEceMpBr0+shFEW3uPJq4QOPj1
         HEOlsJfcredM+Umt7RhfvGvKExjevl/l0zYYX9u4UDyM9fUeyLD9vi1yFC4aPDJ2ekGb
         cFja15dXb3u4RZYZCNyjWrkLFvqUBmlIk7q+SBkoKANOTiNeVio0TdxdGsPUMO7bl6MM
         gXMYqEZsyNVWSxVm7YNSUATR0ZgFDKzNs+QDz8IE1QJEoPAz4QLxnbSs1apjaHjGvvV0
         1hDwFcl3gog1ejrU93PZ6dpU2GxXFn6v00bCtAsI52kNogcGnO/uX2AYKCSPq+Ogv4ca
         geiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013165; x=1781617965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPwTixStz0zU1NT3ncpNQzPruivDw+P8CqzY5CxuE/Q=;
        b=myfQZTyDuJJiG3mPWBcjHqLCDF6zz6FDa3K4z/sf3BoJkuws3LLZ9I3GzhHbp/UKFh
         +1Rz3Dd38DEG7IxFQWF6hsuoNF0TjQj1OetOoVmjFppWCbE7KhJ9p8L7f+SKKygGaIu/
         xv+qHuFnPlCw7e5CgKu3cOxulT3D3GbXGfkqsaDYwa2Me5QxLJbTF5GRJv1T85WJ7lG6
         flH4KH3BpbWHRks5OYpQ0PhJC7xoZaDsAhLFBZgkrtGmEZQN6sbi5YCooiF9ydrFqlOB
         iuxLTg49tWfh9Yp1B6m3DLE4LdCC8gXZ2FSsawge+LODfMgacoP6s9f5y1Dfr486oyzZ
         LCbw==
X-Forwarded-Encrypted: i=1; AFNElJ+/qYH4cJsA/UzUMYTRA1oy+USY/xR9nP0GWW+83mzYQIpZAmDNwFa2Wv//UfZAwK+pbrgEVr2MHBZWBcipvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+X/xo6CB2fOrmiS3cwDerKAH3jl4v2Sxmb37ozsF5adQIBJuy
	chP6IIuSi1gqUKwmuMVSiM97snwAzMxJFF+2w2WMeNMoi/VfE1ldglvvaEIBtPiXDQp5UuIKNmm
	mcYyT/Ztr1IlY5Tdwp08/VpOwAlsh9zTsYisl2SKx
X-Gm-Gg: Acq92OFJ3zIgjcpSi2oOO2vsvlYjKRHxRyzhJ/xtCg98iaQfhGEntHiXeLQ8du2i2fo
	A5i0byY6DdY2vX9NvbuC14Er6mq9E7dYqnGRjzqH2RVuMWoBjtM0nAG9nDnkdAjngRxqXqHp5Ku
	jSU1wSqVsDKl7lTiYDY4/ad9UtbhgQF+h2VcpnyTRk2274GV0FpM2qqU1XausXqdHTYa1T5iqpK
	pxJdHxi79311yge2T81ob5NtWfbMIUaqoN7VwWRpiwefuRrFxaaRLbcBMLQz4L18PfeCtkXVj2m
	+nr+3kZx+tZSWBSVCohWNXW891b8+X1RB/7XbVNsj1lR/Ghu
X-Received: by 2002:a05:6820:83d8:10b0:69b:5486:e85 with SMTP id
 006d021491bc7-69e68c19e38mr8248758eaf.36.1781013164660; Tue, 09 Jun 2026
 06:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260607143608.76122-1-gavin.li@samsara.com> <20260608174435.62359-1-gavin.li@samsara.com>
 <ae754hwynvlfnuway2jdjuebyammfrz225pxymfhuqpusp4xkp@joyqrrkberpc>
In-Reply-To: <ae754hwynvlfnuway2jdjuebyammfrz225pxymfhuqpusp4xkp@joyqrrkberpc>
From: Gavin Li <gavin.li@samsara.com>
Date: Tue, 9 Jun 2026 09:52:33 -0400
X-Gm-Features: AVVi8CfBHfQw5II0WmIUH72AfGIkRVcNlAUwEU5ehCyFP8GxD9ZsZTPnT_N1E80
Message-ID: <CAKvMnUVZEnH3z-dVmCLgP0cFTjuYCcfaXhOOOy9KNG6kh-RdhA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, Viresh!

On Tue, Jun 9, 2026 at 3:35=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:

> Maybe move the comment above the code ? Can be dropped too.
>
> Also, maybe there is a small race here, not sure. What if the other
> side (polls and) processes the message as soon as it is added to the
> queue with virtqueue_add_sgs() ? In that case virtio_i2c_msg_done()
> will call complete (which won't harm) and kref_put(). If this happens
> for the first req of the xfer, it may end up freeing the xfer while
> being used here ?

Good eye, thanks for the catch. Moved kref_get() to
before virtqueue_add_sgs()

> > -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> > -                                 struct virtio_i2c_req *reqs,
> > -                                 struct i2c_msg *msgs, int num)
> > +static int virtio_i2c_complete_reqs(struct virtio_i2c_xfer *xfer)
>
> Maybe rename to complete_xfer now ?

Done

> > -             if (!failed) {
> > -                     if (wait_for_completion_interruptible(&req->compl=
etion))
> > -                             failed =3D true;
> > -                     else if (req->in_hdr.status !=3D VIRTIO_I2C_MSG_O=
K)
> > -                             failed =3D true;
> > -                     else
> > -                             j++;
> > +             if (wait_for_completion_killable(&req->completion)) {
>
> Maybe do this in a separate patch ?

Good idea, reverted to wait_for_completion_interruptible()

> > -     return j;
> > +     return fail_index >=3D 0 ? fail_index : xfer->num; /* number of s=
uccessful transactions */
>
> If this comment is required, maybe add it above the line instead.

Done
