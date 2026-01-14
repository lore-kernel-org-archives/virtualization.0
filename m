Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02DB3054EB
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382178; cv=none; b=cHcEXiZIZ1oOfeb1Q0citr5AUvzBpbTjGmcAsLsCKVa9cyOQ3QDQGDz6Joe70sbuJKHiyH9/TQNl7EmLPllLvaZByQlxrMPBiSfhtYTCYtF/9cSNn/PchKa4q/AdMqN3HL6A/5dxnrwbtNnu9wW4sgKEwnkc4+JujMgp9t+K384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382178; c=relaxed/simple;
	bh=MA+S/Yakr8pa0eC8++S3b7TCTX4zayGCMn24s7LAmdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzyy8y4ADmWvOxMDuU75FcB8fksp/KOxCotSylajyocMf8CoHW4eZ2ug1F2gFiTgFyTvomWtnFASvdyKAV/KRq/lE06gSMEStyOIEsDSESAwdMzU1UPh2bsRtG3rvPFj3BjTeQwiDkgjTp0YWQv/mZPNW2G8iqysQC+CxRDQKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nASGpjnC; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nASGpjnC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768382169; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MtCA5rWXh0iwYqtCMe9TZKdgA5/BApHUEgmSUWLQOAM=;
	b=nASGpjnCgUK6vU4Uy8p+/D1NwivUvVE2Y0MBUIpJHhRPdEzZ0LsKSMD1dIzUgTHbjHoPPrix7oZcq/FRz+XeBZhiQnXT0W8LmBweKU4JsFeieoU5lnpq8AwApm2Rmnb7MQ2om/pSHMJ/RFz6Wq631/qIz5Pav7qXgbmCOc/5OZc=
Received: from 30.221.145.108(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wx1r-d0_1768382167 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 17:16:07 +0800
Message-ID: <2a4c9a00-45f5-4f6a-90c4-492ea1d50b79@linux.alibaba.com>
Date: Wed, 14 Jan 2026 17:16:06 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Sven Schnelle <svens@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <aWXISRWpkW-oHyUw@hoboy.vegasvil.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <aWXISRWpkW-oHyUw@hoboy.vegasvil.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/13 12:21, Richard Cochran wrote:
> On Fri, Jan 09, 2026 at 10:56:56AM +0800, Wen Gu wrote:
> 
>> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
>> require widespread userspace changes, duplicated tooling, and long-term
>> fragmentation. This RFC is explicitly NOT proposing a new userspace API.
> 
> Actually I disagree.
> 
> The PHC devices appear to user space as clockid_t.
> 
> The API for these works seamlessly and interchangeably with SYS-V clock IDs.
> 
> The path that is opened, whether /dev/ptpX or some new /dev/hwclkX etc
> is a trivial detail that adds no burden to user space.
> 
> Thanks,
> Richard

Thanks, Richard.

This might be true for applications using the POSIX clock API.
(However in practice there is also an ecosystem aspect: apps
and scripts assume /dev/ptpX explicitly, introducing a new
clock path can still incur real adoption/compatibility costs.)

More importantly, the existing ecosystem also relies on the
ioctl APIs (PTP_* ioctls).

Taking chrony as an example. For PHC refclock, chrony's PHC
handler (RCL_PHC_driver) explicitly relies on PTP ioctls[1],

e.g.,

ioctl(fd, PTP_SYS_OFFSET_PRECISE/PTP_SYS_OFFSET_EXTENDED/PTP_SYS_OFFSET, etc)

So a new clock type and APIs would require non-trivial userspace
changes. That would be a lengthy process of adaptation and tool
availability across different distributions. Similar problems
may also arise in other tools.

That's why this RFC is not proposing new userspace APIs.

[1] https://gitlab.com/chrony/chrony/-/blob/master/refclock_phc.c?ref_type=heads#:~:text=static%20int%20phc_poll,%7D

Regards.
