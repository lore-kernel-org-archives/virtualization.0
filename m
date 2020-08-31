Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2329C433E7
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 12:37:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC2C2087D
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 12:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYeLqWwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC2C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD1BE85B5B;
	Mon, 31 Aug 2020 12:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2puAMnjF45AT; Mon, 31 Aug 2020 12:37:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DC39A85B4D;
	Mon, 31 Aug 2020 12:37:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA763C07FF;
	Mon, 31 Aug 2020 12:37:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7631C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 12:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B516B86F85
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 12:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CD1pqixSnKhk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 12:37:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B97885CE3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598877454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4ywBxzubw03QbPXuE6QhtIOCyLsUlt1tcti+tYeiBak=;
 b=GYeLqWwov9IRPaFjep7fZ8e/vWYJsHdqKTuy44FLglHuU5qDY/XLyVxG5TqiXFk/eYUice
 9XX3CyagVHLUfJwNeOlgva3j0OzyfCXj6k4gVcW5zV6xDYB+jbWJzGlXcob++3ilyWDCSc
 nyGows9FMJa1I6Z0x0zlOzRFfVBPWZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-3Gt23T5OPtqmFaRzGnwD0A-1; Mon, 31 Aug 2020 08:37:33 -0400
X-MC-Unique: 3Gt23T5OPtqmFaRzGnwD0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE73D18A2242;
 Mon, 31 Aug 2020 12:37:31 +0000 (UTC)
Received: from [10.36.113.34] (ovpn-113-34.ams2.redhat.com [10.36.113.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A39A5C1BB;
 Mon, 31 Aug 2020 12:37:26 +0000 (UTC)
Subject: Re: [PATCH v3] virtio-rng: return available data with O_NONBLOCK
To: Martin Wilck <mwilck@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20200811142821.12323-1-mwilck@suse.com>
 <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
 <20200826082613-mutt-send-email-mst@kernel.org>
 <519e0296a7d61d5e9e8d258a855eb42a57c641c5.camel@suse.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <a5d4bcd3-e468-e818-3bd2-3a1b0fa172d8@redhat.com>
Date: Mon, 31 Aug 2020 14:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <519e0296a7d61d5e9e8d258a855eb42a57c641c5.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Amit Shah <amit@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 28/08/2020 23:34, Martin Wilck wrote:
> On Wed, 2020-08-26 at 08:26 -0400, Michael S. Tsirkin wrote:
>> On Tue, Aug 11, 2020 at 04:42:32PM +0200, Laurent Vivier wrote:
>>> On 11/08/2020 16:28, mwilck@suse.com wrote:
>>>> From: Martin Wilck <mwilck@suse.com>
>>>>
>>>> If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
>>>> non-blocking read() to retrieve random data, it ends up in a
>>>> tight
>>>> loop with poll() always returning POLLIN and read() returning
>>>> EAGAIN.
>>>> This repeats forever until some process makes a blocking read()
>>>> call.
>>>> The reason is that virtio_read() always returns 0 in non-blocking 
>>>> mode,
>>>> even if data is available. Worse, it fetches random data from the
>>>> hypervisor after every non-blocking call, without ever using this
>>>> data.
>>>>
>>>> The following test program illustrates the behavior and can be
>>>> used
>>>> for testing and experiments. The problem will only be seen if all
>>>> tasks use non-blocking access; otherwise the blocking reads will
>>>> "recharge" the random pool and cause other, non-blocking reads to
>>>> succeed at least sometimes.
>>>>
>>>> /* Whether to use non-blocking mode in a task, problem occurs if
>>>> CONDITION is 1 */
>>>> //#define CONDITION (getpid() % 2 != 0)
>>>>
>>>> static volatile sig_atomic_t stop;
>>>> static void handler(int sig __attribute__((unused))) { stop = 1;
>>>> }
>>>>
>>>> static void loop(int fd, int sec)
>>>> {
>>>> 	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
>>>> 	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
>>>> 	int size, rc, rd;
>>>>
>>>> 	srandom(getpid());
>>>> 	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) |
>>>> O_NONBLOCK) == -1)
>>>> 		perror("fcntl");
>>>> 	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);
>>>>
>>>> 	for(;;) {
>>>> 		char buf[size];
>>>>
>>>> 		if (stop)
>>>> 			break;
>>>> 		rc = poll(&pfd, 1, sec);
>>>> 		if (rc > 0) {
>>>> 			rd = read(fd, buf, sizeof(buf));
>>>> 			if (rd == -1 && errno == EAGAIN)
>>>> 				eagains++;
>>>> 			else if (rd == -1)
>>>> 				errors++;
>>>> 			else {
>>>> 				succ++;
>>>> 				bytes += rd;
>>>> 				write(1, buf, sizeof(buf));
>>>> 			}
>>>> 		} else if (rc == -1) {
>>>> 			if (errno != EINTR)
>>>> 				perror("poll");
>>>> 			break;
>>>> 		} else
>>>> 			fprintf(stderr, "poll: timeout\n");
>>>> 	}
>>>> 	fprintf(stderr,
>>>> 		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes
>>>> read, %lu success, %lu eagain, %lu errors\n",
>>>> 		getpid(), CONDITION ? "non-" : "", size, sec, bytes,
>>>> succ, eagains, errors);
>>>> }
>>>>
>>>> int main(void)
>>>> {
>>>> 	int fd;
>>>>
>>>> 	fork(); fork();
>>>> 	fd = open("/dev/hwrng", O_RDONLY);
>>>> 	if (fd == -1) {
>>>> 		perror("open");
>>>> 		return 1;
>>>> 	};
>>>> 	signal(SIGALRM, handler);
>>>> 	alarm(SECONDS);
>>>> 	loop(fd, SECONDS);
>>>> 	close(fd);
>>>> 	wait(NULL);
>>>> 	return 0;
>>>> }
>>>>
>>>> void loop(int fd)
>>>> {
>>>>         struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
>>>>         int rc;
>>>>         unsigned int n;
>>>>
>>>>         for (n = LOOPS; n > 0; n--) {
>>>>                 struct pollfd pfd = pfd0;
>>>>                 char buf[SIZE];
>>>>
>>>>                 rc = poll(&pfd, 1, 1);
>>>>                 if (rc > 0) {
>>>>                         int rd = read(fd, buf, sizeof(buf));
>>>>
>>>>                         if (rd == -1)
>>>>                                 perror("read");
>>>>                         else
>>>>                                 printf("read %d bytes\n", rd);
>>>>                 } else if (rc == -1)
>>>>                         perror("poll");
>>>>                 else
>>>>                         fprintf(stderr, "timeout\n");
>>>>
>>>>         }
>>>> }
>>>>
>>>> int main(void)
>>>> {
>>>>         int fd;
>>>>
>>>>         fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
>>>>         if (fd == -1) {
>>>>                 perror("open");
>>>>                 return 1;
>>>>         };
>>>>         loop(fd);
>>>>         close(fd);
>>>>         return 0;
>>>> }
>>>>
>>>> This can be observed in the real word e.g. with nested qemu/KVM
>>>> virtual
>>>> machines, if both the "outer" and "inner" VMs have a virtio-rng
>>>> device.
>>>> If the "inner" VM requests random data, qemu running in the
>>>> "outer" VM
>>>> uses this device in a non-blocking manner like the test program
>>>> above.
>>>>
>>>> Fix it by returning available data if a previous hypervisor call
>>>> has
>>>> completed. I tested this patch with the program above, and with
>>>> rng-tools.
>>>>
>>>> v2 -> v3: Simplified the implementation as suggested by Laurent
>>>> Vivier
>>>>
>>>> Signed-off-by: Martin Wilck <mwilck@suse.com>
>>>> ---
>>>>  drivers/char/hw_random/virtio-rng.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/char/hw_random/virtio-rng.c
>>>> b/drivers/char/hw_random/virtio-rng.c
>>>> index a90001e02bf7..8eaeceecb41e 100644
>>>> --- a/drivers/char/hw_random/virtio-rng.c
>>>> +++ b/drivers/char/hw_random/virtio-rng.c
>>>> @@ -65,7 +65,7 @@ static int virtio_read(struct hwrng *rng, void
>>>> *buf, size_t size, bool wait)
>>>>  		register_buffer(vi, buf, size);
>>>>  	}
>>>>  
>>>> -	if (!wait)
>>>> +	if (!wait && !completion_done(&vi->have_data))
>>>>  		return 0;
>>>>  
>>>>  	ret = wait_for_completion_killable(&vi->have_data);
>>>> @@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng, void
>>>> *buf, size_t size, bool wait)
>>>>  
>>>>  	vi->busy = false;
>>>>  
>>>> -	return vi->data_avail;
>>>> +	return min_t(size_t, size, vi->data_avail);
>>>>  }
>>>>  
>>>>  static void virtio_cleanup(struct hwrng *rng)
>>>>
>>>
>>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>>
>> Laurent didn't we agree the real fix is private buffers in the
>> driver,
>> and copying out from there?
>>
> 
> Can we perhaps proceed with this for now? AFAICS the private buffer
> implementation would be a larger effort, while we have the issues with
> nested VMs getting no entropy today.
> 

I agree. I think it's important to have a simple and quick fix for the
problem reported by Martin.

We need the private buffers but not sure how long it will take to have
them included in the kernel and how many new bugs will be introduced
doing that as the code is hard to understand and the core is shared with
several other hardware backends that can be impacted by the changes needed.

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
