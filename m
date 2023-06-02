Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BC1C7EE24
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 13:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E7F661625;
	Fri,  2 Jun 2023 13:30:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E7F661625
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=GPoUwqOp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1FpbzcylEF5; Fri,  2 Jun 2023 13:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E11B60F31;
	Fri,  2 Jun 2023 13:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E11B60F31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40FC6C0037;
	Fri,  2 Jun 2023 13:30:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01F3BC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB05241FE4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BB05241FE4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=GPoUwqOp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QuqVShS7cPz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:30:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 264EA41EEA
Received: from arg-plspam-c1n1.mailshover.nl (arg-plspam-c1n1.mailshover.nl
 [145.131.15.41])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 264EA41EEA
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 13:30:08 +0000 (UTC)
Received: from [5.100.226.106] (helo=arg-plsmtp-c1n2.argewebhosting.nl)
 by arg-plspam-c1n1.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1q54qt-002Nr2-0Z; Fri, 02 Jun 2023 15:30:05 +0200
Received: from [130.37.202.219] (unknown [130.37.202.219])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n2.argewebhosting.nl (Postfix) with ESMTPA id 878FF20774BA;
 Fri,  2 Jun 2023 15:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n2.argewebhosting.nl
 878FF20774BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1685711480;
 bh=xD+LkTEdnTOgB4UWCd2W0rHyPSg4kKrsnvvsl0VWOek=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GPoUwqOpXZTjMMhe1UagOlbMcpLQykM0VMfMfIT3dQPEXyxUJqHxKCWRwlvKxwlR7
 b2vhGWbgJXr41vOmqdakNWiym2GmdRERPBFnjy5FWbE6GDKEN5U2MeX7A7kgoiiWG+
 NCdKICyNIkhFBI1DASKXhntDvB1xGXTX/OjPuoqgeXavh6A1YDjUPt03Lm0APNtdvt
 0AyORjIDaMqQcTbUK83ETKTdtKeB8lMOY+iFKOCZjdiLaiXZpgBbq2O+w/sSCLneQ9
 q6651G2tnxuqzvGZ0NB0NVrymWpYzvbTaJiiddDJw4lFpwtr7aKTe3by0tY5PV+24Q
 i9yN8/xMYjvOQ==
Message-ID: <f204aceb-37a5-336c-4fa8-ffd2eac89df5@gootzen.net>
Date: Fri, 2 Jun 2023 15:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH V2] virtio-fs: Improved request latencies when Virtio
 queue is full
Content-Language: en-US
To: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230531171031.1424338-1-peter-jan@gootzen.net>
 <ZHedgNu89LoiW4sZ@redhat.com>
 <02ad6a48-6db7-fab5-721e-2d940d4a664a@gootzen.net>
 <ZHey45k+V8sP2F6l@redhat.com> <20230601140850.GF1538357@fedora>
 <ZHjnRJXeJnZ9THnO@redhat.com>
In-Reply-To: <ZHjnRJXeJnZ9THnO@redhat.com>
X-Originating-IP: 5.100.226.106
X-SpamExperts-Domain: out.mailshover.nl
X-SpamExperts-Username: 5.100.226.106
Authentication-Results: mailshover.nl;
 auth=pass smtp.auth=5.100.226.106@out.mailshover.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00175661771664)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT92Wblp64m6y23ZuKZMzCK7PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzOoHxWscew68UvLJqW/V1opzyoDuAP4C0aaz3STa5zA+i
 +LgxjoYkXCbk6qYg3TLiBCq0YCJmjpNMbRTU3wgrC0Y3u/qphs34dTesYrpa6tiW8BKfyIS6EHTV
 hG8std+lEPHKAzuJoUDzV774tvkniFloh3x3CR4Jb2gWRrpPKHavoBcHFXwZUk97fdW2ONaouJYi
 QWxaMB85XLIGw32ggM1FjTV5UXzaWZFiY/IuWRLx/Du65BKz/oEcyvz1uhV1UWVvvdkzh9/Seh7h
 SLJU1ktV7ekmGpxaAJ/k28IIq/fPjylt/HZ8k1j7Ut/7PLb7521/uy4r4RP2U/suYnM07Ogv5mRk
 S/8bWrZGatZmbaRBZTprHzkFMzwAzmAh7tTKPGi8jp8jsUjzKct0i2ODM0F9oOOr1xI6jl9Hi9P1
 DKmAwTrzmCHomMs24PzTKAo9gK7/ebDoJ006fIc/+3LKW50gw74ge2pR5Dl9Oxy663zHNkoKwUL9
 WpKjkCojOcsWB9DKkolz7mz7R/5+TR/mb1HgElnnwmI9eQkYzxF3C5agY6v8FjBDhSdJTcfh+/jl
 gTl6fJxyntEfhZCKje4ZDU2/WT5nRIUO3uYch+hAG+TJt6lvqTFBPeozbCkFbqtQLgVqEDmqiK0l
 c17lHF9hQdumSwX5R/88G6ikH5H4tYHVHhzxKltKX/MiaOmx+aXxYXZV7IIcbpaDH/GiU/HytjIG
 7LKzPRPEQUu/PvFeiA8a8+GuZalPmdWaN1GHD8yIQFsrYFEiJEk0Iaw6PBU37Sv6vaDLqb+8rWNF
 lVumawFJ7WVxftoEKQcKvZy1TVAN/2oiLQnPnhxk6tgp0mib5Q50akIN2ZeFlRJmkbJ0ZQ6BanjA
 xVKuJGAhWFF2ZSS+UjcWrIZozpmyIymMtVvuctgzcDoFd+96Xw4QUNtTncp2Qc83zSxytKTt0K+z
 +iotWt2aAGpJDJhZO1G1eN/3CElo9fMv4vD4V+O21R0NgZ+EySNgoEOVVxge1mczbDczWgQESVrY
 xKPfHopgdidcYIjrL3lpTJvQHIv/znG8DGgQIoAcTXG84PsRSeM/8MDAyAyO4Oh498/JE76rMvq0
 Gxr0D6eYR3txFV/LGulnVammGulH/N9Orm0K761f8wsUF6Pa8StFgmwtrwMBe0ED
X-Report-Abuse-To: spam@arg-plspam-c1n0.mailshover.nl
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Peter-Jan Gootzen via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 01/06/2023 20:45, Vivek Goyal wrote:
> On Thu, Jun 01, 2023 at 10:08:50AM -0400, Stefan Hajnoczi wrote:
>> On Wed, May 31, 2023 at 04:49:39PM -0400, Vivek Goyal wrote:
>>> On Wed, May 31, 2023 at 10:34:15PM +0200, Peter-Jan Gootzen wrote:
>>>> On 31/05/2023 21:18, Vivek Goyal wrote:
>>>>> On Wed, May 31, 2023 at 07:10:32PM +0200, Peter-Jan Gootzen wrote:
>>>>>> When the Virtio queue is full, a work item is scheduled
>>>>>> to execute in 1ms that retries adding the request to the queue.
>>>>>> This is a large amount of time on the scale on which a
>>>>>> virtio-fs device can operate. When using a DPU this is around
>>>>>> 40us baseline without going to a remote server (4k, QD=1).
>>>>>> This patch queues requests when the Virtio queue is full,
>>>>>> and when a completed request is taken off, immediately fills
>>>>>> it back up with queued requests.
>>>>>>
>>>>>> This reduces the 99.9th percentile latencies in our tests by
>>>>>> 60x and slightly increases the overall throughput, when using a
>>>>>> queue depth 2x the size of the Virtio queue size, with a
>>>>>> DPU-powered virtio-fs device.
>>>>>>
>>>>>> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
>>>>>> ---
>>>>>> V1 -> V2: Not scheduling dispatch work anymore when not needed
>>>>>> and changed delayed_work structs to work_struct structs
>>>>>>
>>>>>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
>>>>>>  1 file changed, 17 insertions(+), 15 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>>>>>> index 4d8d4f16c727..a676297db09b 100644
>>>>>> --- a/fs/fuse/virtio_fs.c
>>>>>> +++ b/fs/fuse/virtio_fs.c
>>>>>> @@ -45,7 +45,7 @@ struct virtio_fs_vq {
>>>>>>  	struct work_struct done_work;
>>>>>>  	struct list_head queued_reqs;
>>>>>>  	struct list_head end_reqs;	/* End these requests */
>>>>>> -	struct delayed_work dispatch_work;
>>>>>> +	struct work_struct dispatch_work;
>>>>>>  	struct fuse_dev *fud;
>>>>>>  	bool connected;
>>>>>>  	long in_flight;
>>>>>> @@ -202,7 +202,7 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
>>>>>>  	}
>>>>>>  
>>>>>>  	flush_work(&fsvq->done_work);
>>>>>> -	flush_delayed_work(&fsvq->dispatch_work);
>>>>>> +	flush_work(&fsvq->dispatch_work);
>>>>>>  }
>>>>>>  
>>>>>>  static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
>>>>>> @@ -346,6 +346,9 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
>>>>>>  			dec_in_flight_req(fsvq);
>>>>>>  		}
>>>>>>  	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
>>>>>> +
>>>>>> +	if (!list_empty(&fsvq->queued_reqs))
>>>>>> +		schedule_work(&fsvq->dispatch_work);
>>>>>>  	spin_unlock(&fsvq->lock);
>>>>>>  }
>>>>>>  
>>>>>> @@ -353,7 +356,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>>>>>  {
>>>>>>  	struct fuse_req *req;
>>>>>>  	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
>>>>>> -						 dispatch_work.work);
>>>>>> +						 dispatch_work);
>>>>>>  	int ret;
>>>>>>  
>>>>>>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
>>>>>> @@ -388,8 +391,6 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>>>>>  			if (ret == -ENOMEM || ret == -ENOSPC) {
>>>>>>  				spin_lock(&fsvq->lock);
>>>>>>  				list_add_tail(&req->list, &fsvq->queued_reqs);
>>>>>> -				schedule_delayed_work(&fsvq->dispatch_work,
>>>>>> -						      msecs_to_jiffies(1));
>>>>>
>>>>> Virtqueue being full is only one of the reasons for failure to queue
>>>>> the request. What if virtqueue is empty but we could not queue the
>>>>> request because lack of memory (-ENOMEM). In that case we will queue
>>>>> the request and it might not be dispatched because there is no completion.
>>>>> (Assume there is no further new request coming). That means deadlock?
>>>>>
>>>>> Thanks
>>>>> Vivek
>>>>>
>>>>
>>>> Good catch that will deadlock.
>>>>
>>>> Is default kernel behavior to indefinitely retry a file system
>>>> request until memory is available?
>>>
>>> As of now that seems to be the behavior. I think I had copied this
>>> code from another driver. 
>>>
>>> But I guess one can argue that if memory is not available, then
>>> return -ENOMEM to user space instead of retrying in kernel.
>>>
>>> Stefan, Miklos, WDYT?
>>
>> My understanding is that file system syscalls may return ENOMEM, so this
>> is okay.
> 
> Ok. Fair enough. Thanks.
> 
> One more question. How do we know virtqueue is full. Is -ENOSPC is the
> correct error code to check and retry indefinitely. Are there other
> situations where -ENOSPC can be returned. Peter's current patch rely
> on the fact that there is atleast one completion happening after
> queuing of request which will kick the worker thread and submit the
> request later.
> 
> We need to watch out for race conditions very closely. If that assumption
> is not valid in some cases or there are races between getting -ENOSPC
> and request completions, we will have a deadlock scenario.
> 
> Thanks
> Vivek
> 

When following the code path, -ENOSPC is only returned when the queue is
full. So that assumption is correct.

As for race conditions where a request might be lost. If -ENOSPC is
returned and in the mean time the queue has become full again, the 
worker will simply fail and be re-executed when something is taken
off the queue again. It is possible that this will happen indefinitely,
but that's also possible in the current version of the driver.

Peter-Jan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
