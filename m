Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25B153800
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812193; cv=none; b=LO0odDCAEi0yLe7cNCyLwpTk94ZQoZ35A+FhgcIekyE0oPCOh7CoVLiNayG5eLLHWoD6aV1oXQgu8Z4FPUjo+AL61aTQmGTD7h4DAFD5FtsJsimCY3iv6/RZmWqH35PbFcPY+NKz8/w9QLWlRpew5gdJKFeFLYmETNX4NHSB40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812193; c=relaxed/simple;
	bh=ULvnEkKBwCrybQNORJPiinJ0HjslXNnwTFFIRmT8iWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TATo6G/mNeWDR0srtsiJVfTKcwwwdOnEV6ukQw7o0IJXZ2aOZYliwYv5VN7gSNAz/czrP4paV7UR1dmjWwutlK/k6inMom0BRrCJO89mS8HmYv3PJYImJs1DzdzLjVLkWEM2vqPYJH1XsIJxSVfa246JfO3WfW8XzZutAlGyi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kdFOI4oJ; arc=none smtp.client-ip=47.90.199.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kdFOI4oJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718812172; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ULvnEkKBwCrybQNORJPiinJ0HjslXNnwTFFIRmT8iWs=;
	b=kdFOI4oJVtJcA8U55den/haQ/vFsm6hMKnDl4++2FH3prMA4QcxzoUb+xHIdDvd3qAS3ZK/DRkzww48kZ/s/GLmoZiTT6lEwEOIv865OSyGMSUHY5LbC+6cYKhEJbHtxGrzdfdz6aJHV1aQcRJ/K2P3Pd2huCzDv6TBsvX5O22M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8oamoR_1718811851;
Received: from 30.39.254.97(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8oamoR_1718811851)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 23:44:12 +0800
Message-ID: <c4b2d4a9-2fe4-4822-a5ab-57d1bb98f0b8@linux.alibaba.com>
Date: Wed, 19 Jun 2024 23:44:11 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com>
 <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
 <1718680142.7236671-11-hengqi@linux.alibaba.com>
 <20240618181516.7d22421e@kernel.org>
 <1718762578.3916998-2-hengqi@linux.alibaba.com>
 <20240619080802.07acb5ac@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240619080802.07acb5ac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/6/19 下午11:08, Jakub Kicinski 写道:
> On Wed, 19 Jun 2024 10:02:58 +0800 Heng Qi wrote:
>>>> Currently we do not allow RXCUSM to be disabled.
>>> You don't have to disable checksuming in the device.
>> Yes, it is up to the device itself to decide whether to validate checksum.
>> What I mean is that we don't allow users to disable the driver's
>> NETIF_F_RXCSUM flag.
> I understand. What I'm suggesting is that you send a follow up patch
> that allows it.

OK, will do it.

Thanks.


