Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C9214229
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410294; cv=none; b=Ff2+eFyBxUReNcny0+1cA7/3Of6POI2gb+BVSHm7LpgRZzW+yBYOIDHyHnXkl4wRy+kFU6F5mhwrYzI35f8bCop7qWfKudy4YDtT3clrykIzoYT9uKLaJyHuQm8IS2waFDh3p8lennXYJMtId8EYgUGsNu2YuH7NGNj3FmypeUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410294; c=relaxed/simple;
	bh=yQ1UlwAJJHcI/OsM/WOjpj6zZr5R1RBZAV3ItX0DC38=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=N+E4GB91T/PomlOsrtzww4SOOq7Zh+32cIITrX7auNyPgx3VWMQd6GYhf88pk66DC7O6KQL2f3BgDMlwtgiWg+iGR/CkcLJouaI3KU0Yr4hwWR7dgUMLUPLAuhJjFwxsn8p8O9KXQx42mCInMnJpPxWF1x1e31l0xGWspatb6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAIFOzTn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAIFOzTn"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39bf44be22fso4369246f8f.0
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410291; x=1746015091; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3ENo7G6TW6MBK7yQ4g9B813KgFySi5deAa4vwegzbo=;
        b=MAIFOzTnyJTAeTeMJdfuntowxhdS7oBGsnIYqSYoILfldkinRiwM+bpa+mhgMiTjv0
         x9ht4PaYOhJmB+72CXzEAPPQmaV49kahTd3SHpqrE1PVpUYXvsB+aDuUanMG5xbNN0DE
         JSusYLqe7agcuqSJfWqlTUWFdUFpVj3Zi1W7bE1SCqlALAdXqzCkhN8OMzKg910duMwx
         2fs8+AnXm3Hj0Lb5PANli+f89TISv3RE5iLeWp9CQZXLaR7to5//DjCvj5RPHvfRzIzs
         h5WgQ6yOariLBjg1v798U3TSXJ4pXXsywgbE5NtuQ3SiBquyiCylODiz6NECCTH/xXqd
         Ting==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410291; x=1746015091;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3ENo7G6TW6MBK7yQ4g9B813KgFySi5deAa4vwegzbo=;
        b=uf0q5O3n48RqHzh5cA/99B1mGdBMZNapi51iI8LT2nUlubos03JGXfFJ4yGkZbmJTw
         1PopjDPdOf2HUygNyl05I3oHJzSYRc8qvyEOGLpKSiKrZKoSlGk8elU+2wQAOFAoRU18
         HKEoNspHZD97oUX9a0R4WX3si6qZ4Ag1FCGK/PgwRmW59S5S1uP1G5yxIgRE6KdqtzGd
         DZLjEH3I4w9TN8LWl1i5dceCko0pOPUJSHyEaLdtn7lXUaOtJR3A79WmWx3kknmV/0jF
         0JJcl/VtBM5LJU6F/E7tTVFqcR/EIUuPmzEpTfL/miB8lsOvAsKHlnzyLBi5QJhTa+D7
         IW5g==
X-Forwarded-Encrypted: i=1; AJvYcCXdE9/WCB2wBFVFxYFcwRJfxjQIe3aECSD5bfwOBTOCYdapA69gOXToTDsze0oHE8pEl3IDNENaB3C+bCW62w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwuYi5CKNRoW1XRoKxuUMIJj39ugO8gKXdHBZPims03QhzTCjx/
	8K+1WQiKfI6guolyFWLf3TLt4aihT580ML3xNmPb8k62zwtl1F+Q
X-Gm-Gg: ASbGncsNEl8gSBarbx0y4j2dX3Eab6/QLqDDSq+g3c7jA0seoqvGr0JxTFrYF2NU1sx
	bNtFApRLe7I3m34EDjX4qGrR8mdQ/mCQNf2LjQ9vy1zT88QJBXIeWQoQ/+8xtCO9rhIbLUYXZc+
	mi57GjsSDrISvaJJ9ovnzIbU84fsATCD0OVCJ4eHbVAdCBTTnnp1rh+v2A8xAtso/U62lnji3Rx
	RYjIya9aMFMfCKYOB9q7d50IUMW8us8Kp0H19hvS3reh3TSmuLuuAm9+FkwFlKABVFfkwbY5Yaf
	Y0pZ4t8RaFWtuf70Fw85OZhOK9L8FovbpaYKF2qcgNblMTBllLm0SCVi3w==
X-Google-Smtp-Source: AGHT+IFZ8D9fn99GBdz1k+wnK9Zxq4FNrQ2P/nZKAH6ZFy9CpCQ91xB95fWpKA6Gc9C9vj8lWI9UZw==
X-Received: by 2002:a5d:6da6:0:b0:391:2f2f:818 with SMTP id ffacd0b85a97d-39efba2619bmr16139209f8f.9.1745410290643;
        Wed, 23 Apr 2025 05:11:30 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:80e4:de9:c3ea:a346])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4207c5sm18334945f8f.6.2025.04.23.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:11:30 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  io-uring@vger.kernel.org,
  virtualization@lists.linux.dev,  kvm@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Jeroen de Borst <jeroendb@google.com>,
  Harshitha Ramamurthy <hramamurthy@google.com>,  Kuniyuki Iwashima
 <kuniyu@amazon.com>,  Willem de Bruijn <willemb@google.com>,  Jens Axboe
 <axboe@kernel.dk>,  Pavel Begunkov <asml.silence@gmail.com>,  David Ahern
 <dsahern@kernel.org>,  Neal Cardwell <ncardwell@google.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
  "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,
  Xuan Zhuo <xuanzhuo@linux.alibaba.com>,  =?utf-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,  Shuah Khan <shuah@kernel.org>,  sdf@fomichev.me,
  dw@davidwei.uk,  Jamal Hadi Salim <jhs@mojatatu.com>,  Victor Nogueira
 <victor@mojatatu.com>,  Pedro Tammela <pctammela@mojatatu.com>,  Samiullah
 Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v10 3/9] net: devmem: TCP tx netlink api
In-Reply-To: <20250423031117.907681-4-almasrymina@google.com> (Mina Almasry's
	message of "Wed, 23 Apr 2025 03:11:10 +0000")
Date: Wed, 23 Apr 2025 10:55:53 +0100
Message-ID: <m2y0vrtd5i.fsf@gmail.com>
References: <20250423031117.907681-1-almasrymina@google.com>
	<20250423031117.907681-4-almasrymina@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Mina Almasry <almasrymina@google.com> writes:

> From: Stanislav Fomichev <sdf@fomichev.me>
>
> Add bind-tx netlink call to attach dmabuf for TX; queue is not
> required, only ifindex and dmabuf fd for attachment.
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> v3:
> - Fix ynl-regen.sh error (Simon).
>
> ---
>  Documentation/netlink/specs/netdev.yaml | 12 ++++++++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/netdev-genl-gen.c              | 13 +++++++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  |  6 ++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  6 files changed, 34 insertions(+)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index f5e0750ab71db..c0ef6d0d77865 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -743,6 +743,18 @@ operations:
>              - defer-hard-irqs
>              - gro-flush-timeout
>              - irq-suspend-timeout
> +    -
> +      name: bind-tx
> +      doc: Bind dmabuf to netdev for TX

nit: maybe add "for RX" to the bind-rx doc.

> +      attribute-set: dmabuf

The bind-rx op has "flags: [ admin-perm ]", should bind-tx also?

> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - fd
> +        reply:
> +          attributes:
> +            - id
