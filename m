Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68D28688E
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437979; cv=none; b=umKXAglMbOj8dHHgStktH1Z1uiuGocKHOaYHkp+WY9HjOxPI3GasGSDeSgyvY7ocmZH2hY41hiUehfs6wQN6RJuuAZxm3skhm3nUYZ5WtlRcZDv02wLoEiYfDSz28jqLJApnqk0mWmjlzeE3Wl2D4UE+bk3l+Bl42obdwn+Ag/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437979; c=relaxed/simple;
	bh=K6H2BFUCEi2QfQRKc29UYNQrKB2mTNx4SSTK6IFQD8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSwn4/cVmO0Hn1ipMFVJuC4bVRVjsaze3FbvaQ8yTKUNMdY4DAFDhhDpQUzedBVWobjeqwROON8q50v1CB8MvFXI/RdYWCMtJJDPk/Eg6wRzlDaTwEqQuM3uUzEX0Vet6wEGskVwr9wihI46uC1p2oz/GTfBcXQ1/xIt3dJQrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhWv+zEJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhWv+zEJ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so5598890a12.3
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748437976; x=1749042776; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDxFHQvEkH1JIzWvj5qIpEsR4Lb7D0NeMUS03kwt69g=;
        b=GhWv+zEJqKevTd5d0B20QLEJr+L5NEUe2Ptt9Qi1/xBCXY+MEd+3Mh03hswXcsZyQS
         5Whd6vWVUDocTnT8+sKk9bCWc/1ECVtNzAWqPO4rlGz8GvyDlKiMAKrG0oYUKv6Nu7yC
         D+HIDbkr0GTHvHb4pPQVba+bS72qLAhARYQsfLH+G6EDY0O8MkboU3FDKYLhVIF+oBuf
         jF+Yc20Up7TTPQdfu7la7mwEpx7ucpPmGRnl0n/DDBZyzl2CeXJ7IYsI/sU0C0hHobP/
         HknG6S90HoILbjW/VVIkQ4iE9d5TWqwt1vAbb4THSE1O7uLXGDIr9bik7pG1a5acbaoA
         BRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437976; x=1749042776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDxFHQvEkH1JIzWvj5qIpEsR4Lb7D0NeMUS03kwt69g=;
        b=pZNhrMbDGVNHPDZt86DnO1k611F946HwuFh/504U2GfoqxMojFptpLMiikqB9QaBmX
         uDoHywCelif/ZSsKjobJuDyTKigdc9tXkA76wTGsQnA4sNxDS3RIgUklr/WW4bHP4cFC
         2Z5txK7o5KO5td7XDqObSkMWv27AolWWP4FkFy0TK2R8MGwBTYc8o22ZcuDsOGwYopx4
         p1vSGRwBDM+R+mrM9ttgq88YyarV/qjRgnE+z35Y+qngB4otLuLp2fxunic5NET1WqwU
         ziI8xSHHGTdwVlxxmzBkHaivZGoYLrepnKCsi4hkjWs72xMhMPsWgGpSDW36bYHlYJmH
         G6sg==
X-Forwarded-Encrypted: i=1; AJvYcCWi6RU0lzOoPpW4P+abuOT74BhblT7f1+0dAvK0NnTRY+uXrA9BziQoBMOAf8UoQmDoSIFcuHtpjPX00hdlsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFqHbkJEKF1MsHbNNT6V3hqNC8XN3ZhD3lu9OaPy+J1c+06tQh
	4q4uPpFCcTWX8p4YRItWBxYadGDg0V1rmw9EYpBLLlVnMIo2n00OxXLarbnfEBDpUCwAXlcwbR/
	HIRoHn0GUZa7sCvQKtBH2xNXi8mxzr5c=
X-Gm-Gg: ASbGncvMxs6CYombzbGlBudlodZRZR1JdbqS+X63/xZxCx/0I6qYv+gn+QaYKLnF/AN
	XS2+gn7of1g6RTvaFdFFyC9bQtQANokD7kZiZRQTVFBAKVCiD2smjyN64rj2EB+CLli3SIRllOY
	xtUJOya3CxpMimCnnj5siu+vMNEu2Bnv8=
X-Google-Smtp-Source: AGHT+IFhkhDVGFAANmTtdUTChqLRW2O0erNbFgfxUTwqBrgn25zK3RMdSjfzeIrEwQHrkRWadm35PCO2q/W+U2IREXg=
X-Received: by 2002:a05:6402:90a:b0:601:9aeb:3d9 with SMTP id
 4fb4d7f45d1cf-602d9bf0911mr12054019a12.20.1748437976241; Wed, 28 May 2025
 06:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
In-Reply-To: <2e6ec46b8d5e6755be291cec8e2ec57ef286e97b.1748356035.git.mst@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 May 2025 09:12:42 -0400
X-Gm-Features: AX0GCFs6Nw5SDcEM0_7E5W7keZ9RJNrn9CqAZhQPdhLm4jHtE_pv_-tpv8ft8nI
Message-ID: <CAJSP0QV1OfRb8K1yA5rKe_SybpbdETanL+XgcGJ6hhpyHB8RBw@mail.gmail.com>
Subject: Re: [PATCH] virtio: document ENOSPC
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:28=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> drivers handle ENOSPC specially since it's an error one can
> get from a working VQ. Document the semantics.
>
> Reported-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
