Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D415B0EE
	for <virtualization@lists.linux.dev>; Fri, 16 Aug 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801277; cv=none; b=lT/+GytYQ1+fZmYT7OqSWglNtggqsVQ5JKOi23d1ZH5apvnW2+Gw8tFnvo5yW6iRW42c9SByGI46OghmV63N+aXpbAY1Fq5JKvGZ8Oi0AXJDUXxaKoWe4DXLMAbpOPKIXOrVudJAdYMZ2MWaYAm4lY3l1Xrml0grx0acX2T4T4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801277; c=relaxed/simple;
	bh=B8Du7785RKz8I5dtK6eIhQ7HYxTvjJ0RgFG8YUsyucI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueN6CgM+f/XcjM2ob/IEpcKermms3f6ydLN/TjhdAgrBobKkjfxpIcokQhtr4e24p/5XKr9t2xV1jVzXugXSvYYNDfOk3pjyYnd+4WOG7gBEYoF1dTdkXrCNJDS+Z5NpZ/tSE/6tShmpAMDLhMZ3iK3ZNqUc7JLxMkWAt8pQYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WlcPJ4psFz6K5l3;
	Fri, 16 Aug 2024 17:38:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AACD1400DB;
	Fri, 16 Aug 2024 17:41:12 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 16 Aug
 2024 10:41:11 +0100
Date: Fri, 16 Aug 2024 10:41:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hannes Reinecke <hare@suse.de>
CC: David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, John Groves <John@Groves.net>,
	<virtualization@lists.linux.dev>, Oscar Salvador <osalvador@suse.de>,
	<qemu-devel@nongnu.org>, Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linuxarm@huawei.com>,
	<wangkefeng.wang@huawei.com>, John Groves <jgroves@micron.com>, Fan Ni
	<fan.ni@samsung.com>, Navneet Singh <navneet.singh@intel.com>, "
 =?UTF-8?Q?=E2=80=9CMichael?= S. =?UTF-8?Q?Tsirkin=E2=80=9D?="
	<mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Philippe
 =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <20240816104110.000012e6@Huawei.com>
In-Reply-To: <904a433c-0471-4f11-a34b-cef8adf1663c@suse.de>
References: <20240815172223.00001ca7@Huawei.com>
	<904a433c-0471-4f11-a34b-cef8adf1663c@suse.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 09:05:46 +0200
Hannes Reinecke <hare@suse.de> wrote:

> On 8/15/24 18:22, Jonathan Cameron wrote:
> > Introduction
> > ============
> > 
> > If we think application specific memory (including inter-host shared memory) is
> > a thing, it will also be a thing people want to use with virtual machines,
> > potentially nested. So how do we present it at the Host to VM boundary?
> > 
> > This RFC is perhaps premature given we haven't yet merged upstream support for
> > the bare metal case. However I'd like to get the discussion going given we've
> > touched briefly on this in a number of CXL sync calls and it is clear no one is
> > entirely sure what direction make sense.  We may briefly touch on this in the
> > LPC CXL uconf, but time will be very limited.
> >   
> Thanks for the detailed write-up.
> 
> Can't we have an ad-hoc meeting at OSS/LPC to gather interested/relevant 
> people to explore ideas around this?

Absolutely.  If people want to email me directly (or mention in the thread)
I'll gather up a list of people to try and find a suitable time / place
(and then post that here).


> 
> In particular I'd be interested on how to _get_ the application specific 
> memory to the application in question. It's easy if you have your own 
> application and design it to work on DAX devices. Obviously this 
> approach won't work for unmodified applications; however, they really
> might want to use this, too.

That's a good parallel question (as not virtualization specific).
I'd be tempted to enable this path first for aware applications, but longer
term the ability to use this via common allocator libraries (LD_PRELOAD etc)
might make sense (or some other path?) 

> 
> And, of course, the other mentioned problems are worth discussing, and I 
> do agree that the uconf will probably not providing sufficient time for 
> this.
> 
> Cheers,
> 
> Hannes

