Return-Path: <SRS0=+9Ss=O5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF5AC433EF
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 05:19:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C96160FD7
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 05:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C96160FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A62F405C4;
	Sat,  9 Oct 2021 05:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m4H3EFi4oQ-C; Sat,  9 Oct 2021 05:19:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D3F4D405BA;
	Sat,  9 Oct 2021 05:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9781BC0011;
	Sat,  9 Oct 2021 05:19:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9698C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 05:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEF7840195
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 05:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OW00zNh77bXR
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 05:19:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E18B40117
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 05:19:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81E8760F6F;
 Sat,  9 Oct 2021 05:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633756782;
 bh=pUE5rhYEEacp7Estu/aEsIop9rFkTz0XLUt7TITMCkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0xTJqu6aVf9jaa4PLDGjfFS3RUIyELChdiht3fzkIZ5ZiESPsFFHibGA5cDwzRv8Z
 mWs9N7bhubOo/AThkvV5tot0U+wVD961DLdlDOdYfi8ctOjwrVj8g1duJQMO0UE4Bm
 qb4kopNX0ufpuntGQ5bRrlA0jqaXF1MC59+JWPDg=
Date: Sat, 9 Oct 2021 07:19:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Message-ID: <YWEma6YvB2HN9/E/@kroah.com>
References: <YV/8Ia1d9zXvMqqc@kroah.com>
 <1633710428.4908655-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1633710428.4908655-1-xuanzhuo@linux.alibaba.com>
Cc: regressions@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Corentin =?iso-8859-1?Q?No=EBl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Oct 09, 2021 at 12:27:08AM +0800, Xuan Zhuo wrote:
> On Fri, 8 Oct 2021 10:06:57 +0200, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> > On Fri, Oct 08, 2021 at 12:17:26AM +0800, Xuan Zhuo wrote:
> > > On Thu, 7 Oct 2021 17:25:02 +0200, Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> > > > On Thu, Oct 07, 2021 at 11:06:12PM +0800, Xuan Zhuo wrote:
> > > > > On Thu, 07 Oct 2021 14:04:22 +0200, Corentin No=EBl <corentin.noe=
l@collabora.com> wrote:
> > > > > > I've been experiencing crashes with 5.14-rc1 and above that do =
not
> > > > > > occur with 5.13,
> > > > >
> > > > > I should have fixed this problem before. I don't know why, I just=
 looked at the
> > > > > latest net code, and this commit seems to be lost.
> > > > >
> > > > >      1a8024239dacf53fcf39c0f07fbf2712af22864f virtio-net: fix for=
 skb_over_panic inside big mode
> > > > >
> > > > > Can you test this patch again?
> > > >
> > > > That commit showed up in 5.13-rc5, so 5.14-rc1 and 5.13 should have=
 had
> > > > it in it, right?
> > > >
> > >
> > > Yes, it may be lost due to conflicts during a certain merge.
> >
> > Really?  I tried to apply that again to 5.14 and it did not work.  So I
> > do not understand what to do here, can you try to explain it better?
> =

> I took a look, and there is actually another missing patch:
> =

> A. 8fb7da9e990793299c89ed7a4281c235bfdd31f8 virtio_net: get build_skb() b=
uf by data ptr
> B. 1a8024239dacf53fcf39c0f07fbf2712af22864f virtio-net: fix for skb_over_=
panic inside big mode
> =

> A is replaced by another patch:
> =

> 	commit c32325b8fdf2f979befb9fd5587918c0d5412db3
> 	Author: Jakub Kicinski <kuba@kernel.org>
> 	Date:   Mon Aug 2 10:57:29 2021 -0700
> =

> 	    virtio-net: realign page_to_skb() after merges
> =

> 	    We ended up merging two versions of the same patch set:
> =

> 	    commit 8fb7da9e9907 ("virtio_net: get build_skb() buf by data ptr")
> 	    commit 5c37711d9f27 ("virtio-net: fix for unable to handle page faul=
t for address")
> =

> 	    into net, and
> =

> 	    commit 7bf64460e3b2 ("virtio-net: get build_skb() buf by data ptr")
> 	    commit 6c66c147b9a4 ("virtio-net: fix for unable to handle page faul=
t for address")
> =

> 	    into net-next. Redo the merge from commit 126285651b7f ("Merge
> 	    ra.kernel.org:/pub/scm/linux/kernel/git/netdev/net"), so that
> 	    the most recent code remains.
> =

> 	    Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 	    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 	    Acked-by: Jason Wang <jasowang@redhat.com>
> 	    Signed-off-by: David S. Miller <davem@davemloft.net>
> =

> So after this patch, patch B can be applied normally.
> =

> So on the latest net branch, only lost
> =

>           1a8024239dacf53fcf39c0f07fbf2712af22864f virtio-net: fix for sk=
b_over_panic inside big mode

Again, I do not know what to do here, can you submit the needed fix to
the networking developers so this gets fixed?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
