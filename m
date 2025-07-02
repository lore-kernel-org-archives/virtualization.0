Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924635973
	for <virtualization@lists.linux.dev>; Wed,  2 Jul 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434955; cv=none; b=ZM/HinBkqzOfi1j7Qbb2s9ckLJkp6Mdi0QMjpNZjoOJ7HGLa/+BCdMsWH1BUXcnKhF68T1kgS+ThTgFWd/7K4QcIfTEUWJlMztdTNIVjSElgNj5i10ku/c3F9hs11mcMezE28Ht16WjtgVlIg0JGLjxFoAe86qPrvJnyQO87S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434955; c=relaxed/simple;
	bh=S+zPo5ERTStSzH9D1C3v8My4jIfYm5tnWHrJvNIMhwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCI+DV7rpe/6ZBBI8mI+4gnLzRUVVs2A95OBTl878oeU6a+YigaqITfugt0Hl9r7WwvrQrn9YDYiNxxg6sXZGSikQLnDQRIXx9p3EH43xKwJ6NgIIkBfWIbzetluJGZXFI4DkIiOAeJ3V0B89Mc65eePDZfzeslAArzJYMesjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hLso1iuL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hLso1iuL"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a44b9b2af8so22424671cf.3
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 22:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751434953; x=1752039753; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+zPo5ERTStSzH9D1C3v8My4jIfYm5tnWHrJvNIMhwU=;
        b=hLso1iuLrvCCzMXYyC/Vg/uMbhNCZi1FwDY3w4L2iAGxNWw11TV8wBcne2yo3vYomL
         3ngtJ2TW2bCOJV3nIgyzw6JEyoX0Vz8k72zq5Zk+JriZlM/TxqCnTlVbhF22RPfd4ORs
         NupDBcrZ8VUyL/k37J8BHnVbT9RyQrnxYIPl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751434953; x=1752039753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+zPo5ERTStSzH9D1C3v8My4jIfYm5tnWHrJvNIMhwU=;
        b=OptteQFDaESH5evPAExvQbJGaRAfqEecMX09QNY8nT0fKPdF/EN5e0+hC4wIIcBc8t
         xBb+ap6wWs3uYQgO/imVeNZsQJkvJ04KH+3X2ITJQd0+1RdW20270en1eO34fqozb6Gz
         bOQ9Z+zaaKjrTz6OtnWOaZ3/Xru5R9WNyghc+3ppPe9Fmoalsb6anMrAwDKm28tWSPqG
         GK87bU9a7WjvD8hL+5mIVs3TEhiX8buQWCSZq39sue6FrubJbYNCeuxUgAxJjBU8XwFA
         LzK3adg27Ia5J/X10awSKpQ8hAqoWMiFXkVul9OXI/JO9LDGDhx5BUNdEa2tltaRpreg
         /UFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL6hZQAunXah4AcoYulkpsqiGdlNWX3ra0YW5QZu2XkJmvOlA8/fEnsAz5hDK/NxZohl3LYfGMOvKakFChrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPMWcMYMWeEp8I9xkCyzz4JDyRpV0TtzeXMM3DzNvLGvL79c3/
	TcMy1EnkhMR2N8zhCFimtP+peZDKNtngK9KjQujVjnKB2waXBcTKJ55pGY6bgGBb3Wy+4BSnfJV
	bh9W9+uyAlTReOXVIDg548lovGFSUqaKlnZvsbLii2w==
X-Gm-Gg: ASbGnctNKGFogJwvpIThEDVOjvsItXaiBFjNeqaUsLwj3KnXPnrktDLmkFg/BvGUKnx
	KUQYS8WUMYSWds9U9k5ymQPiDdwS8nOOC9xpIPjDsQ8OqWyEXx85qB7oHkcdaQMMQpNhcUzszd1
	u4/20JP4OwyqyFhgObjLUyaa/j5/8uq5edPtXg5hvorpll/RwQgYnG/ErfRJHiQ6FhjmH2qQRKc
	Mzd
X-Google-Smtp-Source: AGHT+IHIs1Nc8ZsOhKfJDquXC4dpDHews6mYsGdn6IsKTHmk+3HLxuHFUSsoGWU8khtMjUXM+53CCCsHY5/gWF+66IM=
X-Received: by 2002:a05:622a:1889:b0:4a7:6f1e:6fa7 with SMTP id
 d75a77b69052e-4a97690acf4mr30954751cf.19.1751434952762; Tue, 01 Jul 2025
 22:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250615132039.2051-1-lirongqing@baidu.com>
In-Reply-To: <20250615132039.2051-1-lirongqing@baidu.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 07:42:22 +0200
X-Gm-Features: Ac12FXzxs43CUldwYNNzjBZVxbrBptY9qCnaMpf-lB08P-9mnEL0MjBx8JxcZDc
Message-ID: <CAJfpegvBFDLDQCKTi-rY1zZWukQkn0nN7kU8QcXLs_QYZK5w8g@mail.gmail.com>
Subject: Re: [PATCH][v2] virtio_fs: Remove redundant spinlock in virtio_fs_request_complete()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Jun 2025 at 15:22, lirongqing <lirongqing@baidu.com> wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> Since clear_bit is an atomic operation, the spinlock is redundant and
> can be removed, reducing lock contention is good for performance.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied, thanks.

Miklos
