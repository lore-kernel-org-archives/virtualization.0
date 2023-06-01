Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D20FC77B7E
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 14:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D792842535;
	Thu,  1 Jun 2023 14:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D792842535
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=nSq1pOY3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fbr89RbWAAvr; Thu,  1 Jun 2023 14:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA1EE4252C;
	Thu,  1 Jun 2023 14:49:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA1EE4252C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81B9BC0037;
	Thu,  1 Jun 2023 14:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4083DC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1421560FC9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:49:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1421560FC9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=nSq1pOY3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zi_ScsbFfN1W
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:49:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27AE8613A3
Received: from arg-plspam-c1n2.mailshover.nl (arg-plspam-c1n2.mailshover.nl
 [145.131.15.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27AE8613A3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:49:12 +0000 (UTC)
Received: from gw.mailshover.nl ([2001:678:76c:1:3996::58]
 helo=arg-plsmtp-c1n2.argewebhosting.nl)
 by arg-plspam-c1n2.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1q4jbw-00BsmT-Cx; Thu, 01 Jun 2023 16:49:09 +0200
Received: from [192.168.83.229] (77-63-74-5.mobile.kpn.net [77.63.74.5])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n2.argewebhosting.nl (Postfix) with ESMTPA id BC891205E4D0;
 Thu,  1 Jun 2023 16:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n2.argewebhosting.nl
 BC891205E4D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1685630947;
 bh=SRoS/Iynd9JW8GnCelXRVWY7tukErst3VzmD3Q2Oes0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nSq1pOY3wd30cAo0n6lIAjxgxgMssW1+fjbTgNCHoHbbfJG7fTonEWCXPwLogJgvw
 Je+ZfK/Ckz3AMU1coRi/V7CVkoZoNcW3Mvll7iqokahsleMNEpTprGIbKcNKhorJV1
 OKbFNFS/7PAXX+YrxIo9hpV5RDpS+QPAdLjjjwdQzwoDELvFuQBPAUrP2YpX5kjw7n
 /qr9Tw8vTuXa2THmXaP2ejh0CYY/YpBp8nqmMNM7+aag1ji4aFqvuGp9Xt0wxuzm5v
 95llI9rBQGIRSB/yN6FDyP3njuqxvlR+Bs7uQKtaXMD0BG7ssAsevZI3gWQYTowyNZ
 ORu7uD3crazlQ==
Message-ID: <07667704-3409-3ad8-6944-b485369e5022@gootzen.net>
Date: Thu, 1 Jun 2023 16:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH V2] virtio-fs: Improved request latencies when Virtio
 queue is full
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
References: <20230531171031.1424338-1-peter-jan@gootzen.net>
 <ZHedgNu89LoiW4sZ@redhat.com>
 <02ad6a48-6db7-fab5-721e-2d940d4a664a@gootzen.net>
 <ZHey45k+V8sP2F6l@redhat.com> <20230601140850.GF1538357@fedora>
In-Reply-To: <20230601140850.GF1538357@fedora>
X-Originating-IP: 2001:678:76c:1:3996::58
X-SpamExperts-Domain: out.mailshover.nl
X-SpamExperts-Username: 2001:678:76c:1:3996::58
Authentication-Results: mailshover.nl; auth=pass
 smtp.auth=2001:678:76c:1:3996::58@out.mailshover.nl
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT90jVzTLJt3vj6cAu5S4eQ0PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5xzOoHxWscew68UvLJqW/V1opzyoDuAP4C0aaz3STa5zA+i
 +LgxjoYkXCbk6qYg3TLiBCq0YCJmjpNMbRTU3wgrC0Y3u/qphs34dTesYrpa6tiW8BKfyIS6EHTV
 hG8std+lEPHKAzuJoUDzV774tvkniFloh3x3CR4Jb2gWRrpPKG0sS4NT/S7hraIXwgzzV4aouJYi
 QWxaMB85XLIGw32ggM1FjTV5UXzaWZFiY/IuWRLx/Du65BKz/oEcyvz1uhV1UWVvvdkzh9/Seh7h
 SLJU1ktV7ekmGpxaAJ/k28IIq/fPjylt/HZ8k1j7Ut/7PLZ4sHptmj4KtYP0wWf5ni5f7Ogv5mRk
 S/8bWrZGatZmbSSp6wqBiWgCUvpQC7hp792Kjeyl92hTDJK+4O0vOmkQc1UkGqjsciyILerEw8FX
 FnC9J8Tfx0FDPUDJU5K58QZrH/iEgzfzmnMXBIwMoePog2OkM5zMbrn2rUwXJSugd8VmzzAQ6gJW
 hVbNViZCOWKRNtlfJySsZ2eS9qGTagUdlCnL4IjEaJi/Te03jgZkrrEp5+1QCuHCTUw0ggLUf54P
 bqpDL7OvFc18bWQRihVmn+UCB3F67PeP7Iep2w5lJ/gPneWh5kublaxZVQoA47wpOMQJvQ/Ck3ii
 U+4DQAj3DhYpgwxEDQuH7GNpv2Hu1lWbvKBSWz9JL+ncH+8owBXh81G7jrpdN7mVSzj08dE/Vqh+
 p1fAN4lz32ween1ENfns9RKYgRr/zO6Pq7dkcZCRq3oTg7MWD+ZQoaUmN03jRfRyWTWs40tiYHh/
 OVIkQNEvdUolNl0YNdMUajomuQYN/2oiLQnPnhxk6tgp0mibbPhjo3exrvNYlwUjtixib2avL+YD
 c2YHUzAZPzd03lfeLwwWMKXDYWRmRiEAGsmgDO7nA7k6cOyQxjQhps+jdFz1pRXWhjh9fdbl44I0
 Df3UANye5mij+Mqql8NZoGGE1H07YtaUHC2h22rHSV+m0L6jX0Is2t8eEL3ZqG06ZzoMifa29zXh
 hznXry6IqJnerLfiFNb0FFyRjT8NmcTq0ZsK3TexxWxyube0LJjGSj+jnQa75Jum1feMIVfUDmU/
 w0m9OyPDekvkd3BNWiTFSFOlxsY77ASAZB1sLAji3Opi4pBglvBqtTQxJduSkSzRv5CQHId5vY1x
 DTpc1F/nsvY4ocfmWv3Fe9Iziczdq+A=
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

On 01/06/2023 16:08, Stefan Hajnoczi wrote:
> On Wed, May 31, 2023 at 04:49:39PM -0400, Vivek Goyal wrote:
>> On Wed, May 31, 2023 at 10:34:15PM +0200, Peter-Jan Gootzen wrote:
>>> On 31/05/2023 21:18, Vivek Goyal wrote:
>>>> On Wed, May 31, 2023 at 07:10:32PM +0200, Peter-Jan Gootzen wrote:
>>>>> When the Virtio queue is full, a work item is scheduled
>>>>> to execute in 1ms that retries adding the request to the queue.
>>>>> This is a large amount of time on the scale on which a
>>>>> virtio-fs device can operate. When using a DPU this is around
>>>>> 40us baseline without going to a remote server (4k, QD=1).
>>>>> This patch queues requests when the Virtio queue is full,
>>>>> and when a completed request is taken off, immediately fills
>>>>> it back up with queued requests.
>>>>>
>>>>> This reduces the 99.9th percentile latencies in our tests by
>>>>> 60x and slightly increases the overall throughput, when using a
>>>>> queue depth 2x the size of the Virtio queue size, with a
>>>>> DPU-powered virtio-fs device.
>>>>>
>>>>> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
>>>>> ---
>>>>> V1 -> V2: Not scheduling dispatch work anymore when not needed
>>>>> and changed delayed_work structs to work_struct structs
>>>>>
>>>>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
>>>>>  1 file changed, 17 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>>>>> index 4d8d4f16c727..a676297db09b 100644
>>>>> --- a/fs/fuse/virtio_fs.c
>>>>> +++ b/fs/fuse/virtio_fs.c
>>>>> @@ -45,7 +45,7 @@ struct virtio_fs_vq {
>>>>>  	struct work_struct done_work;
>>>>>  	struct list_head queued_reqs;
>>>>>  	struct list_head end_reqs;	/* End these requests */
>>>>> -	struct delayed_work dispatch_work;
>>>>> +	struct work_struct dispatch_work;
>>>>>  	struct fuse_dev *fud;
>>>>>  	bool connected;
>>>>>  	long in_flight;
>>>>> @@ -202,7 +202,7 @@ static void virtio_fs_drain_queue(struct virtio_fs_vq *fsvq)
>>>>>  	}
>>>>>  
>>>>>  	flush_work(&fsvq->done_work);
>>>>> -	flush_delayed_work(&fsvq->dispatch_work);
>>>>> +	flush_work(&fsvq->dispatch_work);
>>>>>  }
>>>>>  
>>>>>  static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
>>>>> @@ -346,6 +346,9 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
>>>>>  			dec_in_flight_req(fsvq);
>>>>>  		}
>>>>>  	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
>>>>> +
>>>>> +	if (!list_empty(&fsvq->queued_reqs))
>>>>> +		schedule_work(&fsvq->dispatch_work);
>>>>>  	spin_unlock(&fsvq->lock);
>>>>>  }
>>>>>  
>>>>> @@ -353,7 +356,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>>>>  {
>>>>>  	struct fuse_req *req;
>>>>>  	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
>>>>> -						 dispatch_work.work);
>>>>> +						 dispatch_work);
>>>>>  	int ret;
>>>>>  
>>>>>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
>>>>> @@ -388,8 +391,6 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
>>>>>  			if (ret == -ENOMEM || ret == -ENOSPC) {
>>>>>  				spin_lock(&fsvq->lock);
>>>>>  				list_add_tail(&req->list, &fsvq->queued_reqs);
>>>>> -				schedule_delayed_work(&fsvq->dispatch_work,
>>>>> -						      msecs_to_jiffies(1));
>>>>
>>>> Virtqueue being full is only one of the reasons for failure to queue
>>>> the request. What if virtqueue is empty but we could not queue the
>>>> request because lack of memory (-ENOMEM). In that case we will queue
>>>> the request and it might not be dispatched because there is no completion.
>>>> (Assume there is no further new request coming). That means deadlock?
>>>>
>>>> Thanks
>>>> Vivek
>>>>
>>>
>>> Good catch that will deadlock.
>>>
>>> Is default kernel behavior to indefinitely retry a file system
>>> request until memory is available?
>>
>> As of now that seems to be the behavior. I think I had copied this
>> code from another driver. 
>>
>> But I guess one can argue that if memory is not available, then
>> return -ENOMEM to user space instead of retrying in kernel.
>>
>> Stefan, Miklos, WDYT?
> 
> My understanding is that file system syscalls may return ENOMEM, so this
> is okay.
> 
> Stefan

Then I propose only handling -ENOSPC as a special case and letting all
other errors go through to userspace.

Noob Linux contributor question: how often should I send in a new revision of
the patch? Should I wait for more comments or send in a V3 with that fix now?

Best,
Peter-Jan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
