Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA0DC678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 19:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37DAD610FA;
	Tue,  7 Mar 2023 19:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37DAD610FA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gootzen.net header.i=@gootzen.net header.a=rsa-sha256 header.s=aw2020113001 header.b=BjKkSSKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PnujtrEu_xCx; Tue,  7 Mar 2023 19:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 15659610F2;
	Tue,  7 Mar 2023 19:43:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15659610F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E002DC0071;
	Tue,  7 Mar 2023 19:43:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DE88C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 19:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6BD541730
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 19:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6BD541730
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gootzen.net header.i=@gootzen.net
 header.a=rsa-sha256 header.s=aw2020113001 header.b=BjKkSSKa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgqt7u1AODew
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 19:43:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D305541729
Received: from arg-plspam-c1n4.mailshover.nl (arg-plspam-c1n4.mailshover.nl
 [145.131.15.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D305541729
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 19:43:42 +0000 (UTC)
Received: from gw.mailshover.nl ([2001:678:76c:1:3996::58]
 helo=arg-plsmtp-c1n2.argewebhosting.nl)
 by arg-plspam-c1n4.mailshover.nl with esmtp (Exim 4.92)
 (envelope-from <peter-jan@gootzen.net>)
 id 1pZdDl-00H9W2-Tx; Tue, 07 Mar 2023 20:43:39 +0100
Received: from [192.168.2.3] (86-94-78-64.fixed.kpn.net [86.94.78.64])
 (Authenticated sender: peter-jan@gootzen.net)
 by arg-plsmtp-c1n2.argewebhosting.nl (Postfix) with ESMTPA id 08452212C580;
 Tue,  7 Mar 2023 20:43:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 arg-plsmtp-c1n2.argewebhosting.nl
 08452212C580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gootzen.net;
 s=aw2020113001; t=1678218216;
 bh=5KkI/k3jsWseHlb5Bvd8UoMyxCu8OaCeP04nWTxNKFI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BjKkSSKawgykN3kBLVSXXRRiH0UE/QHvf0oc41gUISSNPmfVOLUPWeyrwYs2QeG9a
 PBhHkK+FlqzpzsfFzjEswqpXhKj6Afkr9QneTEv3H/VQlV53P8GW7+RBGyOqHn0aw9
 2ajNPA4YmiwRaihe74YjAoU1VFzemi0uZKFKpuBYDp4CLojVRq4fX/HrUZlTUyYRRY
 Ko4RodEQ+zq1l19kofL3h6pfd9RfU0ModzGBS+uNCaXwcBX5b2TE1+pNonA9IrXYml
 tolMnSVTJxo7R/9sHdwdB9+O1FVOLUfQUjGe4p0RN5YYgBXkV1+eyoSqfmOqp+jYf0
 XPE1EE0/Pgoig==
Message-ID: <40eeb5a4-3515-2277-460a-03c06c03126c@gootzen.net>
Date: Tue, 7 Mar 2023 20:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: virtio-fs: adding support for multi-queue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
 <Y+LDUmWyXCdPIriB@fedora> <Y+LJMwo/K2CHdaPc@redhat.com>
 <9babf0e8-19c3-bb1b-39f8-c755fdc57c8d@gootzen.net> <Y+N8x5kIe3pAaeUj@fedora>
 <82ddafee-7548-e7bd-2f41-24ce9251aa25@gootzen.net> <Y/YncAV/7H+vzNCy@fedora>
In-Reply-To: <Y/YncAV/7H+vzNCy@fedora>
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
 ynpSb/CKBVE+QbGzP2Z0BPFt5b5pCLBWHJg8WbFJziHgK1Oil8cgZzG1jY8zrI4/58ftqsSvdaOI
 qN3J28r+FUflMQb7dZr8lU7dO26mv3x+YLwVBU/MABN7lHPgCtfR1oXQBR6g9xbdPkvO2m4rOTlf
 lVUxBr5I5CECRqjKzPHzfK0/f4gT+u8xmBY51pW35Y5CNhuXtnJzIUaeDfLv6KmzCrehIIgLm0+F
 itfrR5q7RvWRRIdDsS9pj/EgmDOEqIbNAaVKKdj73uczPEg+PVRTiaxPY52n0Pp/8yV7HoI16fbi
 xIh2igyGOTY84DLWOHvWygl8AA8/5ztQlUHjPHihLGCRVrdrvGGkVOdVOjtQ2N+dx6g4qnpotjVE
 UpWDgren0H4rQ1KKGryx0JZhLC81Orwh4yINmQZR6vBLo4Y4llHVwm+NHLJa6jPDSb07I8N6S+R3
 cE1aJMVIrtAQxu0fzO2nWaLHXIXc7jCaOnYR+e17nmKXMy4iUno/l2R44/7at9DP1rQ8e6dbF/Yf
 z7ZwWRFpJHQnmVbGJADN05ts0q1kAwN/BsJ5rgnN6lWWfbxdEnUR4INpxAADPys1B40gCL5VNX8g
 JFo88WpjKQHJiT2j1/80QvMXtYprN3IFirrxg0C9TOJS5M2KxsiWtR7u1TrujcxpsCiL4TPXkiO6
 ghBAoyDaY9hnPZvlm3uvgh+r1tEhZOhX8zunvT3ZjYomfMT0lLLqxhWidw3+K7c/sfbbQMv6MIlN
 +N/lrH7p6VGdwfImRl/rPGStdnL1rUNfcZIlJvngbMObx3LYM3A6BXfvel8OEFDbU53CCQnCihEa
 D46g2fxqBQefb521eLh3jGwoiiV9nXQXUeuO5TcDeKjrEmYPn2IVWRsQflB9Sq3IKyx2Xh+sOVZ4
 CBatn0S8eirC/vmWnQKPHselBNnKdVKniTChC/hbCdubo/IVzCSdQGoPuuUx6qVk7EOmUJ9srurs
 HmezKxlECWroHYCAcKZUbg67z+ctunvBrQRB0bFtNR3UJCng1L88i5VmEhxHrM1JXDriv6TTJTEv
 uGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@arg-plspam-c1n0.mailshover.nl
Cc: German Maglione <gmaglione@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 miklos@szeredi.hu
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

On 22-02-2023 15:32, Stefan Hajnoczi wrote:
> On Wed, Feb 08, 2023 at 05:29:25PM +0100, Peter-Jan Gootzen wrote:
>> On 08/02/2023 11:43, Stefan Hajnoczi wrote:
>>> On Wed, Feb 08, 2023 at 09:33:33AM +0100, Peter-Jan Gootzen wrote:
>>>>
>>>>
>>>> On 07/02/2023 22:57, Vivek Goyal wrote:
>>>>> On Tue, Feb 07, 2023 at 04:32:02PM -0500, Stefan Hajnoczi wrote:
>>>>>> On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
>>>>>>> On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
>>>>>>>> On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>
>>>>>>> [cc German]
>>>>>>>
>>>>>>>>> For my MSc thesis project in collaboration with IBM
>>>>>>>>> (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
>>>>>>>>> performance of the virtio-fs driver in high throughput scenarios. We think
>>>>>>>>> the main bottleneck is the fact that the virtio-fs driver does not support
>>>>>>>>> multi-queue (while the spec does). A big factor in this is that our setup on
>>>>>>>>> the virtio-fs device-side (a DPU) does not easily allow multiple cores to
>>>>>>>>> tend to a single virtio queue.
>>>>>>>
>>>>>>> This is an interesting limitation in DPU.
>>>>>>
>>>>>> Virtqueues are single-consumer queues anyway. Sharing them between
>>>>>> multiple threads would be expensive. I think using multiqueue is natural
>>>>>> and not specific to DPUs.
>>>>>
>>>>> Can we create multiple threads (a thread pool) on DPU and let these
>>>>> threads process requests in parallel (While there is only one virt
>>>>> queue).
>>>>>
>>>>> So this is what we had done in virtiofsd. One thread is dedicated to
>>>>> pull the requests from virt queue and then pass the request to thread
>>>>> pool to process it. And that seems to help with performance in
>>>>> certain cases.
>>>>>
>>>>> Is that possible on DPU? That itself can give a nice performance
>>>>> boost for certain workloads without having to implement multiqueue
>>>>> actually.
>>>>>
>>>>> Just curious. I am not opposed to the idea of multiqueue. I am
>>>>> just curious about the kind of performance gain (if any) it can
>>>>> provide. And will this be helpful for rust virtiofsd running on
>>>>> host as well?
>>>>>
>>>>> Thanks
>>>>> Vivek
>>>>>
>>>> There is technically nothing preventing us from consuming a single queue on
>>>> multiple cores, however our current Virtio implementation (DPU-side) is set
>>>> up with the assumption that you should never want to do that (concurrency
>>>> mayham around the Virtqueues and the DMAs). So instead of putting all the
>>>> work into reworking the implementation to support that and still incur the
>>>> big overhead, we see it more fitting to amend the virtio-fs driver with
>>>> multi-queue support.
>>>>
>>>>
>>>>> Is it just a theory at this point of time or have you implemented
>>>>> it and seeing significant performance benefit with multiqueue?
>>>>
>>>> It is a theory, but we are currently seeing that using the single request
>>>> queue, the single core attending to that queue on the DPU is reasonably
>>>> close to being fully saturated.
>>>>
>>>>> And will this be helpful for rust virtiofsd running on
>>>>> host as well?
>>>>
>>>> I figure this would be dependent on the workload and the users-needs.
>>>> Having many cores concurrently pulling on their own virtq and then
>>>> immediately process the request locally would of course improve performance.
>>>> But we are offloading all this work to the DPU, for providing
>>>> high-throughput cloud services.
>>>
>>> I think Vivek is getting at whether your code processes requests
>>> sequentially or in parallel. A single thread processing the virtqueue
>>> that hands off requests to worker threads or uses io_uring to perform
>>> I/O asynchronously will perform differently from a single thread that
>>> processes requests sequentially in a blocking fashion. Multiqueue is not
>>> necessary for parallelism, but the single queue might become a
>>> bottleneck.
>>
>> Requests are handled non-blocking with remote IO on the DPU. Our current
>> architecture is as follows:
>> T1: Tends to the Virtq, parses FUSE to remote IO and fires off the
>> asynchronous remote IO.
>> T2: Polls for completion on the remote IO and parses it back to FUSE, puts
>> the FUSE buffers in a completion queue of T1.
>> T1: Handles the Virtio completion and DMA of the requests in the CQ.
>>
>> Thread 1 is busy polling on its two queues (Virtq and CQ) with equal
>> priority, thread 2 is busy polling as well. This setup is not really
>> optimal, but we are working within the constraints of both our DPU and
>> remote IO stack.
> 
> Why does T1 need to handle VIRTIO completion and DMA requests instead of
> T2?
> 
> Stefan

No good reason other than the fact that the concurrency safety of our 
DPU's virtio-fs library requires this.

 > I had been doing some performance benchmarking for virtio-fs and I found
 > some old results.
 >
 > 
https://github.com/rhvgoyal/virtiofs-tests/tree/master/performance-results/feb-10-2021
 >
 > While running on top of local fs, with bs=4K, with single queue I could
 > achieve more than 600MB/s.
 >
 > NAME                    WORKLOAD                Bandwidth       IOPS
 > default                 seqread-psync           625.0mb         156.2k
 > no-tpool                seqread-psync           660.8mb         165.2k
 >
 > But catch here I think is that host is doing the caching. In your
 > case I am assuming there is no caching at DPU and all the I/O is
 > going to remote storage (which might be doing caching in memory).
 >
 > Anyway, point I am trying to make is that even with single vq, virtiofs
 > can push a reasonable amount of I/O.
 >
 > I will be cuirous to find how multiqueue can improve these numbers
 > further.

We are currently seeing the following throughput numbers:
https://github.com/IBM/dpu-virtio-fs/blob/d0e0560546e2da86b0022a69abe02ab6ac4a6541/experiments/results/graphs/nulldev_tp.pdf
This is using a null device implementation in the DPU (immediately 
return reads and writes in the FUSE file system). All using a single vq 
and one DPU thread attending to it. On the host this experiment is using 
two fio threads pinned to the DPU's NUMA node. We see no additional 
throughput when using more than two threads.

 > I am wondering how did you conclude that single vq is the bottleneck for
 > performance and not the remote storage DPU is sending I/O to.

The single vq is not the sole bottleneck.

With us operating within the constrains in our DPU library, it leads us 
to two options:
1. Do thread pooling DPU-side to distribute the requests from the single 
queue to our eight cores.
2. Implement multi-queue.
We would like to go for the multi-queue option as it is the superior 
option with it exploiting parallelism both host and DPU-side (like in 
the block and net layers).
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
