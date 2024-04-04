Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED183A19
	for <virtualization@lists.linux.dev>; Thu,  4 Apr 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230892; cv=none; b=YUWzvgYI6Pp3NXqavHdVyk3t4a880/x/Fj8MxiWIABBXMSEcEU4YfIDenczisuUQVImrnSr9E6ctlW2Jfqew6S1MarpPmHU1uHeNneCM32jgG/HQqf34GirDoPQ7JN5TwABZUKIAjhsMTX/mkn4z89ywbVc3jlAqk/KiyNaU/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230892; c=relaxed/simple;
	bh=xTu/IdCn/048THaVHddyM991QlKheudeHaOzDUEba/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxNUye3WScm5H+r+2wccoZjJ+D84haG6kH/nX67a+dXWLAehcbhVKWo1EgYuVFINFfQd/9Ehj4MvpkbCJ5mJdY0je+TlWTHKGRQy5qAAjYxcjpN+5Xy1xhcK32ebKMg1LVQ6gySnizrFJTk9YJkrviT69IWOfz6CJ2h72GcchXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/l193E/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/l193E/"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so1002342276.2
        for <virtualization@lists.linux.dev>; Thu, 04 Apr 2024 04:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712230889; x=1712835689; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTu/IdCn/048THaVHddyM991QlKheudeHaOzDUEba/4=;
        b=j/l193E/44huoJ04oBkRB2ZnTXE6+p/NUCx8c35Myr8DR1iqSOtfR2Fz16hDbeJ1OH
         tUExXpGQ28dkceUDdMpyO8EbZRjSCrex+1svJMWBUgMGjtORV2tIu1aUU7tRrlTqseAW
         3xBtk7B1sZWDxq6CBSHE23og4y4Uf0xWMmAPTgeKpXcaQUESIoqY/A0oYtntVtq9wzjm
         lJOxkU+B0t80gJwZe9OA2Oo42MF8k5j1NhzpyvqPDfPA7+hO00Q1BN72ZWALO04aNEn/
         BY01VUCN7ueDh8EfydFPuyA/LoG6wR5CeAWHszNIXog+FGeMZVY6ZzFMUx6QC5hmrLKo
         Veng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230889; x=1712835689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTu/IdCn/048THaVHddyM991QlKheudeHaOzDUEba/4=;
        b=XMCUoK7WuS2yY+/4rYKHrXVDfkAK/dXWNaeZjyui43eQGmRm/yOKHLyNpIBxFmG2A+
         PZ7y1w8KCEjCSzH03nViWCXuGjp5b68ejRbpKKxw6zkKrVzQA45QBM/Dmo3Tecd3jowg
         T1SIS7UWun73Vp80JaRBODKoWBpNyln939bCtHsG4oSyrwyrnFh4BZS7KYZttL2oqLqa
         of8YPlXt7Ui0xKn7dIvFWNGCe8i+UP07awzM1vAefw9X6MGgI93l1IKI9Q97IPysAR9+
         JUn0Io7p9rsxj7Wv/9W/Z808y6a0ixPPJlI+dBznED5PSjJJh9EUye/emR8Y2GitBVbA
         G5aA==
X-Forwarded-Encrypted: i=1; AJvYcCWudfwcweMXA19CLStJpwdNPBywyfj9WJoYLB1apAgZ1tEEHkzuyzQI+8WQxSO7LTrk+G7HuB1ePLHLANOVlzrIZEnWGdKiz761ltes8Zc=
X-Gm-Message-State: AOJu0Yw7ZdpVq4tu0dH2HwA2dkIzJljkyqLNVnNZBnQQ3Ar5e14k8vh9
	yZyrSJF6ac8zy6wCw3ibcJCj7eN/wzHk1G5xPAZnl3seeaLJ2qQmmNG+PkV9/OhVAzIQSPm2uB5
	8bA3FIltSM+L6ezYA3DQFiqvM9Hh80eTHgW4k8w==
X-Google-Smtp-Source: AGHT+IEhL+O4bSIOCRsSy+Vdywn61xtrVBJ3li47sHwN1FOt8H7g9W+tj2/Or7rao9/9euGeRsXbtXq4vPMz7+GnZRc=
X-Received: by 2002:a25:ba86:0:b0:dd1:6fab:81e4 with SMTP id
 s6-20020a25ba86000000b00dd16fab81e4mr2034373ybg.37.1712230889318; Thu, 04 Apr
 2024 04:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org> <20240331-module-owner-virtio-v2-12-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-12-98f04bfaf46a@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 13:41:18 +0200
Message-ID: <CACRpkdYpVUq1SgxnPVfRdTiNg3o8dcBePxoxu9GRYy6LdzUE5A@mail.gmail.com>
Subject: Re: [PATCH v2 12/25] gpio: virtio: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Sudeep Holla <sudeep.holla@arm.com>, 
	Cristian Marussi <cristian.marussi@arm.com>, Viresh Kumar <vireshk@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	netdev@vger.kernel.org, v9fs@lists.linux.dev, kvm@vger.kernel.org, 
	linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 10:45=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> virtio core already sets the .owner, so driver does not need to.
>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
