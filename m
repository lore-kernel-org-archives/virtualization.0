Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC34C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 14:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6860C60AD5;
	Tue, 26 Apr 2022 14:18:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzsFrlO_w5CY; Tue, 26 Apr 2022 14:18:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 119CC60B03;
	Tue, 26 Apr 2022 14:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3EECC0032;
	Tue, 26 Apr 2022 14:18:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5704EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34B17405B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xIuWK0Wq-P-7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03E1E4018D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650982682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0bfm5h1PBNVBIKlOUTEv2QDkar3XSs2YfbRFWDvobYk=;
 b=V9Wk6rq6djuJhKk6Ff2TwmIg5e0U5kyt22YoDXBlZZ2GpEVhNWr/QROOmElmLfyR399law
 pzFAj71nT818PMdbWXdw337Kg5wwv6NTLkPlKGYHKEutyBtoF9gNF/PPmI0aqME4zurLEP
 eNqf+a2rHwuB+PGET6uUxWDN2O2Af/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-DhT_ERCtMrSmqJmBg6uqCA-1; Tue, 26 Apr 2022 10:18:01 -0400
X-MC-Unique: DhT_ERCtMrSmqJmBg6uqCA-1
Received: by mail-wm1-f70.google.com with SMTP id
 125-20020a1c0283000000b003928cd3853aso1192832wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 07:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0bfm5h1PBNVBIKlOUTEv2QDkar3XSs2YfbRFWDvobYk=;
 b=vDie8Q22o9vhuPuAF8ZQGjfpnS+QInhJ36m9Qlp0xJzMHJZ1FV+RdTN2eZTlws6f+w
 5taTMNZD+bsiHoXo/Q63g0235y8JAmelsGewVamTpiTDMn6tdnYw2I2SXYZBwx2X1wgk
 0L17xcEUAi3uAA9+1hkQE/XvIjZulCdxw/LWWqgrwjUvfCGgnCeq0Benn776hyToXUMU
 aWdcC1OBnV58GYfEwwTMK2806Xb7Fm6hc+/USn4NLp7cfJj3DsMflb54uzI0p9dpnmqj
 OSoIZUXTrTbRaiJ7h9AROZdpUjgwwZCDvcBltRCxh+VB6j+f99ZOkhQHxy5IFDSSbKNj
 L80g==
X-Gm-Message-State: AOAM530rcEymrVGEEaqJ6tagPSQwpsHJ2CDTIheduOd3U76Fgjxn8rO2
 w3klYGkB0QQ3msv2aseFL7rU/y3i5pmCqUEffWWq2+zHKyDtrrBcY/wNj1e6WCJdG0+bU6hbkFG
 yAHHTtpxxrStv3brB5jDuEgL1iTo8o0J3HYuzYvA1SQ==
X-Received: by 2002:a05:6000:1f09:b0:20a:c427:c7c with SMTP id
 bv9-20020a0560001f0900b0020ac4270c7cmr18187857wrb.337.1650982680093; 
 Tue, 26 Apr 2022 07:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtAUrMnWTRbmK7Qx0YAas5R6NoJQ1P/w8NxcBFdYW8Wq3VDiSAkUB68cbM1Pwbudll5xPJcg==
X-Received: by 2002:a05:6000:1f09:b0:20a:c427:c7c with SMTP id
 bv9-20020a0560001f0900b0020ac4270c7cmr18187840wrb.337.1650982679865; 
 Tue, 26 Apr 2022 07:17:59 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 l3-20020a05600002a300b0020aad7fd63bsm13613932wry.61.2022.04.26.07.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 07:17:59 -0700 (PDT)
Date: Tue, 26 Apr 2022 10:17:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Message-ID: <20220426101640-mutt-send-email-mst@kernel.org>
References: <20220426073656.229-1-xieyongji@bytedance.com>
 <YmeoSuMfsdVxuGlf@kroah.com>
 <CACycT3sLgihkgX5cB6GxDehaTsPn9rqhtWF7G_=J=__oTopJZw@mail.gmail.com>
 <YmfIv2YuARnPe97k@kroah.com>
 <CACycT3sq6WM1uCa+ix79AwTJHaEOhkLycwkZOhqPhABZ4xa2AA@mail.gmail.com>
 <YmfpKGZB06Ix5WPu@kroah.com>
 <CACycT3vD9o+_uLaevCZ=W==YRA_WJP8UJ6czHTtsUny8Rwgd0A@mail.gmail.com>
 <Ymf03l+Ag8ZBSGm2@kroah.com>
 <CACycT3vmN0z=in1hcT7XuW4p-vzq9SAgPJNGGkooc+C+qftWjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3vmN0z=in1hcT7XuW4p-vzq9SAgPJNGGkooc+C+qftWjw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 kernel test robot <oliver.sang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Tue, Apr 26, 2022 at 10:02:02PM +0800, Yongji Xie wrote:
> > This should not be needed, when your module is unloaded, all devices it
> > handled should be properly removed by it.
> >
> 
> I see. But it's not easy to achieve that currently. Maybe we need
> something like DEVICE_NEEDS_RESET support in virtio core.

Not sure what the connection is.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
