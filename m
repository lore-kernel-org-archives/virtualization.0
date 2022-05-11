Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D72EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 07:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8330A4186F;
	Wed, 11 May 2022 07:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tvToxT06bNyZ; Wed, 11 May 2022 07:13:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0102416FD;
	Wed, 11 May 2022 07:13:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87F29C0039;
	Wed, 11 May 2022 07:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E712CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C74AC60A6B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S0EtvLnzyqW5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:13:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A1F5605BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652253203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQHjzpYWUbx4DIbzDfueaE5axYdznIwfVWGZh8Ng7j8=;
 b=HCshzj2BYoQDbguzjJ2fnhxSK+/VRtg97LKEp9mwRKjKSweXD1FQYsXvZj73IT7eA/5TUv
 1OmZTwwbNSUATvpO6nt7Fhemk1cBxkactJb4n3TAxsOqNxV1plDcYb1waMX+gEyJplAi/T
 ttgFIgdzUvjyzbXRvW3WZlAZbdWjPdQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-tYyJwhHbNoKCMq2asqG-pQ-1; Wed, 11 May 2022 03:13:22 -0400
X-MC-Unique: tYyJwhHbNoKCMq2asqG-pQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 j21-20020adfa555000000b0020adb9ac14fso469786wrb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sQHjzpYWUbx4DIbzDfueaE5axYdznIwfVWGZh8Ng7j8=;
 b=PPdwr1ISxQt+lQhBtjW3EXlKOJjutRSDT99crcjcx6N75U5pTUbGBH2NeN2XFqWZxk
 CdvRvuXmDdQ1zgSYVK20ai55NK9Bh9kbJRd5QXl8vEhQRmWrx+tG12mc5fEgig5Ciril
 zNsiYp4Yf7ftkQ3FiyZClOY7SC/79X+Tqec1TkV4eSbJkYI/6fibqSdkJfRxdVSbDtZi
 cjxPUyRw5SM5zSW+G1tkIPVFduBZi5sI6pwNWxbaxBWRyXS68vlavFzFWyGioJtAEM4g
 Br1KUTkgzCTalZvLnHD/3PNmu/SA3pLD+riQ6onfrCiIL8W91/a7hkYIOIWZsylDSBBk
 mQxQ==
X-Gm-Message-State: AOAM532W9xSo2/5wgCYKpbvr7HwtzcJWmC+6KzKJb7K69yzYEJKZwctv
 gS2+QCO9UFoxCVLUPEdxjAxTRGETgnX02CPf7o263mnLG/bkZmsxEULmvmF1Ps/s9M7ksAte3gQ
 HKsxq9iW7o72aHQ0ATercp4SDch86Nop7ZNEu0eLojg==
X-Received: by 2002:a05:6000:156e:b0:20c:5218:8907 with SMTP id
 14-20020a056000156e00b0020c52188907mr21286289wrz.297.1652253201346; 
 Wed, 11 May 2022 00:13:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxTTooDnLmLT4EcFTkOSjKBlkOtgpHLONSlsyygQ8QPYyAJluPBdZsBfMCA6OcI1SOoePXNQ==
X-Received: by 2002:a05:6000:156e:b0:20c:5218:8907 with SMTP id
 14-20020a056000156e00b0020c52188907mr21286271wrz.297.1652253201133; 
 Wed, 11 May 2022 00:13:21 -0700 (PDT)
Received: from redhat.com ([2.55.46.133]) by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c2e1400b003944821105esm1239510wmf.2.2022.05.11.00.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 00:13:19 -0700 (PDT)
Date: Wed, 11 May 2022 03:13:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <20220511030407-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <YnrxTMVRtDnGA/EK@dev-arch.thelio-3990X>
 <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, mie@igel.co.jp,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Tue, May 10, 2022 at 04:50:47PM -0700, Linus Torvalds wrote:
> On Tue, May 10, 2022 at 4:12 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > For what it's worth, as someone who is frequently tracking down and
> > reporting issues, a link to the mailing list post in the commit message
> > makes it much easier to get these reports into the right hands, as the
> > original posting is going to have all relevant parties in one location
> > and it will usually have all the context necessary to triage the
> > problem.
> 
> Honestly, I think such a thing would be trivial to automate with
> something like just a patch-id lookup, rather than a "Link:".
> 
> And such a lookup model ("where was this patch posted") would work for
> <i>any</i> patch (and often also find previous unmodified versions of
> it when it has been posted multiple times).
> 
> I suspect that most of the building blocks of such automation
> effectively already exists, since I think the lore infrastructure
> already integrates with patchwork, and patchwork already has a "look
> up by patch id".
> 
> Wouldn't it be cool if you had some webby interface to just go from
> commit SHA1 to patch ID to a lore.kernel.org lookup of where said
> patch was done?

Yes, that would be cool!

> Of course, I personally tend to just search by the commit contents
> instead, which works just about as well. If the first line of the
> commit isn't very unique, add a "f:author" to the search.
>
> IOW, I really don't find much value in the "Link to original
> submission", because that thing is *already* trivial to find, and the
> lore search is actually better in many ways (it also tends to find
> people *reporting* that commit, which is often what you really want -
> the reason you're doing the search is that there's something going on
> with it).
> 
> My argument here really is that "find where this commit was posted" is
> 
>  (a) not generally the most interesting thing
> 
>  (b) doesn't even need that "Link:" line.
> 
> but what *is* interesting, and where the "Link:" line is very useful,
> is finding where the original problem that *caused* that patch to be
> posted in the first place.
> 
> Yes, obviously you can find that original problem by searching too if
> the commit message has enough other information.
> 
> For example, if there is an oops quoted in the commit message, I have
> personally searched for parts of that kind of information to find the
> original report and discussion.
> 
> So that whole "searching is often an option" is true for pretty much
> _any_ Link:, but I think that for the whole "original submission" it's
> so mindless and can be automated that it really doesn't add much real
> value at all.
> 
>                 Linus

For me a problematic use-case is multiple versions of the patchset.
So I have a tree and I apply a patchset, start testing etc. Meanwhile author
posts another version. At that point I want to know which version
did I apply. Since people put that within [] in the subject, it
gets stripped off.

Thinking about it some more, how about sticking a link to the *cover
letter* in the commit, instead?  That would serve an extra useful purpose of
being able to figure out which patches are part of the same patchset.
And maybe Change "Link:" to "Patchset:" or "Cover-letter:"?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
