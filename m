Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED003E0C4D
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179069; cv=pass; b=Ojv1AmEQGPi0q90/vRFwAUI18/e55p6J3bXG5fmvxCQ4Ndn0erKUQngvyzHPN9YHd/DfLlVBhZEBrBi254Cmas7dbNMOgkjT1xk2do5TAW8SNFjqNgaSIGXtqc6BVyRn7y6ptHT0GGtZQetewHnSuq1uC3Svg+BxiE5rOf83ZtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179069; c=relaxed/simple;
	bh=+2JphY+nktmaf/PwzUVblf+PDVb8dtBzAGeaHQJSKkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2V+aEqXhXqBhf89xxDZVCjf7NENmY2aRyTPTEf7Xv5G/gi6gXTb3rZTsfvTQoGHesyPDEmlsWdQXiORqmOJotni4fgW6zgwvISg+D/1exPOnsPCiWoQLrBNoQQcva6V3qFc19Ohq63LmlSH+WWaNjTpG7l1hDwBX4vg/eONOPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G//Qb2kf; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G//Qb2kf"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bd5e373d07so28301057b3.2
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 01:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179067; cv=none;
        d=google.com; s=arc-20240605;
        b=Et6ZUSKUwPMBy+jtXr2K/6jgEAur6eVM6zHNn64F4F492UC101JPEMSuMsXgL82Cr4
         mpYbJRFGWJUgtTX+tBr5xPKSuNa7daT7DbXpESMk0XxnqWCcCEnlTZfNLQgi9cefwFUm
         Y5e0zCJOpzfmHgd3LVs5AV+dupgWjCroo9JZgKNGOGnqSV2/RxeuK6BfZM+DGLKuA6Vj
         mYJxyK0T46WJEpvsrMuuI2ubLW2ArXSV2mp/5y8Y0ccyRN26LdcPi3pFfedUHLgr1dNF
         oFVgdCduPyN73unRgFbKH8ytG1wnsCYm3Nf6+L/Tcc/ZtAWfRQVznWh3YsuzomKOdBPl
         wrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
        fh=Aon0+P5PxE6dhpRh2l8yIChXhsHQUapgeMXxh8lXHqU=;
        b=V3lrEMJO71KtLZ/02Ak75rHERUoStJnGxZxkaoZuQ2hhsz/bCSM/KIaVdHw75D/zLc
         sSvwNWSXU2VilhK/0hg66vVvpwxsgjvnkJsP6OFnDo4xxwz4+6Jkgb9KT03OdDOrt3JL
         S449oJCm/B194djzrb6Du9BF8k7yWO4bK4+m7YFpSBMagovW4FZGl8oY7Dj0QEERyDvQ
         V7YOD6sHxV0THWCsXdGiNmRelSLrNHMtJVk+3jHKRrUYwxzGl9PpMTk+e4XwO8j0u6x7
         xA9JsdywV8rOfR3ahCC05QgI5y7Jor8cfKNFbuDuSMBG+zQMWnMUefbRxrIQjOuExGkD
         2ufg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179067; x=1779783867; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
        b=G//Qb2kf9KfElc9fOjiRR18shaPz+2OxQLJkmZreaFrvEWE5RtTaPLKDm40Z3w/p1n
         grQx5t68Vmj3Hl3h4jGEZ9I0h6ixhuB2LT2cX3CUFUqLPybVyQh8Z/DopZgx/Uo6sGSK
         1BeD3EhBgoKGqin0ucTnzmXUtQ7Q4VJPjRuyYJ6hIqLlLMfi5+cuLRUzJr9I8X00INXT
         vmxhgwory2KIyEAAvLzXupqx1nsjC9XK2yqzRU+SIvvW6HjYP7GuQR5UmlUhaqdmhVBM
         KezUWyhKj6XGm4eci5x2JNzhMrkwKD2rGTmVA/OngHo/+m2VORxoL/DVIfMBDr1TdoKi
         b2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179067; x=1779783867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6MJFOu1HURlx5XM1WoHG2w7zZ8Z0olnSEZRjhu2b8sE=;
        b=ELa2zyobvfrVwDYKpA5GiiMwCeuAQxZ20/ztspLbfA3VUfglAdOgMw34s37e27s7tK
         9CCeAEKSCdNylZl5F+2hA8+BnrljdJn383i19tS9OVAzSnHQhAxcLetvLKDkUKTkxXw+
         WSkalkYk+Dk/4z7oqo5BYGoEOK2ZlnDrE0ySs2Zg9V97Qj/evFRmKS+PsklAq1ISVwcC
         cTqNFnFc9Zs3Vuv9CMDybG3N5Pg6xx7r87gCXhwIOEre8wlryM1oOSQEuj3E0fPh0/vz
         YndWIrIGls5nSkX567rMpm2b/f2OmHv+eJ7iPiApsGhfRXw8z6k8o23BNiZxu/EynGrp
         HjIg==
X-Forwarded-Encrypted: i=1; AFNElJ9JoDFDDtQD3KqdWHAiEa5K+pm+T1od5WnfbRZq+nnyly5m5F1CbMWm2kITpwlGqJkOfFfsnI43GqwY5aKz1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjQf0A03kfkSaQ9dmHLtg8lebkI/Fbxv6l2n6YkHuzko9AgoQ+
	rHVyguK2tJize8n+Ztc0cOtNBjVN4ZFYptDSr++4zU281cYF5/IkhF8ma/Jf6Q61uiKagtjG/yx
	pcIWKbLzcfSV3P2v4LY+jUtcdfpKZuTk=
X-Gm-Gg: Acq92OFcuylt8hm5xp2Ikjs9LBhxPyqnCbmS/8hbwkuIsHpfshBkuo3fKmVxvgOYvJQ
	rdj8Ln3wjcQJ2+ZsP1Bav6DY7p1R8gt7Yg8sQTtKyhZLnRycUFQpOaHRxUJLPKm+j7owuJ1cWyc
	sdScoJFotOEuRT+HM9m5dLnR0x7UXQtUKqt9PzGc3uazyQ8enl+gRBydkvYsI60vFqeOWjUrKRP
	WPE3a0Cs7z9pWR6FNcIFYACMktPdFsT5g+bVlWKBMTgGVkU9/6A2IvCRWIH5LspVnM/sPH8lfRH
	wuhZIB48CupdGfhW5+A1gfkPe+7FZoTMZ8XrSK+YzeCikdB4XdC3MWIqD+mdKEfzyl1fig==
X-Received: by 2002:a05:690c:f02:b0:7cf:ab4d:a0e6 with SMTP id
 00721157ae682-7cfab4da692mr7412417b3.19.1779179067451; Tue, 19 May 2026
 01:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260515084030.21986-1-kartikey406@gmail.com> <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
In-Reply-To: <afec1199-4889-4d35-964c-4432ec792fa3@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 19 May 2026 13:54:12 +0530
X-Gm-Features: AVHnY4It9V2jN-5fjRsBqTKrkzDjZ0cvyy8FQ1o37xh7kT1TdZijJ2KMlBZd7uk
Message-ID: <CADhLXY5Mp3QjKoYHpgdd+mehZnOt2fkhCWNNrjfH1rZsKPjycg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH v3] drm/virtio: use uninterruptible
 resv lock for plane updates
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 9:44=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 5/15/26 11:40, Deepanshu Kartikey wrote:
> > +int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_objec=
t_array *objs)
> > +{
> > +     unsigned int i;
> > +     int ret =3D 0;
> > +
> > +     if (objs->nents =3D=3D 1) {
> > +             dma_resv_lock(objs->objs[0]->resv, NULL);
> > +     } else {
> > +             ret =3D drm_gem_lock_reservations(objs->objs, objs->nents=
,
> > +                                             &objs->ticket);
>
> drm_gem_lock_reservations() is interruptible. Given that only one BO
> needs to be locked for the fix, make it
> virtio_gpu_lock_one_resv_uninterruptible() and fail with -EINVAL if
> objs->nents > 1
>
> --
> Best regards,
> Dmitry
>

I have sent patch v4.

Thanks

Deepanshu
