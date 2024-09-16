Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B541487C5
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476405; cv=none; b=gy/ZSLmR81sq0hV9MD4iOW+YjAt3NVdkTqgjyD71o3wL6gVJZ2jvL2WSPx3Anbyn95o1FDuFn4IyzHTGIog+nDu8Y2BGApVfae1mlTLAlBn0yWFGd/VtnkmPnH09ZSfS/ao4atNQtVgNvgutd3UtcGOBxaBM8RLxkEXtk7oIlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476405; c=relaxed/simple;
	bh=XM85QJ+Tc2CQ3IWFm1G1jTKIuhtI8vmRVh0zF/XCmnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8HLZSSM2W9GFZLP0f0xzhvGfX+YZmQvui3GiKijcJ42LuasjMlSVhr625q87ysrqcBFyj/1GHMvjv41FHIrVUxYOetjgvc+mT2KIPGpilzxOR1uyhQFIGfHjtMUAIt6mv+p926TiXUFzfRXFMGrcksJfO6mzbSYN7u3fhYKKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 528B34034D
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 08:46:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.393
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KU2SZDbLiFj for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Sep 2024 08:46:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=gur.stavi@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 915B14009E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 915B14009E
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 915B14009E
	for <virtualization@lists.linux-foundation.org>; Mon, 16 Sep 2024 08:46:40 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6dhr4KZ7z6L7DQ;
	Mon, 16 Sep 2024 16:42:52 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 148FE140158;
	Mon, 16 Sep 2024 16:46:37 +0800 (CST)
Received: from china (10.221.233.88) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 10:46:28 +0200
From: <gur.stavi@huawei.com>
To: <akihiko.odaki@daynix.com>
CC: <andrew@daynix.com>, <corbet@lwn.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <jasowang@redhat.com>, <kuba@kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mst@redhat.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <virtualization@lists.linux-foundation.org>,
	<willemdebruijn.kernel@gmail.com>, <xuanzhuo@linux.alibaba.com>,
	<yuri.benditovich@daynix.com>
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Date: Mon, 16 Sep 2024 11:46:18 +0300
Message-ID: <20240916084619.581-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-2-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> +
> +static inline bool virtio_net_hash_rss(const struct sk_buff *skb,
> +				       u32 types, const __be32 *key,
> +				       struct virtio_net_hash *hash)

Based on the guidelines, this function seems imperative rather than
predicate and should return an error-code integer.

https://www.kernel.org/doc/html/latest/process/coding-style.html#function-return-values-and-names

> +{
> +	u16 report;
> +	struct virtio_net_toeplitz_state toeplitz_state = {
> +		.key_buffer = be32_to_cpu(*key),
> +		.key = key
> +	};
> +	struct flow_keys flow;
> +
> +	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
> +		return false;
> +
> +	report = virtio_net_hash_report(types, flow.basic);
> +
> +	switch (report) {
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	default:
> +		return false;
> +	}
> +
> +	hash->value = toeplitz_state.hash;
> +	hash->report = report;
> +
> +	return true;
> +}
> +
