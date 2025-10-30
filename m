Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63972618
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826730; cv=none; b=Fms8AMBpHF0XPxPny7hovPiOPlmk+KJKIbErH5RPbcZWGaUzMLtNKeUJnAamrmlEfoqUoGBAaVnvJiBwTmmrc+gNBty5+x3U7QBnUsB/hLu2k/riALT/gtD8gVSyHXVQEC8tPgzP7oYkoqci38gxrXYIGBHA5P90gug/VJQCtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826730; c=relaxed/simple;
	bh=wnhbQmh4ahC8PKdCzcYNoFOto08zipbrJDQpVkPseTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ6zLjots2+yXMPVb7KAgJTE/30d+N3LLuNZ+6b4qJ7W3gBb9H17w6q/BS4JXl733LLPD2VX8P4BzN49wk6OucZbkRDGQ9JPZc4ZXr3lEC+1LyuOC6cYOkI7awCg+GQJYNsFTKPcFIbGsZiSJA6mhZ6YGww2CYqMoo6RYalo7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hn1dPaju; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hn1dPaju"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33d7589774fso1357578a91.0
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761826728; x=1762431528; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV3Wyms5GctmoxFgrHuylYNeXPRM7QEqyLlsa9U1RVE=;
        b=Hn1dPajuljkfbTSZA26UXHz1oLV9GZ7LvCYtzconimKe0nDfBNfrxZP2/FW0FLJsX3
         PTlviDh6FAFkXye3zH3AETBMw38/ymyTFEgmeyQy0nFKPGtNEQlU0bwQinPBpUm4R9Az
         Qs0U8BUB9WdF3dEfghEMuTbsDUN3SDzityQ5EOyeKD75bs/bGOxCEiURpFBphsggPMz7
         x2ktj32PJqRS3FeYlN+R+lB6VxCDwyOrn/jcQGWwnjRTuqX2IZ61Md5fsQZwb7j49Xsu
         ZYeaZcq5gbWIkYjgKcbYW4efEkAtDRxQ3dXHRDno8QKRN+fPwdB4Qg0UODpn38HSuc6w
         kYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826728; x=1762431528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV3Wyms5GctmoxFgrHuylYNeXPRM7QEqyLlsa9U1RVE=;
        b=dfEsdAl1TqtrLU3TEkbeoicgw6jE/AkQsgbydnPa8nBAiN6UQ3OJhVxsetbLGBbPf4
         ZTgZqjHcubaXtH7as0UF+bYHzxq1fCggAwbwGwqc/rbdiqdFnakQZkV/RnpRsS8QA/ju
         SFjpS/LYL7ANBocCT5S5nT7sfHaSkivZMIDzMWq+YSOfgPLi84d28k6vn1gnsnJYVywK
         iS2QDSt3SSrrLsP5lCA01XKY2X1nOcUxS7figsfpRyUD5fjqmXUrqKZ2gAUdh6Wbu5HW
         R8RSLoq5Yr1W40CCfGP/4mxXvkzZEGZChIBchCFgjq4UdD2aoJe/j9rgFgng7rLJYKA9
         JB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf6HGDbWQ33LBn4YkGLizLmcyjxZ6sKYcH2tUixS48zC8mKpwahVf5xm7KbS5aC+tnqcxVOBr7W8WwQSwxxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/R1r+ZGMQ1WIg68o9X2DMOEVm1GTnjonrwMBSr47N7uZnc/RO
	QLNNeiWqrBZqkX1mM+FniVsajoR4BXgAD8PSYd7Ji+zlB0lPbhGuGMT45mP7wGnviwkbtbzjynR
	rg3SO5DJz25Ma8b3QIUuCcitzJNsBgL3YeNpLjmTn
X-Gm-Gg: ASbGnct+s+d5/DJ/8yGbOw3NgxuRi3BeWNDYGBAlSKmiXmFw2So4Sras62NNqyiQrXD
	NNB7x84w0X9IK5teVQm/bwk5o2RHnu8Vw7bukrF25wEe+1QlZgkObjplSMMHcxkrqXZ9NgPbtlQ
	Qu4IsEQlTZ1o5ZQcKGn+S/sj/nP8RMJMK1djSXrpux6EgpOxKJRNNyB0sf5usLT4Dd5+NqSeYEz
	6au0TJB0J26rOrV1hdAOgzA5DdEEJrOvUEBkrKB+8DAsqxHBYKBO2ErbUNvsBz2G4OwoysvNtS7
	OeeX5N0=
X-Google-Smtp-Source: AGHT+IEAOTMFK3D5taJ3KPSJjji4K5xecEJyo6FAdbfI1bayrytkxTVqsVBKlawrgvajLnMKq8BLOieel/imjS8/7jA=
X-Received: by 2002:a17:90b:1c87:b0:33f:ee05:56e7 with SMTP id
 98e67ed59e1d1-3404c404985mr3892931a91.16.1761826727860; Thu, 30 Oct 2025
 05:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-3-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-3-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 30 Oct 2025 20:18:36 +0800
X-Gm-Features: AWmQ_bmiKDcTTVrpLtfWQHLoVOAgkHmCC4dbaQET0qDlzDFIGwHDaLhNbSek-Lo
Message-ID: <CACycT3tUQuQLgxE1-++izeKZLbdzKWUt9a5ukRW52HCjm3V1ZQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows separate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
