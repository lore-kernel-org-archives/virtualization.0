Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701805576C
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 11:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D52DC8213C
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 11:06:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D52DC8213C
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecOr547z15G9
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 11:06:11 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDA8F820B0
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 11:06:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDA8F820B0
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxuSk2Z_1701774362;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VxuSk2Z_1701774362)
          by smtp.aliyun-inc.com;
          Tue, 05 Dec 2023 19:06:04 +0800
Message-ID: <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
Date: Tue, 5 Dec 2023 19:05:59 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd
 access
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, pabeni@redhat.com, kuba@kernel.org,
 yinjun.zhang@corigine.com, edumazet@google.com, davem@davemloft.net,
 hawk@kernel.org, john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
 xuanzhuo@linux.alibaba.com
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/5 下午4:35, Jason Wang 写道:
> On Tue, Dec 5, 2023 at 4:02 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> Currently access to ctrl cmd is globally protected via rtnl_lock and works
>> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadlock
>> may occur due to cancel_work_sync for dim work.
> Can you explain why?

For example, during the bus unbind operation, the following call stack 
occurs:
virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close -> 
cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occurs).

>> Therefore, treating
>> ctrl cmd as a separate protection object of the lock is the solution and
>> the basis for the next patch.
> Let's don't do that. Reasons are:
>
> 1) virtnet_send_command() may wait for cvq commands for an indefinite time

Yes, I took that into consideration. But ndo_set_rx_mode's need for an 
atomic
environment rules out the mutex lock.

> 2) hold locks may complicate the future hardening works around cvq

Agree, but I don't seem to have thought of a better way besides passing 
the lock.
Do you have any other better ideas or suggestions?

Thanks!

>
> Thanks

