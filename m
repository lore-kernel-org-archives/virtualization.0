Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847113AA38
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726473721; cv=none; b=OefpsIkump6gkuMRWztlIy9l5PEfSPOf+Nt05nefYUvs4e0Lxs3KnuRxq8y/p3HxguacTtuVsTaxSXw5xcpXUOAWryRuYbYF4/OH5fZYU4N6q1kqVbVj78f6iYmIm+jPoYInKtxBU+IQdp+yd+pG43hQzODF9IFkloxRDtv/12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726473721; c=relaxed/simple;
	bh=46/KW6t/Ri9qLs83dZwNcfB7QL78F1lTLAYCmSjs+g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZsoAN/4Q9akuHMERpLQghLMBprtHLqX4oL+xf0b4EimlIjhOrdyVbOH38VkD+Gr2nKhy+PikL5W34bsRjqePlHZrP/ItEbOKzDm1asCjLbBDOT00Crq+SaU1rsktdCvOVUdnk9g5YEYTSknAUi44siKMX/W5W6CA5a6tbLdvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32610406DB
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 08:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.892
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYe1n7Db-yFu for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Sep 2024 08:01:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=gur.stavi@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E7DE8406C8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7DE8406C8
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7DE8406C8
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 08:01:58 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6cjH0kRmz6L6ww;
	Mon, 16 Sep 2024 15:58:11 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 827341400CB;
	Mon, 16 Sep 2024 16:01:55 +0800 (CST)
Received: from china (10.221.233.88) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 10:01:46 +0200
From: <gur.stavi@huawei.com>
To: <gur.stavi@huawei.com>
CC: <akihiko.odaki@daynix.com>, <andrew@daynix.com>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <jasowang@redhat.com>,
	<kuba@kernel.org>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <virtualization@lists.linux-foundation.org>,
	<willemdebruijn.kernel@gmail.com>, <xuanzhuo@linux.alibaba.com>,
	<yuri.benditovich@daynix.com>
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Date: Mon, 16 Sep 2024 11:01:36 +0300
Message-ID: <20240916080137.508-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240916071253.462-1-gur.stavi@huawei.com>
References: <20240916071253.462-1-gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500005.china.huawei.com (7.182.85.13)

> +
> +static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
> +				       const __be32 *input, size_t len)
> 
> The function calculates a hash value but its name does not make it
> clear. Consider adding a 'calc'.
> 
> +{
> +	u32 key;
> +
> +	while (len) {
> +		state->key++;
> +		key = be32_to_cpu(*state->key);
> 
> You perform be32_to_cpu to support both CPU endianities.
> If you will follow with an unconditional swab32, you could run the
> following loop on a more natural 0 to 31 always referring to bit 0
> and avoiding !!(key & bit):
> 
> key = swab32(be32_to_cpu(*state->key));
> for (i = 0; i < 32; i++, key >>= 1) {
> 	if (be32_to_cpu(*input) & 1)
> 		state->hash ^= state->key_buffer;
> 	state->key_buffer = (state->key_buffer << 1) | (key & 1);
> }
> 

Fixing myself, in previous version 'input' was tested against same bit.
Advantage is less clear now, replacing !! with extra shift.
However, since little endian CPUs are more common, the combination of
swab32(be32_to_cpu(x) will actually become a nop.
Similar tactic may be applied to 'input' by assigning it to local
variable. This may produce more efficient version but not necessary
easier to understand.

key = bswap32(be32_to_cpu(*state->key));
for (u32 bit = BIT(31); bit; bit >>= 1, key >>= 1) {
	if (be32_to_cpu(*input) & bit)
		state->hash ^= state->key_buffer;
	state->key_buffer =
		(state->key_buffer << 1) | (key & 1);
}

> 
> +
> +		for (u32 bit = BIT(31); bit; bit >>= 1) {
> +			if (be32_to_cpu(*input) & bit)
> +				state->hash ^= state->key_buffer;
> +
> +			state->key_buffer =
> +				(state->key_buffer << 1) | !!(key & bit);
> +		}
> +
> +		input++;
> +		len--;
> +	}
> +}
> +
