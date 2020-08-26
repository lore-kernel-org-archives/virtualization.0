Return-Path: <SRS0=/kjp=CE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06486C433DF
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 12:27:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C222C2080C
	for <virtualization@archiver.kernel.org>; Wed, 26 Aug 2020 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVeJjHhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C222C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92AB886230;
	Wed, 26 Aug 2020 12:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2-8+SSJ3Bv6; Wed, 26 Aug 2020 12:27:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF224861D5;
	Wed, 26 Aug 2020 12:27:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED7FC016F;
	Wed, 26 Aug 2020 12:27:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07CB0C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ED745860FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJX1gr-IUn-D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0E1C9860C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598444825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rkkQI/wYXENlCW1Jvqq6bXzYIJuw8NEg9m3IFD6BwCs=;
 b=hVeJjHhLORhsrr3dhEKoGSAT1FqsOU7bQUC1/R0Dwe4W8gtL8jDAYZIR7Hag4mr/Zxe6+J
 4I4Oksl2GMqVqv6L9+dFAWoA80QilFLsV8J/XlSq4aVPEGH39vdHit0wUbYGYMfI/KWe09
 P+3q5yrCk587SrZxoqDpRnwBpfpOsLY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-Cp02ErMFPleypQmvPILk-A-1; Wed, 26 Aug 2020 08:27:04 -0400
X-MC-Unique: Cp02ErMFPleypQmvPILk-A-1
Received: by mail-wr1-f71.google.com with SMTP id p16so458911wrf.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rkkQI/wYXENlCW1Jvqq6bXzYIJuw8NEg9m3IFD6BwCs=;
 b=IBUB4stLLEDhKVKNAfkdYamN51JdJs20IPgAzD4DQGi/apDcfZ6aRfSJfOoTH4gre0
 iroYcna2/aemIaU1SeHWMb3gBzrH9a8/F8qSsxC0G9f96xPqMKiviRty3r85/1G145Jb
 c3DAL5DsyZhr5GsfrdceWwdxL4ztD84UbKMXP+FvXgImV6uByNUYd4U0J0e3PSeRr1WN
 72+GG2S360rNodsgZC4i4tfC94XkjkfoCk1O5t1nMtvpHv4iG3BN7QnzeSukwUAXCuNd
 6CiCLLxByWfiKvKPLbGtUhfuz47vkNmBQy1uyJXKLOJcLTSF0bD95kY5/2wpIHC0C+vk
 bgzQ==
X-Gm-Message-State: AOAM531zUxvlhkmTFRtsWfRPHvOYxdGf9YV0WBkYh5Sf/m9k+67VyG7R
 CsUIXUhYq5Z2KnmJMoDFaXo9j1z0TBj6PjOuRNpz/JkF+2lUZu8fKCCAhhLU47A70yEiNRGE1B1
 E7x7wNomhN9kOzcsVy9CcmnzqvJkTiqEHU6KyrE8Z1g==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16012160wru.9.1598444822741; 
 Wed, 26 Aug 2020 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0xbC9dzkRh8kdZb85jaCpn6wU2yctKY2q7jCpoCcHlZEv5/EKsYUsT9W3INNqvjYLG61L9g==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr16012138wru.9.1598444822448; 
 Wed, 26 Aug 2020 05:27:02 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id v4sm4912619wml.46.2020.08.26.05.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 05:27:01 -0700 (PDT)
Date: Wed, 26 Aug 2020 08:26:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200826082613-mutt-send-email-mst@kernel.org>
References: <20200811142821.12323-1-mwilck@suse.com>
 <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, mwilck@suse.com
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

On Tue, Aug 11, 2020 at 04:42:32PM +0200, Laurent Vivier wrote:
> On 11/08/2020 16:28, mwilck@suse.com wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
> > non-blocking read() to retrieve random data, it ends up in a tight
> > loop with poll() always returning POLLIN and read() returning EAGAIN.
> > This repeats forever until some process makes a blocking read() call.
> > The reason is that virtio_read() always returns 0 in non-blocking mode,
> > even if data is available. Worse, it fetches random data from the
> > hypervisor after every non-blocking call, without ever using this data.
> > 
> > The following test program illustrates the behavior and can be used
> > for testing and experiments. The problem will only be seen if all
> > tasks use non-blocking access; otherwise the blocking reads will
> > "recharge" the random pool and cause other, non-blocking reads to
> > succeed at least sometimes.
> > 
> > /* Whether to use non-blocking mode in a task, problem occurs if CONDITION is 1 */
> > //#define CONDITION (getpid() % 2 != 0)
> > 
> > static volatile sig_atomic_t stop;
> > static void handler(int sig __attribute__((unused))) { stop = 1; }
> > 
> > static void loop(int fd, int sec)
> > {
> > 	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
> > 	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
> > 	int size, rc, rd;
> > 
> > 	srandom(getpid());
> > 	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1)
> > 		perror("fcntl");
> > 	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);
> > 
> > 	for(;;) {
> > 		char buf[size];
> > 
> > 		if (stop)
> > 			break;
> > 		rc = poll(&pfd, 1, sec);
> > 		if (rc > 0) {
> > 			rd = read(fd, buf, sizeof(buf));
> > 			if (rd == -1 && errno == EAGAIN)
> > 				eagains++;
> > 			else if (rd == -1)
> > 				errors++;
> > 			else {
> > 				succ++;
> > 				bytes += rd;
> > 				write(1, buf, sizeof(buf));
> > 			}
> > 		} else if (rc == -1) {
> > 			if (errno != EINTR)
> > 				perror("poll");
> > 			break;
> > 		} else
> > 			fprintf(stderr, "poll: timeout\n");
> > 	}
> > 	fprintf(stderr,
> > 		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes read, %lu success, %lu eagain, %lu errors\n",
> > 		getpid(), CONDITION ? "non-" : "", size, sec, bytes, succ, eagains, errors);
> > }
> > 
> > int main(void)
> > {
> > 	int fd;
> > 
> > 	fork(); fork();
> > 	fd = open("/dev/hwrng", O_RDONLY);
> > 	if (fd == -1) {
> > 		perror("open");
> > 		return 1;
> > 	};
> > 	signal(SIGALRM, handler);
> > 	alarm(SECONDS);
> > 	loop(fd, SECONDS);
> > 	close(fd);
> > 	wait(NULL);
> > 	return 0;
> > }
> > 
> > void loop(int fd)
> > {
> >         struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
> >         int rc;
> >         unsigned int n;
> > 
> >         for (n = LOOPS; n > 0; n--) {
> >                 struct pollfd pfd = pfd0;
> >                 char buf[SIZE];
> > 
> >                 rc = poll(&pfd, 1, 1);
> >                 if (rc > 0) {
> >                         int rd = read(fd, buf, sizeof(buf));
> > 
> >                         if (rd == -1)
> >                                 perror("read");
> >                         else
> >                                 printf("read %d bytes\n", rd);
> >                 } else if (rc == -1)
> >                         perror("poll");
> >                 else
> >                         fprintf(stderr, "timeout\n");
> > 
> >         }
> > }
> > 
> > int main(void)
> > {
> >         int fd;
> > 
> >         fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
> >         if (fd == -1) {
> >                 perror("open");
> >                 return 1;
> >         };
> >         loop(fd);
> >         close(fd);
> >         return 0;
> > }
> > 
> > This can be observed in the real word e.g. with nested qemu/KVM virtual
> > machines, if both the "outer" and "inner" VMs have a virtio-rng device.
> > If the "inner" VM requests random data, qemu running in the "outer" VM
> > uses this device in a non-blocking manner like the test program above.
> > 
> > Fix it by returning available data if a previous hypervisor call has
> > completed. I tested this patch with the program above, and with rng-tools.
> > 
> > v2 -> v3: Simplified the implementation as suggested by Laurent Vivier
> > 
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> >  drivers/char/hw_random/virtio-rng.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > index a90001e02bf7..8eaeceecb41e 100644
> > --- a/drivers/char/hw_random/virtio-rng.c
> > +++ b/drivers/char/hw_random/virtio-rng.c
> > @@ -65,7 +65,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >  		register_buffer(vi, buf, size);
> >  	}
> >  
> > -	if (!wait)
> > +	if (!wait && !completion_done(&vi->have_data))
> >  		return 0;
> >  
> >  	ret = wait_for_completion_killable(&vi->have_data);
> > @@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
> >  
> >  	vi->busy = false;
> >  
> > -	return vi->data_avail;
> > +	return min_t(size_t, size, vi->data_avail);
> >  }
> >  
> >  static void virtio_cleanup(struct hwrng *rng)
> > 
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Laurent didn't we agree the real fix is private buffers in the driver,
and copying out from there?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
