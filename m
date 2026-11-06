Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993831;
	b=zYGcX7EGoKqxGzB9nPR6Arl57mZyEGBBXBNMAgwoCuT4UY1dGf80B0MPb+aSHSpkGQG6
	 kv00ewBH/ml8XCQZgwlVSlR50ZtEvrqVyWOSfERC+7kkFIhIMz4NB/uAobfV8NrKAPnnu
	 kFQF6cd4CjtKAYkyXoH4iraBKHFRV7Slflc36QH0TTY1D5V74naMAtgWjOj+LoDWkFG6u
	 m/gtEO5Odna0mO1jCnYCM1Ywbdx1H1VWsfdxIGMWnrkM0ImkU59LJe72pNeFO/ffF9G3d
	 c0np+pYsQ0mmh/qhnKumjk0V7YzTsrIcVwEcegK1qeU9uncNy9M222dbDdN055bWWWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
	b=jcnOlPKuEN5qUavPw0dppsWAQxNFacMkyScsvnS3EFXjnAcGWEKYKQ72ZdwwV1kCywHc
	 Ja2FsOnG8LTCOoBEQLvKNzyQYoo7oRNKATG+WWahnoV9zkjZTJkxtC6AZ17TydXf5AL1c
	 B0LTL0I6B/NpB8wH5OFPvd0Kik+EbtzqeckjnfYpgl5hlCjJQO7lz/OCmtTpv4fH/pAbf
	 Nlh31j05fBZVZU/WGiy06UHC4MgMnDcz/M9jlxBM6QW1IfpEOAnvlIYuq7QccTET7AE5O
	 qRITq0YOJwFoSZskELP49HS+bqg0tdZUCTUxOoRxlSaXDO86uZ38QBoMesAE1OPCT3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ddVuOiyA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF535606A336
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 19:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF535606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ddVuOiyA
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso339a12.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 11:37:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993829; cv=none;
        d=google.com; s=arc-20260327;
        b=YSwiEXu9q85B9VIXTYMOEJw92FUZ2TCTrTMKaWv7o6ee7tTlNSQqD+Gd32dGo22e72
         HbgaK9yD3krXLy9ADOyq66DOzZlJOR7gO7Zcwnb+NesycMQAP8bliVOXdmORXgAnEksb
         vhkXYdjKF0w/THQ3GPrMJxPg8icQMmjgNEay9K8xGJp5EEjhFXhO0otn3LwBb57Lz6wD
         anrXENmiXTSQZfIG6nPHd0R8jNfWV7368XiIh0gzfWI9hlg2zAfKbMWIJA0bvePyyvKf
         nzGpL7o+/1AoqKDL0+m6Ifpv9l5Cn7IhQYOsGDtikABcLW/usInGNrp1TtQliM5WV0he
         fhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        fh=vItNZSp/xGhhnQdM85ZWPHFtJkDOyn65qFktjmexZcQ=;
        b=oG7YotHiWdM8feugV2tQbCkSA+IHlL47kAUAJZEVQeavu9nNYufZvfCZBfmTC6sCV3
         AwZkOrQVy4wZo3IqaIBtt2h3Qkg8Ukd6TEIBQZ5pq1J4qBa4hK8mshZb6hwtCaxsofd6
         mgM3bD2sbJSmQybXmm+l2aVCyQ2YXgOxplThRPDMOaDKQnW4ljdnli/3obaNgyYG0RqQ
         a4cTc0ZUnU/ao/qdOuwAHGkO7bywgCNUvwFKvI/hhYbiZHs20gM5+VEmBVry8gYu+AY5
         KC48va7j3y991didmL5z2Z9bPatKTgMKItgC0E0lw/4LWaFx3lH+QLCfdbaHwSUCktFT
         19SA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993829; x=1794598629; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        b=ddVuOiyAVwsrosrtiSdw861G4QIxMsiAA44yuWUkwJBVgjtWcHZHJIPKOOlJUjh/zn
         XKOP4OvPk9q9R1HEzpA8ms44gci9HcHUsJymkIGw3IJLjoHZ3jIb9ETyqopUeG5ZJwKg
         R8eXaoJUeWjRc1YOsjghUVEd006Op77Iz/KD+IjNs3dgoJYE/7+1Vhom1m1yLiCXuAX9
         eHB+HIjP5GpVguF9CdgNb5YqbKS+GES6O1nHjIUisMQR35DJsUm67Rj5a/6OoaZWWsQW
         7Z+TncRX4jwmgeYKHOoBUxr29bxKxbatOb35EwiaF+XPEiZO7074+wE9bQ1Iyx4pr83L
         uAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993829; x=1794598629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v077dxPdbR6B229Sx3h6EgyHNBd+S9MvYu+3WDhncOM=;
        b=dJLlZ7gTeiLBODxVSAfTdLQPcAdkK+dBRNzRk7mNnOykI7/K4rv2uwE1mc6CGdU9th
         eap5Ovp5TWUv1yFqmZo9N5uEr8MfJ7dCgA08+KWc9MHfeeAMWP6qDTOQO7VUo4IW/oz5
         bnFMZoU1e0siTwj8XCpF1fpKR0nuzyXsNjfYLzJxJ1xefXuW/9UbTLCyTpgpEH8xSH3x
         jGQN9LOUXjSomxUgXrqrrY73IxBt6HjB1wrY3wWiFClMgdkROTXLaDYhCPZoTqp1hA/F
         /DD/MGJtSEaQl9tejxtvuySCsrSbWtc/8Ik+EJ8FGFth44g3amtm+d+R6NiBqm2lW330
         oIMQ==
X-Gm-Message-State: APuU4Z9Bee1vx8K78bmxu8jNujUgfJcFd0n3Q1jghlJ1YqZQ6kFGVBw5
	XoFzvYqhjnmOrRYyg6h1GeO4HS0nGbol8NX38GU7qSAZkHBbJREJgQNTdJWAkDLmiWL41IHJJem
	AGzBo5bCll8q6HF4nvvNouYIFj5+wdbh/SmbIRjbu
X-Gm-Gg: AYBFou0v/p0jLJHVMqb9nRtAkXjfguEU2LQy732+IR/DyQfqpilMPsHnIUnHrMIlhek
	ac9vUIxhcIPqL4rdssLpe69YBOVkDW/ZDDX/JP9uxCx2qpcIrrE5t3AsSpVnvFw7Zg1nThgZfP8
	Wx5LsqLhSr5FbDvnmfGEljR37IWYr/uMwYfLi9Rr4paGyHiqlYjRghT3YJxxVg6W4YLEAaeiPEp
	IGRhdfgUxQm/mYkTFZ9ulcwpesjRwR7b42kVxWy8nqkegHxOJEFUQXNcKyCsgOq4ea219lo/yWC
	3/214ZTe/nTk9kCFOyOBjM9hY77Vz5jXUr834QzvmcZf3S+8LUeH/BWU+EsAWC/Ik8Ei5HNs7zW
	Puz1oqc75cRwHeXstsSrj6dLoWz03Lr4T650LecUJ0I8BqpS3F+2g1GE570QdpcP0G0s=
X-Received: by 2002:a05:6402:23d0:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b6f845ff3cmr14348a12.15.1793993828178; Fri, 06 Nov 2026
 11:37:08 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com>
 <20261103211424.127627-5-almasrymina@google.com> <sashiko-outbox-198073@kernel.org>
In-Reply-To: <sashiko-outbox-198073@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 6 Nov 2026 11:36:56 -0800
X-Gm-Features: AclHuK-XzQbdvaiv61WJyi_8ZqhwGRBCNFscgmlOjr77cMwMQUJZYeAEPiQPfDQ
Message-ID: <CAHS8izMDj5a0xyX4HAoAt=djt7As-Ko=LyEUfq9iJnPoCegXsA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: remove skb->pp_recycle and
 consolidate netmem refcounting
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
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
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Byungchul Park <byungchul@sk.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vikas Gupta <vikas.gupta@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
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
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>, 
	Frank.Li@kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 1:15=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] page_pool: TOCTOU race in page_pool_unref_netmem() non-RMW f=
ast path
> - [High] tls: page leak between netmem kTLS records and mlx5 tx_sync_info=
_get()
> --

Real issues.

pw-bot: cr

--=20
Thanks,
Mina
