Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F561339B1
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804255; cv=none; b=FPM+iqWbh/sol3/u0Us9+7XsGFbapa6Bm2tgz4BHJ+5oLWhm5bPQxsvDIsgfGk0hRVyX4ai3VD+euQt0TSVnZDpvfZz4ImiztYs53wiOPwQ/8vb7Z6qbMeqDu86wg3JsAdvh4HYEH/+MgwWeFLEYL2VQvtxpNQMkskOY+n4uGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804255; c=relaxed/simple;
	bh=VSCAwzN9jGEFjN6clhdgho0T6MdtX6T1mFw6hrhtdzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJNFssPhYqYJQ00HNoVmd6gRCDmDaCbIp5hU/d3oxYBuJQkQaJTGPyKR5n6gj1oB395Q5CgbbJHFHuqqtuPAIFGu+bitZZvx9yR7c3gfRgsYk7eoHd6GqpZsGkv8t1FsQrdtj6/MeUT0MomL0gutPZvS45rwQvT5kPaRmKLpwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQ3Zscme; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ3Zscme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768804253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo0PBev8tqxIPS/T2dvnIKxaRMmpWT6VO0j3tm6Zsd0=;
	b=KQ3Zscmeo+LRNyJQfbFM0vo8CyIujlOTPZRWkOkEhyUtrjA693ynWWQls6uPMtX6+pu+26
	9WGK9V5xcFb+4z2fEIrch1S6HJCUh5UkoSnfUUPz9xjChDjh/X1LtviQNWnroCun2O/iwH
	vE5HA73mZe4W8LDmz5VliH3No+XAMI8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-PFVEeOGlM9aedpr0D8YDHA-1; Mon, 19 Jan 2026 01:30:52 -0500
X-MC-Unique: PFVEeOGlM9aedpr0D8YDHA-1
X-Mimecast-MFC-AGG-ID: PFVEeOGlM9aedpr0D8YDHA_1768804251
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34abd303b4aso8043416a91.1
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 22:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804251; x=1769409051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oo0PBev8tqxIPS/T2dvnIKxaRMmpWT6VO0j3tm6Zsd0=;
        b=CstgKZX6aNkCP7/RM3yjJpkMVX15/MWzkz2KIPz80PsOzkUhvPzB+DNXvE3hdkJ80d
         1E/dp6oJCMycEQ+XNfrcpOD5Rl4Mu1CdplEA1NysCphdhfUi8dwlq/d+yxb8zPrCVvkB
         MFSurJpkK8H4sK3HG5f/LDS4dazmlgHGADy4+hun2MrGGZSvmiin7sNCTjJpHs5Oa9y3
         J92cNg6XbvBL3yBaRPTmVIaCbWvvyGlEh/WW20QJ7ra9SEfXX3jk4N9y3eJ41ghVEbTx
         qXe6XMoF4fc3mZXN8QaDOhiRoG1cRc/4PHLeKq+hmrkbyfdvOzqSZ9R1lcDOX8mcAJ6g
         hoeg==
X-Forwarded-Encrypted: i=1; AJvYcCVNzT0PvVrxv+hjnavD0FKvwqfjeEvevUE+Le/ko4bdbHfgdOLHIC3y3oau4Yy+f6ZRWP1nrJJ7+1Wq1uWCbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsq0BR1VynnYpu0Jg6stpv93EFOBkz6uGC59ol/UqPKJFIP5mV
	0dZWxCLqu+g9fWkSgled1Ffc1Bb9Cx0KdcWYDgWOQ3E58BctlSXjFJCeB9wET+rz2nAEQjerqFt
	Zp7owsjjF2y62eVDFtN/uA7iEaGNS60fyUxN/nkmIj2w296nH28ho5cgiVd0V1776qIopKhkpZM
	xMhISgFa8wKTl+LcPrahhclS3CxeNnvvke9/I0teUh4Nk=
X-Gm-Gg: AZuq6aKf8syXpL89i/R/Wpbd6P5F0iaoxZsi/BCR6xwtIrbyUNFpyn8z+1mzN8xe85/
	idgM82uXjKFRZZNM9J/NxmjGKarLeL9rwqmKDYaKml4FdzbhZUy1m0PBT0QQYti9JaNjJgGaMQN
	/LnPRf4BdvCQRLcjYY1K+ezfpXuyp6gLJSgcYdrPrOvNP+++uSn7K5C4vV4P+xdRhsjKw=
X-Received: by 2002:a17:90b:4a0f:b0:340:e517:4e05 with SMTP id 98e67ed59e1d1-35272ee3c6amr9920647a91.12.1768804251158;
        Sun, 18 Jan 2026 22:30:51 -0800 (PST)
X-Received: by 2002:a17:90b:4a0f:b0:340:e517:4e05 with SMTP id
 98e67ed59e1d1-35272ee3c6amr9920626a91.12.1768804250749; Sun, 18 Jan 2026
 22:30:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-7-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 14:30:39 +0800
X-Gm-Features: AZwV_Qic7EaqnY4saovw6kNKoEQC9pmz2VFkfAce6G-D0LsPOVuIg6QTCxixnLw
Message-ID: <CACGkMEuoeM6chToiEckBiRWi82oKHg7JFm_qi7aGKa1xJGwTFA@mail.gmail.com>
Subject: Re: [PATCH v14 06/13] vhost: forbid change vq groups ASID if
 DRIVER_OK is set
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d0qlYvAjD6SxP1OjsFpvuTxPpyZtXjfnhMTSwHanzlg_1768804251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Only vdpa_sim support it.  Forbid this behaviour as there is no use for
> it right now, we can always enable it in the future with a feature flag.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v12: Fix typo in patch message (MST).
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

