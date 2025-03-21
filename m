Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D91FFC7B
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552826; cv=none; b=uDIUx3f3SFfmlnxavaSKDnEl3YmbhvHt4JAv3OynXeXSdN45iagMAvc2KGbwbt7GAc5WSEXHEKjcqVrX5lm5/dgMR8VXYbNiKEV94+C2W36Hi6K0h/5Sn4lPhJ+5rKYKJZbv6Xf9B188wgVH98r1441hyWUS8AZ0cWKn7+3byjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552826; c=relaxed/simple;
	bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leOqYqbmWRd5y3W6AEcp6LyvXjZg05m5K7UKhUsFR1NUgik4yvu6qkcvHorXFOdBqYofT9+Xbdb8okFKdi89kbsE4WqlWrP87APYAK/i3LOTa08MiKEJZW29alobVHuiTAvICOj/4jjgNt8s6XRDboAT5FJVILKMzqOKvgb7T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=F0gdvc/9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="F0gdvc/9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c59e7039eeso238291585a.2
        for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1742552823; x=1743157623; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
        b=F0gdvc/9vdCdYfIdgLnWvD6kT7ypO7+Heth16lX6chjQxHgquyzvvzPF7jvGdGE4c2
         hakm/b50vC4SbuZI9dOVPI6FsUxlbN6lBNDAejJCk4VvPVkmmnmo09U42rEzrWtuJuuh
         5wJKP+CiHsILfL6R+bTSiYry6RbE17mPatvLQQBoAs8idO/ebZW2W0dqJUaiWRdViIiR
         21cwUM68beoFojjCut8giQ0DSmHDwpocg8I/lWZ5td8VF/LcCVX9989ZXC0Hd6XRr+nE
         gw0qyA8Nsszz1IvY13lb5fntB34ngVB6kvY8RCTvy1Bo4a7QtGThyR8XJuio8+BN2u+5
         L4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552823; x=1743157623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
        b=BM2pjmH5x+rO6e4Fzno/WTngTnDzXt1SkabjylT0o45mQzIEhqQqaRgdaDpvDOeyuC
         j2CsF1lSRP/qPQdldwUYCezkLWp/CSeOxzKsoxkHlq3jfJZyAQ6qEBUXikY8Fz01NTjz
         uuKpnfTescuF5Dmt+cE7oxO8jf6FT63HyGhWwFEoNwcicGxHIRXtLcI+w2U61GzDj4fg
         xuDm2bKc4J2uUfc8XdSrWQ3IT5WYJ6iIRZ2lfBIn08sKnIaXYLDG60Rg5HjPcAf/GCFO
         uBupLo67vOrez+93GbPe4TFCEydDc17a8L8rzuc1HCN3BJwvg6mA8KHgiMDNnifYT3nu
         PjfA==
X-Forwarded-Encrypted: i=1; AJvYcCW82hJ8Ks78LGaboiPUz+E8NTXYMJ3vLkFPamoeRTib54wXnqcn0wWekIPvsuJCI6KtfaMg26BmkhCypJgatw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ/1J4tNQh7ApyQewBQiodNs97zAjk5I5d/lad0Jj/D9UKJQWE
	VBAVNvvMgboC+zTrCWyziSn0uJvLYVuLIQiBI/NWDtQ+2fkT5Ex31z+i0tQujne/C5sGborDaPc
	+Psv2jvy/qoFFTrlhIIHYfZTwpvRejk94COsMCg==
X-Gm-Gg: ASbGncspw8ABA+NRSSZNxHAXjoKlMMmpYDlRMj0aw4ONcUzbBUIjBC46Vj8g9APWxG/
	anUSUk8K28XJOQta0Lf4NkcRL70YjSkNNhvJwgGZqwKDDZaU7mIw9JErEGvxWcK1Dzxbbxuwtt6
	L4TDAiFHl4nyE2POSG3YAnyPvd
X-Google-Smtp-Source: AGHT+IGtKZxKAoZgtR0aBlIVmyFJdz4vLgELnLl5z6u4LuYLjXNoyuq0UVrTF+CIIc7xPDTVRmAHZ+SRVPvG/7TyZXI=
X-Received: by 2002:a05:620a:4055:b0:7c5:a423:f5b0 with SMTP id
 af79cd13be357-7c5ba13361dmr406693385a.7.1742552823192; Fri, 21 Mar 2025
 03:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250314085858.39328-1-vignesh.raman@collabora.com> <20250314085858.39328-2-vignesh.raman@collabora.com>
In-Reply-To: <20250314085858.39328-2-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 21 Mar 2025 10:26:52 +0000
X-Gm-Features: AQ5f1JpymW7UP78_0g_Z-sNByprYGBFX-xYqr_OlbVrsK0-Hob7Zk88vIu6Znbc
Message-ID: <CAPj87rMjF84yyPqBshuGu=8qx6Xhq9Z-HgEnQe=tRtbu3E8OtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/ci: uprev mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org, 
	jani.nikula@linux.intel.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Fri, 14 Mar 2025 at 08:59, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> LAVA was recently patched [1] with a fix on how parameters are parsed in
> `lava-test-case`, so we don't need to repeat quotes to send the
> arguments properly to it. Uprev mesa to fix this issue.

Thanks a lot; the series is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel
