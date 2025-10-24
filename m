Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4E30BBB6
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298964; cv=none; b=A74Ea6oxe/mKFU+SIdTi5D3KDHcAmp2UOcM/rFkNKWs3rwsnIL5FQiReMPYmqqA/1VW1Oig1+x7MnCFo3hZ+Vo886E+roUFQDIOculAwkgtBQg1Q0UDS0PP5eD2w96gmqajBJ24km/t31IReJz8OZh1qhf/tekdRfzPBElxk+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298964; c=relaxed/simple;
	bh=v6zZ/xFOejo7boXqRMIsAbGB0NF9X4qEXPtYrhfvpSg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=s9qlttmxUS9D0BBWjEKKQ/sRnJlG1GO3bV1uzyme8NvdSW4/Fp4EYnp4x8dLLVtRPYuy+rAm3lDv1RdD59wy1zwzQjTidJDnmMvmq2Oq/LRcf69B1rfj9ElLTTRBroIMBDJuFHJU6MPH4tg1BqOBDecSj+jOqw+ZCj3dspSXdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MUbx/8pZ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MUbx/8pZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761298958; h=Message-ID:Subject:Date:From:To;
	bh=8rZN9o6PveF97o8zjC+fmoeterg0twTcX2+0jC1zd80=;
	b=MUbx/8pZQU/GQuq3CToPtKVsIMlW2MGxBZq4Xg+vz5nURwOPKCRpC01a6MJstGrOXyUjwUXr4D4JEaU1zxzV3JJt8pQmEBU3OnfsS4bLQBLJwsfL4iNsl1N2Er/0nwg4M1xXtadapbGtJ4Mug6XUFOZfTwW3E1Mvd7iFT31u9hU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wqu3869_1761298957 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 17:42:37 +0800
Message-ID: <1761298922.6304543-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v3 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Fri, 24 Oct 2025 17:42:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20251024074130.65580-1-xuanzhuo@linux.alibaba.com>
 <20251024074130.65580-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251024074130.65580-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Test:

 I observed that the "hdr_len" is 116 for this packet:

        17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
            192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
        fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
            192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796

    116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)

