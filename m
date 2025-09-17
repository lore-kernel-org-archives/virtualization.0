Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A672F546D
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103323; cv=none; b=haWVzB5buNE/3S1pkB1AINV7JbMy/KrpNSBIwjXV5OazWjrYVhSPyypj0qKygKcb1SP9UffIT/IFz2JI0pTdfRvvRalSKbqksaeJkPbnPSXvVfdfrv7h1KsqYWlANY4Hb+H5dfu1AFHVaWsn0j5ee35TFEKkyi5IJjb9/2+0PUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103323; c=relaxed/simple;
	bh=05OuWmIx0EGQ+z4Mvd8YfoR1xCyiI2LeN4jLN7AezMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9fo7HJbZTgOMXK2Ed3xbL3AHJa0WTzbr4U0wwy5YG0NhSNigepgE1idsz1Px/hwEObT0GZUOFdNFyrN1l07ZhagFEbABRPspoj/b0APqMLCLhueBKvL5SdEnv2wFVqGKdNP5ydPRs3um3xWIbaMi/Mg48SttuxC82iGV/xdkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h6FMVTto; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h6FMVTto"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-261682fdfceso7719475ad.1
        for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758103321; x=1758708121; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05OuWmIx0EGQ+z4Mvd8YfoR1xCyiI2LeN4jLN7AezMc=;
        b=h6FMVTto4lTvhlSyix7AJMzOvZx8LkFj2Op7BtyCRkio9eme4/sFc6rJTMspdfc48y
         CrbFCWkjqBJd55DPLohoGI62HsOxmsCLYuEgyk4VbACHrjqBCYD3qpaikJRTUvzBwZw3
         k15Grrj5MVxdotpBGkzeyXYaqr490+Edh8TX0lw7CJVAx7toXdQc2kD5wjx6jI0HCkD+
         hQ/a4Hy7O1w+bn5V/LZYFSVj3WLyDKasdf/Mhx02ZHwkwAdhgJ3p5DTgq7BwLrNXw+lw
         Dflp2DXcrbATw/KrnyOV4ql4jRX5cxO0whYuWyDT7/5BwNGAo/o3lWOm31Ca9ylbMZ3X
         0thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103321; x=1758708121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05OuWmIx0EGQ+z4Mvd8YfoR1xCyiI2LeN4jLN7AezMc=;
        b=F1KxgskLOLhW0E6IvxE05TGymGeoQ1r1jC5LaWC54CPOdVjtBb+ENRpap4XIR9ac0M
         V3oehb0oKnxdJdFBbk9F1MyxjgqS6bd/iUNyEvlDYc6+u//Vc0SiTUCS7XKAU6C35mwL
         arEXBHBrlr5KFVfzZqtetaudihs8mYzQUzvR3az4OthpSJKYJ4AsZFckGdhm2ZNnqiyy
         Fug2/7oaOoyH2fF1bQr+lE8yg2nEqy4+QVA3jC8F6R/GQlPs7HS2NOjqRgtio07ZTxZk
         kRb1N4X3DBwrs8SJUmy7IkuzueUuMbrCJ+n4u/vzEKvUVTP0tG7a6mNbvQRmXCw/8myT
         VgFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJtQ792d/tOvNij+fNQoF2uAcjn3dcCGtl7PEWvomLttdorWFRmGQ36AGJhhdLztXn/Qeje0H+3k4HZ+Euyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEjPf9J+FKeUObcYNHZRwQfXRRND02ugM5DmItmIFeOYL+Yf8n
	T1dD60ecqn5vv0Mb4p72fNTbX17B58F6/TSS75fGuPx/+91OeL1ZcKsplv6zEDh8JxbngLDUW6D
	JKuo71iZiBSI/wx6PCiqHhcEMLt7z5h3yAB7x5Cx7
X-Gm-Gg: ASbGncu7Z4CPDyRzXxdTOXvEMe++PTuEDYUkh7BWUqqt17+MmhHw9aBH5yEIMdHt4jV
	DDJ3eQYljKqkcXsX8Lali4+Ryf9NCOdfSZGQigKObUca9YiB1oALbJB1xmDlW7NzTBU+OcD/9jK
	+eOsI38bp5Avw3pSymTdfsqX8dWeWel38zBxSkPu1jZZOele+41uiMcTVDSEnec82GieA8iuOgB
	fS0UsCe6CuY/Is5PtQy5WXgmBNLy+OnFnl4
X-Google-Smtp-Source: AGHT+IGZwHVx6Ssa4CbYrghSzzm/47CthhCvCAGo18dD3J9Ik9FjPw6pxNwNxLFS3lNwcuy4I0jlW5OSWsv/mLRISmY=
X-Received: by 2002:a17:902:d4c8:b0:262:9ac8:6132 with SMTP id
 d9443c01a7336-267d160b79fmr67814045ad.19.1758103320679; Wed, 17 Sep 2025
 03:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-3-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-3-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 17 Sep 2025 18:01:49 +0800
X-Gm-Features: AS18NWD7EY3QwkpBx4m1uRgvB5KcwXIFDktxQSExWKLqQh0PwM10VIVvgqzksGg
Message-ID: <CACycT3vFBpum21PBEdyE-acZb+yPqGcig+xGqWP5qPNT3Ca=5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] vduse: make domain_lock an rwlock
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> It will be used in a few more scenarios read-only so make it more
> scalable.
>
> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
