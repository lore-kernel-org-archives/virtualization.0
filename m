Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7FEC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 20:27:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7549610E8
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 20:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7549610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DED88276B;
	Thu, 28 Oct 2021 20:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qRDjHOXu1v4; Thu, 28 Oct 2021 20:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 121C38274F;
	Thu, 28 Oct 2021 20:27:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC19FC0012;
	Thu, 28 Oct 2021 20:27:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA426C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 20:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C98EF82768
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 20:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zOpuzgdplsij
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 20:27:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E63CF8274F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 20:27:41 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id ee16so16726808edb.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U0VCnTA81ztDINtqM6o6E9V84NQRoJIC2+B0VqSCsgE=;
 b=aU+2/tLVqGhrkL8ZpCKlx+PcMEu3GaIu0/hZv6wjBFRk8HsEtjdYBCcf9dOyTrybl2
 WV7Y2E9MzToRnOBCFDGe9SEjhzBTjEhNoYdU0wljiNHQDZS4B2ZVBjLByLXt8rjoM77t
 sL5qIln7NXcdnNVwJAYmltJsOUYaUHKYnSMFBSEzlxOs8wdk+7vDD7O2O8TcvERmCWgG
 2GIZLntcYQY2TuH9sKqXELePl7xCU7bzQqIRDz2TXOuchgm/FsQ5HPWzCHEy1LdVXw6N
 /V+r4VexOjVbxlSbzxZySGs2iU9gC+jJ/TGL9Jex4Mw6GVxQjPwG6OdqpR5XV7CVWVPW
 TxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U0VCnTA81ztDINtqM6o6E9V84NQRoJIC2+B0VqSCsgE=;
 b=HIj3JnWry7JbWZ/hs4cGHP5gb2kEvx9env/61wNO6addLPRrYvwh0HPept3FHmoMLJ
 hu/MQioapV+tYzODILXw1WP96XZK9SJtkB8CqSEHGWcvo/YK60tfab0Vet70w99RejFj
 BCpU96gfpXP8P8DHanIl+2gjlNlO9L2kB8hKofMkqTUGmrQ5svvmELgYso86Un6bRT7T
 iXVMckkPgPFshCTB2r5e6BfBwAdytRdvaZ6aHwJUsdkah8lGNM6sumYalTaK3Vkf4lP+
 9F9M0Tv85NlQsKhdPl4eLlnKtjdZQxBRfAzjhpg4BKuD6FvzOMJbNbNr3pAS0Y7O2vrL
 RKNA==
X-Gm-Message-State: AOAM5322oIRehr7Ffn7O3P5BVstKBFKgUBcgr6K8MsRmfBeFMi3a9fQ/
 1Fo6PduwvDZ0uBDI6KelO2kEZp9BsXU1CaljHwoDsGmj
X-Google-Smtp-Source: ABdhPJysuozMPwnprfLWQ4H1YLRNhk7WckQ5rLx8Uj3goEitmiwLYts8gkQj9oxCM28wiR4vYBxYoeOz4RXr6t1J5/M=
X-Received: by 2002:a50:e043:: with SMTP id g3mr9170158edl.196.1635452859927; 
 Thu, 28 Oct 2021 13:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211021074445.452309-1-maksym.wezdecki@collabora.com>
 <20211021092535.ozafsijlakj7ccwc@sirius.home.kraxel.org>
 <327a5c8a-d82d-f115-27bb-37125affe24b@collabora.co.uk>
 <20211021115212.dk2kl2vbl6qotjwa@sirius.home.kraxel.org>
 <CAPaKu7TfEtikdg2HEt2_PH7=zPbk=d9wfosDjNmr1AU6CC6sMw@mail.gmail.com>
 <d1b610f3-6a73-eda1-a35b-3efc85cbb582@collabora.co.uk>
 <ff1f2f85-2f14-af01-3f57-ed5abb4e8a49@collabora.co.uk>
 <20211027111157.m5wppq52jzp3la3s@sirius.home.kraxel.org>
In-Reply-To: <20211027111157.m5wppq52jzp3la3s@sirius.home.kraxel.org>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 28 Oct 2021 13:27:29 -0700
Message-ID: <CAPaKu7R3iKHXO7rD5_err0HA7UFSTvFUx-YhyPfQ=hErz5nf8g@mail.gmail.com>
Subject: Re: drm/virtio: not pin pages on demand
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>,
 Maksym Wezdecki <maksym.wezdecki@collabora.co.uk>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
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

On Wed, Oct 27, 2021 at 4:12 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> [ Cc'ing Gurchetan Singh ]
>
> > Can we follow up on this issue?
> >
> > The main pain point with your suggestion is the fact,
> > that it will cause VirGL protocol breakage and we would
> > like to avoid this.
> >
> > Extending execbuffer ioctl and create_resource ioctl is
> > more convenient than having the protocol broken.
>
> Do you know at resource creation time whenever you need cpu access
> or not?  IOW can we make that a resource property, so we don't have
> pass around lists of objects on each and every execbuffer ioctl?
Yes.  The userspace driver should be able to internally mark the
resource as NO TRANSFER and omit it from execbuffer.  It can be tricky
though because resource wait will no longer work.


>
> > Blob resources is not a solution, too, because QEMU doesn't
> > support blob resources right now.
> >
> > In ideal solution when both QEMU and crosvm support blob resources
> > we can switch to blob resources for textures.
>
> That'll only happen if someone works on it.
> I will not be able to do that though.
>
> > I would like to introduce changes gradually and not make a protocol
> > breakage.
>
> Well, opengl switching to blob resources is a protocol change anyway.
> That doesn't imply things will break though.  We have capsets etc to
> extend the protocol while maintaining backward compatibility.
>
> > What do you think about that?
>
> I still think that switching to blob resources would be the better
> solution.  Yes, it's alot of work and not something which helps
> short-term.  But adding a new API as interim solution isn't great
> either.  So, not sure.  Chia-I Wu?  Gurchetan Singh?
I can agree with that, although it depends on how much work needs to
happen in the userspace for virgl.

We will look into a userspace-only solution, or at least something not
involving uAPI additions.

>
>
> While being at it:  Chia-I Wu & Gurchetan Singh, could you help
> reviewing virtio-gpu kernel patches?  I think you both have a better
> view on the big picture (with both mesa and virglrenderer) than I have.
> Also for the crosvm side of things.  The procedure for that would be to
> send a patch adding yourself to the virtio-gpu section of the
> MAINTAINERS file, so scripts/get_maintainer.pl will Cc you on patches
> submitted.
Sure.  Will do.
>
> thanks,
>   Gerd
>
> >
> > Maksym
> >
> >
> > On 10/22/21 10:44 AM, Maksym Wezdecki wrote:
> >
> > > Once again with all lists and receivers. I'm sorry for that.
> > >
> > > On 10/21/21 6:42 PM, Chia-I Wu wrote:
> > >> On Thu, Oct 21, 2021 at 4:52 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >>> On Thu, Oct 21, 2021 at 11:55:47AM +0200, Maksym Wezdecki wrote:
> > >>>> I get your point. However, we need to make resource_create ioctl,
> > >>>> in order to create corresponding resource on the host.
> > >>> That used to be the case but isn't true any more with the new
> > >>> blob resources.  virglrenderer allows to create gpu objects
> > >>> via execbuffer.  Those gpu objects can be linked to a
> > >>> virtio-gpu resources, but it's optional.  In your case you
> > >>> would do that only for your staging buffer.  The other textures
> > >>> (which you fill with a host-side copy from the staging buffer)
> > >>> do not need a virtio-gpu resource in the first place.
> > >> That's however a breaking change to the virgl protocol.  All virgl
> > >> commands expect res ids rather than blob ids.
> > >>
> > >> Using VIRTGPU_BLOB_MEM_HOST3D could in theory work.  But there are a
> > >> few occasions where virglrenderer expects there to be guest storage.
> > >> There are also readbacks that we need to support.  We might end up
> > >> using VIRTGPU_BLOB_MEM_HOST3D_GUEST, where pin-on-demand is still
> > >> desirable.
> > >>
> > >> For this patch, I think the uapi change can be simplified.  It can be
> > >> a new param plus a new field in drm_virtgpu_execbuffer
> > >>
> > >>   __u64 bo_flags; /* pointer to an array of size num_bo_handles, or NULL */
> > >>
> > >> The other changes do not seem needed.
> > > My first approach was the same, as you mentioned. However, having "__u64 bo_flags"
> > > needs a for loop, where only few of the bo-s needs to be pinned - this has
> > > performance implications. I would rather pass bo handles that should be pinned than
> > > having a lot of flags, where only 1-2 bos needs to be pinned.
> > >
> > >>> take care,
> > >>>   Gerd
> > >>>
>
> --
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
