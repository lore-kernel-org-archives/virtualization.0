Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E058AC433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 14:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66C99416F3;
	Mon, 11 Apr 2022 14:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MrOyFyuUg3Aj; Mon, 11 Apr 2022 14:00:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 927F04091A;
	Mon, 11 Apr 2022 14:00:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65A19C0033;
	Mon, 11 Apr 2022 14:00:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBCFDC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A81D83E21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkbFz7L212u3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:00:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A009B83E0E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649685619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6v4s9jcqjHj1+7r9Rv3PhwmFEcECKyiel7WBx1Gr7GY=;
 b=Jh1XkEAswZYovS0rWbqzKJRX6sZTgc+3YiNGf8ElwNyMe9sWvNgDUMOUuZ1OyB+JE+z2xH
 hfQSlS9TkdcK+EfxCeJ5b+vRr73vZVOZRYGd0Pfz+jkIKIZyAhxGPjMvIPge0jceZrN8VG
 81nHvGnKYrTFN3xM1Y0Ffhg2plEHUxQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-9fL6VUJoNqS6XuOb1Lzt4Q-1; Mon, 11 Apr 2022 10:00:18 -0400
X-MC-Unique: 9fL6VUJoNqS6XuOb1Lzt4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74CA33810D58;
 Mon, 11 Apr 2022 14:00:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 561B62024CCC;
 Mon, 11 Apr 2022 14:00:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 11BD2220079; Mon, 11 Apr 2022 10:00:17 -0400 (EDT)
Date: Mon, 11 Apr 2022 10:00:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: Re: [PATCH] fuse: avoid unnecessary spinlock bump
Message-ID: <YlQ0cT/BOzHi8Q1b@redhat.com>
References: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
 <Yk7w8L1f/yik+qrR@redhat.com>
 <b7a50fac-0259-e56c-0445-cca3fbf99888@linux.alibaba.com>
 <YlAbqF4Yts8Aju+W@redhat.com>
 <586dd7bb-4218-63da-c7db-fe8d46f43cde@linux.alibaba.com>
 <YlAlR0xVDqQzl98w@redhat.com>
 <d5c1b2bc-78d1-c6f8-0fb0-512a702b6e3b@linux.alibaba.com>
 <YlQWkGl1YQ+ioDas@redhat.com>
 <3f6a9a7a-90e3-e9fd-b985-3e067513ecea@linux.alibaba.com>
 <afc2f1ec-8aff-35fa-5fde-75852db7b4a8@fastmail.fm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afc2f1ec-8aff-35fa-5fde-75852db7b4a8@fastmail.fm>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: Dharmendra Singh <dsingh@ddn.com>, miklos@szeredi.hu,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 stefanha@redhat.com, gerry@linux.alibaba.com
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

On Mon, Apr 11, 2022 at 03:20:05PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/11/22 13:54, JeffleXu wrote:
> > 
> > 
> > On 4/11/22 7:52 PM, Vivek Goyal wrote:
> > > On Mon, Apr 11, 2022 at 10:10:23AM +0800, JeffleXu wrote:
> > > > 
> > > > 
> > > > On 4/8/22 8:06 PM, Vivek Goyal wrote:
> > > > Curiously, why minimum 1 range is not adequate? In which case minimum 2
> > > > are required?
> > > 
> > > Frankly speaking, right now I don't remember. I have vague memories
> > > of concluding in the past that 1 range is not sufficient. But if you
> > > like dive deeper, and try with one range and see if you can introduce
> > > deadlock.
> > > 
> > 
> > Alright, thanks.
> > 
> 
> 
> Out of interest, how are you testing this at all? A patch from Dharmendra
> had been merged last week into libfuse to let it know about flags2, as we
> need that for our patches. But we didn't update the FLAGS yet to add in DAX
> on the libfuse side.
> 
> Is this used by virtio fs?

Yes, idea is that this is used by virtiofs. Now looks like there are
multiple implementations of virtiofs daemon and they are either not
using libfuse or have forked off libfuse or created a new libfuse
equivalent in rust etc. So as fuse kernel gets updated, people are
updating their corresponding code as need be.

For example, we have C version of virtiofsd in qemu. That has taken
code from libfuse and built on top of it. BTW, C version of virtiofsd
is deprecated now and not lot of new development is expected to take
place there.

Then there is rust version of virtiofsd where new development is taking
place and which is replacement of C virtiofsd.

https://gitlab.com/virtio-fs/virtiofsd

This does not use libfuse at all.

And I think other folks (like developers from Alibaba) have probably 
written their own implementation of virtiofsd. I am not sure what
exactly are they using.

I see there is rust crate for fuse.

https://crates.io/crates/fuse

And there is one in cloud-hypervisor project.

https://github.com/cloud-hypervisor/fuse-backend-rs


> Or is there another libfuse out there that should
> know about these flags (I think glusterfs has its own, but probably not
> using dax?).
> 

So server side of fuse seem to be all fragmented to me. People have
written their own implementations based on their needs.

> Also, testing is always good, although I don't see how Jeffs patch would be
> able break anything here.

Agreed. I worry about testing constantly as well. qemu version of
virtiofsd does not have DAX support yet. Rust version DAX support is
also minimal. 

So for testing DAX, I have to rely on out of tree patches from qemu
here if any changes in virtiofs client happen.

https://gitlab.com/virtio-fs/qemu/-/tree/virtio-fs-dev

Jeffle is probably relying on their own virtiofsd implementation for DAX
testing.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
