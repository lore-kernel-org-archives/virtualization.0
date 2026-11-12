Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794482417;
	b=GKZjRfE8xnUm5FA8VWEABtUHYV1+bBoC50DTZpbjGTGNs5ZRsFMQFCDLMAx36KdW3gGZ
	 TWHo3jGrdcZgu3Ju+pQ4V+AUIHTJd3jfC4Y6EiV16P1cIQ+8YkzCF8NebcvV5hzBJVgmg
	 7oPLYDc9mCRD0I0rsm9WDa1V4RopLIjzCt7N0QMy9Kf4ddRJ2ZiFmquSXZz6UuMil6S0R
	 rJCKKZD9NetY+VC9xPFDjvK9RGKja3EBzQet1O9Jp5P98ht+r+FDFugjADGc1G3oRGoNO
	 1trWXG8hcFaxwO9sg/cKR+1EjypnmhKckqxx7pB8Mk9RPnznbHAJp4oSEL28hw681Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482417;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5ziLmMlwTQBnBAgwJdnf7L34hsFaEYwyaTVUcHngXrg=;
	b=tZDN7Tr195NyNkZNseDNYH7uZELX6KaRrLxU3srDHhb6Dj454+oZsvI9OAb0IjMzG9f8
	 5NSRrDgqrFyRR6hEOKcegDZiqqq3XC697KQyGp1C77dZ/XNBQWhOWdqKIaWPxYz7seOnt
	 Mp8/8wTtCC0gtgNoDRupU+2dSsYHoXGaEIBEAXF7a4S9ouOA4olVIXhHgGjequ7pgKTG4
	 ced1ll1QQ272zlVG2tREhH93hP68PmK1YemFATaWb9oYm3OZyn+9yBtNHkOjiXNnupOdn
	 f2IgV66Xyh75lCv8bcd2oqBRL6pTMjILWm8Zpue3sz4vS2cMtOaWceeBkdL+hDqew2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Jqvlzwte;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498660A2623
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2498660A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Jqvlzwte
Received: from ratatoskr.trumtrar.info (unknown [IPv6:2a00:1f:f805:2b01:a03:2f4:308a:7b52])
	(Authenticated sender: str@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 20CBF202C8B;
	Thu, 12 Nov 2026 12:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ziLmMlwTQBnBAgwJdnf7L34hsFaEYwyaTVUcHngXrg=;
	b=Jqvlzwte4CNvoUmUqCJjakfD06Vqd8vBwJRhwk524wO9xJaBJAG6u940PMBHlFeB0T2JGO
	vfTl25eCtVEJ4VgxXKmlNPnwGt5LaBkWu7WK/2zj8IePzkbgXq65lzRokNqyeIv+XleExq
	2xHGyUasfnq33NUKq0fYuWIMpjI7l30bGjlggXdF8A2kgQ5x0QpVfbeHI0YlofAAlbNFJv
	IA1Ew+7lwO/RBgd8RndIy8FISlYA9V21TR6SdXm23JCkuPtI2LaQp1AtZY0dhgBquI6Ay2
	87BSnPlyMYPk/9U46bglnc7UAUSCubw85UB17ZfnIspoNiFZ6eRescjwVhFstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794482414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ziLmMlwTQBnBAgwJdnf7L34hsFaEYwyaTVUcHngXrg=;
	b=dp47u5dGkCJaLq3lmXVqaYm6OOADpkwXoHYGg0u+b3IdNH0zguJ/IvNLXwPv7lcueTJIXW
	xgVvolfrV/cwsY0Zaxh8LbBGJO/WJKTBZ4mE63rkwDsGQCEN9qYFH/VAe2ziAEglkrkwL4
	en/inP1rNB/mZ4FwAjallDM3dbHVjDnv/6i4VItrjR1lSUIaI4LP6HrTco0UlzVZlOpeFf
	+nLcVmK7P4FNu5nEJHny464KOKd5vdMM+CjMp3Tokayk0F1u8f1DScJsBTHT+DjSMQwY7R
	08VimuIOg2sDjVpfiy8UAMdF8GMyXUYVjPK0tFn4NSF00HzOiuQgBCK4jIHcRw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794482414; a=rsa-sha256;
	cv=none;
	b=A78Xe278fURcZdSSdxlONOkmr/vh8dYXz5RCqhYwtWRRgcwtByww4k0qSc4LXk4OQ+lClb
	4qxAZP/DoRvdUTe782W1cRuik3avfmHG/0Edt1DAMOyuC7eu4/WsRicmZboLUQ3u1q8l57
	Sr5iSLKqccL1X+l3CS+KXjQqhpz93MvlVVQNUTPSmFhJgNMIJyI51m8UC+VRYxTisCYvZL
	Dk+/H03K0ms/yEf9oIvtn4sA5hZhfBGONuoo3t5bKfMdggE1csuTpdhYUpjo7MXpP45BFX
	LwdCmSf+n7s46YqwM/ZWMyg+kBrw3HzeDtlJp0bUYJR4YL7oYEqhtbPXhqmTrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=str@pengutronix.de smtp.mailfrom=s.trumtrar@pengutronix.de
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Thu, 12 Nov 2026 12:19:33 +0100
Subject: [PATCH net-next v5 1/9] net: ethtool: tsconfig: allow hardware
 timestamping without a PHC
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-v6-7-topic-virtio-net-ptp-v5-1-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f@pengutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Liang Chen <liangchen.linux@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org, 
 kernel@pengutronix.de, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=sJoHRrVMKr6ZSzo1Qq3LalC6B8sAG2AlxpNu43jHhDQ=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ9bXBa9V11v//6j7t9q9ubGxsfBnhliLYc6Fwx8Wcle+F
 eSwOH6zo5SFQYyLQVZMkUVlYQWfqMcHz8hpIlwwc1iZQIYwcHEKwES6HBn++3NuVxK9mMt/TuXr
 6y0zPZiqHhbs6ryVfue9g86OKVpufxl+s6XpWV1Irpt3K1DsNr9M9t70FYaFIsmKprbfdi/a/H0
 KNwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

A driver can do hardware timestamping without a PTP hardware clock; its
get_ts_info() then reports hardware timestamping with phc_index -1.
ngbe and txgbe (libwx) do so when no PTP clock is registered, e.g. with
CONFIG_PTP_1588_CLOCK=n, and dpaa without a ptimer-handle.

SIOCGHWTSTAMP and SIOCSHWTSTAMP work for such a device, but
tsconfig_prepare_data() refuses it with -ENODEV:

 - TSCONFIG_GET fails.
 - TSCONFIG_SET passes the new config to ndo_hwtstamp_set() first and
   fails only when building the reply, so user space gets an error
   although the config was applied.
 - In a dump only -EOPNOTSUPP is skipped; the error ends the dump, and
   the devices after this one are not listed.

The reply already leaves out ETHTOOL_A_TSCONFIG_HWTSTAMP_PROVIDER when
the index is -1. Let tsconfig_prepare_data() take that path instead of
failing.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 net/ethtool/tsconfig.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index 2db0e7ba8b9f5..75f9b319aa310 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -73,11 +73,7 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 		if (ret)
 			goto out;
 
-		if (ts_info.phc_index == -1) {
-			ret = -ENODEV;
-			goto out;
-		}
-
+		/* -1 without a PHC: the reply leaves out the provider */
 		data->hwprov_desc.index = ts_info.phc_index;
 		data->hwprov_desc.qualifier = ts_info.phc_qualifier;
 	}

-- 
2.56.0

