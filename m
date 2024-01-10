Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC554D103
	for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/s7wvlw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso158355ad.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jan 2024 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704909021; x=1705513821; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziX4iAyQd6HuMoejvtTa4o/24+LLm+GeIG6etI51RFw=;
        b=m/s7wvlwp1jNT0NtXXgiISVYE06BgDu8gdvSlh2kLw/2/XObuURNUc7/xZ35ELrocT
         MGX41o6rzr4kt50BxE+upyaehU5J18bmZB/RYHiGHJPaMDw8E0aZPoeA2BLy7pQByKpQ
         LnAyOh4nz0kaaImK5tfFQm6ru1iHRYlzu5Si0hX153LiEH4zU+wIlpSlCxiWZ7YnQlMH
         vwG98ZUweku7E+ya7dyycB2W337bWhXX/KlTglI3OgFQ+eS2rguxGhIcswsjXZXnj9Bj
         Bjy+w4/htUWIQ58EM2WPXPkJ68+zXPTuf8TiKQhUN60zV8M7zbVgQnSjUOrK1N9WXLhp
         6uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909021; x=1705513821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziX4iAyQd6HuMoejvtTa4o/24+LLm+GeIG6etI51RFw=;
        b=QDwU0/CW+jg4pPPMI4k+WooCCSpTD6rOutvpIuZK2VFsS42UNi+8GVhx+zt+isDGFX
         I262NQrhcmpgd2LyxWBbG2TEyfamawVaRGa/hope4J+k9WRDogIBXNswaebAYvvIRhcu
         xq7YDqYdIXfDNz0mzrvwNoKmRKwO6aqz9gRhkLjGnPHcirQ/8BQrumFkrQWJ3aK2rB6u
         vqb5snrrouHA/Y05qyUguEkyD2IilZ6q5k2KTuFdVF2n/2LiL9EIJ1N7LOsXMf3WNA2p
         WWY19G0B7T0njrY4UO2bU5AReQi+8/alpAf4VYdSfjxWaqTII9nOCaQaeQnlc1d9Dur/
         DS1w==
X-Gm-Message-State: AOJu0Yw8UTMYjpbD+Kd/D3Y7B3e8UR8M/FCGoCNIPurKtIM/EP1Qg1hj
	9L+lN3sElthGY27pWWa1CT+mqSyKHOGYh91ptnqc+eLaMJKISGD0T+S0Y4uI1/DYBtfvN8SrgJN
	BRStdMAsW8rAZXuZ20n9WbJAzwcj76uWIUsRW
X-Google-Smtp-Source: AGHT+IEJ1kVbKPySZnD2kKeOBfKyCBhNXAuJLGSkzYysePXX7J9uu7bfnYGIqnXlWDnqA8f4ASaYZl73K0Ijv1kIfTA=
X-Received: by 2002:a17:902:da8c:b0:1d4:c2bd:eff1 with SMTP id
 j12-20020a170902da8c00b001d4c2bdeff1mr7544plx.8.1704909020628; Wed, 10 Jan
 2024 09:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com>
 <20231220214505.2303297-3-almasrymina@google.com> <20231221232343.qogdsoavt7z45dfc@google.com>
 <CAHS8izOp_m9SyPjNth-iYBXH2qQQpc9PuZaHbpUL=H0W=CVHgQ@mail.gmail.com> <20240104134424.399fee0a@kernel.org>
In-Reply-To: <20240104134424.399fee0a@kernel.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 10 Jan 2024 09:50:08 -0800
Message-ID: <CALvZod4xbQr0gZdfXYNTaS11d2T2hHpXxi5Lfyt=y+TcDseOhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, David Howells <dhowells@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
[...]
>
> You seem to be trying hard to make struct netmem a thing.
> Perhaps you have a reason I'm not getting?

Mina already went with your suggestion and that is fine. To me, struct
netmem is more aesthetically aligned with the existing struct
encoded_page approach, but I don't have a strong opinion one way or
the other. However it seems like you have a stronger preference for
__bitwise approach. Is there a technical reason or just aesthetic?
