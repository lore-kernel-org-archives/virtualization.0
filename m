Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EFF14E2E0
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563197; cv=none; b=Xu2EukunIdytNxwyyXxQWzDnc2xaedrrv3iHGRtT2oMNgIEYK8C9pWh83jdQ9BDdmcjYlKNBNvrapRhH7ZGWwPsoeNY+/WohPXmOk+mXqGWJCELN8a5wreVt3Y7KBf1iEwg+ETqdQmpI+1/x8vMu11R2lB9gUcdlWap4DTUldz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563197; c=relaxed/simple;
	bh=wyryXguB8266lLWCkFJS/84WDCfywSXsHKF549oL7yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+l5llOM9fCNB52mhTvIMBtros9ouiREw97JyXfVos8/7FJARefS8XwN/t1BQIStLdfceJuebj6gV8CNINcJK19hOFV9pZj0p9OHFyJup2vFolaigA4az3/PT14g2ik5PP0ukaYUshaqqUBO2HsatEbKnuOV8HO47W5Y3k6ho9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6/Aw5+h; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6/Aw5+h"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29f6f8614c8so133884a91.0
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563195; x=1712167995; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Apmp+5NG0ozOI/JWe7g3FmXSoAcJcuTi09oKHmC84=;
        b=Q6/Aw5+hn4VrkJQdlaSs6jzRNPoiUbA9/IcEldgAXPaswAqQGRq58XwnGngen7ljIe
         iopgDOJxl2t+cpRVDK78Z3fDtPNmIqmMC7AWFF54V2MBwwbhYviGpjrSlmoxXogxiTai
         pWKRefE13mCOV+8ylbdZeESVOCdIN+wQDMGHkgX+qL5T8UIIlIRlo8tVLxCKFJKfAKsy
         9LKKzQzgN2N33xNv9fQMg03k2UaUPoFE/1H6jAHdcr/Ny2fNlLBGJAqv/Bwx7wFFo7t2
         wILaFsEz9Z0ns2IxVVFjgr6ZqbJKZWxerXeu8RKHAIWV0H3bWbfPT5RphXd5JQ1djqOO
         9zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563195; x=1712167995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+Apmp+5NG0ozOI/JWe7g3FmXSoAcJcuTi09oKHmC84=;
        b=ZDR8+DBZsTqSgJLMtxV5Sk+KvwKfh7y90dw6gHIw15dBPIO/rhBtmRrpe0HBSpRCZ1
         Ij7h+KuzgTe3ZYUzQ36c7oml8W6iBdNzMZq4cCJ/KC+OclhYhX9/MZdqAePtVYujtelU
         J5orGRDiEgAC9nIEKPeolyJl1eeFAMjvfNe9hBucZTC0OQG5ZMUqKQwrakHtxW1h8D9X
         1k2Zhc8RKinyD0NsnFo7myiwjcCYDHAq7q1jTbSS6QpazfXS0cGRcZIgRZfx798rB0uk
         KltxKgvW/nxxL4E1gb9rym5k1vvV9eR5TCBKzd/YEi2rjw0N+j/p3IxZR1jERkfqTC4L
         t9yA==
X-Forwarded-Encrypted: i=1; AJvYcCVBdB8sh/c7opD3/XSXDePzrG9HC/oKdJsffNdN52lE6PNGoWkAjBNdr/v7y10hkCX18YP1rwDAkDXSL0IcAqi+wBsKIecKCPMWntjU6ws=
X-Gm-Message-State: AOJu0YwrGA1+0j6+oJqy24WFYbiuvhAZkrJ0llROgZNF11Xtl13omjeP
	YCCXwzZslcVF6E43b37kcB7/H8IvlGaDe9T0aIiUQQDO5bJBIFlXplb8pRXdoiY8EA6Pb2w86K2
	6jvQauuGpgUvnEqIWLw/hEJNMM+s=
X-Google-Smtp-Source: AGHT+IHLikdTRV0YFY05LU+4dKjjaqnZE0r4ZhQYCDgh/j+5MZTT1jmReESMvyU/J8EN3USD/LkkQwkRCTSMfu5GTf8=
X-Received: by 2002:a17:90b:3702:b0:29d:dfae:4fac with SMTP id
 mg2-20020a17090b370200b0029ddfae4facmr514671pjb.23.1711563195269; Wed, 27 Mar
 2024 11:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANiq72mbsAYmR_dRPpQQ=9-NWhTtp0TWiOz0v=V-0AvwYbWw4A@mail.gmail.com>
 <20240327-magnetic-nonchalant-hare-bbe8d2@houat> <CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com>
In-Reply-To: <CANiq72kqqQfUxLkHJYqeBAhpc6YcX7bfR96gmmbF=j8hEOykqw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 Mar 2024 19:12:47 +0100
Message-ID: <CANiq72=hguVfscJQSCAYS2FfL1VpUVvX_Chd4X8gAX4Twq-TLQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/qxl/qxl_cmd.c:424:6: error: variable 'count' set
 but not used
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 3:43=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Will do -- I found another one when running the CI with the above one fix=
ed:
>
>     drivers/gpu/drm/qxl/qxl_ioctl.c:148:14: error: variable
> 'num_relocs' set but not used [-Werror,-Wunused-but-set-variable]
>
> I will send you one for that too then.

Done: https://lore.kernel.org/lkml/20240327175556.233126-1-ojeda@kernel.org=
/

Cheers,
Miguel
