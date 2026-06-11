Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012C3BCD0D
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170166; cv=pass; b=BT8APmkaIs5xlV5O5/ms/OoJ2n6GKHWxzKJS32gjF6KfEXd+vnOFj1DHdkeeDgamk0bDDLar6CrKiJq7jHSZaTGAWm49gg11/185xja98VsO+yvXzCt/97K8UNDTOzbswY5K9AV8Wsl7YPFNxtonsfYrfFGlR4fu5xDGAxwEXOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170166; c=relaxed/simple;
	bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4Wx9A7PC4ICW0mGCGmOqaONjl9xMa0b3kQiCqbzkN7CedjhXwaaKYRPVxHs6SG7pFwCBOQcKfDgQ6XEjqdkdbM715CnZtu4ex5Fs9l8b3NP3bARg47zX9prvIO9634bmarl6ix0VrFaIbgmkVyMKxL+n59hGRv6fWihrGK/3kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=g+cflWxX; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g+cflWxX"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176ca6bab1so9690501cf.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781170164; cv=none;
        d=google.com; s=arc-20240605;
        b=FlsAj8YHbcReUymFwOyxgW8lBXkqeCAoVzlaxLm5SAv0eIJoaWHDke0ver0zdWCKk+
         XzXvNvVhQe1nyojcw8K85NR0/kDTJAd5oho6h4RKYdvEfPl+omCsPk+6ratJqktUqOHA
         6ezGKOK2CagxogY2+w5oJYQnP8HVGv+Ko1qPpjW6iWYXP1jd65s2/LJXR0oQiOwjTV6V
         p0WPrD6Jtc2L1borLEoiDCY37khn23iWC2UtSEsICK3yLFRbRNEiK3FUmamI2S1E9S9A
         F5EcoPmkiaeAgJIm3Q2fTJwBSuknjYJeA2naxktCqPPe9jf55RIjd834eKhtokIbyfmG
         pIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
        fh=7ZIkNrdXzsp2DCV5LYCH0qmxPyAmsFWk5GDEirOZppw=;
        b=QhxkijFp1D9nQR+3sAN3Ee1TR9TeixU8pWHCD4atY78u8e+q7/k2yG9l2s1TTvoDeM
         6/+RKbL2HG7Rm1sY6+tD6wjdNLmUtxmJYrc5tXIq6m3vaPeT2jHfMYw9slOrGMqUp/Sw
         s+6+emXdtyvNZbXJY/B6kAQIlKh3CzmwK4+yCfgc9ZIvID7g9A53mck93X6JlLtUAp2c
         WGjWXkRdAjS5YcbPZTqzQmoKecPvwd5uNz/Oy+/5RdRVlXU4I9lPx3Ok8Mz7D8Dddks7
         gb+e4G1+XsZ3kDkyxb9m64brDQ3Ab7f5bbrmjW1L9jb3itp61/hVIPYcA9/UW56F30qq
         BY4Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781170164; x=1781774964; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
        b=g+cflWxXN/BX8qxS35t5jGWOM9h770wmWpNsxqxxTrw4bFr2JcN7F+e4WGqbONO39s
         hG6zr+w3JZyTEo3QdWH0xc1h8kNWbyWUA1D02lu0NGWon64HrfsD29w/o2ph8oW9d8We
         qUtt321cHwtFSFErjYzeeZLScSPCzL6fJw7nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170164; x=1781774964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgIN2i8cK5yBqIrKoTv7yZ634l42ulLRdn9aAMoBcT0=;
        b=D7ENPPrv1N4JSP+BiirBKOflVY5yaiSFgQ0E/1HXuECE79DA7m8dxYTOkQf/Tgj8IH
         +l5NAvwxbKY015oJr2mf/EHlajUt/eIhsbt0FdXMShrY9sQWH6scX20AGcOphEMGBrmi
         8Fw9f+SdJ7hZwRlgutNiUQmgI8W+kPu4quUJ24hRtKHetVhGR/RaML/023Tvc7aRIchj
         RnYgeRATRnLGOjUAvINtJ3TW+p9KKkDjGqLmZxCFTgWDxm83QxGtsz7BkzNdUW5FLjmj
         aK0B5cLffnapCceF8YHODdLrxDpiuozIEd9bpW1jlxdZ6eEMguDdHMCcpE6wgjCI3pGa
         17EQ==
X-Forwarded-Encrypted: i=1; AFNElJ+gS8mH/ZnFnvd/7zYaI1nTMpp5syLof72D/Azho+I1GRqqOe5gXU7yWqPnBfaLwZ4Ko2TVDmAtG9QFttDq5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSySkGi3kim/0mx8RJuRB8Ti0aTVl74tLENMqR3ooKyxfjLVgX
	2J9gvWNef0Lu0QZawWC8bORnpUd7ZRdr/Hffl+XJcxvmdpdbuvoSQH/eYIJhUprFNbOfk04dLsH
	o45DuiBj8O7GpNU1x446WtXGTb2NAYsVdgBDxW1dFzw==
X-Gm-Gg: Acq92OE3llxmfv7ifI/FD1cjt7be18OOtRHZ4unD7Ioyz6u07tiOcHEF4VVsyfCDR8f
	DwN+7EkDul7w6jyn0sXlBrjKinfvZ/hg0QLkwlMfJMaFke5C6kOVYAjlaf42WTRo3KU24UeE7UA
	pDtrmvQg+BBWGhoGAp6GlE4gP/t1mcriihUzqUPcsXLNc6ba/FFL2YotWDghjjwR4ysV2LGJRME
	c+kFsDGGe3z9Brqdu7DH4A7eY5uyVyItvFdfvcKBY2K4H3+8GQezvHU75CTB0GMQsFCfS5e61z8
	tszn9mrPXmq5QMCZHXsvrIjS3YPiYufIzNYDT0XNhFx+fck9NQw=
X-Received: by 2002:a05:622a:2513:b0:516:ca56:a44d with SMTP id
 d75a77b69052e-517eefade6fmr19793901cf.6.1781170163781; Thu, 11 Jun 2026
 02:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260402104407.11495-1-liwang@kylinos.cn>
In-Reply-To: <20260402104407.11495-1-liwang@kylinos.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 11:29:12 +0200
X-Gm-Features: AVVi8Cen8jzh4k-FyeRSFJBfNV9EUv7MDTwdvrFmM1KWWYcpiJldXe6uBNuaZ6A
Message-ID: <CAJfpegs8v6a9D1zWsNY7pX_Zx1wgjGvoEFS6hkk+qE2iDQptZw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virtiofs: hiprio FORGET robustness and no-reply
 request completion
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 12:45, Li Wang <liwang@kylinos.cn> wrote:
>
> This series fixes virtiofs completion for FUSE requests that do not use a
> reply descriptor, tightens hiprio FORGET handling when virtqueue submission
> fails transiently, and prevents the hiprio worker from stalling when one
> FORGET must be dropped after an unrecoverable error.

Can someone from the virtiofs team please review this?

Thanks,
Miklos
