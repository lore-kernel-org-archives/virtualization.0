Return-Path: <SRS0=ctfp=KQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971C4C433ED
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 10:06:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CD66135C
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 10:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CD66135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5FEE845B4;
	Fri, 21 May 2021 10:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2u7pMHgonJS; Fri, 21 May 2021 10:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF8E845A7;
	Fri, 21 May 2021 10:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC32C000D;
	Fri, 21 May 2021 10:06:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AAC4C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 10:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E792C4014E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 10:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id juTcmoHKl61Y
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 10:06:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [207.211.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01CC44010B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 May 2021 10:06:38 +0000 (UTC)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-nzPTwh8TNoKqhAUNAmkdWg-1; Fri, 21 May 2021 06:06:33 -0400
X-MC-Unique: nzPTwh8TNoKqhAUNAmkdWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 703E56D241;
 Fri, 21 May 2021 10:06:32 +0000 (UTC)
Received: from bahia.lan (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFCBB1964B;
 Fri, 21 May 2021 10:06:17 +0000 (UTC)
Date: Fri, 21 May 2021 12:06:16 +0200
From: Greg Kurz <groug@kaod.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4 4/5] virtiofs: Skip submounts in sget_fc()
Message-ID: <20210521120616.49d52565@bahia.lan>
In-Reply-To: <CAJfpegsNBCX+2k4S_yqdTS15TTu=pbiRgw6SbvdVYoUSmGboGA@mail.gmail.com>
References: <20210520154654.1791183-1-groug@kaod.org>
 <20210520154654.1791183-5-groug@kaod.org>
 <CAJfpegugQM-ChaGiLyfPkbFr9c=_BiOBQkJTeEz5yN0ujO_O4A@mail.gmail.com>
 <20210521103921.153a243d@bahia.lan>
 <CAJfpegsNBCX+2k4S_yqdTS15TTu=pbiRgw6SbvdVYoUSmGboGA@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Cc: linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Vivek Goyal <vgoyal@redhat.com>
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

On Fri, 21 May 2021 10:50:34 +0200
Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Fri, 21 May 2021 at 10:39, Greg Kurz <groug@kaod.org> wrote:
> >
> > On Fri, 21 May 2021 10:26:27 +0200
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > > On Thu, 20 May 2021 at 17:47, Greg Kurz <groug@kaod.org> wrote:
> > > >
> > > > All submounts share the same virtio-fs device instance as the root
> > > > mount. If the same virtiofs filesystem is mounted again, sget_fc()
> > > > is likely to pick up any of these submounts and reuse it instead of
> > > > the root mount.
> > > >
> > > > On the server side:
> > > >
> > > > # mkdir ${some_dir}
> > > > # mkdir ${some_dir}/mnt1
> > > > # mount -t tmpfs none ${some_dir}/mnt1
> > > > # touch ${some_dir}/mnt1/THIS_IS_MNT1
> > > > # mkdir ${some_dir}/mnt2
> > > > # mount -t tmpfs none ${some_dir}/mnt2
> > > > # touch ${some_dir}/mnt2/THIS_IS_MNT2
> > > >
> > > > On the client side:
> > > >
> > > > # mkdir /mnt/virtiofs1
> > > > # mount -t virtiofs myfs /mnt/virtiofs1
> > > > # ls /mnt/virtiofs1
> > > > mnt1 mnt2
> > > > # grep virtiofs /proc/mounts
> > > > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > > > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > > > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > > >
> > > > And now remount it again:
> > > >
> > > > # mount -t virtiofs myfs /mnt/virtiofs2
> > > > # grep virtiofs /proc/mounts
> > > > myfs /mnt/virtiofs1 virtiofs rw,seclabel,relatime 0 0
> > > > none on /mnt/mnt1 type virtiofs (rw,relatime,seclabel)
> > > > none on /mnt/mnt2 type virtiofs (rw,relatime,seclabel)
> > > > myfs /mnt/virtiofs2 virtiofs rw,seclabel,relatime 0 0
> > > > # ls /mnt/virtiofs2
> > > > THIS_IS_MNT2
> > > >
> > > > Submount mnt2 was picked-up instead of the root mount.
> > >
> >
> > > Why is this a problem?
> > >
> >
> > It seems very weird to mount the same filesystem again
> > and to end up in one of its submounts. We should have:
> >
> > # ls /mnt/virtiofs2
> > mnt1 mnt2
> 
> Okay, sorry, I understand the problem.  The solution is wrong,
> however: the position of the submount on that list is no indication
> that it's the right one (it's possible that the root sb will go away
> and only a sub-sb will remain).
> 

Ah... I had myself convinced this could not happen, i.e. you can't
unmount a parent sb with a sub-sb still mounted.

How can this happen ?

> Even just setting a flag in the root, indicating that it's the root
> isn't fully going to solve the problem.
> 
> Here's issue in full:
> 
> case 1:  no connection for "myfs" exists
>     - need to create fuse_conn, sb
> 
> case 2: connection for "myfs" exists but only sb for submount

How would we know this sb isn't a root sb ?

>     - only create sb for root, reuse fuse_conn
> 
> case 3: connection for "myfs" as well as root sb exists
>    - reuse sb
> 
> I'll think about how to fix this properly, it's probably going to be
> rather more involved...
> 

Sure. BTW I'm wondering why we never reuse sbs for submounts ?

> Thanks,
> Miklos

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
