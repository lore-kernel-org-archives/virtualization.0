Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C259E95A80
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 06:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88D6A41901;
	Sun,  8 Oct 2023 06:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88D6A41901
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEoDgATk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9YWrHFNpcUiS; Sun,  8 Oct 2023 06:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE38D418FE;
	Sun,  8 Oct 2023 06:41:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE38D418FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A53D2C0039;
	Sun,  8 Oct 2023 06:41:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB629C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8752140530
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8752140530
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEoDgATk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VxFLygKhX-5a
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:41:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BCE14010F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 06:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BCE14010F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696747292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYCw3ejgsMHs1TF/dQzWUZ9FJHhLcnSApWifqzzSdvQ=;
 b=SEoDgATkzfHK7fWrMmd4DwGcF6LW9R5ZiBE2lkkUDHxZFZZBnyrZ/xhF6/Zh3RimEc/lDP
 qzq4gWdAc3XvP9VgigZ4o+9jrNqr8Tqe5qgKVI3vqzRcKgpyME9dsZtJ920XTtbVrFtddG
 OF4KeblVO3B4qXcu3zFUEV2U6WiU0Ck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-H3rhVIdRP-2hcM5lTS7oZg-1; Sun, 08 Oct 2023 02:41:30 -0400
X-MC-Unique: H3rhVIdRP-2hcM5lTS7oZg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso281267766b.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 23:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696747289; x=1697352089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYCw3ejgsMHs1TF/dQzWUZ9FJHhLcnSApWifqzzSdvQ=;
 b=WbDtXYUDsJ/p/IAhWxI+3m14siUFrddZWDpprbnPx9flxLinJQM+X3tsJyeZCeHfI8
 wsV29D16dGOKdkI0e2Osvwm5yV4CUeRVtImbYg2au/Amzaek+lCNKghaikqskDY3Q5qx
 ygWSjnOGZnA+q9GaqliwDizxUz/TgIRki5kAZj3D+jhvFpYg7Ku1NySqTmF7rneziil0
 tuLnzoU7dIP9Fq8i4cfC4A8Eus+msSRTKS51kDTfuC+6ZdMc6gJcarKTTp+VRMOpylg2
 epGYWjrmbo9YS5PzJKkwbuSSW+4IKsWAgSvLNFa4l+4A24Upsn6Wp1QY2PBkmW4NKaUA
 8H/g==
X-Gm-Message-State: AOJu0YxbAwtkLbLzk03GDQFxFlow+VvLA62JiV6/5cNQxn5H570DqvW2
 zDUsgNmIugYXf3b1yWSQWy6pb0YfvEDf+JnaCX9q63Jtz8H+fQKtTiUjTp+xawo9+Zw/pVQVQDc
 ObbzgjOR2ajFXJIAmrTJQvd9o20JVouLZBpRQMTmFiQ==
X-Received: by 2002:a17:906:2921:b0:9ba:97a:cea4 with SMTP id
 v1-20020a170906292100b009ba097acea4mr3136246ejd.65.1696747289219; 
 Sat, 07 Oct 2023 23:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2TdQduQE0kVS/TzLbsch5g4rzkhFzD9IQ81NTdePePszD420kbTRAxTKKs+7cQpoyp4SfIA==
X-Received: by 2002:a17:906:2921:b0:9ba:97a:cea4 with SMTP id
 v1-20020a170906292100b009ba097acea4mr3136236ejd.65.1696747288786; 
 Sat, 07 Oct 2023 23:41:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a170906411200b0099ccee57ac2sm5208096ejk.194.2023.10.07.23.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 23:41:28 -0700 (PDT)
Date: Sun, 8 Oct 2023 02:41:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <20231008024039-mutt-send-email-mst@kernel.org>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
 <20231008022022-mutt-send-email-mst@kernel.org>
 <2023100823-absurd-imitation-092d@gregkh>
MIME-Version: 1.0
In-Reply-To: <2023100823-absurd-imitation-092d@gregkh>
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

On Sun, Oct 08, 2023 at 08:40:05AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 08, 2023 at 02:20:52AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> > > Now that the driver core allows for struct class to be in read-only
> > > memory, we should make all 'class' structures declared at build time
> > > placing them into read-only memory, instead of having to be dynamically
> > > allocated at runtime.
> > > 
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Cc: Xie Yongji <xieyongji@bytedance.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Greg should I merge it or do you intend to merge all these patches?
> 
> "all"?  There's loads of them for all sorts of subsystems, so feel free
> to take it through your subsystem tree if you want.  I usually scoop up
> the ones that no one picks after a release and take them through my
> tree, to pick up the stragglers.
> 
> So it's your call, whatever is easier for you is fine for me.
> 
> thanks,
> 
> greg k-h

To clarify which commit does this depend on?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
