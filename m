Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999FBC433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 12:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11820417CF;
	Wed,  8 Jun 2022 12:44:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQZdi3G4T0so; Wed,  8 Jun 2022 12:44:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BE7B417A6;
	Wed,  8 Jun 2022 12:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07FABC0039;
	Wed,  8 Jun 2022 12:44:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71FCFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BA8982AB9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y5n3RaSKndmv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C08F82AA7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654692285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gDZKJAkFIiucFog1TOTZeqqoQwvori+AWAJxkaK2Pk=;
 b=MIrcRhvsV7OTBuMv72gEr2hVA9BS84b5qr93U/P9k9QSdqOn2lWTCUproSwk5cqva4Nj6+
 vW7YIyRI2AOB7nYSgus0IKeMhvqrGZBVT6hi/av2Jek0RxjUGe5921B3ICNecPFJ2TkgUk
 bIv4TZQMQpRYmFX7WVHZpoJljzWfgBs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-fvBPobWRMhiQfFGJUMr1Bg-1; Wed, 08 Jun 2022 08:44:40 -0400
X-MC-Unique: fvBPobWRMhiQfFGJUMr1Bg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FB7C2999B56;
 Wed,  8 Jun 2022 12:44:40 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.9.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B75852026D64;
 Wed,  8 Jun 2022 12:44:39 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 76575220882; Wed,  8 Jun 2022 08:44:39 -0400 (EDT)
Date: Wed, 8 Jun 2022 08:44:39 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
Message-ID: <YqCZt7tyEH50ktKq@redhat.com>
References: <20220607110504.198-1-xieyongji@bytedance.com>
 <Yp+oEPGnisNx+Nzo@redhat.com>
 <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: linux-fsdevel@vger.kernel.org,
 =?utf-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
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

On Wed, Jun 08, 2022 at 04:42:46PM +0800, Yongji Xie wrote:
> On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > > interface and forced unmount") tries to remove the control
> > > interface for virtio-fs since it does not support aborting
> > > requests which are being processed. But it doesn't work now.
> >
> > Aha.., so "no_control" basically has no effect? I was looking at
> > the code and did not find anybody using "no_control" and I was
> > wondering who is making use of "no_control" variable.
> >
> > I mounted virtiofs and noticed a directory named "40" showed up
> > under /sys/fs/fuse/connections/. That must be belonging to
> > virtiofs instance, I am assuming.
> >
> 
> I think so.
> 
> > BTW, if there are multiple fuse connections, how will one figure
> > out which directory belongs to which instance. Because without knowing
> > that, one will be shooting in dark while trying to read/write any
> > of the control files.
> >
> 
> We can use "stat $mountpoint" to get the device minor ID which is the
> name of the corresponding control directory.
> 
> > So I think a separate patch should be sent which just gets rid of
> > "no_control" saying nobody uses. it.
> >
> 
> OK.
> 
> > >
> > > This commit fixes the bug, but only remove the abort interface
> > > instead since other interfaces should be useful.
> >
> > Hmm.., so writing to "abort" file is bad as it ultimately does.
> >
> > fc->connected = 0;
> >
> 
> Another problem is that it might trigger UAF since
> virtio_fs_request_complete() doesn't know the requests are aborted.
> 
> > So getting rid of this file till we support aborting the pending
> > requests properly, makes sense.
> >
> > I think this probably should be a separate patch which explains
> > why adding "no_abort_control" is a good idea.
> >
> 
> OK.

BTW, which particular knob you are finding useful in control filesystem
for virtiofs. As you mentioned "abort" we will not implement. "waiting"
might not have much significance as well because requests are handed
over to virtiofs immidiately and if they can be sent to server (because
virtqueue is full) these are queued internally and fuse layer will not
have an idea.

That leaves us with "congestion_threshold" and "max_background".
max_background seems to control how many background requests can be
submitted at a time. That probably can be useful if server is overwhelemed
and we want to slow down the client a bit.

Not sure about congestion threshold.

So have you found some knob useful for your use case?

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
