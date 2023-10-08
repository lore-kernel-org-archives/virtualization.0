Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FDBE95A82
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 07:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96431827F0;
	Sun,  8 Oct 2023 07:07:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96431827F0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TE2Pu8b4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXUzz8ujXBWk; Sun,  8 Oct 2023 07:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2AB182786;
	Sun,  8 Oct 2023 07:07:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2AB182786
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88E1EC0071;
	Sun,  8 Oct 2023 07:07:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 756CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D81A40499
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D81A40499
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TE2Pu8b4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dch9OEaQGa_W
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:07:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C70C40140
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:07:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C70C40140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696748863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2fivEi497/0xD/eVssN8LHPs3sN6zS8/o+fjkoWBRM=;
 b=TE2Pu8b4bI6SwLBUbk+V2c1NY53diPV0LvE1+qa6hGeQ4ns6KDuVzHaEjTrpPW5MRnS+ge
 /bzGfd6AYhuM3S4EBQSXw8AL7ph3xQRj1p9NAhmlod6pLYOoNcWO7jC4ys4n5mpQ4kqxAE
 WdrYsyd1f7V3c7ebVBU19HafGMfwvGY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-5QeiD0djNLykri2zEkLd2g-1; Sun, 08 Oct 2023 03:07:41 -0400
X-MC-Unique: 5QeiD0djNLykri2zEkLd2g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-533c6d0b377so2964397a12.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 00:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696748860; x=1697353660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2fivEi497/0xD/eVssN8LHPs3sN6zS8/o+fjkoWBRM=;
 b=nO2w7Wd4dgTCWquG3/6s1toglPJqPK0q3A/ZcWRrQ2bGNf4eavUx3v3DkkpsnkppMh
 4x6oBu+O1QqiVzRM64smx5+DjxUkHOA6Qrr2vroKpODtbZ9ym9C8C/F0dJ6jgfU2JcFz
 ZEioMrxPzhloiYxul/TVkx7X1F2FuKhMJWdG4dNngqPr6CFTcq0l+WCjd4rAui+buzPq
 898u5iEqqhunJeg2cuCgplly2K4qI7GHW/TQJsujKEQSU3eSuxxiTccH4S5GAmt/M/ML
 hvu60PJGIlEIiMrqEYIknJGfdXYDfsOdy9rtb3Zj5e05MnR3v3i11jh5vw3882hS4jiB
 JT1Q==
X-Gm-Message-State: AOJu0YwHjbrNAvN6j7f/yeQuZCDowO50FCJ4WEZ19B5ZaEXikzA/mDa5
 5fYbhKoPR4/NnYg+0WY+WWxmMnFGK1U5JseE2l4pp0e7khr7aYGD/+Jt676WeQ7BBBzWdx0/F1v
 ZoqVMGArIRNrfAQqY+71IFpAGHApKLxL1m6cHKTNtJw==
X-Received: by 2002:aa7:df13:0:b0:534:2e79:6b02 with SMTP id
 c19-20020aa7df13000000b005342e796b02mr11409843edy.39.1696748860322; 
 Sun, 08 Oct 2023 00:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFySVBqxXAGtREE7jPD9CcOGGCbypdtm0B3v9aUgbouC7L+wvkutiu0pdF1XDBwRsDRHo6oQ==
X-Received: by 2002:aa7:df13:0:b0:534:2e79:6b02 with SMTP id
 c19-20020aa7df13000000b005342e796b02mr11409832edy.39.1696748859997; 
 Sun, 08 Oct 2023 00:07:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a50fb87000000b00533c844e337sm4701861edq.85.2023.10.08.00.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 00:07:39 -0700 (PDT)
Date: Sun, 8 Oct 2023 03:07:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <20231008030727-mutt-send-email-mst@kernel.org>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
 <20231008022022-mutt-send-email-mst@kernel.org>
 <2023100823-absurd-imitation-092d@gregkh>
 <20231008024039-mutt-send-email-mst@kernel.org>
 <2023100835-driver-disrupt-9ea0@gregkh>
MIME-Version: 1.0
In-Reply-To: <2023100835-driver-disrupt-9ea0@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Xie Yongji <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Sun, Oct 08, 2023 at 08:46:45AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 08, 2023 at 02:41:22AM -0400, Michael S. Tsirkin wrote:
> > On Sun, Oct 08, 2023 at 08:40:05AM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Oct 08, 2023 at 02:20:52AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> > > > > Now that the driver core allows for struct class to be in read-only
> > > > > memory, we should make all 'class' structures declared at build time
> > > > > placing them into read-only memory, instead of having to be dynamically
> > > > > allocated at runtime.
> > > > > 
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Cc: Xie Yongji <xieyongji@bytedance.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > 
> > > > Greg should I merge it or do you intend to merge all these patches?
> > > 
> > > "all"?  There's loads of them for all sorts of subsystems, so feel free
> > > to take it through your subsystem tree if you want.  I usually scoop up
> > > the ones that no one picks after a release and take them through my
> > > tree, to pick up the stragglers.
> > > 
> > > So it's your call, whatever is easier for you is fine for me.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > To clarify which commit does this depend on?
> 
> The 6.4 kernel release :)

I'll pick this up then. Thanks!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
