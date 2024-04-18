Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D5F16F917
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456383; cv=none; b=cI0m3YQ0gQajV9Gip1decIYIjbZigLcXzOdt0shSVDb6ceXp3jpaUpsItorU9j06Wqm3xCEoZFNztZKmVRT7tKlIqvhj3hGeaRYkW0kVw7ZbIMtDosxI6trQah9dA5XZsMCTX11XmzASNaEhxqOQ/a56rcr1ELJc3Smo4J+q4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456383; c=relaxed/simple;
	bh=Y/heGktoA68QBCplEkjVHGnBmjZAzNi7ohDYGyE0POk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E07P1cu4c55MhZlp9wZEYd5O+DNdmFPkGgy2wxjxCPT6lwsFU/IG5a4Vv/6xhmx+V5gxVP7qYOxQz7WCuua6XK4H5w3+uSpw43L98/cvBBmB0XbupaNiW2UwKnRrHVo3us6K8xMrYV5w9PlLIksw/Dz/hzf88+sJ61sQnRwrhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xroM7pzX; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xroM7pzX"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713456373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=huP7ejolsE0iGUnCoSxQbMRLw1Yoi/q0PzHQjduj7WU=;
	b=xroM7pzXHFHUo9Z8sgumixY/nEh/jFsZ2Prws0SdZQDPFfwuqfYrSJTLCDXYf7F4V6ayjL/s1BWPzrTpV4cQqkKd0utbOwku9QoUmq8LXTeJOLcNTwxk/CfVMSKU1rYuBABFJy8yeXJpMYYpXrlnHMG76ryhPF1Mx3KVI8n2Fb8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4p1UVo_1713456370;
Received: from 30.13.151.155(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4p1UVo_1713456370)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 00:06:11 +0800
Message-ID: <4e71c828-7f50-461b-b5ed-90fb45749521@linux.alibaba.com>
Date: Fri, 19 Apr 2024 00:06:10 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
To: Dan Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
 <20240416193039.272997-4-danielj@nvidia.com>
 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
 <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
 <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I didn't see any warnings with GCC or clang. This is used other places in the kernel as well.
> gcc version 13.2.1 20230918 (Red Hat 13.2.1-3) (GCC)
> clang version 17.0.6 (Fedora 17.0.6-2.fc39)
>

I think Paolo is suggesting this[1][2], guard will mess with the sparse 
check and cause a warning:

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-4-danielj@nvidia.com/
[2] 
https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-6-danielj@nvidia.com/


