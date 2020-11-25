Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C67C5519F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:39:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E9D206B5
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8LfA6fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E9D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2A6EA203F3;
	Wed, 25 Nov 2020 09:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KKP0dNNbTBHo; Wed, 25 Nov 2020 09:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1B28827400;
	Wed, 25 Nov 2020 09:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01E3DC163C;
	Wed, 25 Nov 2020 09:39:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEC8EC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 95B9987434
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sD1aF2q2fgE1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:39:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EE8C587433
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606297171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vLAe9WsMJa4w6mGB+nZbn05U5f9ZhXoUHhlb18I67WM=;
 b=N8LfA6fJUsnckPhWmlbKQQx1u9wjEdivRybRwkNQJtLInXUpN8olFOMDaND8bBVoh8TzCW
 Zis1CNex0n5wtqnUqniopC1Epo5zY1u9xwuR9zucRYLwhmQZ3Zpv0UcXO0EfI5ChHgWWOV
 TacjUh43LtK4X8T+ucmfPOLpzwivsWk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-HhYJSPLOPsSTXhfzDEf0Rw-1; Wed, 25 Nov 2020 04:39:28 -0500
X-MC-Unique: HhYJSPLOPsSTXhfzDEf0Rw-1
Received: by mail-wr1-f69.google.com with SMTP id l5so561426wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 01:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vLAe9WsMJa4w6mGB+nZbn05U5f9ZhXoUHhlb18I67WM=;
 b=Ndky3uA59EgnHPYjz4KTeDBKrJnfJeBYbH5LPwcR6EYgRgirWGI51mp/2DlYIdGYdc
 xQrZw1CwgeixkAoS4qQUupFfeRkfqM1frJAzktwEYX1mJn1wUxuFzG6QyjJ57AZvFqCR
 vLvuKiNCicME4XFPAcI+WRUVgqXMn92k1IT46lyFL3tnOT05P0UiO3Mwu9TQX8q0zj77
 0hG7ZB2oKq+YHQMN2ju9WYk+ieKbPkXg0eVGmTyhNZemFuXrTddk/YjpoPQfv8sY6EU2
 xjBx/HA3jmSUp280IydjdVTvtk+LWwgjxl9iKiONdL6LT4LEOCMGcAlNUBLpI0gMJ4sc
 SjXQ==
X-Gm-Message-State: AOAM533LX29IGghoug6LfajuRS0cyukkUMIUjEJ3JkMrJIrXx5cAUypf
 rEVPzjbl5JXCPJIJRFPlxxS4gGdqH8l5+qJfCVy0nDOws2HKboVXkvVnqzKemLzQDu6a04xCaM+
 vM8PAswCy6om6AASzGfIGf0ckreBreN/FJgowWH60Pg==
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr3091884wrx.344.1606297167323; 
 Wed, 25 Nov 2020 01:39:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvXC32/ddlvJ4NJFERmkr2++TuEfCzuPoAuQSQtQVzeuZ3OA+94pX0QNprI5nIOlJQnFOknw==
X-Received: by 2002:a05:6000:10d2:: with SMTP id
 b18mr3091860wrx.344.1606297167062; 
 Wed, 25 Nov 2020 01:39:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id c17sm4088789wro.19.2020.11.25.01.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 01:39:26 -0800 (PST)
Date: Wed, 25 Nov 2020 04:39:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v3] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20201125043726-mutt-send-email-mst@kernel.org>
References: <20200811142821.12323-1-mwilck@suse.com>
 <4ae4f348-c186-f7e4-f7e3-b1f1e4a4b408@redhat.com>
 <20200826082613-mutt-send-email-mst@kernel.org>
 <519e0296a7d61d5e9e8d258a855eb42a57c641c5.camel@suse.com>
 <a5d4bcd3-e468-e818-3bd2-3a1b0fa172d8@redhat.com>
 <20200908101413-mutt-send-email-mst@kernel.org>
 <0a5fcbc9bb6eef521c627035687de4654a1dd740.camel@suse.com>
MIME-Version: 1.0
In-Reply-To: <0a5fcbc9bb6eef521c627035687de4654a1dd740.camel@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
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

On Tue, Sep 08, 2020 at 05:33:40PM +0200, Martin Wilck wrote:
> On Tue, 2020-09-08 at 10:14 -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 31, 2020 at 02:37:26PM +0200, Laurent Vivier wrote:
> > > On 28/08/2020 23:34, Martin Wilck wrote:
> > > > On Wed, 2020-08-26 at 08:26 -0400, Michael S. Tsirkin wrote:
> > > > > On Tue, Aug 11, 2020 at 04:42:32PM +0200, Laurent Vivier wrote:
> > > > > > On 11/08/2020 16:28, mwilck@suse.com wrote:
> > > > > > > From: Martin Wilck <mwilck@suse.com>
> > > > > > > 
> > > > > > > If a program opens /dev/hwrng with O_NONBLOCK and uses
> > > > > > > poll() and
> > > > > > > non-blocking read() to retrieve random data, it ends up in
> > > > > > > a
> > > > > > > tight
> > > > > > > loop with poll() always returning POLLIN and read()
> > > > > > > returning
> > > > > > > EAGAIN.
> > > > > > > This repeats forever until some process makes a blocking
> > > > > > > read()
> > > > > > > call.
> > > > > > > The reason is that virtio_read() always returns 0 in non-
> > > > > > > blocking 
> > > > > > > mode,
> > > > > > > even if data is available. Worse, it fetches random data
> > > > > > > from the
> > > > > > > hypervisor after every non-blocking call, without ever
> > > > > > > using this
> > > > > > > data.
> > > > > > > 
> > > > > > > The following test program illustrates the behavior and can
> > > > > > > be
> > > > > > > used
> > > > > > > for testing and experiments. The problem will only be seen
> > > > > > > if all
> > > > > > > tasks use non-blocking access; otherwise the blocking reads
> > > > > > > will
> > > > > > > "recharge" the random pool and cause other, non-blocking
> > > > > > > reads to
> > > > > > > succeed at least sometimes.
> > > > > > > 
> > > > > > > /* Whether to use non-blocking mode in a task, problem
> > > > > > > occurs if
> > > > > > > CONDITION is 1 */
> > > > > > > //#define CONDITION (getpid() % 2 != 0)
> > > > > > > 
> > > > > > > static volatile sig_atomic_t stop;
> > > > > > > static void handler(int sig __attribute__((unused))) { stop
> > > > > > > = 1;
> > > > > > > }
> > > > > > > 
> > > > > > > static void loop(int fd, int sec)
> > > > > > > {
> > > > > > > 	struct pollfd pfd = { .fd = fd, .events  = POLLIN, };
> > > > > > > 	unsigned long errors = 0, eagains = 0, bytes = 0, succ
> > > > > > > = 0;
> > > > > > > 	int size, rc, rd;
> > > > > > > 
> > > > > > > 	srandom(getpid());
> > > > > > > 	if (CONDITION && fcntl(fd, F_SETFL, fcntl(fd, F_GETFL)
> > > > > > > |
> > > > > > > O_NONBLOCK) == -1)
> > > > > > > 		perror("fcntl");
> > > > > > > 	size = MINBUFSIZ + random() % (MAXBUFSIZ - MINBUFSIZ +
> > > > > > > 1);
> > > > > > > 
> > > > > > > 	for(;;) {
> > > > > > > 		char buf[size];
> > > > > > > 
> > > > > > > 		if (stop)
> > > > > > > 			break;
> > > > > > > 		rc = poll(&pfd, 1, sec);
> > > > > > > 		if (rc > 0) {
> > > > > > > 			rd = read(fd, buf, sizeof(buf));
> > > > > > > 			if (rd == -1 && errno == EAGAIN)
> > > > > > > 				eagains++;
> > > > > > > 			else if (rd == -1)
> > > > > > > 				errors++;
> > > > > > > 			else {
> > > > > > > 				succ++;
> > > > > > > 				bytes += rd;
> > > > > > > 				write(1, buf, sizeof(buf));
> > > > > > > 			}
> > > > > > > 		} else if (rc == -1) {
> > > > > > > 			if (errno != EINTR)
> > > > > > > 				perror("poll");
> > > > > > > 			break;
> > > > > > > 		} else
> > > > > > > 			fprintf(stderr, "poll: timeout\n");
> > > > > > > 	}
> > > > > > > 	fprintf(stderr,
> > > > > > > 		"pid %d %sblocking, bufsize %d, %d seconds, %lu
> > > > > > > bytes
> > > > > > > read, %lu success, %lu eagain, %lu errors\n",
> > > > > > > 		getpid(), CONDITION ? "non-" : "", size, sec,
> > > > > > > bytes,
> > > > > > > succ, eagains, errors);
> > > > > > > }
> > > > > > > 
> > > > > > > int main(void)
> > > > > > > {
> > > > > > > 	int fd;
> > > > > > > 
> > > > > > > 	fork(); fork();
> > > > > > > 	fd = open("/dev/hwrng", O_RDONLY);
> > > > > > > 	if (fd == -1) {
> > > > > > > 		perror("open");
> > > > > > > 		return 1;
> > > > > > > 	};
> > > > > > > 	signal(SIGALRM, handler);
> > > > > > > 	alarm(SECONDS);
> > > > > > > 	loop(fd, SECONDS);
> > > > > > > 	close(fd);
> > > > > > > 	wait(NULL);
> > > > > > > 	return 0;
> > > > > > > }
> > > > > > > 
> > > > > > > void loop(int fd)
> > > > > > > {
> > > > > > >         struct pollfd pfd0 = { .fd = fd, .events  = POLLIN,
> > > > > > > };
> > > > > > >         int rc;
> > > > > > >         unsigned int n;
> > > > > > > 
> > > > > > >         for (n = LOOPS; n > 0; n--) {
> > > > > > >                 struct pollfd pfd = pfd0;
> > > > > > >                 char buf[SIZE];
> > > > > > > 
> > > > > > >                 rc = poll(&pfd, 1, 1);
> > > > > > >                 if (rc > 0) {
> > > > > > >                         int rd = read(fd, buf,
> > > > > > > sizeof(buf));
> > > > > > > 
> > > > > > >                         if (rd == -1)
> > > > > > >                                 perror("read");
> > > > > > >                         else
> > > > > > >                                 printf("read %d bytes\n",
> > > > > > > rd);
> > > > > > >                 } else if (rc == -1)
> > > > > > >                         perror("poll");
> > > > > > >                 else
> > > > > > >                         fprintf(stderr, "timeout\n");
> > > > > > > 
> > > > > > >         }
> > > > > > > }
> > > > > > > 
> > > > > > > int main(void)
> > > > > > > {
> > > > > > >         int fd;
> > > > > > > 
> > > > > > >         fd = open("/dev/hwrng", O_RDONLY|O_NONBLOCK);
> > > > > > >         if (fd == -1) {
> > > > > > >                 perror("open");
> > > > > > >                 return 1;
> > > > > > >         };
> > > > > > >         loop(fd);
> > > > > > >         close(fd);
> > > > > > >         return 0;
> > > > > > > }
> > > > > > > 
> > > > > > > This can be observed in the real word e.g. with nested
> > > > > > > qemu/KVM
> > > > > > > virtual
> > > > > > > machines, if both the "outer" and "inner" VMs have a
> > > > > > > virtio-rng
> > > > > > > device.
> > > > > > > If the "inner" VM requests random data, qemu running in the
> > > > > > > "outer" VM
> > > > > > > uses this device in a non-blocking manner like the test
> > > > > > > program
> > > > > > > above.
> > > > > > > 
> > > > > > > Fix it by returning available data if a previous hypervisor
> > > > > > > call
> > > > > > > has
> > > > > > > completed. I tested this patch with the program above, and
> > > > > > > with
> > > > > > > rng-tools.
> > > > > > > 
> > > > > > > v2 -> v3: Simplified the implementation as suggested by
> > > > > > > Laurent
> > > > > > > Vivier
> > > > > > > 
> > > > > > > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > > > > > > ---
> > > > > > >  drivers/char/hw_random/virtio-rng.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/char/hw_random/virtio-rng.c
> > > > > > > b/drivers/char/hw_random/virtio-rng.c
> > > > > > > index a90001e02bf7..8eaeceecb41e 100644
> > > > > > > --- a/drivers/char/hw_random/virtio-rng.c
> > > > > > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > > > > > @@ -65,7 +65,7 @@ static int virtio_read(struct hwrng *rng,
> > > > > > > void
> > > > > > > *buf, size_t size, bool wait)
> > > > > > >  		register_buffer(vi, buf, size);
> > > > > > >  	}
> > > > > > >  
> > > > > > > -	if (!wait)
> > > > > > > +	if (!wait && !completion_done(&vi->have_data))
> > > > > > >  		return 0;
> > > > > > >  
> > > > > > >  	ret = wait_for_completion_killable(&vi->have_data);
> > > > > > > @@ -74,7 +74,7 @@ static int virtio_read(struct hwrng *rng,
> > > > > > > void
> > > > > > > *buf, size_t size, bool wait)
> > > > > > >  
> > > > > > >  	vi->busy = false;
> > > > > > >  
> > > > > > > -	return vi->data_avail;
> > > > > > > +	return min_t(size_t, size, vi->data_avail);
> > > > > > >  }
> > > > > > >  
> > > > > > >  static void virtio_cleanup(struct hwrng *rng)
> > > > > > > 
> > > > > > 
> > > > > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > > > > 
> > > > > Laurent didn't we agree the real fix is private buffers in the
> > > > > driver,
> > > > > and copying out from there?
> > > > > 
> > > > 
> > > > Can we perhaps proceed with this for now? AFAICS the private
> > > > buffer
> > > > implementation would be a larger effort, while we have the issues
> > > > with
> > > > nested VMs getting no entropy today.
> > > > 
> > > 
> > > I agree. I think it's important to have a simple and quick fix for
> > > the
> > > problem reported by Martin.
> > > 
> > > We need the private buffers but not sure how long it will take to
> > > have
> > > them included in the kernel and how many new bugs will be
> > > introduced
> > > doing that as the code is hard to understand and the core is shared
> > > with
> > > several other hardware backends that can be impacted by the changes
> > > needed.
> > > 
> > > Thanks,
> > > Laurent
> > 
> > However I am not sure with the patch applies we never return
> > the same buffer to userspace twice, e.g. if one is
> > non blocking another blocking. Doing that would be a bug.
> > 
> 
> As Laurent mentioned in 
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02039.html,
> there are only 2 different buffers that may be passed to virtio_read(),
> rng_buffer and rng_fillbuf.
> The latter is only used in blocking mode.
> 
> AFAICS there's just one problematic situation: 
> 
>  1 a user space process reads random data without blocking and runs
> register_buffer(), gets no data, releases reading_mutex
>  2 the hwrng kthread grabs the mutex and makes a sync call, vi->busy is
> still set, so no new completion is initialized.
>  3 hwrng calls wait_for_completion_killable() and sees the completion
>    that had been initialized by the user space process previously,
>  4 hwrng "thinks" it got some positive randomness, but random data have
>    actually been written into rng_buffer, not rng_fillbuff.
> 
> This is indeed bad, but it can happen with the current code as well.
> Actually, it's more likely to happen with the current code, because
> asynchronous callers might hang forever trying to get entropy,
> making this scenario more likely (if there's a process, like nested
> qemu, that would keep calling . So this wouldn't be a regression caused
> by my patch, AFAICT.
> 
> How can we avoid this problem entirely? A) With private buffers, of
> course. B) Another, a bit hackish, approach would be to remember the
> active "buffer" pointer in virtio_rng, and restart the IO when a
> another buffer is passed down. C) Finally, we could modify
> virtio_read() such that blocking calls always re-initialize the buffer;
> they'd then have to wait for a potential already running IO from a
> previous, non-blocking access to finish first.
> 
> But I believe this is something which could (and should) be done
> independently. Alternatively, I could add B) or C). A) I'd rather leave
> to Laurent.
> 
> Regards,
> Martin

Of the simple solutions, C seems cleanest.
Laurent, any interest in working on A meanwhile?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
