Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1CAC433B4
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 13:28:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB636144B
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 13:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB636144B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD3DB40ED9;
	Wed, 21 Apr 2021 13:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvjK_BMcl3bC; Wed, 21 Apr 2021 13:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4849B40EC1;
	Wed, 21 Apr 2021 13:28:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ADE5C001A;
	Wed, 21 Apr 2021 13:28:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10B76C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 13:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F8AF60C1B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 13:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id edGwSnmiBRB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 13:28:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3960860C25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 13:28:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 979CB601FD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619011695;
 bh=gd6rsygtuagfkB4FDvWJXsa742reDkhpJW+iRUjhuHU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=t25R61c8zfm3o/7Vj1DobsToPSADsHEVrGtsGb9SMfxgo9LRkwpXmz6M9VycBiOr0
 CSh641IvPStyZj3lqUxbfnUTyFFFerPXvh/q5RyecQMkV/1xdm3IyrZfnxOdmp0rHH
 bWZ/Ppdry7GCTH6YGXQLnp7GoFCwsv6WPhENEm2G0nEC6hYdrldw7cU/QSLR889A2Q
 ZPHWNe6Cw8Y4NhvTA+fERLFTJExanBNg1AHZ2BOxqO90ic9Bb+0NwmvhA39sFTxbFt
 Xf3EYNTN+yLVaSdTIUZJV0mra9tV39R/0IUKXAnQFohvlaK2R0kjHPvotFj9vZuvl2
 mODpr6RkoErDg==
Received: by mail-ed1-f45.google.com with SMTP id k17so9862214edr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 06:28:15 -0700 (PDT)
X-Gm-Message-State: AOAM533HYtDEjf4mkY6TC3dlY1XjREY1GRTDY7HVARA5NtJUbwAUPFEk
 w96IFiv6Mssjz6dYLx9UNyrd4b3WK50lRyAwDvc=
X-Google-Smtp-Source: ABdhPJxesrYNMpetivD88y9gOQd9/WNjXGkrwbMGNXwoHyVO6fn06ZJLI0nODGQZ/qRqHh0KYR1I2lEnH5FMv/zbdYU=
X-Received: by 2002:a50:ec92:: with SMTP id e18mr39345623edr.246.1619011694047; 
 Wed, 21 Apr 2021 06:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210406235332.2206460-1-pakki001@umn.edu>
 <20210407155031.GA1014852@redhat.com>
In-Reply-To: <20210407155031.GA1014852@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 21 Apr 2021 15:28:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc-GuTmVzWPXWqSegtckDsfyYj_aOKwK1TKCsYFkK681A@mail.gmail.com>
Message-ID: <CAJKOXPc-GuTmVzWPXWqSegtckDsfyYj_aOKwK1TKCsYFkK681A@mail.gmail.com>
Subject: Re: [PATCH] fuse: Avoid potential use after free
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aditya Pakki <pakki001@umn.edu>,
 linux-fsdevel@vger.kernel.org
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

On Wed, 7 Apr 2021 at 23:25, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Apr 06, 2021 at 06:53:32PM -0500, Aditya Pakki wrote:
> > In virtio_fs_get_tree, after fm is freed, it is again freed in case
> > s_root is NULL and virtio_fs_fill_super() returns an error. To avoid
> > a double free, set fm to NULL.
> >
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  fs/fuse/virtio_fs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 4ee6f734ba83..a7484c1539bf 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1447,6 +1447,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
> >       if (fsc->s_fs_info) {
> >               fuse_conn_put(fc);
> >               kfree(fm);
> > +             fm = NULL;
>
> I think both the code paths are mutually exclusive and that's why we
> don't double free it.
>
> sget_fc(), can either return existing super block which is already
> initialized, or it can create a new super block which need to
> initialize further.
>
> If if get an existing super block, in that case fs->s_fs_info will
> still be set and we need to free fm (as we did not use it). But in
> that case this super block is already initialized so sb->s_root
> should be non-null and we will not call virtio_fs_fill_super()
> on this. And hence we will not get into kfree(fm) again.
>
> Same applies to fuse_conn_put(fc) call as well.
>
> So I think this patch is not needed. I think sget_fc() semantics are
> not obvious and that confuses the reader of the code.

This patch might be harmful, might be not. Probably should be skipped
due to uncertain intentions:
https://lore.kernel.org/linux-nfs/YH+7ZydHv4+Y1hlx@kroah.com/

Best regards,
Krzysztof
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
