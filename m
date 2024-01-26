Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83556225A5
	for <virtualization@lists.linux.dev>; Fri, 26 Jan 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298170; cv=none; b=iRuEduGtttp/1AYtYFLv/YUenpHdL8fzxYg3RGwQpK4buYDi+0tLES8U9Bh3nPX0hAq94xDAlAlCnREefk3Wzye7NKNZsGMOBOlVWvdQSZv54rM43yQEC8ARGI5Z1jSN1rtkygW8VIMNauFliZXyTjj5irCktP+AooJalbWpI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298170; c=relaxed/simple;
	bh=l+Dvtec0Umm6fy+Pe70Xk2fhp3AdoGWxoMdBqZkcrNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHOF+XIochwX7nlt0Jx2xwXWW7+/VHb9STV1tXxG737TvCd4G8LSBrHCiuFGhc5XgAP0y17hN8IvIEln/TgqiMBRkvzTVI5/qC3NSF7fzXqbaDmiSq65EaTLLzxmw0DUX65Mj4Roy6s2mGwcXLx+f7llJLiLWjbGE/FdTpqAUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XpkiwDCC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XpkiwDCC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d7431e702dso6697105ad.1
        for <virtualization@lists.linux.dev>; Fri, 26 Jan 2024 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706298168; x=1706902968; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5DMkPLX96PHJXiX9+65dx4WF+ILk2GGzs/YrGWKt/0o=;
        b=XpkiwDCC6Bk7QGadPSBSLUIjBhA4u05U/4ko/ygBe/SMeysNv9PF+qMx+7uhNnXCHY
         gsKUSEmgt2nHgEk0WXU7oqiHTRvQ/9tlOfBM5om2ZdribRuiRxdpDHdeKQC2rD/lDZnn
         qolQIzoGUeTgABcUHhV/LlBtFtXhrHZdsyKv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706298168; x=1706902968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DMkPLX96PHJXiX9+65dx4WF+ILk2GGzs/YrGWKt/0o=;
        b=UJh4rA7King2r6upODsApbaf9ZDC5nF9Bz1ycG+nF8kRmAmEeXaHbs36PXTWyQUtZK
         /Et8bEK3sVg+N4WvPqO9tac1x4zPNJinKTrgr28L5qiQ07L4IetREhyZKpHljSGXFzfW
         U/LKDRlpqxHbIVIoyq2iZiVj49YLBHPm7+cHtg85vT/LX15lBex+jRnRYlWf7e7PmXfu
         3WRoE73NLuBGiwDVemDH80gm9VHhNnwR91h4nymEkOkMEmQwKXRV82OIb5kdoClLshye
         dwSqt6rt/fBjeYWI0Jdc6v4oTFaJHpUA5sk1XSXTQfxJpBTFBmxwZTK2XADpRCM/Ch4d
         U2UQ==
X-Gm-Message-State: AOJu0YyC79XPT15pe74flXi/pLDyPoMnBRYET81MzBvIc/QMcusUV+Jf
	FaL8CKsbVY80T7JsAnACJH66OnsRqtzANYGfbOIyqJTEZZD1UYO6AnYnRz3KOg==
X-Google-Smtp-Source: AGHT+IFHN4j5JWPgqLRncyxuWDXfih88qvcwRs7KGjN10AwjsNYqiHieHRDFcg8FReSFNd6bMel2XQ==
X-Received: by 2002:a17:902:a585:b0:1d7:1c88:71f6 with SMTP id az5-20020a170902a58500b001d71c8871f6mr246392plb.139.1706298167739;
        Fri, 26 Jan 2024 11:42:47 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kn11-20020a170903078b00b001d6f04f2b5dsm1292497plb.30.2024.01.26.11.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 11:42:47 -0800 (PST)
Date: Fri, 26 Jan 2024 11:42:46 -0800
From: Kees Cook <keescook@chromium.org>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-hardening@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/82] vringh: Refactor intentional wrap-around
 calculation
Message-ID: <202401261142.C23C2EC9@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-32-keescook@chromium.org>
 <CAJaqyWdGAb088DxKq4ELBeir=PGrqkRuQ0FYkTBwKkfJa4SWbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdGAb088DxKq4ELBeir=PGrqkRuQ0FYkTBwKkfJa4SWbQ@mail.gmail.com>

On Fri, Jan 26, 2024 at 08:31:04PM +0100, Eugenio Perez Martin wrote:
> On Tue, Jan 23, 2024 at 2:42 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> >
> >         VAR + value < VAR
> >
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> >
> > Refactor open-coded unsigned wrap-around addition test to use
> > check_add_overflow(), retaining the result for later usage (which removes
> > the redundant open-coded addition). This paves the way to enabling the
> > unsigned wrap-around sanitizer[2] in the future.
> >
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: virtualization@lists.linux.dev
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/vhost/vringh.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 7b8fd977f71c..07442f0a52bd 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -145,6 +145,8 @@ static inline bool range_check(struct vringh *vrh, u64 addr, size_t *len,
> >                                bool (*getrange)(struct vringh *,
> >                                                 u64, struct vringh_range *))
> >  {
> > +       u64 sum;
> 
> I understand this is part of a bulk change so little time to think
> about names :). But what about "end" or similar?
> 
> Either way,
> Acked-by: Eugenio Pérez <eperezma@redhat.com>

Thanks! Yeah, you are not alone in suggesting "end" in a several of
these patches. :)

-Kees

-- 
Kees Cook
