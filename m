Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00780C77B61
	for <virtualization@archiver.kernel.org>; Sat,  8 Apr 2023 08:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 473D784604;
	Sat,  8 Apr 2023 08:57:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 473D784604
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bci3IG9S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8JuznUwlvQ5X; Sat,  8 Apr 2023 08:57:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84CDF84536;
	Sat,  8 Apr 2023 08:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84CDF84536
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5318AC0036;
	Sat,  8 Apr 2023 08:57:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E88C6C002A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 08:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFB1C84538
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 08:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFB1C84538
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sd_xP8CVSqaS
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 08:57:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4B5384536
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4B5384536
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 08:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680944240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lfjjYvx7Pgpi68/mS3D+vP5XfsGKFR0qQMUA6+pIEI=;
 b=bci3IG9SHEHaK/qXy4HibSKz5YFRucDq560AJyx7hgHJt3EuCvvK1E17R+oiexAYtAErs+
 Qb/0+o+fSmS5lcSi7lBkFReGC6OCUMfEoYfCgbWn9nzKuYg0dmik87T3jdHvzlmsRY895u
 Fl8Ss3Wuerf7tphaSsE4LCMpUjm40fE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-cp4vTAMnM1GvXcVDMQzX7w-1; Sat, 08 Apr 2023 04:57:18 -0400
X-MC-Unique: cp4vTAMnM1GvXcVDMQzX7w-1
Received: by mail-wm1-f71.google.com with SMTP id
 gw11-20020a05600c850b00b003ee8db23ef9so1535748wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 08 Apr 2023 01:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680944237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lfjjYvx7Pgpi68/mS3D+vP5XfsGKFR0qQMUA6+pIEI=;
 b=NOXiT54eJVgTD6SPFRpKExoyPIGkg7iw6wMv620vyAK/gSBosxEC7I7QxJP5+JKF+K
 DXLJ/AcLC0dc9Xxuvcr2VVmlcvBH0IRyDU32IIS9MrVF40z3DCL7lgosZXtaMZpwIZpk
 5JXatK7gJgarivB7v6XdqwjmPVkmB7KkZccCXn6fgKJRqXlJMaHQ4m582un9aVJ7ZGWD
 yVtEHDTaYAs8SJVeRwt0IAHCyvewRP6ik4y5th8P/H6uFXQVmgNtkfnhAMut2ZW2lysw
 srmAcbmKJ8aFuXY6mR57B7ycwdXW0y6sCLs4cRrv2s6mCMZy4KEpcjIJWCLIXxgLAXaI
 9mTA==
X-Gm-Message-State: AAQBX9cCQboq3n4pT6bCDbY2lnxe4BCFGxxTCgSk0oZhVXkw4NDfbMSY
 3h6+GvF7cZb41+LLiOnlgcp2PzOMt084qq/LqnbZOtvjyCKphAxK4rBIyiRKmhaJAQq7SJR/JkM
 erOd3QBA6qXpBDKVQOy5wPp5n/+JTRL3R44RIlKd4Cg==
X-Received: by 2002:a05:600c:2307:b0:3ed:2709:2edf with SMTP id
 7-20020a05600c230700b003ed27092edfmr3342374wmo.13.1680944237567; 
 Sat, 08 Apr 2023 01:57:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zm1vNoYal26ZbXo1H9khk65+j8QGdgN7juEK/UAnxyb/hzflsloKWp/YxMHvvourojsF007Q==
X-Received: by 2002:a05:600c:2307:b0:3ed:2709:2edf with SMTP id
 7-20020a05600c230700b003ed27092edfmr3342357wmo.13.1680944237288; 
 Sat, 08 Apr 2023 01:57:17 -0700 (PDT)
Received: from redhat.com ([2.52.20.155]) by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b003ede3e54ed7sm7229667wmj.6.2023.04.08.01.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Apr 2023 01:57:16 -0700 (PDT)
Date: Sat, 8 Apr 2023 04:57:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Message-ID: <20230408045648-mutt-send-email-mst@kernel.org>
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
 <20230408023544-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723451039675B61F723B1C6D4979@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723451039675B61F723B1C6D4979@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "viktor@daynix.com" <viktor@daynix.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Sat, Apr 08, 2023 at 07:32:52AM +0000, Alvaro Karsz wrote:
> > Hmm so I conclude that drivers without kick_vq_with_data
> > should not accept VIRTIO_F_NOTIFICATION_DATA then?
> 
> Yes, vDPA drivers without kick_vq_with_data should not offer VIRTIO_F_NOTIFICATION_DATA  in the first place.
> 
> We can be more forgiving in such cases and clear the feature bit + print a warning.
> It may be easier to debug when creating a new vDPA driver.

No need to warn I think, it might not be mandatory.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
