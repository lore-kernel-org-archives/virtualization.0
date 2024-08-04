Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E623E545
	for <virtualization@lists.linux.dev>; Sun,  4 Aug 2024 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753883; cv=none; b=GmBYC7i1KidHSa4dI6Jbs386Qfu8PKg0Qh+2S8XMZP54oU+2pruhw+1em+VopyN6piA2i2WI5IzUD2y9Q76csHriVmkYV4D7Qdq70D0rvdD6u6zadDXuuvD5HCv4Ltss6/A5YxuemNgVoUckm1DHLIYEx2qfkzBT4mX/jJFxdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753883; c=relaxed/simple;
	bh=sM563CEGX+iYVBrLjeDfGXla4ALwff+kdJMmGjR+TG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiNCzm6roATHJrWVjv3vOSYYi+58U6bzsQI/Vluo8/D77dCIwKoCQZQ+D4pFx7aYcA/1PZw0/9MEAi+8V/M9fan9/y94WVEtL4SSDtlx2OrqWd+HIYMjbZvqT4SNkRBvQlVim8J3gTeUNEOPw1gtJiSck4hWZ8kedQDdjwd3Iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684c05f7afso1203287f8f.2
        for <virtualization@lists.linux.dev>; Sat, 03 Aug 2024 23:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722753880; x=1723358680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM563CEGX+iYVBrLjeDfGXla4ALwff+kdJMmGjR+TG8=;
        b=IrLdNahAOAOc8UZoU7uc2tUPDqxfMxKLRLjR6xIe3qPUjPK/MevZ/0wCpBSw0hTQ3l
         JfvYrwWFk+VO6U/YPtW7ow5UAV1QGSrqHT2Q3jKRm/UYae8b7hLgSpuiDyPvJgm9SBDM
         GjwvvHHWABCm0BSVSa07LR4vvQuP+5Y21UIGZdSD6Mhytk3LJ9dqYzFTvjhCt9eiJBit
         +pmqnqOe237eEfRCesMkeR1XkZKXst5mPlizqpAXD4HrvyoAD9UVJqNrJpaNsjhmLOhz
         RJoQDAbuStKAsh8Xj2iSfMmALuLxd2sKt+wIwMOkQvqshlEVO29Ijynz9z2h8udoKlD7
         kGGg==
X-Forwarded-Encrypted: i=1; AJvYcCVvz7bm7H/e+9M9q5TVCgyeYxLuaP2gjJhNa7KPLoCEPetfGt2r1r1xYkRgHAlemIZuUy+x2cvM9eMI8SYHNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySJ/AtNMytBB067NzEESJMHoOm+tb3bXaZZUMCA18DMugpzW8s
	LDF/zHDrH0ZVnCjptbf38OvMYWus4f5fIx6zfLrjACyPMktZ8LLA
X-Google-Smtp-Source: AGHT+IF+HIEN3u4KbARF8SJvOwd5zbIiuHalh5c4I/D6/TshZm+RxUSfK1q1kRjeS4JttPgnFZS+0w==
X-Received: by 2002:a5d:648d:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36bbc0c8bbemr3329655f8f.4.1722753879500;
        Sat, 03 Aug 2024 23:44:39 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06e0f5sm5973058f8f.104.2024.08.03.23.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 23:44:39 -0700 (PDT)
Message-ID: <ddf1824f-c60a-4908-a67b-ebe7546be870@grimberg.me>
Date: Sun, 4 Aug 2024 09:44:33 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org,
 bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240731124505.2903877-5-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Regardless of the API discussion,

The nvme-tcp bits look straight-forward:
Acked-by: Sagi Grimberg <sagi@grimberg.me>
