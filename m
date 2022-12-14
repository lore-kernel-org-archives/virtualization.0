Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65CAC4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 11:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5969581B17;
	Wed, 14 Dec 2022 11:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5969581B17
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yh97XS+Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id afOGS1dTKINB; Wed, 14 Dec 2022 11:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6BF9818D4;
	Wed, 14 Dec 2022 11:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6BF9818D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77662C0032;
	Wed, 14 Dec 2022 11:58:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5683DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F6926066D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F6926066D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yh97XS+Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dLqMc8o0WDyZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:58:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C343600C4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C343600C4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671019115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Puk59mM8eVDxnAzNFx5aGXWzYXrsqC20wq+ZEPuJ168=;
 b=Yh97XS+YfYNfGPpyo0uPY+U0JXVYwp6yiA/2mD+nwczb++s2OvNjRrq1ldhQwGfPjKDGQw
 k+cHYIGd5e1FFPp6wezHHukyAOXXuG3a9uSegIzN0GM2kGacfGSsR7jkLH0H+nLXhrBHAJ
 SvFn1tW4fGlR5VKcAcG101VsmxMAX6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-IG821mBMPnC5BVTmL0BfGA-1; Wed, 14 Dec 2022 06:58:34 -0500
X-MC-Unique: IG821mBMPnC5BVTmL0BfGA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c126-20020a1c3584000000b003cfffcf7c1aso7136990wma.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 03:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Puk59mM8eVDxnAzNFx5aGXWzYXrsqC20wq+ZEPuJ168=;
 b=DaiebS1DNx6lcXqYYFsJ7OI7uL/KLdkrNcUa+7fI0idHr4Rq4iLSQNr9bsWjY75ECs
 M+9FO0YgrOZUbO6F1TblEd7ASV0QAp7xvc+mefyfE7mHOGPd26wdWCTgwgeTJJZMNXml
 d2jcLORBm/7sdzcxchv90WDlbzD0Gf+oNDzCBPdabO28OR1UfmIxAKE9c73sqb31ynUr
 ZN97GZqeYgPLGwwwGyF0rZ0RzaKCRv3f5ni/R+UMeAcEifKZLrZ4WvSConQiY9p24dJe
 M4vPxpuqaZtEZ8QUMHTg+oMEQjdjbvNTa1PjHwxjvK/MrReL7PaJpcGfiq5jf+jf78+t
 u6KA==
X-Gm-Message-State: ANoB5pkXsgmxzWCRbIHDSVwqa5iDkMHWhiD4pO8MadyCFD8hw9iXye3g
 yCAQTDrNQ128uDKVRytUEB4OZD73fB0zMK4RjymFKA4WpROVMenaziyvua3Vc/xqdpFb/PhBOMW
 mlht4t2SgAv8NmPg6hbDZ/wnxDy2TA/ryBOhDsfT8Iw==
X-Received: by 2002:a5d:526a:0:b0:242:877d:ca63 with SMTP id
 l10-20020a5d526a000000b00242877dca63mr16179194wrc.44.1671019113294; 
 Wed, 14 Dec 2022 03:58:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4HSxAPf40LKD9a4HZ7iVGC/QK8BhMe6SSXxWXIEd+STJY7Pm38ou+bHRi/WjDGVGhtNtqGUg==
X-Received: by 2002:a5d:526a:0:b0:242:877d:ca63 with SMTP id
 l10-20020a5d526a000000b00242877dca63mr16179181wrc.44.1671019113009; 
 Wed, 14 Dec 2022 03:58:33 -0800 (PST)
Received: from redhat.com (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adff882000000b00241d21d4652sm2635751wrp.21.2022.12.14.03.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 03:58:32 -0800 (PST)
Date: Wed, 14 Dec 2022 06:58:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214065417-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
 <Y5mjcuCRP45ynJis@shikoro>
 <20221214105642.3xagckvbbgu5mubl@vireshk-i7>
MIME-Version: 1.0
In-Reply-To: <20221214105642.3xagckvbbgu5mubl@vireshk-i7>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: asowang@redhat.com, Jian Jun Chen <jian.jun.chen@intel.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 Conghui <conghui.chen@intel.com>
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

On Wed, Dec 14, 2022 at 04:26:42PM +0530, Viresh Kumar wrote:
> On 14-12-22, 11:20, Wolfram Sang wrote:
> > Dunno if this is really a rule, but if a maintainer steps out and makes
> > sure there is someone to pick up the work, this is more than welcome.
> > Way better than a stale entry in the MAINTAINERS file.
> 
> Sure, a stale entry is always bad.
> 
> > I mean, it does not limit the chance to have further maintainers, for
> > example. I believe in meritocracy here. Those who do and collaborate,
> > shall get responsibility. If not, then not. We can fix this, too, if
> > needed.
> > 
> > What is the reason for your question?
> 
> It was a general question that I asked myself and didn't know an
> answer to. I wasn't sure if adding someone to be a maintainer here to
> a driver, which they haven't contributed to until now (at least based
> on open source commits), is right or not, since this isn't a stale
> entry in MAINTAINERS anyway.
> 
> An entry as R: would be okay normally IMO, as this makes sure
> interested party is kept aware of the development in the area. An M:
> entry somehow gives a higher level of authority to the person and
> without any prior contributions, it feels tricky at least.
> 
> Anyway, I don't have any objection to the patch at least as it was
> primarily developed by Intel engineers.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

If a maintainer acks a patch I generally expect that the patch is good.
If we have a maintainer who's not familiar with the codebase, this
assumption does not hold.
R: would be ok with me.

> -- 
> viresh

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
