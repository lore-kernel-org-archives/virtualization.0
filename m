Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6268FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 06:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EED6E404F0;
	Wed, 11 May 2022 06:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUKFPEVX-IFh; Wed, 11 May 2022 06:23:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85ED74011F;
	Wed, 11 May 2022 06:23:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63100C0032;
	Wed, 11 May 2022 06:23:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAA6CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 06:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9C1840178
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 06:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yjPoPmIANM6N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 06:23:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FB514011F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 06:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652250185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwyljACqAbVlQtU4LAdoRLkrWe0WUBj5SX13dxtUmBw=;
 b=KPAqoqKPdMjtlH55V3/1X5xt8M5ellDPzfCxOqmXJXFHyt1QaFitDLpflMMBk/PuKhTJk/
 xEDhq/1Z95vMiyBmTHzPsfLZ1Adw04StC+4OqLcv3wfqoKksaB2iWHPvOwdPJ4H8LPJUCt
 ARHx5tcUtUEmUDphveBDL2ujsxgkw7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-ri1fX3qiNcW2fULS2bnE2Q-1; Wed, 11 May 2022 02:23:03 -0400
X-MC-Unique: ri1fX3qiNcW2fULS2bnE2Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 o13-20020adfa10d000000b0020c6fa5a77cso411364wro.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WwyljACqAbVlQtU4LAdoRLkrWe0WUBj5SX13dxtUmBw=;
 b=3/ikHnAbXxGCi8u0WX7Ps/X2UCW6hbFugiUbFzavQCB0B3XMcxLVSG6x/8j6hh3n//
 Tc96p+SX0qpqtaMbRFx//t2eyfMNdO956vDYaS1cjvgsHDS6Snr8Ce9OzS9p5RwVfFNw
 dVnMb96pbjzW53yvIa9XKmT4OWbFfytpo4W6EGObbqKlQwGVtCC3O+Ad9k3/NhWTvyOE
 RX+CIywtfI4Vq8CEic3h3UtzVJ0hxk7uvSnGsat4uND4ZqHKLhbbmJbcX8wDI1zXy+D7
 LH/amxddrQOsJJxOyL1tuR9hUfgCHGNqjkbyHRcXnHDk4etbxBmYqRpfoJy57NstLN1K
 vv1A==
X-Gm-Message-State: AOAM531N/FfVivMiYgwCnSyKndRjnf3e5YJZB/PwJlzSVqf0kYMBzixh
 tCaT7UTAH410sB+5Wjr+vdhzMnpoczUlgKhhi73xlcuioBmjXvEWTVilB2lYaG5TSfutEd3spSZ
 RfFkPMHQZHmIuJNUdMsXVGIw3G/K/p6HHKn6GuPJMLQ==
X-Received: by 2002:a05:600c:5112:b0:394:55bd:5f9d with SMTP id
 o18-20020a05600c511200b0039455bd5f9dmr3210781wms.188.1652250182462; 
 Tue, 10 May 2022 23:23:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcV3T8X8kCnCQofNw+5gZoO6rnCBUJnaiWHS+ZFla1vKmmL1Rqa83V1y1VetYmuhrJXc006Q==
X-Received: by 2002:a05:600c:5112:b0:394:55bd:5f9d with SMTP id
 o18-20020a05600c511200b0039455bd5f9dmr3210762wms.188.1652250182189; 
 Tue, 10 May 2022 23:23:02 -0700 (PDT)
Received: from redhat.com ([2.55.31.58]) by smtp.gmail.com with ESMTPSA id
 p19-20020a7bcc93000000b003942a244ecesm1155431wma.19.2022.05.10.23.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 23:23:01 -0700 (PDT)
Date: Wed, 11 May 2022 02:22:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <20220511021608-mutt-send-email-mst@kernel.org>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: KVM list <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
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

On Tue, May 10, 2022 at 11:23:11AM -0700, Linus Torvalds wrote:
> On Tue, May 10, 2022 at 5:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > A last minute fixup of the transitional ID numbers.
> > Important to get these right - if users start to depend on the
> > wrong ones they are very hard to fix.
> 
> Hmm. I've pulled this, but those numbers aren't exactly "new".
> 
> They've been that way since 5.14, so what makes you think people
> haven't already started depending on them?

Yes they have been in the header but they are not used by *Linux* yet.
My worry is for when we start using them and then someone backports
the patches without backporting the macro fix.
Maybe we should just drop these until there's a user, but I am
a bit wary of a step like this so late in the cycle.

> And - once again - I want to complain about the "Link:" in that commit.
> 
> It points to a completely useless patch submission. It doesn't point
> to anything useful at all.
> 
> I think it's a disease that likely comes from "b4", and people decided
> that "hey, I can use the -l parameter to add that Link: field", and it
> looks better that way.
> 
> And then they add it all the time, whether it makes any sense or not.
> 
> I've mainly noticed it with the -tip tree, but maybe that's just
> because I've happened to look at it.
> 
> I really hate those worthless links that basically add zero actual
> information to the commit.
> 
> The "Link" field is for _useful_ links. Not "let's add a link just
> because we can".
> 
>                            Linus


OK I will stop doing this.
I thought they are handy for when there are several versions of the
patch. It helps me make sure I applied the latest one. Saving the
message ID of the original mail in some other way would also be ok.
Any suggestions for a better way to do this?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
