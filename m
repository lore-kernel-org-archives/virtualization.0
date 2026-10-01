Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680031D72E
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830120; cv=pass; b=Ckq79587iMXzooXR4j+8LZjK6ev25gfKEqWmEerSGo7OgUBY0neFSucmAAN83pr69OAayY45Cioy1m2zN03B2qsHR1nCg1cLNaOACsDaYvSm2PnwvbMvaFALKFdYO0sjvH2W0bRoEN1Udj/P6GB0z9dBkzQVMDA1214my5qWEfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830120; c=relaxed/simple;
	bh=3ABacmlhv8U64sW7//9fPqLoIWrV59ydnWI6VCca9rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rul0i1IBcEU0XWoWErYLUjZJ1b6cdjPql79S/kBt0Nz1muA6huDNQz4ozP2glDtk+vkpGgNMKkbTrvUI/LPEhpw9zi8G9/1JmipdU6bDhyeSB83fe4u1hzwBvzY0Gjlwqt9TsCvzaxIBVd4ZmsN2Nr+ab+TWXvtiedJisShRIbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUCOG0CG; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUCOG0CG"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a58fef219fso11620951fa.1
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 21:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790830117; cv=none;
        d=google.com; s=arc-20260327;
        b=jBueNpAzVncZ1S9tu4IrPcbAOd6zZ0Fdv12uzKwza7JV2QZ+O858SxACnH0v3H6G7a
         jOiTpcslVIP6ULCZ2gaB1HYHBUK2zBuyvehwTSt2JeSS2VqYj/mkfqpFDkG4hB7suBnI
         pzEryNYm/EG64cv+cq7fPyFSbiE6jFKRe1SIYqVeGL5we1Zs/kJgjvghILyTZYVP4T4W
         t1sTBUcoivZcYmrJfs7+1sXaiXHeFYs1WAS2zIOdnI17rsSLVEIYLT/GXZSYIpEEulAP
         Wp2Wb2MjQg6zoslOYsNz0F8wotlkMwcGJx+MZ1dw/9mzOyaZtxR4fLT8WOiwqG8SvdT9
         bprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3ABacmlhv8U64sW7//9fPqLoIWrV59ydnWI6VCca9rE=;
        fh=D+LVSM5MOkiaiqmpgNazc9TfRvucwK0pNYxbqATZ2e8=;
        b=ZLUNgDgFZ/j02VrfogFEi4aN+5qMaVF8Qa79lEKBrD+MoLALoQAIhK2w05H/4bgUk+
         s67z2tRXTUOw+C95OG+F4IWmo+K3PAv43o4l5OJBXFoFeO59F5HcT6zmGs+hTybypugc
         WdutmSr0t90i4I+TRk92ydbqVCpEqkANq6eE61S4op2gafuvYNOtMSaKJGWfoZeirYBW
         60VrOgePZc5hSwe6ocFSBHGVvGov15LT7UaOlLiP958XmENpWj/mmC4uMUAe6T0SPcmh
         yCSk+MpRmagfbnHk5TU7sVJk2f6T0Sj4ukqjl6LMuroTMK6hGVQePjpoOSsGN78+OzU8
         bBow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790830117; x=1791434917; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ABacmlhv8U64sW7//9fPqLoIWrV59ydnWI6VCca9rE=;
        b=LUCOG0CG+b14BxU8Lnn8GjQL4rTJ4RwkPgD37NBrbodRcO5k2zfc8VZdd2m4mFxWVI
         SrX/FieeAkm+AF05VKvY95R0TVMYEE6+kvEP21+4KexXlj+dLYoe4ORqPHirFkLPbd8h
         9/jVZr53NSbkyzIE6qx7ZUGr+AG92EEzvbIX5e3+SWQmvLTog6s/1i3O5v6dAkxt/atC
         mjcwihLgv90UZsI4y2SXoTWy6Dz9tfsKbXc1AhxRpAsg9tzYGvPvUJUsDeJWpGVY3rbI
         0D0lxBhZVVNmT3FtLDgg1mIi5eWP+IZONbx63FXTcu0wUzzKvKpW77+9vrTA7O++Zagk
         S02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790830117; x=1791434917;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ABacmlhv8U64sW7//9fPqLoIWrV59ydnWI6VCca9rE=;
        b=LiqH6MVVhZpBfowYhxqcsjxrOO8gBSzy7zM3pM9ej67qBITVSNbVQjJsLb4QsQ6T8W
         7GVu1qG7rZIz8pNNpnctl07KIpF/48LqC3jP7K3LfHYCxh8s3AKGI1J3cJDJTMTWfSVy
         DV3Oe/qVlRVVGOoLyYvAQ1yToG14z1n+339ZJvBfr5kAQCtv1w9Bk/62vP9B4qqJs8ui
         aEggKNKUi+FKEzTcTWeK+dkauld+so6JLKQIIwhMPA5uFXUF4eWfKWNJqaHTdudEhJ38
         /x6WERM7Dpwcmz3dMQWKC0DEtxDcGcG5BZnsJWWiGcSJ5qs3ZeGK8bx8jZ7URHT4VhhT
         +EPA==
X-Forwarded-Encrypted: i=1; AKwUvBxkbA8D2gHm3pyUifHXeIYfk1xFw+Mg5BCRlJZUhQLP07FrHsdy6xbPUlLaJatm0IYFW3vP7Ua6vKhC+cuYXw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKvOhzbUGhxH0vnP3oid9FNngRhh8sGCAvO1FS9PTqpLt/ssHSn
	/9jivmvpw4uWN7dT5HFGA64Wy/K+0gsf3SsP520Tj74RzkiqBAx9kpUpuKnMpr1GgRENC0+viqg
	AVIodQkRklrP0NPBDlcfDFDCh/lmZCwU=
X-Gm-Gg: AYBFou1+mLmiTzNbuFXhiM+AhJ6SYI8exc2h9xsOEmHeRCDitWe/kOyAoCoYOvn3uqa
	CR1Dsn26hmZ4emTqadAGM0XbuoNuFZ0Z+Pze4us+A6/d7Kil5t6rxBMcMJmXD+ANnRhJXIbVkro
	He75WMw8cN1bSoBB9TvWFv1t2Q4aWS2lVZ0Z4PlY9SQM5int86B8n8vGXdjlf/1kiUk4IdfOoXM
	5I1CaXrz5biV+XqIH+4CpeYSr0dfIynuQTqNOxiW8o0ijWnlyhQ1cTXrwq29MuDR1hdKsw/Dfhm
	duFawnyWCo1g+SMDe0VA4LleWCkSFS5q3MUIFitw6EA2eRqO9hvFWA==
X-Received: by 2002:a2e:8806:0:b0:3a7:6590:7eda with SMTP id
 38308e7fff4ca-3a7833a2488mr2717631fa.14.1790830116633; Wed, 30 Sep 2026
 21:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260930155920.1684465-1-oss.patchbox@gmail.com> <20260930195908-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260930195908-mutt-send-email-mst@kernel.org>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Thu, 1 Oct 2026 00:48:25 -0400
X-Gm-Features: AclHuK8nX9Hl6iAsCD15Gr_6NKLb1XER29fZC1Iq7_Rz_t2zgcFj4klPKJNXK7k
Message-ID: <CAGG=RgDH1fCe3uiFkVY=v=cgcdGc_E0nyGk-v72mR4mefCY=Ng@mail.gmail.com>
Subject: Re: [PATCH RFC v1] vdpa/ifcvf: Time out and report device reset failure
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review.

On Wed, 30 Sept 2026 at 20:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> No one handles reset errors. You can not timeout this.

Agreed, returning early lets callers free memory the device may still
DMA into.

For a device that is present but never completes the reset, would it
be acceptable to fence it instead: pci_clear_master() after a bounded wait,
and pci_set_master() only once a later reset completes? .reset would
then always return with the device quiet, so caller can keep ignoring
the result.

> Use standard is present APIs not "all ones" hacks.

Will do, v2 will use the present APIs.

Thanks,
Yuho
