Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EFEC05027
	for <virtualization@archiver.kernel.org>; Wed,  8 Feb 2023 08:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCA618126C;
	Wed,  8 Feb 2023 08:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCA618126C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=d26Dgo9m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPwXaoePGDA8; Wed,  8 Feb 2023 08:33:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24B5D8126B;
	Wed,  8 Feb 2023 08:33:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24B5D8126B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08DEDC0032;
	Wed,  8 Feb 2023 08:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E022C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B78760E26
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B78760E26
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=d26Dgo9m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q2ubnZl2kpuH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:33:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CBE360E14
Received: from arg-plspam-c1n1.mailshover.nl (arg-plspam-c1n1.mailshover.nl
 [145.131.15.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CBE360E14
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 08:33:41 +0000 (UTC)
Received: from gw.mailshover.nl ([2001:678:76c:1:3996::58]
 helo=arg-plsmtp-c1n1.argewebhosting.nl)
 by arg-plspam-c1n1.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1pPftZ-005W1H-10; Wed, 08 Feb 2023 09:33:38 +0100
Received: from [192.168.149.229] (77-63-125-159.mobile.kpn.net [77.63.125.159])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n1.argewebhosting.nl (Postfix) with ESMTPA id 12E0B20FDDB8;
 Wed,  8 Feb 2023 09:33:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n1.argewebhosting.nl
 12E0B20FDDB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1675845215;
 bh=rYzan/FuTQ7p0YtgZz8VTrBbBeHaG2uKl4bk7bPfT00=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d26Dgo9mCFnO/sovxn9STsgkBs4UAdqIfJIgJae26neDjCKvdJtCy/1JOqkdQ+MAt
 PKNGtQXVc+BeE9hIcfbGmc7VkSx1prGo7hpGqSfxCXg4IxwxWvmTFGvxW3QhRRFKZD
 3+2ylga/T+ZpKaGBeFbr1b71rxx4WdGZbN5lS0MZVl/pnah9xfL6h2YX3S5E6EOXEV
 Z10jx/DVJh0jnd/yTvtKKrSbFsvV1AGRIdD7rX2B0ZYa2yI+fi3UxVSEIAhsDo8gxS
 ECZwi+VDpcPFKQv7zMwZh66ZALk6vzFxQioJo6M8SrBPao0unuIMsI4Rb5wRSEfDW4
 adxeg5A0Knchw==
Message-ID: <9babf0e8-19c3-bb1b-39f8-c755fdc57c8d@gootzen.net>
Date: Wed, 8 Feb 2023 09:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: virtio-fs: adding support for multi-queue
Content-Language: en-US
To: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
 <Y+LDUmWyXCdPIriB@fedora> <Y+LJMwo/K2CHdaPc@redhat.com>
In-Reply-To: <Y+LJMwo/K2CHdaPc@redhat.com>
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
 +LgxjoYkXCbk6qYg3TIawcnjp72bONhx4Mq5aOLxSoTTR9EU9SxhPgqM/MGf4rLeq1QlVxVIOSQI
 6nltebQHq1dUm7KO98IufawMVTgBlGnnha52gl/eZX+qOjZiMD+ASdkB9dbz/TtmTM5NajFEzf7m
 ynpSb/CKBVE+QbGzP2Z0BPFt5b5pCLBWHJg8WdKv5OtO95lSEeUa5U+hq5MzrI4/58ftqsSvdaOI
 qN3J28r+FUflMQb7dZr8lU7dO26mv3x+YLwVBU/MABN7lHPgCtfR1oXQBR6g9xbdPkvOsAla00Q1
 td48za8uDdjAm6jKzPHzfK0/f4gT+u8xmBYhbnenARZ7dL8z80zzxQOTDfLv6KmzCrehIIgLm0+F
 itfrR5q7RvWRRIdDsS9pj/EgmDOEqIbNAaVKKdj73uczPEg+PVRTiaxPY52n0Pp/8yV7HoI16fbi
 xIh2igyGOTY84DLWOHvWygl8AA8/5ztQlUHjPHihLGCRVrdrvGGkVOdVOjtQ2N+dx6g4qnpotjVE
 UpWDgren0H4rQ1KKGryx0JZhLC81Orwh4yINmQZR6vBLo4Y4llHVwm+NHLJa6jPDSb07I8N6S+R3
 cE1aJMVIrtAQxu0fzO2nWaLHXIXc7jCaOnYR+e17nmKXMy4iUno/l2R44/7at9DP1rQ8e6dbF/Yf
 z7ZwWRFpJHQnmVbGJADN05ts0q1kAwN/BsJ5rgnN6lWWfbxdEnUR4INpxAADH4uXMAy6RF4i1KYl
 d8mpboH7yq6mwPlbiQG1JCa4zEZrN3IFirrxg0C9TOJS5M2KxsiWtR7u1TrujcxpsCiL4TPXkiO6
 ghBAoyDaY9hnPZvlm3uvgh+r1tEhZOhX8zunvT3ZjYomfMT0lLLqxhWidw3+K7c/sfbbQMv6MIlN
 +N8HDDs3wsotH3lahGi28quuZJJOKkTac2b4ECQdKw1U9XLYM3A6BXfvel8OEFDbU53CCQnCihEa
 D46g2fxqBQefb521eLh3jGwoiiV9nXQXUeuO5TcDeKjrEmYPn2IVWRsQflB9Sq3IKyx2Xh+sOVZ4
 /D5EXEh0sJLdnFQPXuAXg8elBNnKdVKniTChC/hbCdubo/IVzCSdQGoPuuUx6qVk7EOmUJ9srurs
 HmezKxlECWroHYCAcKZUbg67z+ctunvBrQRB0bFtNR3UJCng1L88i5VmEhxHrM1JXDriv6TTJTEv
 uGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@arg-plspam-c1n0.mailshover.nl
Cc: German Maglione <gmaglione@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, miklos@szeredi.hu
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 07/02/2023 22:57, Vivek Goyal wrote:
> On Tue, Feb 07, 2023 at 04:32:02PM -0500, Stefan Hajnoczi wrote:
>> On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
>>> On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
>>>> On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
>>>>> Hi,
>>>>>
>>>
>>> [cc German]
>>>
>>>>> For my MSc thesis project in collaboration with IBM
>>>>> (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
>>>>> performance of the virtio-fs driver in high throughput scenarios. We think
>>>>> the main bottleneck is the fact that the virtio-fs driver does not support
>>>>> multi-queue (while the spec does). A big factor in this is that our setup on
>>>>> the virtio-fs device-side (a DPU) does not easily allow multiple cores to
>>>>> tend to a single virtio queue.
>>>
>>> This is an interesting limitation in DPU.
>>
>> Virtqueues are single-consumer queues anyway. Sharing them between
>> multiple threads would be expensive. I think using multiqueue is natural
>> and not specific to DPUs.
> 
> Can we create multiple threads (a thread pool) on DPU and let these
> threads process requests in parallel (While there is only one virt
> queue).
> 
> So this is what we had done in virtiofsd. One thread is dedicated to
> pull the requests from virt queue and then pass the request to thread
> pool to process it. And that seems to help with performance in
> certain cases.
> 
> Is that possible on DPU? That itself can give a nice performance
> boost for certain workloads without having to implement multiqueue
> actually.
> 
> Just curious. I am not opposed to the idea of multiqueue. I am
> just curious about the kind of performance gain (if any) it can
> provide. And will this be helpful for rust virtiofsd running on
> host as well?
> 
> Thanks
> Vivek
>
There is technically nothing preventing us from consuming a single queue 
on multiple cores, however our current Virtio implementation (DPU-side) 
is set up with the assumption that you should never want to do that 
(concurrency mayham around the Virtqueues and the DMAs). So instead of 
putting all the work into reworking the implementation to support that 
and still incur the big overhead, we see it more fitting to amend the 
virtio-fs driver with multi-queue support.


 > Is it just a theory at this point of time or have you implemented
 > it and seeing significant performance benefit with multiqueue?

It is a theory, but we are currently seeing that using the single 
request queue, the single core attending to that queue on the DPU is 
reasonably close to being fully saturated.

 > And will this be helpful for rust virtiofsd running on
 > host as well?

I figure this would be dependent on the workload and the users-needs.
Having many cores concurrently pulling on their own virtq and then 
immediately process the request locally would of course improve 
performance. But we are offloading all this work to the DPU, for 
providing high-throughput cloud services.

 > Sounds good. Assigning vqs round-robin is the strategy that virtio-net
 > and virtio-blk use. virtio-blk could be an interesting example as it's
 > similar to virtiofs. The Linux multiqueue block layer and core virtio
 > irq allocation handle CPU affinity in the case of virtio-blk.

The virtio-blk use the queue assigned by the mq block layer and 
virtio-net the queue assigned from the net core layer correct?

If I interpret you correct, the round-robin strategy is done by 
assigning cores to queues round-robin, not per requests dynamically 
round-robin?
This is what I remembered as well, but can't find it clearly in the 
source right now, do you have references to the source for this?

 > Which DPU are you targetting?

This is something I unfortunately can't disclose at the moment.

Thanks,
Peter-Jan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
