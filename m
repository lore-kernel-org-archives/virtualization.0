Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E072AC10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 659078137B;
	Tue, 27 Dec 2022 07:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 659078137B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KdY9hD5i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5BBkjY14Mvi; Tue, 27 Dec 2022 07:05:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5A2680B91;
	Tue, 27 Dec 2022 07:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5A2680B91
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFCAEC0032;
	Tue, 27 Dec 2022 07:05:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 041B0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2FF78134B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:05:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2FF78134B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WVrt7RF1RGRW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:05:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1ACB080B91
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1ACB080B91
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t6B+5aJ0Guf5xJnrVgDQJOLVwGWWIObpNI/iqDeXCf0=;
 b=KdY9hD5i5pcWzts+WRUbCqnDwAz+dNmI5AX++W+a4OFquHWxzIyggtQ1e33pJbuRIWy+tG
 nPKzQeBIm6dWJk6VKnTKkb3oOyOcZ3zJ/0yJuDwurstcNUwwl29XE0SD1DlT4JQi06WGmb
 IQjkPqeL34f1prsTJGosRRTVKIJo0hI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-zOzBoERpMqqP4aUid3ZgQw-1; Tue, 27 Dec 2022 02:05:47 -0500
X-MC-Unique: zOzBoERpMqqP4aUid3ZgQw-1
Received: by mail-wr1-f71.google.com with SMTP id
 e10-20020adf9bca000000b0026e2396ab34so1659057wrc.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6B+5aJ0Guf5xJnrVgDQJOLVwGWWIObpNI/iqDeXCf0=;
 b=YMO51zQp9PBg9CuVjyEcyMENxdce5xcLcVuXaUeilk2BJbR8ehqWki2YkUdE3PZVkL
 jqy+Gi6wzFinIPqxXLHL1S/C8Jm+yycqQQjP/vOa6H2gjI/Tyar044OByocOMl1l1QOc
 ei4JXtEuS/ruwAUsFoFrTEWI4AXDdpLe9h3JJB7YsGED1885j/wPzlGXAcDv3M32gP/b
 0XRECnPZ1DqJ8VRf4kwLT2Sw1q+gQsWkr0dmTFc67Qhb3nwZr7//24Ar/6P3jNVSqvYB
 1lwP1Oz1Y8AYhpowfdbEpO7F/kracW2FD8CQnOaQDbHnZQS6/yxBH5ezipQdiKDWg42R
 L87g==
X-Gm-Message-State: AFqh2ko1pCQCr2Fj2YG2y8UNvIcmDge31+YpNWFpWh0lfx3CCP2/X/GL
 5sXONgZwC2mMMOkGkeZqSwqp04dap7mowQ+qH199/nvVhMxg+zDDRr7bSHAS9kfOHZCxqiBVEOU
 IY6offP1oj3eI/ouXZoOoWw0Xw7f6IS7k14Sn+c2Xsw==
X-Received: by 2002:a05:600c:3789:b0:3d1:f234:12cc with SMTP id
 o9-20020a05600c378900b003d1f23412ccmr14917381wmr.33.1672124746385; 
 Mon, 26 Dec 2022 23:05:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7VxVFTlp1bWTB6ltmdqn/ESzBZWCVVlTMmPA5egsFORFko71Rv1M6SSn/w7ah7B/gMr/N1w==
X-Received: by 2002:a05:600c:3789:b0:3d1:f234:12cc with SMTP id
 o9-20020a05600c378900b003d1f23412ccmr14917367wmr.33.1672124746164; 
 Mon, 26 Dec 2022 23:05:46 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 he11-20020a05600c540b00b003d359aa353csm15894121wmb.45.2022.12.26.23.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:05:45 -0800 (PST)
Date: Tue, 27 Dec 2022 02:05:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 2/9] vringh: remove vringh_iov and unite to vringh_kiov
Message-ID: <20221227020425-mutt-send-email-mst@kernel.org>
References: <20221227022528.609839-1-mie@igel.co.jp>
 <20221227022528.609839-3-mie@igel.co.jp>
 <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtAaYpuZtS0gx_m931nFzcvqSNK9BhvUZH_tZXTzjgQCg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Shunsuke Mie <mie@igel.co.jp>
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

On Tue, Dec 27, 2022 at 02:04:03PM +0800, Jason Wang wrote:
> On Tue, Dec 27, 2022 at 10:25 AM Shunsuke Mie <mie@igel.co.jp> wrote:
> >
> > struct vringh_iov is defined to hold userland addresses. However, to use
> > common function, __vring_iov, finally the vringh_iov converts to the
> > vringh_kiov with simple cast. It includes compile time check code to make
> > sure it can be cast correctly.
> >
> > To simplify the code, this patch removes the struct vringh_iov and unifies
> > APIs to struct vringh_kiov.
> >
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> 
> While at this, I wonder if we need to go further, that is, switch to
> using an iov iterator instead of a vringh customized one.
> 
> Thanks

Possibly, but when doing changes like this one needs to be careful
to avoid breaking all the inlining tricks vringh relies on for
performance.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
