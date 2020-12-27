Return-Path: <SRS0=FCrO=F7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0455EC433DB
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:19:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889C7206ED
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889C7206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E77486FE1;
	Sun, 27 Dec 2020 11:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lUwOxzn-zsIP; Sun, 27 Dec 2020 11:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B473C86FBE;
	Sun, 27 Dec 2020 11:19:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3362C1787;
	Sun, 27 Dec 2020 11:19:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1682BC0891
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0A33586FDE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QFV6xdn2Ffax
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3F5BB86FBE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609067944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LApBtbLYVR4nVOhn6rQeBe5qLuDrsVTk4tLKcXzpBU=;
 b=baeEZth7wDG8xobd/rIGUual7y1zl2Lqz1EiaZYjjJHGKvzRmuvta5p3m64548di3mcp/4
 M+pbJlA/b7kFu4TT4fIsnrvShnZfusJVWeqwhL5EFlXZJJMYv0PKTa+vSv9YGCq7Roxjlk
 HDfeZkKlmaDEqWJm326+Z4eGlv8FNE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-3Xsg-BV2ORiqyxIr2skVCw-1; Sun, 27 Dec 2020 06:19:00 -0500
X-MC-Unique: 3Xsg-BV2ORiqyxIr2skVCw-1
Received: by mail-wm1-f72.google.com with SMTP id s130so5472234wme.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 03:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8LApBtbLYVR4nVOhn6rQeBe5qLuDrsVTk4tLKcXzpBU=;
 b=dz6TPsLEMD6NU58Cbxv23C0fWYvHIoogi4HNO0ILmQTfpgBbTcmGSQc3rOTMDKo7SQ
 DqDXgWBbI+Zku0G7H0wlb0G1xDtRGt/L54XCtJt1sECGCQYlR7eUG5548jYOD8R6eXFP
 N/29FSUyngtrRtRgkMUt2+zZ+vSn7pnGXdxGWUyIMNoepLzZNyDElb+EOEyKiAdvqivz
 W+9Qvd/pE7ZTXiDKxv0D8YvYo5BtH3etzciMKaLxT33qfQv4jxZqwt2hTDzCdalHE2nG
 6c8cLdI6EJIYhvGRnfH8wec3xvM+OjCRKALyXDWaAdwypFFvcZhW53uPcO/Krsjr6jWe
 +65Q==
X-Gm-Message-State: AOAM532GNZKFcjf2yilVnyUBaPmfXvr6NcJdOq7Wc+ba6koGul5MVolV
 jcjFQ0Q5/ydtZ3y2tJys+8zOb9M6znZMQovkjpeYLvGOUWax8OD9PGrsMhEQqo/5tEo69d9t6VG
 Di750hNJV7Eyidb5EUzQFBbGwRiXSqoW3eQ6lBFppSQ==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr44747942wrt.136.1609067939148; 
 Sun, 27 Dec 2020 03:18:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyn4prM0xFLNfmKsCnqirXaeOgmM9Xmrpk1zGoqYAU4AUGjRmjDq8m9TqmaySygRIk0FU1t+w==
X-Received: by 2002:a5d:5105:: with SMTP id s5mr44747927wrt.136.1609067938974; 
 Sun, 27 Dec 2020 03:18:58 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id v4sm49928180wrw.42.2020.12.27.03.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Dec 2020 03:18:58 -0800 (PST)
Date: Sun, 27 Dec 2020 06:18:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] tun: fix return value when the number of iovs
 exceeds MAX_SKB_FRAGS
Message-ID: <20201227061540-mutt-send-email-mst@kernel.org>
References: <1608810533-8308-1-git-send-email-wangyunjian@huawei.com>
 <CA+FuTSfmKFVZ7_q6nU92YYk-MLKWTa_bkE+L4C8vi5+UQ1_a8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSfmKFVZ7_q6nU92YYk-MLKWTa_bkE+L4C8vi5+UQ1_a8A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 wangyunjian <wangyunjian@huawei.com>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 virtualization@lists.linux-foundation.org, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

On Thu, Dec 24, 2020 at 10:56:16AM -0500, Willem de Bruijn wrote:
> On Thu, Dec 24, 2020 at 6:51 AM wangyunjian <wangyunjian@huawei.com> wrote:
> >
> > From: Yunjian Wang <wangyunjian@huawei.com>
> >
> > Currently the tun_napi_alloc_frags() function returns -ENOMEM when the
> > number of iovs exceeds MAX_SKB_FRAGS + 1. However this is inappropriate,
> > we should use -EMSGSIZE instead of -ENOMEM.
> >
> > Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
> It might be good to explain why the distinction matters: one denotes a
> transient failure that the caller (specifically vhost_net) can retry,
> the other a persistent failure due to bad packet geometry that should
> be dropped.

It would be good to have a definition of what constitutes a transient
failure. At the moment there's a proposed patch to vhost that
tests for 
	err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS
and we'll likely add EIO to that.

Alternatively, I'm inclined to say any invalid input should
just return EINVAL except maybe for memory access errors
which traditionally are EFAULT.
Then vhost can handle any failure except EINVAL and EFAULT
as transient.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
