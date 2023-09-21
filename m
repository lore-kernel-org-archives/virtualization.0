Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1333BE7D0A0
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 17:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1E7761033;
	Thu, 21 Sep 2023 17:24:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1E7761033
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwtkSQyr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5H3IJnqOzVQv; Thu, 21 Sep 2023 17:24:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1817360E3A;
	Thu, 21 Sep 2023 17:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1817360E3A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1AC6C0039;
	Thu, 21 Sep 2023 17:24:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC71FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EDB3408F9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:24:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EDB3408F9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AwtkSQyr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awSIZKNylGgp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:24:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6998408F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:24:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6998408F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695317055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A/UaA3dwsjl/5n39ZInDe8A7bNv9U9kL0fxecQB4u1g=;
 b=AwtkSQyr5dmgV2dRXwKtdgryW0l72rgfQvOsvkZS9D0jtOISQHeEue6a1bNmyZ4KQWkM4Y
 1+4rUJBWukkXMdGQCQ2pLquSOZMYD6KiD/7NI9AeV18h12Z2nUwama7kkrFbIwpc8YB0DA
 zN3PXg4acCqA/HHXdf18M7nJiMigMX8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-0CncRBJsOHO1zxC0q4hzKg-1; Thu, 21 Sep 2023 13:24:13 -0400
X-MC-Unique: 0CncRBJsOHO1zxC0q4hzKg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c030cea151so16969981fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 10:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317052; x=1695921852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/UaA3dwsjl/5n39ZInDe8A7bNv9U9kL0fxecQB4u1g=;
 b=Jf5n+seXHNkEyjILBbKIn2B1PxjLZlPgobf5dwIAX7eXnaCRrK1X/MMCB3AoQZXRYC
 XvEQYvF7YZ2ja/JbJgpeLgX7FKBcFzKIkxQpET48G7AKjMU1eqXMGhU8/GWc4fkZ5Gy4
 ZoEdPjW68gpre7vDOSPOk3OpdT955PG2QbrV2kwpcyEPWc6/qp+vrhJ92//hU2kLCG92
 yW140dVsxYZKejp8Omvj138xw9hjzwH3a/1zdxrqxbIRNNNgQ9Hhj5RXfhXkmvEdR+p8
 ydg3q4Pi84psFzPWDkTvvX24iyPx/zXPUNhcRrv7g3ogN4zFTCJcL4YdJ0oJS2yFmIhZ
 UNPw==
X-Gm-Message-State: AOJu0YxRMrb42QxEY2dFbGpBUbnxYsWcIOOKGCn3TjsPPhK1lhrO4V7P
 XPjW5LecoFwXET0sMk2iMi51IQBQh4/gVsX8YDznlmBHD3hLC9MgirtSm+swQaCJ51HnHmj1Qe7
 jWqw6lLDK0oJiy90yOZc1JPKy8HSYPDMBVhzrksaRDw==
X-Received: by 2002:a2e:7a15:0:b0:2c0:18b8:9656 with SMTP id
 v21-20020a2e7a15000000b002c018b89656mr5417399ljc.24.1695317052274; 
 Thu, 21 Sep 2023 10:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuyY22Pu4JJbcepqQfut19xS8d93zqlgBqv3AjWx+BgTUEs/dbdgGpZwmKYhhDDtmusapHPw==
X-Received: by 2002:a2e:7a15:0:b0:2c0:18b8:9656 with SMTP id
 v21-20020a2e7a15000000b002c018b89656mr5417379ljc.24.1695317051939; 
 Thu, 21 Sep 2023 10:24:11 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 p26-20020a170906229a00b009ad8338aafasm1380250eja.13.2023.09.21.10.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:24:11 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:24:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921132206-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813216D57AD82FAC0C10A7DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813216D57AD82FAC0C10A7DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Thu, Sep 21, 2023 at 05:09:04PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 10:31 PM
> 
> > Another question I'm interested in is whether there's actually a performance
> > benefit to using this as compared to just software vhost. I note there's a VM exit
> > on each IO access, so ... perhaps?
> > Would be nice to see some numbers.
> 
> Packet rate and bandwidth are close are only 10% lower than modern device due to the batching of driver notification.
> Bw tested with iperf with one and multiple queues. 
> Packet rate tested with testpmd.

Nice, good to know.  Could you compare this with vdpa with shadow vq
enabled?  That's probably the closest equivalent that needs
no kernel or hardware work.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
