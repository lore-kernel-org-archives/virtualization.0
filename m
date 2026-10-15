Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2451C040
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065284; cv=pass; b=IJI7+/UCEQCyvCaTdVzTv8mGJdajefgHG9f7FG+NOHl83EZ2GYXlhEOfMPI7wSqI11FRK8pGTrGbEak6KwM6wazDR95MW+Eaqhb5qo1Ls66HsKSYXYhLEIKGtRdmVvc09M2gkIsXsZ/tum7Wol3J6C0HnFNjf3gfmMKOqA74ojA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065284; c=relaxed/simple;
	bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq+NUJo/xug+ErMVEl7+k0WnZ8OwVotnm7RGOHwKFVNJKgnA2HYhMX9BxxKwIMhwDvU2VuopwUH5+ZOxFEoeaoUZWUDIpGveUrac23yPLzWGOFB3hAWjZB7Pi3r7a7FpU1TEz/y/yXkMq8//8hdHiEDkN/iHjWfrEJsTv7t2jZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T67Cui0a; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T67Cui0a"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533797e72e8so8533491cf.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 04:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792065281; cv=none;
        d=google.com; s=arc-20260327;
        b=W/h1NFNEnZUFe9viy3P+ffzx8jbRe3yZCyRpVd03YtB7Zu30KlG1i90d466Sfz4Ym0
         fOpsrQyviCm9y9PggBrHCkpbhc9jIddq1+kCPD2xN2T7OcCHvkq0EwWQ5sWIhVf4xJkZ
         Ch2EIeXsaKTTdtYRP+PGUHFvTFzjlGmoaAyZF9iwvjrP+OyOmKkn0xhQWjtrsXOv0jr7
         0ALpRy8vJwOiTtNAojHRpuj3A1Li9VtgCfISEIDQrqwVOztxno8dr2xS/eG/t9i3d/uC
         4RE+yM8UTUR01OsLSZVU7zrEJrH6+MwEU5jdfKSIEJNvDVE4R7ucO/6/KFVjkSgH2Z/n
         uuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
        fh=9QD3RcPuGcsqmRxxPzsVhc7D9dY7t/4NNNdOLavroL0=;
        b=DPmbi3dI3zfEdqYVioLcjvmL4X/DlufjhWGcYNON0oSO7mWXcM3/vmDC5LL4Bs5iFF
         Ev/Tvbc5afVbQnn7asYXBJ3sUgJ9t4xx5wMo6B3Q2tJD+ok9MRY7itJqKFcJj28g81T2
         oWY5Mzqf/sm+f/ZENix/001mo4La/XmdblmA8OoGNqtDhRAa+DLVqhh3HG4EfcozMlV1
         6+WZWWXTHPh8h8tVbjonLLN9qAz6ZVB+sIcH1F9qLM2ojcVRwhwykqOGOjYjRbwuGKq/
         ZNMyB0Abkkxty7accF59rXCgc9//xdTqll+eo4GaNrtYSO7qsix+ZLPQd6xmrUyBR3z6
         mDCw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792065281; x=1792670081; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
        b=T67Cui0aTt5MXQ7pmaxG7jj2z2NmM8jCAZgWwa3SJZSTQcBsWOA86i6VGqGjALt9Ne
         cuduEc9JxVr/vM1MWm40LlvkdnWZ8kIqQTgDwmxoH+zvh6Sy3lJVWVZL5rWNVqiW8vUs
         I/lkZyYpzRCi2ktW4V7ABaMMh+LbXm4NlDZXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792065281; x=1792670081;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ttWWCBe5s6LvEvuhu7UMsF9414H3CKAKMZfdr0bsCwA=;
        b=bmughcql09ZDFCbu3K/qZZiZYS4UAXwBDFuwiMaQmdrukk5hnsmWsMMK1p4Wnr/89g
         1QCpjvWoKl31cWAON3zbxWVzTh2j3NNHh4ZSlPW5yu3vL1seqt5KRTFzcgF0jmQ+WANY
         rQ6O55nwgdAhKTTZ2531xxJSPw7Hs0Dq4WpkOIu/VEVtQpyS7EOCdyP+fnxR6Zv3W5/L
         AGnuD6J3+QzIWLC9EBZzpegU7eom8qQyaSpCq98llqfllSRndTR+78Td/ukv1UH6Yj2o
         vMxM85Z0/PD8Wl/6RCg0OmNbTSVIFDZptLsvyFJ5j/XT9ADPKe8W2kMSt8sfLiJ9A0Na
         OOvw==
X-Forwarded-Encrypted: i=1; AKwUvBxYBgXDAKlXJyqOZecVa9NKn578oBE13azRXtZtueBhnxWzMcaNnaVrPlJ6qLXvd+baVycnrK8ltuw4EiCykQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCmc91udmfVh9CfwMc/I9jzEY9G761TwO/BDZwQByZ1YFaSUKA
	HO5RFN4q/BrDnK2oiEz/xdAyVCz2V3I5o2rWhU7zWKs8OLTep/1IVJY4tXNZhheAxJBm8wBmsC+
	MQNh6h0cSuSakJ+JPOg+Rtvjm96vRkUidvnvXRQzKtA==
X-Gm-Gg: AYBFou1D2d3zELt3n6Min2JEe1ap4LBylIbk/f3u86Bczy9UK8lWfMt0eLCTzFQ5mUA
	Y/ar+o/3LNUF1ZWbuOvM+NjWjeZQK+Qmzj2rpLqqYU7hpD3emAagkUAWCjdrU5OWIsOSYBXA6hW
	J+9GRebM0e/3trRowYkfUFp8+PqsFpJZ32O2ZifTyFI+xDoOd+8KldiDvzjawvPn60WLdPk6CjV
	CnWD0tEmonREEQABnnccKZ1TQbWcNHv5XVml9Pyqrx0j9b2I2qEs8lDVRi+CXMUU+o2C26acc0e
	R+4hTm41djj6kIDEaeGp2eTzGv+DtE/ba72mXjRqw21Yql7OzxG4Tsqvjl9hIrsPO68+5zYW/nl
	eW/73im7FmGaEdImi2g==
X-Received: by 2002:ac8:5705:0:b0:532:f0a2:ef4 with SMTP id
 d75a77b69052e-5359fa9f9abmr292049781cf.26.1792065280681; Thu, 15 Oct 2026
 04:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260929094812.93374-1-tkhandelwal32@gmail.com>
In-Reply-To: <20260929094812.93374-1-tkhandelwal32@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 Oct 2026 13:54:29 +0200
X-Gm-Features: AclHuK-b14bcg6mR4vOtm8iYsjO-WDFkkV-OiklyH6IKsJTNTAuDKd92iU3RYd8
Message-ID: <CAJfpegs1Zq1zKfGDOucL_PZMUwVuHjandRn-rrNrBPnKex8hcA@mail.gmail.com>
Subject: Re: [PATCH] fuse: propagate SB_POSIXACL to submounts
To: Tarun Khandelwal <tkhandelwal32@gmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, German Maglione <gmaglione@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Tarun Khandelwal <tarun@supabase.io>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 11:48, Tarun Khandelwal <tkhandelwal32@gmail.com> wrote:

> Copy SB_POSIXACL from the parent superblock, as is already done for the
> other superblock fields inherited from it. It cannot be set in
> fuse_sb_defaults(), because fuse_fill_super_common() checks whether the
> flag was passed at mount time to decide fc->dont_mask before setting it.

Applied, thanks.

Miklos
