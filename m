Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC25A5F
	for <virtualization@lists.linux.dev>; Thu,  4 Jan 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lKy7mIca"
Message-ID: <2109a62d-ddd9-4da2-8f3c-71ac84dcaea1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704331864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkOVP2zeJYrVsdbKJ6Gh7q3FRwVkgVJ/eI7VWqugeIo=;
	b=lKy7mIcaqgFTAA7qJQYxWn3EUs6YVQIDnMILUdJwjnRek8RG7g6UyL3z41TX4rcO9nqOzz
	WZ0EKMcDAX7v7bWxK1QVuprINFqvwEOfWeqIY1TufNA6Qa3ei3+1QwNkZcAZpuwHrYD08s
	xYDoLiyvo0FTDZzrOOiBKsjbyOK80z8=
Date: Thu, 4 Jan 2024 09:30:55 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzFdIHZpcnRpb19uZXQ6IEZpeCAi4oCYJWQ=?=
 =?UTF-8?Q?=E2=80=99_directive_writing_between_1_and_11_bytes_into_a_region_?=
 =?UTF-8?Q?of_size_10=22_warnings?=
To: Jakub Kicinski <kuba@kernel.org>, Zhu Yanjun <yanjun.zhu@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <20231227142637.2479149-1-yanjun.zhu@intel.com>
 <20240103165531.12390f0e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240103165531.12390f0e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/1/4 8:55, Jakub Kicinski 写道:
> On Wed, 27 Dec 2023 22:26:37 +0800 Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Fix the warnings when building virtio_net driver.
> This got marked as Not Applicable in patchwork, not sure why.
> Could you repost?

Got it. I will resend this commit very soon.

Best Regards,

Zhu Yanjun

