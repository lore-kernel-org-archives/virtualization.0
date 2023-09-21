Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61603E7D0A6
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 19:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E55A26136F;
	Thu, 21 Sep 2023 19:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E55A26136F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cNbfZzqJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B-5GdKsdEId3; Thu, 21 Sep 2023 19:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72AB760B45;
	Thu, 21 Sep 2023 19:34:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72AB760B45
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54B25C0039;
	Thu, 21 Sep 2023 19:34:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F337C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 037F782CF1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:34:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 037F782CF1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cNbfZzqJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XkFVW9Ly3ZW3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:34:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A3D08223F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:34:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A3D08223F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695324851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AaaqDZJL021384uafe4l1Ly4iUujziU7vTMCEb1hokc=;
 b=cNbfZzqJFeAfyqlyVKBM19Qi8zxUFmu8b9Rk5cnupFpDgZN0RSU6Mz5B94SzSeK+4wVUsO
 yQPp80LCVR0/N7TIt5UOuE9UqYw114WXVhpSTVQA+i7BQTZ9YV01zuJz88NVHD+3/ZtW+0
 xwjZcE2u+Y6kIXkleNeFg+DgWHB1eUE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-ko0aLdChOaKaK_DYLtYStQ-1; Thu, 21 Sep 2023 15:34:09 -0400
X-MC-Unique: ko0aLdChOaKaK_DYLtYStQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a621359127so106439966b.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695324848; x=1695929648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaaqDZJL021384uafe4l1Ly4iUujziU7vTMCEb1hokc=;
 b=FWeFcSvkJrKNATbPSz4Q6Uyc3LIZA/Xdyoi/1leLvFE+c/Tmkh+iL8pG1b4OVlTHV+
 m7dRlSH/bn+CJp7E1txKsku6nWixbG1sy4Ha+bT8hG0hscEw9Ekcb7YsziIPLJ0l5H6e
 ANVzWFFOec/1FLxzqsABQwlsFCbJZRQtcJiFDK1t91FIswS/kx731fvM3tS+DUGRX4j6
 lEnhPdY7lvMoxbXoRCxF/Itb5ECDqzucpoSAWHxPM9CE7Db3hWtm88e33bbIDTcLDZ5P
 vFey8T66mgW2oMFPCaYm6fOm59M4eCR2+Hk5gYUx9OLW7tpiZ5NklShBKjR7v2PlwMzm
 6iiA==
X-Gm-Message-State: AOJu0YwTQky7OwQ6Q72nKxY131vM4wuYoTX+mQEe+5Ij4q4Gf3zgrtp1
 BPaEprUQB9/KOdTYwyObbFm9Gu0unpeuxMzRVbxP/KfME6ujMXPgZ+1ogND/8bQk02HLN57eVt5
 zTATRUM7WCk1wQG9m9w1G6YeYPWP9blC8Pjap9ov4HQ==
X-Received: by 2002:a17:906:5385:b0:9a5:c9a4:ba1b with SMTP id
 g5-20020a170906538500b009a5c9a4ba1bmr5252295ejo.8.1695324848646; 
 Thu, 21 Sep 2023 12:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6S+HUO5/kka0lpaeZ0v+bDS8T9qfxs2Z/38Jcf9wrPi/YGWshdqAvzXLHy4LubK85IYUcsQ==
X-Received: by 2002:a17:906:5385:b0:9a5:c9a4:ba1b with SMTP id
 g5-20020a170906538500b009a5c9a4ba1bmr5252281ejo.8.1695324848363; 
 Thu, 21 Sep 2023 12:34:08 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 oq19-20020a170906cc9300b0098f99048053sm1497148ejb.148.2023.09.21.12.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 12:34:07 -0700 (PDT)
Date: Thu, 21 Sep 2023 15:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921152802-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921181637.GU13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 03:16:37PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 01:55:42PM -0400, Michael S. Tsirkin wrote:
> 
> > That's not what I'm asking about though - not what shadow vq does,
> > shadow vq is a vdpa feature.
> 
> That's just VDPA then. We already talked about why VDPA is not a
> replacement for VFIO.

It does however work universally, by software, without any special
hardware support. Which is kind of why I am curious - if VDPA needs this
proxy code because shadow vq is slower then that's an argument for not
having it in two places, and trying to improve vdpa to use iommufd if
that's easy/practical.  If instead VDPA gives the same speed with just
shadow vq then keeping this hack in vfio seems like less of a problem.
Finally if VDPA is faster then maybe you will reconsider using it ;)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
