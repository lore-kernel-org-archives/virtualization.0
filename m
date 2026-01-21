Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5712225788
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005239; cv=none; b=IUb5RpUd9I8YTnBQaljASCadK81pQdxH8lT483UD5oSl+QhKeTLfr09/QnTREHjPtW8mIdE0oWgqReWXGfdS/fAxyNRutrSeTqVPp7LQsszjfQpoMfw+bIQgkXyBxtzslXIG6xiYPPqS5UjylYrWlcBzj/4BtzQzTXDt5dCUfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005239; c=relaxed/simple;
	bh=nECRXUddvBB6r882YwmQmC1NCKzawqob/o0ecaEnuoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6DkEGOmC+TznqR6WgpcQ96T6pThPwhMEsOqs3T6zCuLVnwnWi/BBPlH1QQVRgF7cPXZJwnYwjfqwicIUTfOOO7kqh0RQzvpq9zuneb2heykYMZ8Fuxo4k3oQ0Km8JOVkAofs8MkOvoMLVpL5uDuidRD/xjtjwNoJAc3yrLTLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qKQqQLAt; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qKQqQLAt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769005231; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4F4Z+wmFIYVbLHvWeOOQXSgEYrKMraRbThlYduC1oZ4=;
	b=qKQqQLAtXK1GxNUN4qxzQ89TRCJgj9rRs7da7L+7dQXVRwKhp0cqVaGOxzOxHn548K0MICjJSbjFCw1YDre9cOdMeynVPMi1oQQI8ok/UFkKg+tvrmFWhmrECgVKQOaCpf70dlbYqOjMN5cngGFBwX+qybK7bdXjUROWg5bGouA=
Received: from 30.221.145.201(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WxYTFJ9_1769005228 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 21 Jan 2026 22:20:29 +0800
Message-ID: <711e54ef-97db-4e01-b0d8-bcf2dea61fe6@linux.alibaba.com>
Date: Wed, 21 Jan 2026 22:20:28 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Sven Schnelle <svens@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yg3ikpcwukvv6z6gf6zzkoxlgu37ihauqpm2pkhmxuz6hsxfcc@eaeqykdvkh5v>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <yg3ikpcwukvv6z6gf6zzkoxlgu37ihauqpm2pkhmxuz6hsxfcc@eaeqykdvkh5v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/19 22:48, Manivannan Sadhasivam wrote:
> Hi Wen,
> 
> On Fri, Jan 09, 2026 at 10:56:56AM +0800, Wen Gu wrote:
>>
>> Hi all,
>>
>> This is an RFC to discuss the appropriate upstream home and maintenance
>> model for a class of devices/drivers which expose a high-precision clock
>> to userspace via the existing PHC interface (/dev/ptpX + standard PTP_*
>> ioctls), but are not tied to a traditional NIC/IEEE1588 packet
>> timestamping pipeline.
>>
> 
> Thanks for starting the discussion. I sent out an email just today on this
> topic [1] and learned about this thread afterwards.

[...]

> 
> Some Qcom MHI devices expose the high precision clock derived from GNSS/Cellular
> network over the MHI registers and we recently sent out a series exposing them
> as PHC [2]. Since this driver is closely tied with MHI bus, we added it as a
> part of drivers/bus/mhi/.
> 
Hi Manivannan,

Thanks for the note and for sharing the MHI PHC use case.

Yes, this is very similar to what motivated this RFC, there are more and
more PHC providers which are not tied to NIC/IEEE 1588.

[...]

>>
>> Introducing a new clock type or a new userspace API (e.g. /dev/XXX) would
>> require widespread userspace changes, duplicated tooling, and long-term
>> fragmentation. This RFC is explicitly NOT proposing a new userspace API.
>>
> 
> +1
> 

[...]

> 
> If we get a consensus to move forward with exposing the device clocks as PHC, we
> will respin the MHI driver and would love to get an ACK from the (new)
> maintainers.
> 
> - Mani
> 
> [1] https://lore.kernel.org/all/vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67/
> [2] https://lore.kernel.org/mhi/20250818-tsc_time_sync-v1-0-2747710693ba@oss.qualcomm.com/
> 

