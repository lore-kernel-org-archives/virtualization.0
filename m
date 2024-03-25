Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014F5479F
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711333295; cv=none; b=QGalEYnS/j8DAaCF94mzSZxp/+Eg/kNAtiS4g/tg/JpWoeC32k4phO4qn5GOrSve8AC9kq6hU6aVZ/b//JATCBaHXfnyL3icrD7ZV0PprwWz1ElK9jEM9LpjN/lFSUiqq91CRvp9UXLd/zZy8VCTJ+1S5F77vIw/H1j2sXQTUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711333295; c=relaxed/simple;
	bh=O55hfeRrM8Nyva7hubsFry8A4/QGu0XdVfEA6z4VZmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CshLIC66uKSy/JSewTDwidB5W6IA82OTPloUB+3WIjljan72woSZCVpEsXzUZIbwM9GzGxz3/KRJm9iKJYSMM1ki3tpFNIT4toYFWAI1n/sBH6yrmeC5fTGRQZt7afVxDZXnZpBadvzGAPUv+peixKGrsaGeylE3G/nTmc6bBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uDdh0wSq; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uDdh0wSq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711333290; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P3YrW/OUqxaVBghKQR22O4dIfIzNVTvbEPAdpxgPbw4=;
	b=uDdh0wSqyOKKQbWOLmE+7KSMsKBJjiTaISQA1HuqhaCS1ylErYQgzyfikkkds6zvEzwuhWXpL3gFqqQ+xpWBbJTH7EIBtsEcxVWsvRnQveJ+WOR4U3AB0wwfbZ+XnLEVcCjCQYIiofdoQTOwymlt4mZNbMzz7MjnFpZJxK4Rax4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W38IF0._1711333286;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W38IF0._1711333286)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:21:29 +0800
Message-ID: <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
Date: Mon, 25 Mar 2024 10:21:23 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/22 下午1:19, Jason Wang 写道:
> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> Currently, ctrlq processes commands in a synchronous manner,
>> which increases the delay of dim commands when configuring
>> multi-queue VMs, which in turn causes the CPU utilization to
>> increase and interferes with the performance of dim.
>>
>> Therefore we asynchronously process ctlq's dim commands.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> I may miss some previous discussions.
>
> But at least the changelog needs to explain why you don't use interrupt.

Will add, but reply here first.

When upgrading the driver's ctrlq to use interrupt, problems may occur 
with some existing devices.
For example, when existing devices are replaced with new drivers, they 
may not work.
Or, if the guest OS supported by the new device is replaced by an old 
downstream OS product, it will not be usable.

Although, ctrlq has the same capabilities as IOq in the virtio spec, 
this does have historical baggage.

Thanks,
Heng

>
> Thanks

