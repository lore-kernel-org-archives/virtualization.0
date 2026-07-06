Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3C3F8235
	for <virtualization@lists.linux.dev>; Mon,  6 Jul 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337523; cv=none; b=gBeA56bJjx/Ag4n5NriGX9ailMBMLI499zsinynxkkgsWnfsM7ofnVhgaZzhCTk3YDqu9/XB8BExUIDH+4MJrlZdJ36Gsl9Rmr49wJ4Y5fikD54z5BCZiuOyu5YZ5ZRgo7yCGnKjikCakeM9CdkctqSP8bUl2Z7vfQQuLE0vSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337523; c=relaxed/simple;
	bh=BLYTU/FB02JaMt+a+NRBpjJbtGwQHXGUPpjml7VqeZQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GyhIylWVh+QHfaSRYGKg+j1vZD2F9mLkKknPkYUhrwTi5NvLa30PTXEIbrWRIGrXC/pifK6kQRpMkhyEksf3k30bM6hFeYX7jpaXshtuMK9UsIKxN5DByvveL7G7a3KKIjSOn9+xFAt7zfhiw7GmbBEb/HAQQiGknR3JaXpjFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q2yApZVs; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q2yApZVs"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T/ob3DPNtA2AANXo33FNblZ3kqyiNGk8sYmN47Kv6xQ=;
	b=q2yApZVsSaTwACej7DuIe47ztVE2QwyVXppO7aIhAc1MwY7D0/N/AWDGxjla8sUr+K5/XzNxC
	VdJBZsiCbAoQwaK4h+XpHNJJxgmFZ1qFpd4hLzWEE1H1/QTVKJqoqgsPzOb03uJjSzQp5T+JHNu
	HTnqix69dUijr7gIl1hxx2M=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gv25b1b0Mz1K9BV;
	Mon,  6 Jul 2026 19:22:43 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id CEE6E40565;
	Mon,  6 Jul 2026 19:31:54 +0800 (CST)
Received: from [10.174.177.15] (10.174.177.15) by
 kwepemj100016.china.huawei.com (7.202.194.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 19:31:53 +0800
Message-ID: <0e51efaa-24b7-4a19-97f4-0669fd92d513@huawei.com>
Date: Mon, 6 Jul 2026 19:31:52 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>,
	<syzbot+listbf7b8eeeb8dda31d6de1@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <stefanha@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kvm@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [syzbot] Monthly virt report (Jun 2026)
To: <sgarzare@redhat.com>
References: <6a3c3ed6.80e5668d.5d0ef.0001.GAE@google.com>
 <d1e9d389-affa-4d12-aaf7-3fcf3218966c@huawei.com>
 <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <CAGxU2F582RpWGOUxTU783zZuxWj7e4eZtiDcNdUmWobLSFSq2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100016.china.huawei.com (7.202.194.10)



On 周一 2026-7-6 17:24, Stefano Garzarella wrote:
> On Thu, 2 Jul 2026 at 04:55, mawupeng <mawupeng1@huawei.com> wrote:
>> On 周四 2026-6-25 04:32, syzbot wrote:
>>> Hello virt maintainers/developers,
>>>
>>> This is a 31-day syzbot report for the virt subsystem.
>>> All related reports/information can be found at:
>>> https://syzkaller.appspot.com/upstream/s/virt
>>>
>>> During the period, 0 new issues were detected and 0 were fixed.
>>> In total, 5 issues are still open and 61 have already been fixed.
>>> There are also 2 low-priority issues.
>>>
>>> Some of the still happening issues:
>>>
>>> Ref Crashes Repro Title
>>> <1> 24      No    WARNING: refcount bug in call_timer_fn (4)
>>>                   https://syzkaller.appspot.com/bug?extid=07dcf509f4c013e25dc5
>>> <2> 3       Yes   memory leak in __vsock_create (2)
>>>                   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>
>> Hi,
>>
>> This is regarding the still-open "memory leak in __vsock_create (2)"
>> bug (#2 in the monthly virt report, extid 1b2c9c4a0f8708082678):
>>   https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>
>> I spent some time analyzing the root cause and the previous fix
>> attempt; below is a summary and a direction that tested out.
> 
> [...]
> 
>>
>> I'm not subscribed to follow the list at full volume; happy to send a
>> formal patch (with the af_vsock.h / pending_work changes folded in)
>> if the direction looks right to the maintainers.
> 
> Yes, please, a formal patch with a great commit message is much better
> than a long text to read IMO.

Thanks for replying.

As we conducted more thorough testing and further analysis of our own fix,
we found that it is not as comprehensive as the existing AI-generated fix
provided[1].

Could you please let us know if there are any issues with this AI-generated fix?

[1]: https://syzkaller.appspot.com/ai_job?id=cd978d21-2110-4f57-9525-d7d91c4a7e02

> 
> Thanks,
> Stefano
> 
> 

