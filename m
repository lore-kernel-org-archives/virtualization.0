Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69C8C433EF
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 11:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57DB341C89;
	Thu, 27 Jan 2022 11:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40e7d3dRrXfs; Thu, 27 Jan 2022 11:25:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E1C8041C86;
	Thu, 27 Jan 2022 11:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B60E1C001A;
	Thu, 27 Jan 2022 11:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F4A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E49F40BA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2voqStg-_Uts
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:25:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2317640B9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643282742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2o4bR97oN2i6VG2aec1T4YVnCkGQ4JcA5PZBDTzUZR0=;
 b=Fpfhy7iIQoD+Unb5CfacWbFce7suLrR5sffzAYccvj/bl8IuoPwdKEV8scKXYRoeCwqVp9
 qCeoiXqjXMrJpbt2LBqHWsGUa7PJZ7N5DkFFSsEm27aJHhKq8PAYxcpdLR1joBbcYpbhKq
 owQKz5zOCcwkR384r+Oqg0C1XtOAdf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-cC2JVd96NkS2sKbblEnUFw-1; Thu, 27 Jan 2022 06:25:41 -0500
X-MC-Unique: cC2JVd96NkS2sKbblEnUFw-1
Received: by mail-wm1-f71.google.com with SMTP id
 o3-20020a1ca503000000b0035056b042deso1380128wme.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 03:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2o4bR97oN2i6VG2aec1T4YVnCkGQ4JcA5PZBDTzUZR0=;
 b=wrlZOPqhc/dSKTX19VPB+Ufi091kkVL4URA2J3lNV2kr6lLPbI9gEp+bYlp4tU18pe
 /GMFexoBRCuo0H1Mkb0X3IJRlDodqYMUDWq0SJA1aMm3FFdItJJKEaprks7+bMiIxY4Z
 EscDJMhIZjCxfe+1Y2qnCxQhecvLDoiroqCMTTw7L7+XuDiC7PfhrNaeFWNEupVc/zpc
 E7O8C5IU0fMcDW6xB03CeiXSsmCjkbsjVN/N833ca4CKNW26Njlyun2SxvUOUmCHqzE9
 c4pkuvSKw4EFe1nivnLP9zlDvmkh0iGZc42NFgwHLfvhddba/gpX6/evcullsAIs3APD
 wW7A==
X-Gm-Message-State: AOAM533xvvsiHIIV/Jx3d8NlB4g+smZn/xfuexmQvg7gW9sNjCoNeyxb
 5fU8KRiMv/QmE0bf0d1IBK8ticHXltoYBknr9hiy+vEJMZ6bl+bbxfYQuTngoGmeC+e4czZzXRo
 2Ex1svFSoAntvIyEEw7/Z66X82Qkdh1lnCrJu0jJO2A==
X-Received: by 2002:a05:600c:1e1a:: with SMTP id
 ay26mr11298014wmb.75.1643282740607; 
 Thu, 27 Jan 2022 03:25:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc2yr02BKE4J2NT4vPIVpdhpyT6toQJ73XSOnuIQbceTgdUDWNpFvb+cmnt/JpyUsuIAWWGg==
X-Received: by 2002:a05:600c:1e1a:: with SMTP id
 ay26mr11298004wmb.75.1643282740378; 
 Thu, 27 Jan 2022 03:25:40 -0800 (PST)
Received: from xz-m1.local ([85.203.46.170])
 by smtp.gmail.com with ESMTPSA id n13sm1881967wrm.68.2022.01.27.03.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jan 2022 03:25:40 -0800 (PST)
Date: Thu, 27 Jan 2022 19:25:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH v5 23/26] util: Add iova_tree_alloc
Message-ID: <YfKBIuTzsoOF9Mj5@xz-m1.local>
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-24-eperezma@redhat.com>
 <YfJeZPn6nsCUxFiL@xz-m1.local>
 <CAJaqyWd52cXWHnLsgo=kP2Z7=VG6YKtxFGhTe7OamfYcZxhz6w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd52cXWHnLsgo=kP2Z7=VG6YKtxFGhTe7OamfYcZxhz6w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Parav Pandit <parav@mellanox.com>
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

On Thu, Jan 27, 2022 at 11:09:44AM +0100, Eugenio Perez Martin wrote:
> > > +/**
> > > + * Try to accomodate a map of size ret->size in a hole between
> > > + * max(end(hole_left), iova_start).
> >
> > I think this functions need the most comments, and above sentence is more or
> > less not sounding correct... My try...
> >
> > /*
> >  * Try to find an unallocated IOVA range between LEFT and RIGHT elements.
> >  *
> >  * There're three cases:
> >  *
> >  * (1) When LEFT==NULL, RIGHT must be non-NULL and it means we're iterating at
> >  *     the 1st element.
> >  *
> >  * (2) When RIGHT==NULL, LEFT must be non-NULL and it means we're iterating at
> >  *     the last element.
> >  *
> >  * (3) When both LEFT and RIGHT are non-NULL, this is the most common case,
> >  *     we'll try to find a hole between LEFT and RIGHT mapping.
> >  */
> >
> 
> This is also called with left == NULL and right == NULL in the first
> allocation with an empty tree. This allows iova_tree_alloc to have the
> same code path both if the three is empty or not.
> 
> But I can add the use cases in the doc for sure.

Ah, right.

> 
> > > + *
> > > + * @args Arguments to allocation
> > > + */
> > > +static bool iova_tree_alloc_map_in_hole(const struct IOVATreeAllocArgs *args)
> > > +{
> > > +    const DMAMap *left = args->hole_left, *right = args->hole_right;
> > > +    uint64_t hole_start, hole_last;
> > > +
> > > +    if (right && right->iova + right->size < args->iova_begin) {
> > > +        return false;
> > > +    }
> > > +
> > > +    if (left && left->iova > args->iova_last) {
> > > +        return false;
> > > +    }
> > > +
> > > +    hole_start = MAX(left ? left->iova + left->size + 1 : 0, args->iova_begin);
> > > +    hole_last = MIN(right ? right->iova : HWADDR_MAX, args->iova_last);
> >
> > I assume these values should be always inclusive, hence
> >
> > s/right->iova/right->iova + 1/
> >
> > ?
> >
> 
> Right, it is confusing the way it's written. But I think it should be
> right->iova - 1 in any case to make it the hole last element, isn't
> it?

I was thinking "-1" but I failed to make it coherent with the thought when
typing.. Heh.

> 
> Would it work better to rename variable hole_last to hole_end? If not,
> we have a special case of the second allocation when iova_begin == 0:
> - We successfully allocate a DMAMap of size N. By the way the
> algorithm works,  it starts at 0, so [0, N] is allocated.

If we're always talking about inclusive ranges, shouldn't it be [0, N-1]?

> - We try to allocate a second one of size M. At the first iteration,
> "right" is the previously allocated DMAMap.
> Using the -1 trick we get hole_end == HWADDR_MAX.

I'm not sure I get the point, but both naming look fine to me.  As long as we
use inclusive ranges, then hole_end/last will be limited to HWADDR_MAX.

> > > +static gboolean iova_tree_alloc_traverse(gpointer key, gpointer value,
> > > +                                         gpointer pargs)
> > > +{
> > > +    struct IOVATreeAllocArgs *args = pargs;
> > > +    DMAMap *node = value;
> > > +
> > > +    assert(key == value);
> > > +
> > > +    iova_tree_alloc_args_iterate(args, node);
> > > +    if (args->hole_left && args->hole_left->iova > args->iova_last) {
> >
> > IMHO this check is redundant and can be dropped, as it's already done in
> > iova_tree_alloc_map_in_hole().
> >
> 
> Assuming we add "iova_found" to iova_tree_alloc_map_in_hole to
> IOVATreeAllocArgs as you propose, it returns true if we are able to
> allocate a DMAMap entry, so no more iterations are needed. But if it
> returns false, it simply means that DMAMap cannot be allocated between
> left (or iova_begin) and right (iova_end). It doesn't tell if you can
> keep iterating or not. In other words, false == keep iterating if you
> can.
> 
> This other check signals the end of the available hole, and to avoid
> iterating beyond iova_last in the (unlikely?) case we have more nodes
> to iterate beyond that.
> 
> I'll try to make it more explicit.

Makes sense.  Comment works.

Thanks,

-- 
Peter Xu

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
