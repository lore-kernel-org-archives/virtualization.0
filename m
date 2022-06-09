Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DF0C43334
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 13:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D555A840D2;
	Thu,  9 Jun 2022 13:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KH7S_Gyr4V4e; Thu,  9 Jun 2022 13:31:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6691E840AC;
	Thu,  9 Jun 2022 13:31:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32850C0032;
	Thu,  9 Jun 2022 13:31:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE87FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 13:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6ED340DC2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 13:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqXMBSEE8WVp
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 13:31:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2BDD40D7D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654781476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMPwHw/Q9eNYynI7+rtrxtdteC/ovjXlvHhbRHIpVsk=;
 b=OXpy3gkS9PpdEzjLaLNhuzlFxFa47V8v487MqivYbIPsZET7ejS6iINnVDg3iuPPJ4aggx
 leq/V90id5MmWqBm3MxbBue9pe+KmBR3R7TaHbqhVrYPitG+E7L+5K3ai8jb+UsuBIehT6
 PQR8x8gTSInpZlSO1pee1xEeh7B5Syc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-MC8o3B3aOta2xz9Xz0x6tA-1; Thu, 09 Jun 2022 09:31:07 -0400
X-MC-Unique: MC8o3B3aOta2xz9Xz0x6tA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 502C829AA3B4;
 Thu,  9 Jun 2022 13:31:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B9F6C53360;
 Thu,  9 Jun 2022 13:31:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 12D9B220882; Thu,  9 Jun 2022 09:31:07 -0400 (EDT)
Date: Thu, 9 Jun 2022 09:31:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH] fuse: allow skipping abort interface for virtiofs
Message-ID: <YqH2GofHjS4nkWpQ@redhat.com>
References: <20220607110504.198-1-xieyongji@bytedance.com>
 <Yp+oEPGnisNx+Nzo@redhat.com>
 <CACycT3vKZJ4YhPgGq1VFeh3Tqnr-vK3X+rPz0rObH=MraxrhYA@mail.gmail.com>
 <YqCZt7tyEH50ktKq@redhat.com>
 <CACycT3sMe8EdBWxZhT0HTwVB7mGPk=eV3jG-8EkNK+W-Y_RAiw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3sMe8EdBWxZhT0HTwVB7mGPk=eV3jG-8EkNK+W-Y_RAiw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
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

On Wed, Jun 08, 2022 at 09:57:51PM +0800, Yongji Xie wrote:
> On Wed, Jun 8, 2022 at 8:44 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jun 08, 2022 at 04:42:46PM +0800, Yongji Xie wrote:
> > > On Wed, Jun 8, 2022 at 3:34 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 07, 2022 at 07:05:04PM +0800, Xie Yongji wrote:
> > > > > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > > > > interface and forced unmount") tries to remove the control
> > > > > interface for virtio-fs since it does not support aborting
> > > > > requests which are being processed. But it doesn't work now.
> > > >
> > > > Aha.., so "no_control" basically has no effect? I was looking at
> > > > the code and did not find anybody using "no_control" and I was
> > > > wondering who is making use of "no_control" variable.
> > > >
> > > > I mounted virtiofs and noticed a directory named "40" showed up
> > > > under /sys/fs/fuse/connections/. That must be belonging to
> > > > virtiofs instance, I am assuming.
> > > >
> > >
> > > I think so.
> > >
> > > > BTW, if there are multiple fuse connections, how will one figure
> > > > out which directory belongs to which instance. Because without knowing
> > > > that, one will be shooting in dark while trying to read/write any
> > > > of the control files.
> > > >
> > >
> > > We can use "stat $mountpoint" to get the device minor ID which is the
> > > name of the corresponding control directory.
> > >
> > > > So I think a separate patch should be sent which just gets rid of
> > > > "no_control" saying nobody uses. it.
> > > >
> > >
> > > OK.
> > >
> > > > >
> > > > > This commit fixes the bug, but only remove the abort interface
> > > > > instead since other interfaces should be useful.
> > > >
> > > > Hmm.., so writing to "abort" file is bad as it ultimately does.
> > > >
> > > > fc->connected = 0;
> > > >
> > >
> > > Another problem is that it might trigger UAF since
> > > virtio_fs_request_complete() doesn't know the requests are aborted.
> > >
> > > > So getting rid of this file till we support aborting the pending
> > > > requests properly, makes sense.
> > > >
> > > > I think this probably should be a separate patch which explains
> > > > why adding "no_abort_control" is a good idea.
> > > >
> > >
> > > OK.
> >
> > BTW, which particular knob you are finding useful in control filesystem
> > for virtiofs. As you mentioned "abort" we will not implement. "waiting"
> > might not have much significance as well because requests are handed
> > over to virtiofs immidiately and if they can be sent to server (because
> > virtqueue is full) these are queued internally and fuse layer will not
> > have an idea.
> >
> 
> Couldn't it be used to check the inflight I/O for virtiofs?

Actually I might be wrong. It probably should work. Looking at
implementation.

fuse_conn_waiting_read() looks at fc->num_waiting to figure out
how many requests are in flight.

And either fuse_get_req()/fuse_simple_request() will bump up the
fc->num_request count and fuse_put_request() will drop that count
once request completes. And this seems to be independent of
virtiofs.

So looks like it should work even with virtiofs. Please give it a try.

> 
> > That leaves us with "congestion_threshold" and "max_background".
> > max_background seems to control how many background requests can be
> > submitted at a time. That probably can be useful if server is overwhelemed
> > and we want to slow down the client a bit.
> >
> > Not sure about congestion threshold.
> >
> > So have you found some knob useful for your use case?
> >
> 
> Since it doesn't do harm to the system, I think it would be better to
> just keep it as it is. Maybe some fuse users can make use of it.

I guess fair enough. I don't mind creating "control" file system for
virtiofs. Either we don't create "abort" file or may be somehow
writing to file returns error. I guess both the solutions should
work. 

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
