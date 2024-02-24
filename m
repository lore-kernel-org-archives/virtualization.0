Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDF286BF
	for <virtualization@lists.linux.dev>; Sat, 24 Feb 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774884; cv=none; b=smuPv61tnubA1/t7QtnUaKFWgNuRYbZWWTmrJVWScuOsEkhuEEpAPkk6TAtgc3ZJ+bKPqkTYv7Mw9FU9ZJjS5PsoDtjCAkOPL4/gFIvt+ARrroAm505D2GKqBX/C9Gm8oV0wsfqaXxBN6DFEi6e43RLlT3K8PnexgcQZXOVFDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774884; c=relaxed/simple;
	bh=nE5DSH/2ELYK1JvZqCj67vENYb9LS+DdBt1/Q4hymUQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m+POmiZvzYlNdr+K/WFKjAggW9Wz97SD1H/EmmjrsOoAyWyVPjjcXo6rzM864GUE2y3uHlxcbOATcBuknufWz67ad8dsgMQd34OT++zgCdShoKXjONYH8Kz/zBHoDh4qdoWFs9fFJCld3fhLdUWAdfbfO5YMxTWM9ggigbPCOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ThlM73S3cz4f3jHl
	for <virtualization@lists.linux.dev>; Sat, 24 Feb 2024 19:41:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 942441A016E
	for <virtualization@lists.linux.dev>; Sat, 24 Feb 2024 19:41:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnc5vV1dll0EKvEw--.15558S2;
	Sat, 24 Feb 2024 19:41:12 +0800 (CST)
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by
 max_nopage_rw
To: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
 <CAJfpegsM2ViQb1A2HNMJLsgVDs1UScd7p04MOLSkSMRNeshm0A@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cacbafa1-c229-f4e8-2fcc-ec1127bb3f26@huaweicloud.com>
Date: Sat, 24 Feb 2024 19:41:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJfpegsM2ViQb1A2HNMJLsgVDs1UScd7p04MOLSkSMRNeshm0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnc5vV1dll0EKvEw--.15558S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18Wr4kCw4DXFW7JFWrZrb_yoW5Jr1rpr
	Z3Ka17Zrs5JrWUAayxtFyqgFyxAws7KF47JrnYgw1fu3WUAwn7tF1UWF48uFy7CrZ7JayF
	krs5KwnFv398ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/23/2024 5:42 PM, Miklos Szeredi wrote:
> On Wed, 3 Jan 2024 at 11:58, Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When trying to insert a 10MB kernel module kept in a virtiofs with cache
>> disabled, the following warning was reported:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
>>   Modules linked in:
>>   CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
>>   RIP: 0010:__alloc_pages+0x2c4/0x360
>>   ......
>>   Call Trace:
>>    <TASK>
>>    ? __warn+0x8f/0x150
>>    ? __alloc_pages+0x2c4/0x360
>>    __kmalloc_large_node+0x86/0x160
>>    __kmalloc+0xcd/0x140
>>    virtio_fs_enqueue_req+0x240/0x6d0
>>    virtio_fs_wake_pending_and_unlock+0x7f/0x190
>>    queue_request_and_unlock+0x58/0x70
>>    fuse_simple_request+0x18b/0x2e0
>>    fuse_direct_io+0x58a/0x850
>>    fuse_file_read_iter+0xdb/0x130
>>    __kernel_read+0xf3/0x260
>>    kernel_read+0x45/0x60
>>    kernel_read_file+0x1ad/0x2b0
>>    init_module_from_file+0x6a/0xe0
>>    idempotent_init_module+0x179/0x230
>>    __x64_sys_finit_module+0x5d/0xb0
>>    do_syscall_64+0x36/0xb0
>>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>    ......
>>    </TASK>
>>   ---[ end trace 0000000000000000 ]---
>>
>> The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
>> kmalloc-ed memory as bound buffer for fuse args, but
> So this seems to be the special case in fuse_get_user_pages() when the
> read/write requests get a piece of kernel memory.
>
> I don't really understand the comment in virtio_fs_enqueue_req():  /*
> Use a bounce buffer since stack args cannot be mapped */
>
> Stefan, can you explain?  What's special about the arg being on the stack?
>
> What if the arg is not on the stack (as is probably the case for big
> args like this)?   Do we need the bounce buffer in that case?

I will try to answer these two questions. Correct me if I am wrong. The
main reason for the bounce buffer is that virtiofs passes a scatter list
to the virtiofsd through virtio eventually, so it needs to get the page
(namely struct page) for these args. If the arg is placed in the stack,
there is no way to get the page. For ITER_KVEC dio mentioned in the
patch, the data buffer is still allocated through vmalloc(), so the
bounce buffer is still necessary.


>
> Thanks,
> Miklos

