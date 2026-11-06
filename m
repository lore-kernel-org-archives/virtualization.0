Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987600;
	b=g+aACD1I9hQK4qGrUPElr35zblVWyxkx/HwWZCmhFY4iWu90woDAE8SF3SSynKtgjNYL
	 fEIuyKldtqmVg+lk5M5dLKXJiF87uecOt0zmRaUnrL3ZLf/ZHN/Ychbfhpdxxw1R9sSQN
	 MjLd77u94IUcGEUPb6ndrBStk0HTzWHwCSScIEzfH+T7j8McPRd0d2MJBXx1XJzy2evKF
	 J1xZogZ0wp5UtTt9ICJ/rN8LEQYs8ov3JrFSlw0Fi9rkClGE+tOAnzcsrigRL122KQw6Q
	 2ImeNEQx78JdVAwKRUFSkUI8SqrGXvtDA8YvZfqTWXFXerYuIf321G2e7iyQzzTJx/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
	b=mbV2c0KsFutXU3Qh3EJVTNTt12KuxgA30SEIGrG2R0m/tfIj3nCFbHwKk/euO6x4fljq
	 vrOtWjoxvTTe9sia6xDevulFNaMUr2+rs9ZqXvt7BgLjIXtMAq4kah5Bdj9toYyhmewMv
	 7s1QSFi22hrRF0TNwN1XoLJvs+s8tAvyN26rwvKj+Hl2HsZ/Q03OGSl0BPDTb0xcKHw2/
	 JAHjBy6QvqiTFn/PVHM593ENFNBQFHDfZXI+KkOmFx8hVWc1LWYvMmoPlHQv+B143bpHp
	 XHsgONiuiQm+r+jHzfZPzYeckXhOwKAJiu9TMHAd9/dThAeaJWlEv6N8wiOuBJOaM/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Th9hIdKD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312B606A32F
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 17:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7312B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Th9hIdKD
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so801a12.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 09:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987599; cv=none;
        d=google.com; s=arc-20260327;
        b=ml+/RUzVJKq0XgXBXFXdr2hv7hAsTVFeNg9Cz8Fyr40arT5EbO3EXzxgr5glTSY/QP
         WiVFzU+juebIpBhugfE8qkpkdggfpFHi2DvxTVjmLdBrfOLoi6outKnQWjy0AAnRBw44
         yBsTGGgGarOCKktUy5eMcKsgnp40MCRrsz7RJEIt+X8gKr129HL1v0VmdV6N51xHy6vG
         ElOUNkOmI+5CEDYJyfdOeu9JDPL/OawLsFQ4k0qRrLEpTCBkv8SfFAtgxAiT4ReGkuDv
         Gw4dVcnXh+ZA9fCK26Mlg+eON6MQW9WimaJ3mlPWflX8eLZVnuRJydM1ADUje3+bRXID
         +xKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        fh=ecbtrLdfZxBsKU1514ZWwbV4aFsifWvyIBCm1HehCfk=;
        b=DOzG+KVXROFwC/uXmmv51Pv3wy5OGErplONva76Ecpkpn8V8HZZ9TcGKMW7qflzyN3
         rxN2KHHi7Am+K47vzunq17lld+Ca7+eZnf9ebqTeEzgFooJ4SQlCkEJvtdRqZs0lJeiX
         6ISvDqiqbb28+TjA3lWjKXNPKtnkxmCVmx8Vv1eOt4GboDJ7m2HAdsUEqXQLdJuurwNU
         QqqixaboYwsR9Uer9YHaL/aQ4HN1YUhmF9GMtIK65elMPSS0aPEdjunz90wjglRpGuRs
         a34Yn4XuAg4VymQDr/1YmaWE0pPmRABotqzp8xNK9XrBpt5v4xZNj5mHTx1tUsiyTcHL
         9etQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987599; x=1794592399; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=Th9hIdKD+Pr+y2Leqf7USTebRE0FOTbhOHirWteGBscPnxhLlBfUzX+7zlHGi8fXbd
         0ep0SzZdSnuI+ACIiivcL2Efujs8z4MyJqLG78mCg/GX2HT4cR89G77MEZNtfDWy1Wqn
         1ntwJ7FMEn191DrfAm/KH1Qm1CTNoCqhO51mVhGzO1++h9nCjIxYwJypxl/W1R6Wn5Qx
         ULSz22e9FU0Nn/oxxHJTV1Eyzsv6Cau38h4FnZnGcYwwsu4OnufAEo0ieWfhyPdrEdgU
         gi+a7i5TfDjG+rWyuepnRwiavIdTJ2LvCUSEOB74KogL+DvALYRHWl5v/ZeuynEP+hHT
         XJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987599; x=1794592399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pDupBwR2/7t1JImpr59IJwI8nCk2i1PzTMP7JDf060=;
        b=2VzkZT6hXYJrLZfEpQW897WpfEOoqtVuHVMy6eGQw1fJfc4jYGxdX8vLuuRgNQvlSo
         Ehn6zREBhA6oibHIUbTVSakp/Om5dRqe1KPEtSrw0Hrc1tvCpFOHvppJYb7TcL2WoPuT
         KCF9KAvmDRNXcpoWg79QIpukFp9/REmwJ4tY4thcMMEA9eCh3nXfcjEKu1+jj5FPS2dK
         heSEuBmEQyct3/1aOZPHPZOfayHI8rs4DLq/55X5vJml1pJBSC7TztY4NTR/xm1zHxbd
         8p/qm6jluqGGEfg58oouDWABUpo8merdSJwTP5Cj1eW2xCHvkt3T97LwDVul8v9AuOtI
         JaJQ==
X-Forwarded-Encrypted: i=1; AL+hErEtqQw22VMYQ9p5HeI/aTV1h3vOQbr2EHz/gexp4bP4FYPhBAiLzpulKHKIYLP3fIgInGhid2AjF1kRpMQIJQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yQggfJ1zZ9GaXI3XosFNALHFww0N2vtkeMP5oaHU+XohjH8Di
	y0WI/EzcvHqKw6oL/LlfTQTh1lIBD3RuHxK34DUYmiLlFyLmf3fq3miOZEIeaoej47uPD66z8Bz
	E2kvvXJv+5b3xhs5WUaPMxqDmQvJQDCtd0kv9FY8e
X-Gm-Gg: AYBFou3SEjGQZ4IIMMY6kutV1CYRMzwRjTS6AlVNYc5/DUltsLuzYYK9+AoqDS9Za+W
	2C/I9JJEUCX6p9hxHvSIs1jZoMXOgrYBKryqcN+ckbcHCtZpxGonBiaeLRs2BVZ94C5TpP8Sh6k
	D8O1cCog0zWiks+IwXihHwqjDGbNJYzcFIfOoE8ISUv4Ro0GWqqNVXsneDfKrBUg3yvTne6FrqA
	9zfY2VRRzzpE2kLHFndpiH8UuN0wH66pSRCc3tyouME7lZAnSKimororHMP1B81UXJ5ST/7Xcti
	1f2VXzQ02knqfnVsrAZZlv13YQXcPH2cfw8iMDUYz0yF3EIlMsQtj4whoSZvh3WXqfj3cl0kucX
	vLqKm0IBBS+YvnqALK580CoHxv3ItT65QXncY6xfP4KWv1HGaB4hHiTPGqpkfX/2yHWE=
X-Received: by 2002:a05:6402:20d2:10b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b6f84514ccmr6722a12.13.1793987598073; Fri, 06 Nov 2026
 09:53:18 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com> <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
In-Reply-To: <cf2e3292-d591-42a4-bf6e-76f4567604c6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 09:53:06 -0800
X-Gm-Features: AclHuK9NbTvBEPfZwCm6iqd7sXh-jqNYXp8FMPv7QJO9bGGBVmf4WllHJrUhzyo
Message-ID: <CAHS8izO7QmD1qp=QfUsCq-R+p7OuOVUtqPJZh1k+u7H1J3KnoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: deprecate skb->pp_recycle and skb_mark_for_recycle()
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Willem de Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Byungchul Park <byungchul@sk.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, 
	Philo Lu <lulie@linux.alibaba.com>, Justin Chen <justin.chen@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, 
	Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Yibo Dong <dong100@mucse.com>, 
	Brett Creeley <brett.creeley@amd.com>, Justin Lai <justinlai0215@realtek.com>, 
	Larry Chiu <larry.chiu@realtek.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Ronak Doshi <ronak.doshi@broadcom.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Eric Joyner <eric.joyner@amd.com>, 
	Mohammad Heib <mheib@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, 
	Chintan Vankar <c-vankar@ti.com>, Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Kevin Hao <haokexin@gmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 11/3/26 22:14, Mina Almasry wrote:
> > Remove the per-SKB skb->pp_recycle bitfield and skb_mark_for_recycle()
> > helper, and reference-count netmems directly by their underlying type
> > via netmem_is_pp() inside netmem_inc_ref() and netmem_dec_ref().
> >
> > This series simplifies SKB and netmem reference counting:
> > - Reclaims 1 bit from struct sk_buff (skb->pp_recycle).
> > - Unifies reference counting of SKB fragment netmems and regular netmem=
s
> >    under netmem_inc_ref() and netmem_dec_ref(), eliminating the separat=
e
> >    skb_netmem_ref(), skb_netmem_unref(), and skb_mark_for_recycle() API=
s.
>
> Part of the performance gain from page_pool was to completely avoid the
> atomic refcnt operation, when we can see that page refcnt=3D=3D1.
> Are you removing this?
>

I am not, and this is a very sharp observation, because retaining that
optimization was one of the things I struggled with my LLM to come up
with a way to retain that optimization without pp_recycle. Patch 4
includes verification from pp-bench that the fast path remains just as
fast:

   - no-softirq-page_pool01 (fast path): 37 cycles (18.7 ns) baseline
vs      36-37 cycles (18.5 ns) patched.
   - no-softirq-page_pool02 (ptr_ring): 77-78 cycles (38.9 ns)
baseline vs      76-77 cycles (38.4 ns) patched.

But the sashiko comments indicates there is at least 1 race related to
this we missed. It looks like a smp_rmb() after checking the page is
exclusively owned may fix it. Let me see if that works.

--=20
Thanks,
Mina
