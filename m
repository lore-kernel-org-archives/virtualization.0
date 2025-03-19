Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22192505C4
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372290; cv=none; b=Bw5J3dSWtWsylP/t16B2umJQYzFf4zsr7ZGmOe1iOzQZUT5kZfLVO8BI3Q8YRvQiZqCqTvIfmwZUdFi9zX8S311ba310z0xzQbLSyWnMbhciTT4bJL3sA9EEn927FIj2oJB3lVWdkJZq/QWC94B9I7rC6Pk+fIAy5XwYTGxYMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372290; c=relaxed/simple;
	bh=zKCGYClygELnOz5kUrSj+2y/YlS9cO2lSdiPcMiRq64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7DQd5eI+gA+CWos4/tGz+ZuTcuBz+1eQB9qvGI2r7tS6sHRRcyJnooP/AwYZqLweh35A0OgcqTtL6dElPEM9Sk8z9gRoLTNw4K7/rwWkbLJzP7x30x9T3ZmVtH0TTDmAU61OJ1pzIBxXGgivFTfn37POU4d3KTKRMVEGFe/ykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqgBrrFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqgBrrFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742372287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u4weFtyR8Vv/0WRgvwevHnBmwuMVQABx5dwojXYaS1A=;
	b=UqgBrrFMCR7ZBlynjLSSLIFF3ZfrXMxtDq3PEplMwj7J/yNRPKYMTiAtT6E2VwNJwQgreh
	rXXXpsjbDmZc2YK9RHPgkKYjEkJ0f9tMcJzt78h1b/TxSltQKhcHhf10mrrqwxt7GOeJQ6
	sWs9ViRBpzraZzeo1Y7Wf8m5GVlgS44=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Nfk9vl53PSOzBJ8qGN061Q-1; Wed, 19 Mar 2025 04:18:06 -0400
X-MC-Unique: Nfk9vl53PSOzBJ8qGN061Q-1
X-Mimecast-MFC-AGG-ID: Nfk9vl53PSOzBJ8qGN061Q_1742372285
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e5d9682f6eso5938961a12.3
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 01:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372285; x=1742977085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4weFtyR8Vv/0WRgvwevHnBmwuMVQABx5dwojXYaS1A=;
        b=xIjs/yJqjQixiJYCwh+akXct6ktzME07m0jPNY2Y0dOgvV+tJGz+yuo5ptY4fyMrOX
         HugdE3M/oq2xW7BkYaMA5vy9vuCTjgzxVL7BVIG0tJ/26Akn+671SDosKUUrGxfZMRlB
         zIhMfEsPppxpQGV+IWXYzt4HU5wzc5xtJ/mxNv/Ln5ZU3inFrtMSBRRMiGPG4qg6G1pt
         wiX3dWIMnR7czD2zWdKq1/AVW0H+jlpGRhz8oNHk79zEfIKIyvD77nNnipH792Ln2CSq
         fesHIgpFIFJrZilvJA1pLigt4/WLe+Qy4ZdeSzEGsycg+FrnlsQiDMW9EyAoz5wuQ5Dj
         TevA==
X-Forwarded-Encrypted: i=1; AJvYcCVfv04QuIBendoR462DRkOsZHt2OCvuQtfJccWxL8JlhLXatnAE7ZPDO91scids92CAEyebLUlUHV8iNalSsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa7zR8v6YBCsh/XGdLEDV7d5hD+GdsNB8Rpag6bIM9OO3R/nrj
	UW0TOqJ3+5h12w6qP7lK+2s42oINhKt7ZOq2A8wHOb9B5noSVuvi39C188RdbUrD2ltiihq2c6R
	/GPdvBHQhF/htb3QY45MFyNz7BCKuz1nWAzuAMyVLfJ5FyO+jPuqjKmrCpcJsmcDJ3SBsAOQp3g
	uznVhkWgJmKF/PL/uEiLVWH01S21Yj8VUR12RSTZ0=
X-Gm-Gg: ASbGncuSr6M906twarKjLVn0DiuDACxLFfg77VOPg+via28i9xmQcS87Lk1s/W64cit
	wGogde4N627pIfvQVzQTS4ny9UCQky77HWtTIYaJyXZXl4Q7mfRj3MSRSMzA+Yhjx7oya4YW0uw
	==
X-Received: by 2002:a05:6402:84e:b0:5e6:13a0:2321 with SMTP id 4fb4d7f45d1cf-5eb80f98226mr1528277a12.32.1742372285015;
        Wed, 19 Mar 2025 01:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX9nz4PdJIYgHPcBf3jCqH7Zjv1u+6eHEgELtuPU+YClK9V5WOHBjYADD5j90Xk8f2xxcCVZPPvbntyja6ch4=
X-Received: by 2002:a05:6402:84e:b0:5e6:13a0:2321 with SMTP id
 4fb4d7f45d1cf-5eb80f98226mr1528262a12.32.1742372284630; Wed, 19 Mar 2025
 01:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 19 Mar 2025 16:17:27 +0800
X-Gm-Features: AQ5f1JqtDok_bmysxOd31u7DWf9rtwBh16X9cCFBc9Txej8fP9FvAHet7aatDRA
Message-ID: <CAPpAL=w6bNxmsqpK7TGKM_YkQOLPe_w=D8_rCA6NsQCJCbHktw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] virtio_net: Fixes and improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
	Philo Lu <lulie@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zHHeLGZabeonkWf5xPurux1yYerbilOo3nUhhQdEKAE_1742372285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of patches with virtio_net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Mar 18, 2025 at 5:57=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=3Dz299Q7b4qEDONpYDzbVqhHxCNVk_vo=
-KdP9A@mail.gmail.com
>
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (4):
>       virtio_net: Split struct virtio_net_rss_config
>       virtio_net: Fix endian with virtio_net_ctrl_rss
>       virtio_net: Use new RSS config structs
>       virtio_net: Allocate rss_hdr with devres
>
>  drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------=
------
>  include/uapi/linux/virtio_net.h |  13 +++++
>  2 files changed, 56 insertions(+), 76 deletions(-)
> ---
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> change-id: 20250318-virtio-6559d69187db
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>

