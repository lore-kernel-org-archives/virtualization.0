Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC06FA9
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469968; cv=none; b=uOsaXowQuRzBFtU23uqvbAxF6cO9pDYbtGYWPXtaJixM7KPQ5Oo5BgSBpU60WfTXw29GiqJgRF7uaPad6L6RLdRdNj5EJYDtNLzZcOlcAEC0ncuUickuSU42RoYhkaUQRBDDFevvkcZye8z8dymPhOTa9rSTFGthmKrfYrUMIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469968; c=relaxed/simple;
	bh=9j14obn7LJhO8DocmOfVRGauUW8ZOKLXG5D4pRwAFBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/JaSIC2eN0ed6WfvH98T7qiP86Iw8KkhA6LW5NbzWEPxSI7CgrZ/Juxy81677Eo6R8gxj3y67t/lPRKC9Bd1hnrRAeoUui7fIib7/eDNjCnTyNSewLoEupYu0tABg/mXE78rMhRhw0eIp5R1BdMemmClXqxsz8uwPJse9C3NLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ih+a+xQC; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ih+a+xQC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710469963; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uWppkp/CDYn1IU8SGxz0loaKDXyaJFyU0HWPRcBekZI=;
	b=Ih+a+xQC/wzNtKFtMAd6uzxbbpp1KtFPmyxhsxW+QPHKrPBqRL5RZLxkWb1O7h/7jUAFdZWfoy8KGxKUzfCbR6U6XweEwIl/kmtero5oueZOr/XAV/pUoc1TS3qtMqsoZumc4TnvstwHabw7K1hk4EKl6CgERrtfaNzd9rPKI2s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W2UXABh_1710469953;
Received: from 30.221.148.72(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W2UXABh_1710469953)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 10:32:41 +0800
Message-ID: <143ea675-97e5-42ab-b8e6-55b2675294c3@linux.alibaba.com>
Date: Fri, 15 Mar 2024 10:32:32 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] net: provides dim profile fine-tuning channels
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Tal Gilboa <talgi@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Breno Leitao <leitao@debian.org>, Johannes Berg <johannes.berg@intel.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <1710421773-61277-1-git-send-email-hengqi@linux.alibaba.com>
 <20240314114955.71ada20c@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240314114955.71ada20c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/15 上午2:49, Jakub Kicinski 写道:
> On Thu, 14 Mar 2024 21:09:31 +0800 Heng Qi wrote:
>> The NetDIM library provides excellent acceleration for many modern
>> network cards. However, the default profiles of DIM limits its maximum
>> capabilities for different NICs, so providing a channel through which
>> the NIC can be custom configured is necessary.
> Given that DIM is currently enabled and disable via ethtool
> why are you putting the API is sysfs and ops in ndo?

Hi Jakub,

Thank you for reaching out. We're flexible regarding configuration 
methods and are
open to using either sysfs or ethtool, depending on what's most 
appropriate for the task at hand.

If the ethtool is favored, I am happy to proceed with it!

Best regards,
Heng

