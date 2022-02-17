Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD035C433FE
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 09:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 713C260B12;
	Thu, 17 Feb 2022 09:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BqNgGqtJZCQL; Thu, 17 Feb 2022 09:48:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EB1F6F67C;
	Thu, 17 Feb 2022 09:48:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7A58C0021;
	Thu, 17 Feb 2022 09:48:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94DEEC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:48:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DBEE6F67C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CaT35yTW5e9z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:48:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B5FC60B12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645091313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xxe0ytJzju6g3/HrW8yGRlI4FlDzlNM0zVQgVVP7siY=;
 b=RUVJ8gdJBhQaCnljiuQ/LSMakYNPCtumP8+h61GQu5fK8Box1JauqieW6qRqa7gnitrk2j
 X5HFPXA767ku377kYQYU73GpIAU/SUkW79uuV3ma0KYzUNipAFXD0WHu85ORFK6/vgI2/p
 CBDRoYXCEonR2bvcmhOf6tIzl7gOy9A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Vg_596YbMpmOXKJUC4mN_g-1; Thu, 17 Feb 2022 04:48:27 -0500
X-MC-Unique: Vg_596YbMpmOXKJUC4mN_g-1
Received: by mail-qv1-f71.google.com with SMTP id
 eu2-20020ad44f42000000b0042bfcac4a52so4669060qvb.16
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 01:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xxe0ytJzju6g3/HrW8yGRlI4FlDzlNM0zVQgVVP7siY=;
 b=B+9v0Z9Ih8l2TbhDgFFEQgf0O1GMVcz7XH56US14kKaC25iuT08f0q6R9/B8wStayY
 4f4vqCW4682sXm9PhM+3X/KYw6jPTZFivcYT6I79M+oQSPLMVszO8ZAk4mGAePUchj6Y
 OC1bvGjhCdzYCuRXJgjSDA7jjST9RPvps4SlR2riiKg0+4Kf+Xk2zyy40+dPZkqOX3hd
 Mppf9dU759j0W7q+4uFlL0iBn7G862lu5/xaB+y6n53dBLSpiwn9PhNRenV4DgaHY4k4
 J+AUeEpDIJnSxjKCO0+MSU78/TUd27QGjKc5AzzGvG8bmRZ131tX5SJf7NjmUg7H95ao
 1biA==
X-Gm-Message-State: AOAM533Adej/D7Z5/5gXVq1aioO/qFcbu96ZhqJPccVZ+E4KwxIYv8Zp
 Qs0vn62gj0bV7+1FHAsgMIW9rJ91U/8SaqVcgoQl/0nIP+gdZTEepvKI9cVI7H+u0S1BRa9LwQv
 zH03+EfsyP2iyaga17EKEtf4LbAujl52FMutuv1v+1w==
X-Received: by 2002:ac8:57cc:0:b0:2cf:51a9:df93 with SMTP id
 w12-20020ac857cc000000b002cf51a9df93mr1616154qta.166.1645091307079; 
 Thu, 17 Feb 2022 01:48:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJx9ng4NIvyX79q9z7uy2yyP8m7uhEbaPwsePA5VEK9FDTJGfyzyq+NNAAp3Ge6dJX82YMmw==
X-Received: by 2002:ac8:57cc:0:b0:2cf:51a9:df93 with SMTP id
 w12-20020ac857cc000000b002cf51a9df93mr1616146qta.166.1645091306827; 
 Thu, 17 Feb 2022 01:48:26 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id k4sm22499788qta.6.2022.02.17.01.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 01:48:26 -0800 (PST)
Date: Thu, 17 Feb 2022 10:48:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [syzbot] WARNING in vhost_dev_cleanup (2)
Message-ID: <CAGxU2F7CjNu5Wxg3k1hQF8A8uRt-wKLjMW6TMjb+UVCF+MHZbw@mail.gmail.com>
References: <0000000000006f656005d82d24e2@google.com>
 <CACGkMEsyWBBmx3g613tr97nidHd3-avMyO=WRxS8RpcEk7j2=A@mail.gmail.com>
 <20220217023550-mutt-send-email-mst@kernel.org>
 <CACGkMEtuL_4eRYYWd4aQj6rG=cJDQjjr86DWpid3o_N-6xvTWQ@mail.gmail.com>
 <20220217024359-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220217024359-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: syzbot <syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com>,
 kvm <kvm@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 syzkaller-bugs@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
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


On Thu, Feb 17, 2022 at 8:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 17, 2022 at 03:39:48PM +0800, Jason Wang wrote:
> > On Thu, Feb 17, 2022 at 3:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Feb 17, 2022 at 03:34:13PM +0800, Jason Wang wrote:
> > > > On Thu, Feb 17, 2022 at 10:01 AM syzbot
> > > > <syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.org..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=132e687c700000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=1e3ea63db39f2b4440e0
> > > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
> > > > >
> > > > > WARNING: CPU: 1 PID: 10828 at drivers/vhost/vhost.c:715 vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
> > > > > Modules linked in:
> > > > > CPU: 0 PID: 10828 Comm: syz-executor.0 Not tainted 5.17.0-rc4-syzkaller-00051-gc5d9ae265b10 #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > > > RIP: 0010:vhost_dev_cleanup+0x8b8/0xbc0 drivers/vhost/vhost.c:715
> > > >
> > > > Probably a hint that we are missing a flush.
> > > >
> > > > Looking at vhost_vsock_stop() that is called by vhost_vsock_dev_release():
> > > >
> > > > static int vhost_vsock_stop(struct vhost_vsock *vsock)
> > > > {
> > > > size_t i;
> > > >         int ret;
> > > >
> > > >         mutex_lock(&vsock->dev.mutex);
> > > >
> > > >         ret = vhost_dev_check_owner(&vsock->dev);
> > > >         if (ret)
> > > >                 goto err;
> > > >
> > > > Where it could fail so the device is not actually stopped.
> > > >
> > > > I wonder if this is something related.
> > > >
> > > > Thanks
> > >
> > >
> > > But then if that is not the owner then no work should be running, right?
> >
> > Could it be a buggy user space that passes the fd to another process
> > and changes the owner just before the mutex_lock() above?
> >
> > Thanks
>
> Maybe, but can you be a bit more explicit? what is the set of
> conditions you see that can lead to this?

I think the issue could be in the vhost_vsock_stop() as Jason mentioned, 
but not related to fd passing, but related to the do_exit() function.

Looking the stack trace, we are in exit_task_work(), that is called 
after exit_mm(), so the vhost_dev_check_owner() can fail because 
current->mm should be NULL at that point.

It seems the fput work is queued by fput_many() in a worker queue, and 
in some cases (maybe a lot of files opened?) the work is still queued 
when we enter in do_exit().

That said, I don't know if we can simply remove that check in 
vhost_vsock_stop(), or check if current->mm is NULL, to understand if 
the process is exiting.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
