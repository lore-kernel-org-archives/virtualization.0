Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D723D7CA
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826240; cv=none; b=kWpf7ElkAOH92fefYO6fNq/AcFiXTjal18OUuzSPHNRwsvN7VLD8SW+2lCzz7TaEASQ0Ba39wIRiaZd1TWxhN+H+E9pz9zx3CUXVFhos9dNI5auZzuzKfoFk2MXLV6h+q1+ZG7BpVjfLeLhinNDv9qD6Pzol3ERGNhTTU4Hiqtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826240; c=relaxed/simple;
	bh=zJ1BMKe0xLHA2vcalytGuoCGulRSfJEWC9LqRcwSx2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPrvKrO1EtGrL/FXo0wpDgZf1plP45/uqUFePtmzpzUJCaz82UBKrd+qEOw1a8S0heY8XIX2RnV1V7uWIDYzuw9U3E4RDjk6i/Hm+qCfXAlQPdJyI4Vxrnrmutak2S3dc1rDrRmqX9jnZM+/xUvMhXoWZgw86c7qzq/f0s37dS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gf6G889e; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gf6G889e"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso933900b3a.1
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761826238; x=1762431038; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oJ0JlkrVuBslS3CgdZDs0o9o1Bd+9FyfJgJWBt+B10=;
        b=gf6G889eyUEfrktBzgOXLDkoVleJ6dYfr40RekVSpfXa3NZxKDrSGQVGIlcQC+iFJ4
         MIHaY8XYVDyU22K9aGo+PKqyYjudRR8/rbVE3pmf1HgXcdyF2xGk3Xj84qrUedotjOJt
         zxLmj8YhWgl1/P5qWsH8wiPRWfpYxsDg1TiD5E4FRy+3v6W92T+V42XdR+6CVJG4z7S4
         /76ncmlI5akXrFUMo/4+i8FJlCebz2ArTiCce6VptKNhbyYAF1v4HRVB6JMC2ClgZwzX
         mqm+LvYGyvxNh5moYxEGKkl3NDN5v/vBhc4muDZ9j0DAMAtvwq9dklu9sT0U9dSkzSw8
         vi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761826238; x=1762431038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oJ0JlkrVuBslS3CgdZDs0o9o1Bd+9FyfJgJWBt+B10=;
        b=mph8UNhgS0sNY1jYNC4lQJ8jpKSORzza10yAq9t8gSMsL3Oupuae5hfwWz7O/Pt3v5
         d3fCj6/0HekENGOUZT+jO3irvIJLO7+NWEVdaKV9Rk8NvFMWVvhyeEAW9Nh4s2Tk17Ia
         nXuCTpB3xDqFIFI1bUPWDOZoPrmVDssc7XDDyiL7IfYf1MWvqjRSgCNw81+6Q677JzvW
         EcSf2sPwpMKNeh52LcfR69wWQJpkhVyRPW0RyqPQfjTIug7bVwxBR2BUkY8kyzyPsz8W
         GVmlIRkS+b2jP88w9ektmHf0p73bN8kNzhEZgYedF3f0hPYcQ77yQixYhoSnMk5gFSJ1
         JLYw==
X-Forwarded-Encrypted: i=1; AJvYcCVBaRn/W1kl+Gnio55SrdELe53+Dwu3RmeC2xFK/PHwJtw4j4azQkJvOtxlB8GvCrfkjMkCXYj9AacLMzXfeA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx30CteqS/CFhgp88aEveJ2kMfnFeI2EqxA0TIoWWdWSyGzoqDW
	6nQLusVkj+zZkf93rtermX66E5lZtB4528jQ7BBvwTcx+C27eGxiKPJALgF3qz6Fg4CAlTg/lq9
	ZP8+0Sgi6tEHUKSDFfZ1pT4DByt2/GPiQXO5Aj42T
X-Gm-Gg: ASbGncvRpMWHCqyPpHQVeSz4smLML9d1Bg0OAgQ1AYS3PQMrpDxyTA8qPqRD/ogwa44
	aUl/MVWY00hDRnnuxKmi8/c3KvqXj+e5AD1a63zyHWELK7jim0U1yHQ0Lu18bXz5Pi1Og5z1lpp
	nSJ8b/WDuKZz5Sof0commGDosQbu7luMAVMZzaZIwpwinKHaO4R33F2qB2GE2kvOkuRxE/Czv8g
	BXw6UJlQbPp46+onrWp8iKi8MPl7ACizfHfN9940Dlu/+uWNw9XeUqJw0OkQHkHHtxu+Qj6
X-Google-Smtp-Source: AGHT+IGcdPel/fTbcZF8JyrLGWNlQpLy1fw1vn/jk/bK9k05MEnRYPrwN86FrLI7df4o62yne5nLNvB1jzmUZ0DyVUY=
X-Received: by 2002:a05:6a20:7285:b0:334:7bce:8394 with SMTP id
 adf61e73a8af0-34654fe4068mr9064766637.51.1761826237600; Thu, 30 Oct 2025
 05:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-2-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-2-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 30 Oct 2025 20:10:26 +0800
X-Gm-Features: AWmQ_bloY2C-mDC1zXHDDyiHqhx48yeEZti-RLhfuos4-6prx5z3FKe-_-91q-M
Message-ID: <CACycT3uwzDc4_Xhg1hOuEpBj9G21P1OJjJyt+GCWi_=NG1ad7Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:00=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This allows the kernel to detect whether the userspace VDUSE device
> supports the VQ group and ASID features.  VDUSE devices that don't set
> the V1 API will not receive the new messages, and vdpa device will be
> created with only one vq group and asid.
>
> The next patches implement the new feature incrementally, only enabling
> the VDUSE device to set the V1 API version by the end of the series.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji
