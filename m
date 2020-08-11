Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA5C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 11:26:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB90D20716
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 11:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKb4/boO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB90D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 642838539A;
	Tue, 11 Aug 2020 11:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5nBZizz2OBc; Tue, 11 Aug 2020 11:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 563F085313;
	Tue, 11 Aug 2020 11:26:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 258EEC013C;
	Tue, 11 Aug 2020 11:26:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B7A1C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6193C86E68
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id snzzUMo7nJx6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:26:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8737E86CC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597145178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMyfeaWOAmGShheG4PrBuj4YCLetggwAwUSkL1meUIA=;
 b=jKb4/boOhcGP+35jk+i3ma+KqLfvwtIo+9jaTnZn1wQBs9LHhXzc8nqT69LLgifrgPlj/n
 HMgF6eidKnc/qdX5ZDnzPlbXiBSKCEk7v9XhuJNEng1uZ7l74Ga8cUbseBA4FtkYBdoPoo
 GXL3sNUNFHnv85ylnsyzdlrAPNUDQJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-9o7CH2D-OyWKMwmwOogEqQ-1; Tue, 11 Aug 2020 07:26:16 -0400
X-MC-Unique: 9o7CH2D-OyWKMwmwOogEqQ-1
Received: by mail-wm1-f72.google.com with SMTP id i15so859084wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 04:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iMyfeaWOAmGShheG4PrBuj4YCLetggwAwUSkL1meUIA=;
 b=nq6jjIHPegoeqLq5ZZ+CqgM0vIM/ZoFsNLxQMFvHvVxxLN/NQHnhadfD8z32PXJYYi
 qRSDT0YTZPiC09AtCtL7F2nLaNX5wodk3L+/jRNM6I7M3xZIxTXrNohnthH4XWStBTfp
 yzLg7gpPITZld3cjyObfTNVAFaFskBpXq0kfxuS3j5CZrXWTFMEm4HXdNaIJ9bZQg7fT
 43jfgI/mtzQRK2SJ6SyJLdDDWqO1bD6PZAqDtJ4duAoqQTNv6jAQiVC3Vqtlp5dB6t5M
 BeD4NzUK0zV2b1ZNFlt+nOOiVoR42ncvXulv48116Yslt8TKBHj569XqXQZIZvLrXs8k
 epyw==
X-Gm-Message-State: AOAM530kCpSH2rko2JNPL3vW75F1U6saHkk5SXFnfyLOmbYLydPxCOYG
 S95egHAJ3hQqKpCKasdxYWvZ+6h8vj5rRul5aZKnO4x6I2kKUqILz02NYvsloBeSUJfcb0QxuVM
 BfCI3b0jWaP9URsxNAKsrPmvjGwFTfawpPiZfwQE8lw==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr6046654wro.164.1597145174841; 
 Tue, 11 Aug 2020 04:26:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypnYkMPA7DMqq8CYhuKzDTIAa9ULJQxDDixSYC+mNmXEC6KzTA5hvyRBJb/IiWnr6gFfQg7g==
X-Received: by 2002:adf:ef08:: with SMTP id e8mr6046629wro.164.1597145174565; 
 Tue, 11 Aug 2020 04:26:14 -0700 (PDT)
Received: from redhat.com ([147.161.8.240])
 by smtp.gmail.com with ESMTPSA id l10sm25455753wru.3.2020.08.11.04.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 04:26:13 -0700 (PDT)
Date: Tue, 11 Aug 2020 07:26:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: mwilck@suse.com
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811071726-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
MIME-Version: 1.0
In-Reply-To: <20200715133255.10526-1-mwilck@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
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

On Wed, Jul 15, 2020 at 03:32:55PM +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> If a program opens /dev/hwrng with O_NONBLOCK and uses poll() and
> non-blocking read() to retrieve random data, it ends up in a tight
> loop with poll() always returning POLLIN and read() returning EAGAIN.
> This repeats forever until some process makes a blocking read() call.
> The reason is that virtio_read() always returns 0 in non-blocking mode,
> even if data is available. Worse, it fetches random data from the
> hypervisor after every non-blocking call, without ever using this data.
> 
> The following test program illustrates the behavior and can be used
> for testing and experiments. The problem will only be seen if all
> tasks use non-blocking access; otherwise the blocking reads will
> "recharge" the random pool and cause other, non-blocking reads to
> succeed at least sometimes.
> 
> /* Whether to use non-blocking mode in a task, problem occurs if CONDITION is 1 */
> //#define CONDITION (getpid() % 2 != 0)
> 
> static volatile sig_atomic_t stop;
> static void handler(int sig __attribute__((unused))) { stop = 1; }
> 
> static void loop(int fd, int sec)
> {
> 	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
> 	unsigned long errors = 0, eagains = 0, bytes = 0, succ = 0;
> 	int size, rc, rd;
> 
> 	srandom(getpid());
> 	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1)
> 		perror("fcntl");
> 	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ + 1);
> 
> 	for(;;) {
> 		char buf[size];
> 
> 		if (stop)
> 			break;
> 		rc = poll(&pfd, 1, sec);
> 		if (rc > 0) {
> 			rd = read(fd, buf, sizeof(buf));
> 			if (rd == -1 && errno == EAGAIN)
> 				eagains++;
> 			else if (rd == -1)
> 				errors++;
> 			else {
> 				succ++;
> 				bytes += rd;
> 				write(1, buf, sizeof(buf));
> 			}
> 		} else if (rc == -1) {
> 			if (errno != EINTR)
> 				perror("poll");
> 			break;
> 		} else
> 			fprintf(stderr, "poll: timeout\n");
> 	}
> 	fprintf(stderr,
> 		"pid %d %sblocking, bufsize %d, %d seconds, %lu bytes read, %lu success, %lu eagain, %lu errors\n",
> 		getpid(), CONDITION ? "non-" : "", size, sec, bytes, succ, eagains, errors);
> }
> 
> int main(void)
> {
> 	int fd;
> 
> 	fork(); fork();
> 	fd = open("/dev/hwrng", O_RDONLY);
> 	if (fd == -1) {
> 		perror("open");
> 		return 1;
> 	};
> 	signal(SIGALRM, handler);
> 	alarm(SECONDS);
> 	loop(fd, SECONDS);
> 	close(fd);
> 	wait(NULL);
> 	return 0;
> }
> 
> void loop(int fd)
> {
>         struct pollfd pfd0 = { .fd = fd, .events  = POLLIN, };
>         int rc;
>         unsigned int n;
> 
>         for (n = LOOPS; n > 0; n--) {
>                 struct pollfd pfd = pfd0;
>                 char buf[SIZE];
> 
>                 rc = poll(&pfd, 1, 1);
>                 if (rc > 0) {
>                         int rd = read(fd, buf, sizeof(buf));
> 
>                         if (rd == -1)
>                                 perror("read");
>                         else
>                                 printf("read %d bytes\n", rd);
>                 } else if (rc == -1)
>                         perror("poll");
>                 else
>                         fprintf(stderr, "timeout\n");
> 
>         }
> }
> 
> int main(void)
> {
>         int fd;
> 
>         fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
>         if (fd == -1) {
>                 perror("open");
>                 return 1;
>         };
>         loop(fd);
>         close(fd);
>         return 0;
> }
> 
> This can be observed in the real word e.g. with nested qemu/KVM virtual
> machines, if both the "outer" and "inner" VMs have a virtio-rng device.
> If the "inner" VM requests random data, qemu running in the "outer" VM
> uses this device in a non-blocking manner like the test program above.
> 
> Fix it by returning available data if a previous hypervisor call has
> completed in the meantime. I tested the patch with the program above,
> and with rng-tools.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  drivers/char/hw_random/virtio-rng.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 79a6e47b5fbc..984713b35892 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -59,6 +59,20 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
>  	if (vi->hwrng_removed)
>  		return -ENODEV;
>  
> +	/*
> +	 * If the previous call was non-blocking, we may have got some
> +	 * randomness already.
> +	 */
> +	if (vi->busy && completion_done(&vi->have_data)) {
> +		unsigned int len;
> +
> +		vi->busy = false;
> +		len = vi->data_avail > size ? size : vi->data_avail;
> +		vi->data_avail -= len;

I wonder what purpose does this line serve: busy is false
which basically means data_avail is invalid, right?
A following non blocking call will not enter here.

> +		if (len)
> +			return len;
> +	}
> +
>  	if (!vi->busy) {
>  		vi->busy = true;
>  		reinit_completion(&vi->have_data);

> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
