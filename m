Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8342E652
	for <virtualization@lists.linux.dev>; Fri,  5 Jan 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn2yr4o9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28be024282bso1245763a91.3
        for <virtualization@lists.linux.dev>; Fri, 05 Jan 2024 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704469722; x=1705074522; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHjuD7i+UA3Qw3m7etGOaevmlRCqaIA5WQMiwQTIlE8=;
        b=Wn2yr4o99/mu+EDiA/AXIWvuSCPa0gk3Csrtxy16QhANcr3byg406v02DVMS9bCrga
         BNnN0F4tS3poyTNvd6vDAOVyo7QgDcCpgdK6j3sER5cI0hYPhK8YbuXr09u87/fFgAzc
         YOe/EjWER87W9EOhvsgmdtiJpJgvaDsUsHr8Olns4TItRur+hVxEo+0vp6JL8vug6Hgz
         qImqZwBhk70UwRkVTrKjj7gOEUj1vsQrgawG6dv0Eg/8y0URWQJuQzOqDZ0cRZyqenvf
         CM5mulns4b/1zqK+PespYANcssyGZwODIUzzsSv14Y4rNreQOEXCSg6kGrH3hWM8vqw+
         egjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469722; x=1705074522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHjuD7i+UA3Qw3m7etGOaevmlRCqaIA5WQMiwQTIlE8=;
        b=pOsqOBbqHq1e3PHxGIj1exXY+WuV8M7yDzul8JJ41+d6c+BjOEkeVsfZe4pdme8WTR
         hbO6BWMPW3L3ly28Q0CSFKxpp8/yoFTOx+EJ42RDxT7WabC8kcTjc7ywMg6+YxP0Ynpw
         sps9UJZ4ta9maPQ7lvoYorDu4gmvwYJFYWqowPMNsSoTozw+rThOiq1F/nyGgLYhlGsn
         vnuELK6Ip4U2xhKbzer+e0tG8dsGsMPAP92gqualeXFdoFTQmocVg+BLmplhsqS51vWF
         +R3/eLvkgzT2qxEmkJuSqvI38wldD5WUWvxioPKJAYjj0Q3HXVs2cPygU4owT9ZLkrKZ
         HSow==
X-Gm-Message-State: AOJu0YxCdbu9hj2DjpIjCAygYfr0/41O0sJEObNmOsG+qePKnLAS6KUd
	XCfY9uV5lGo9867p27qGbVA=
X-Google-Smtp-Source: AGHT+IG4JLyKQE+gM4c27FKh73op2FHqLSCwte9ikVSJ5ZEE7F/zmt6FTbncQktxxFKJuFQG75IOqA==
X-Received: by 2002:a17:90a:5512:b0:28c:ef1a:db1a with SMTP id b18-20020a17090a551200b0028cef1adb1amr1858002pji.35.1704469721772;
        Fri, 05 Jan 2024 07:48:41 -0800 (PST)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id gj9-20020a17090b108900b0028be4f51d2dsm1420897pjb.5.2024.01.05.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:48:41 -0800 (PST)
Message-ID: <ec7f36ffdb2a76fe5cac7272da07242b3a6296f4.camel@gmail.com>
Subject: Re: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Wang
 <jasowang@redhat.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand
 <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Felix Fietkau
 <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,  Chaitanya Kulkarni
 <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
Date: Fri, 05 Jan 2024 07:48:39 -0800
In-Reply-To: <20240103095650.25769-6-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
	 <20240103095650.25769-6-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> When draining a page_frag_cache, most user are doing
> the similar steps, so introduce an API to avoid code
> duplication.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

