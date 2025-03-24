Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19925DD15
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Mar 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812304; cv=none; b=iTrygPEvL72UQUjOWolqirQOPETCkif6bzmTXg55jeNG9r9cD46mr9Zpqm7NeuhhHDB5UFX0Yv4xgNGz+7vxEoKA2oWwIaI7EkrLtl5mLrgG2Vzj+BeeykjdChDDKuSiYQBS4hhs8c7MT+C97pJHt7HVp4AnZp4EOk5HS7xkHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812304; c=relaxed/simple;
	bh=7GAZFJZl+eKu5P9ihY2WmQuvZGa6gA3gVGjHE+fPDMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEPg8xJti2OJ4Pf28fkYTyL0dHmHAG6nCzmV7vg2MiwM4vWXlngpE/7sh7HXmBhh2/n0u33j0wAqUe+WB00rke6Avp8XLjECWCvOCB8xxTLEz3PtZWRsr7H5qD+ysQpYvzjaFBB7nn9OM349OU4aXFSVjI+Ru6Xsp+tVpc6PCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Oh38jK; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Oh38jK"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0728E81AC4
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Mar 2025 10:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IaXqO0dUZTeV for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Mar 2025 10:31:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5DD6281A15
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DD6281A15
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o3Oh38jK
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DD6281A15
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Mar 2025 10:31:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C050BA48F9D;
	Mon, 24 Mar 2025 10:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F69C4CEDD;
	Mon, 24 Mar 2025 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742812300;
	bh=7GAZFJZl+eKu5P9ihY2WmQuvZGa6gA3gVGjHE+fPDMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o3Oh38jKmLbmx2Hy9PuIK6O8ifW4Y0N/uz0RAy/iM6IehElvV79s5T/S0HnlpjEbj
	 CmquiYEvuA9O2qYRu6Jy3udMGB+/ImugKje5kRLPpU0rGJgmmjwa92rnD5SIW2gtjh
	 I/RCkgdLwrK0tz1nXth2eJCD9l0DW53CiFJqn2aStOg9EERHD7wXDs9LEm5Ex4BfjK
	 7z1UkMS6uNVFLXJPXYTp5FlDOo2f/q+SPd5xsISTmMbHr+F9LwH6HclxFneC3VUO4W
	 muKE/QeNmJJhfayAnei1uqT+8MbSJMn9ChCu6fHf62r9NERRKh1i1EGMqY4hVuIdBK
	 2nFLB2fDdo/Xw==
Date: Mon, 24 Mar 2025 03:31:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>, Stephen Hemminger <stephen@networkplumber.org>,
 gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v11 09/10] selftest: tap: Add tests for
 virtio-net ioctls
Message-ID: <20250324033129.0016abc9@kernel.org>
In-Reply-To: <20250317-rss-v11-9-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
	<20250317-rss-v11-9-4cacca92f31f@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 19:57:59 +0900 Akihiko Odaki wrote:
> +TEST_F(tap, test_vnetbe)
> +{
> +	int be = 1;
> +	int ret;
> +
> +	ASSERT_FALSE(dev_delete(param_dev_tap_name));
> +	self->deleted = true;
> +
> +	ret = ioctl(self->fd, TUNSETVNETBE, &be);
> +	if (ret == -1 && errno == EINVAL)
> +		SKIP(return, "TUNSETVNETBE not supported");
> +
> +	ASSERT_FALSE(ret);
> +	be = 0;
> +	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETBE, &be));
> +	EXPECT_EQ(1, be);

The config options needed by selftests should be listed in the relevant
config file, I think you need this snippet:

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 130d532b7e67..9b6aa8c4e6d8 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,7 @@ CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
 CONFIG_AMT=m
 CONFIG_TUN=y
+CONFIG_TUN_VNET_CROSS_LE=y
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
-- 
pw-bot: cr
