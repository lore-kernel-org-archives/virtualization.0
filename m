Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC7C433EF
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 03:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3466840240;
	Fri, 28 Jan 2022 03:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m0Buqv5Uq9SF; Fri, 28 Jan 2022 03:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B93DD4020C;
	Fri, 28 Jan 2022 03:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90EA9C001A;
	Fri, 28 Jan 2022 03:57:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C4CBC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 03:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B109401FD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 03:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YiahsaYI3_ic
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 03:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 389D4415FD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 03:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643342270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jWvHlR7f12xl5QlYdeCb5wE6G0pG1QFlh+7tBOuNAe4=;
 b=hCKCprMi1LbVo06hC0WJ3D1D3I9L0hnLpRL1fzc/LjctT43STCnbHSU9UK/2luGB1yTP64
 X+vT/NwYOgNcyYN1HTTsm9aMVmoFmkhtYeIvousL7+GwyEOsJ3DbEbowK1Fxy1M7MZXsJn
 MwaVz44qH3oA4G88TGITISkz/3bXyVM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-I91Rer8zNXWVfEUysTfBDw-1; Thu, 27 Jan 2022 22:57:44 -0500
X-MC-Unique: I91Rer8zNXWVfEUysTfBDw-1
Received: by mail-wr1-f69.google.com with SMTP id
 q4-20020adfbb84000000b001dd3cfddb2dso1750077wrg.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 19:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jWvHlR7f12xl5QlYdeCb5wE6G0pG1QFlh+7tBOuNAe4=;
 b=3/zhtFcEWIXShhoahx0Y2OVGxjFm+cjxAk6anzHCHvDDZcmX8nfC593NjLHgZGAHbX
 ogLqFlor1klKbvfxA6wDtdFJSX0z8cVmeqybtk5swLF7mUbh49TwxzsFZJJr8LaaHkud
 tclQzXyFESt4WGFYJ99f8EfZxgpR8sxxbKDiunZVoUd7vL3Qi+NtjF+9h3Ju+6ScIz2x
 N6zGoudQ20yoyPjAjBvqQlajy8dSRbZJNKJh+txBgEx+g6+UWWFXH/lTMS7t9a9MScc/
 x8YKGHhlCTuemGTTMoX5y5yZCeaXp8bHpjLPzc0YkJG0tbsd75sbkUalypDmm6WAR9BP
 LeYQ==
X-Gm-Message-State: AOAM530PlJb64SGiSDJh0pDbDQYrzJVikY5ceK8Th2OTq3IEUSf3izU7
 qCPt7DAjIiuoLKtm7CwvQw0N3uw5AraXju2D6koWr8IbtCkR3srrVe8LmpuV3QqJjxD6wlcpFo0
 XGPd10ot6ztWRYA/v5xt+s8i4r7HU+LyLPjTrUj6f6Q==
X-Received: by 2002:a05:6000:1869:: with SMTP id
 d9mr5410544wri.432.1643342262988; 
 Thu, 27 Jan 2022 19:57:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf5IuzSvJxcgfQuZPBSRPgkHI3ACKszhhRY9oImVHXp/pw0dSLnOrDNR2IlDXGR3OHU8Bbrg==
X-Received: by 2002:a05:6000:1869:: with SMTP id
 d9mr5410528wri.432.1643342262784; 
 Thu, 27 Jan 2022 19:57:42 -0800 (PST)
Received: from xz-m1.local ([64.64.123.9])
 by smtp.gmail.com with ESMTPSA id u14sm946742wmq.24.2022.01.27.19.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 19:57:42 -0800 (PST)
Date: Fri, 28 Jan 2022 11:57:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 21/31] util: Add iova_tree_alloc
Message-ID: <YfNprA3OLUqj8LSG@xz-m1.local>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-22-eperezma@redhat.com>
 <Ye4r7tKFhP9VaT5/@xz-m1.local>
 <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
 <Ye6IhLCe6NDKO6+E@xz-m1.local>
 <CAJaqyWcdpTr2X4VuAN2NLmpviCjDoAaY269+VQGZ7-F6myOhSw@mail.gmail.com>
 <YfJSezhQv1kXa1x8@xz-m1.local>
 <CAJaqyWczZ7C_vbwugyN9bEgOVuRokGqVMb_g5UK_R4F8O+qKOA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWczZ7C_vbwugyN9bEgOVuRokGqVMb_g5UK_R4F8O+qKOA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

On Thu, Jan 27, 2022 at 10:24:27AM +0100, Eugenio Perez Martin wrote:
> On Thu, Jan 27, 2022 at 9:06 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 10:40:01AM +0100, Eugenio Perez Martin wrote:
> > > So I think that the first step to remove complexity from the old one
> > > is to remove iova_begin and iova_end.
> > >
> > > As Jason points out, removing iova_end is easier. It has the drawback
> > > of having to traverse all the list beyond iova_end, but a well formed
> > > iova tree should contain none. If the guest can manipulate it, it's
> > > only hurting itself adding nodes to it.
> > >
> > > It's possible to extract the check for hole_right (or this in Jason's
> > > proposal) as a special case too.
> > >
> > > But removing the iova_begin parameter is more complicated. We cannot
> > > know if it's a valid hole without knowing iova_begin, and we cannot
> > > resume traversing. Could we assume iova_begin will always be 0? I
> > > think not, the vdpa device can return anything through syscall.
> >
> > Frankly I don't know what's the syscall you're talking about,
> 
> I meant VHOST_VDPA_GET_IOVA_RANGE, which allows qemu to know the valid
> range of iova addresses. We get a pair of uint64_t from it, that
> indicates the minimum and maximum iova address the device (or iommu)
> supports.
> 
> We must allocate iova ranges within that address range, which
> complicates this algorithm a little bit. Since the SVQ iova addresses
> are not GPA, qemu needs extra code to be able to allocate and free
> them, creating a new custom iova as.
> 
> Please let me know if you want more details or if you prefer me to
> give more context in the patch message.

That's good enough, thanks.

> 
> > I mean this one:
> >
> > https://lore.kernel.org/qemu-devel/20211029183525.1776416-24-eperezma@redhat.com/
> >
> > Though this time I have some comments on the details.
> >
> > Personally I like that one (probably with some amendment upon the old version)
> > more than the current list-based approach.  But I'd like to know your thoughts
> > too (including Jason).  I'll further comment in that thread soon.
> >
> 
> Sure, I'm fine with whatever solution we choose, but I'm just running
> out of ideas to simplify it. Reading your suggestions on old RFC now.
> 
> Overall I feel list-based one is both more convenient and easy to
> delete when qemu raises the minimal glib version, but it adds a lot
> more code.
> 
> It could add less code with this less elegant changes:
> * If we just put the list entry in the DMAMap itself, although it
> exposes unneeded implementation details.
> * We force the iova tree either to be an allocation-based or an
> insertion-based, but not both. In other words, you can only either use
> iova_tree_alloc or iova_tree_insert on the same tree.

Yeah, I just noticed it yesterday that there's no easy choice on it.  Let's go
with either way; it shouldn't block the rest of the code.  It'll be good if
Jason or Michael share their preferences too.

> 
> I have a few tests to check the algorithms, but they are not in the
> qemu test format. I will post them so we all can understand better
> what is expected from this.

Sure.  Thanks.

-- 
Peter Xu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
