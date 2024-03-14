Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACD28FA;
	Thu, 14 Mar 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456867; cv=none; b=AHrgTGCIEfdXcFVtaeGle4BJI2vzkLnEsXDXCqp7s8biUMXiUuGH5akdVcvMyFAT//FRvQ+g4lszeLHeqEZxlQWN9QWis2yK2Du0u+2kRmv7H/BWY1pZMrdseg6J4u0Oaf8fTqwLlGWuq/qpXEyNPeAAHbe28xmAMVqDF7tksYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456867; c=relaxed/simple;
	bh=fGk511EZm1KTJpXdd+V9yDQ8An+EFD4FBiCWlHGDKMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSxg+MLslsPf7iXfr8iBye2VF4g34nTuqnqIGrOehDHoH3DUgFfFp1l4+xfy2Clg/FpWfCBAzGl5mhhDmA0cTkO+Gvj2dy2EcN80JgwjNYFI1uO/TDpdPeTom89mA2fRwFmC7VsnhDPiDz42eCOUf2fI0C12kp1hyI7srCCC4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDuwcqzF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDuwcqzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FF1C433F1;
	Thu, 14 Mar 2024 22:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710456867;
	bh=fGk511EZm1KTJpXdd+V9yDQ8An+EFD4FBiCWlHGDKMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDuwcqzFzcN2SuxSPJojxVJE9hGtZMySeXYvl/FR+54B73tq2n9K95sy8AxgV+Fs0
	 vJsHvWEdCV9ZMdKJPbqLgnPHjmLZ627olbYnXa+9cQObsklWcPITOxtCuvl+BufzNY
	 NVExCZvCPrTCeRyt76tDSAAEpV591oKO+J5tp4ucaS1pekf7afZgCxZd5OofSA4rVX
	 oyDwUHWwZwLEWBaNvJnqFFYtYz4FDYw60yiwyVhA4vvYhExYgdJ3fsD/QBdy5B+MO6
	 qeJAafm5PvoUI/0RztM44rjIDgPRdHxpeHbkJVfq68/xzJqVOJOFkimkokh0R4zKRx
	 iYJ0EXtDbM7wQ==
Date: Thu, 14 Mar 2024 15:54:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/8] virtio_net: support device stats
Message-ID: <20240314155425.74b8c601@kernel.org>
In-Reply-To: <20240314085459.115933-4-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
	<20240314085459.115933-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 16:54:54 +0800 Xuan Zhuo wrote:
> make virtio-net support getting the stats from the device by ethtool -S
> <eth0>.
> 
> Due to the numerous descriptors stats, an organization method is
> required. For this purpose, I have introduced the "virtnet_stats_map".
> Utilizing this array simplifies coding tasks such as generating field
> names, calculating buffer sizes for requests and responses, and parsing
> replies from the device. By iterating over the "virtnet_stats_map,"
> these operations become more streamlined and efficient.

Don't duplicate the stats which get reported via the netlink API in
ethtool. Similar story to the rtnl stats:

https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors
