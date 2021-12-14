Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CDEC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 06:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E76040611;
	Tue, 14 Dec 2021 06:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnhzVJK7hC1b; Tue, 14 Dec 2021 06:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5AF7E405AA;
	Tue, 14 Dec 2021 06:17:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BBD7C002F;
	Tue, 14 Dec 2021 06:17:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC2DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BDA78136D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bKU9EiBmiVsF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:17:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C643481300
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 06:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639462632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rs1al99n2XIOY32vnPT3bDQz4dCiZ8BjpLciyOzyiwQ=;
 b=G1TvJocKo3J79pps5T7MtZg6gKX1829Y9l2Y6Eh7APhV6UlGlxjnLTty31+Fiwj+9e0P52
 UhLonX1K9vEkb/JdzEJCkuV0J47gH+WdYGqYweGB2YX2xHLFg/MCDieW1z4B4w3D0cbORa
 fdzLonh5LeInYn2U7tsQ9j0jeiEVQMA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-a-oefAK6NFW9u3AGuJmOeQ-1; Tue, 14 Dec 2021 01:17:11 -0500
X-MC-Unique: a-oefAK6NFW9u3AGuJmOeQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 f15-20020a056512228f00b004037c0ab223so8574157lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 22:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rs1al99n2XIOY32vnPT3bDQz4dCiZ8BjpLciyOzyiwQ=;
 b=UOuOobR1khzMGxVI17vJ7uSkzOPEx+9EHHytFHhJtHILivz1U16sa1pHOCYjcqma4a
 bmrL7exxLdW2dnu8V5RwuGqWzul3VFvzkHZBNl6vQdDW65TOCbhyRnhBnYw+xx3WdHX2
 rvPCiJxHQUy34mWjdDhiH8nQo8i6/Fv9ndFDdcwd7m+rsh2gVHWchMFMhwVBlLa7W1Xp
 6frYbdjbfL0WbEMlLYTqK85wXFQSWm0bSxN08RYFr19OTCwC3E1PoIHX0VEDRp3Cs9cG
 soZxCUb1hFdgdX8+TxfeEmtkpLx23JnkaBQu6XCatUr08pnbn22nbd++5hXpLgGSMW0e
 geOw==
X-Gm-Message-State: AOAM530ZBc6biIYfGf1Wy529JCCWyRb7FtEriH14eNwj9AvEsO99edT0
 HSLyEhUHAtEY3u9RvoXvDk1kZfpc29jrnyrBJNhWM24OfXWRpl91LfKZARKkt1yBnP13FRXr3LA
 /9/rpETxHc8Va9nbrc5E/ydeOcOKqtGSIZejLU9DWIvjK7R63IZk9YQWwAQ==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr3073044lfr.348.1639462629978; 
 Mon, 13 Dec 2021 22:17:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+A4SrckfwXFHSxAnFQ2VRdIEFEDLR2T1AmincSKFdew5+OnERv7dBBQfD1pS8U7hA7JgQl0T7QKasMt2A33Q=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr3073024lfr.348.1639462629802; 
 Mon, 13 Dec 2021 22:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20211213144258.179984-1-elic@nvidia.com>
 <CACGkMEtrpx-cEzRZUWJQ91DrwxYQJZqvjWmVAZ=YJX8oFVH2bQ@mail.gmail.com>
 <PH0PR12MB5481B9C349742AE1E4D9F4C7DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481B9C349742AE1E4D9F4C7DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 14:16:59 +0800
Message-ID: <CACGkMEuscm=BkWo9FpL-SWph_vMBGegTnKoyyqxUepqnbTFzZQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Allow for configuring max number of virtqueue
 pairs
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Eli Cohen <elic@nvidia.com>
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

On Tue, Dec 14, 2021 at 12:11 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, December 14, 2021 8:47 AM
> >
> > A question, consider the parent support both net and block, if user use
> >
> > vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1
> >
> > How do we know it's a net or block device? Or do you expect some block
> > specific attributes to be added?
> User should pass the virtio device id of type net/blk etc when creating the device.
> No such in-kernel driver exists so far, so when it is added netlink interface should be enhanced to accept the optional device id.

So the plan is to reject the dev adding without specifying the device
type? Looks fine to me.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
