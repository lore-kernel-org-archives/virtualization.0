Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F27CC77B61
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 19:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0074261391;
	Mon, 10 Apr 2023 19:16:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0074261391
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMD8wY8f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id beX6bf31Efes; Mon, 10 Apr 2023 19:16:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 52E0260E92;
	Mon, 10 Apr 2023 19:16:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52E0260E92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FF96C0037;
	Mon, 10 Apr 2023 19:16:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F3BAC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35C1D81F37
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35C1D81F37
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jMD8wY8f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57Ibtbbofnja
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:16:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BC3981E5E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BC3981E5E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681154178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sPFo235kyBYgg2fLMT3ZW1ogJR9rn6lHcH28gnhO+so=;
 b=jMD8wY8fFpshfFsuYeq2eFLck9gGpu9C+Va13Hy/iKy3hm0TvDS3yMUoa34P+RrpVz4dKa
 2QOI1ZcJgMaWYRZPZ05dbgdQYdpDJnhITlgE/J3af5HIAscKJX39Y/rr+vnzblXYM7Hq3G
 1ZZpwGoiPNjMuAx04Cm8/4koIRecIoc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-rYGv8gl9OSa13n90HqpUxw-1; Mon, 10 Apr 2023 15:16:18 -0400
X-MC-Unique: rYGv8gl9OSa13n90HqpUxw-1
Received: by mail-wm1-f70.google.com with SMTP id
 k24-20020a05600c1c9800b003ef6ed5f645so240345wms.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681154176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPFo235kyBYgg2fLMT3ZW1ogJR9rn6lHcH28gnhO+so=;
 b=Gld1k2ecotO7kFMv+AgvRJ12De8imVmdhub9eLzjBHog81ir0nRNuP7MgyxyCwoEvk
 BtholdJ41NzehhotP8Tl5U8Ej8NF7tDINmbyS0AJ2hElX8zx7EPZbNyRMfXvnTIcswbD
 jLA3pJbtp1o3w9D/0YMzmTLq6LPRnpcsCQWKI5evvMoBtzoLLBalvOxSn0e0SdDP3cwV
 0gdJ51B/9OUYsVkerr/V2imrYbkAbIaT/ZovivY6dReDaaIsOK0LUZzig5os4ZfpFeLi
 raH2SMHhHOusuBwpBAiNpDAIQO4g0s1BMBMuWgPEKy104oX+3fTS/ujzY7kgXG6gvxG4
 xdzA==
X-Gm-Message-State: AAQBX9cYHV6uB0IUDkDIobPbiCZwJfyCdNi6vLqyd2yl+I9WtVCgMtuA
 pbzr07uW03kTztYRWeVSlURy/3c4h3S2nuLvzgfA4XIocxZXulwGzstO75X5o+saXVsOWLF8t7f
 UvtF1+VNKcnQW9HUPCp6sZ9AEeUwojZSxtxmH9feaDw==
X-Received: by 2002:a7b:cd10:0:b0:3e2:19b0:887d with SMTP id
 f16-20020a7bcd10000000b003e219b0887dmr7974057wmj.25.1681154176078; 
 Mon, 10 Apr 2023 12:16:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yj4C6u1lvqj5x8nYc4rUtnI/cLoYn4IqOCfzJdLFCUYWU4OgKl1a1UOtM9Oz4tcJga59u2Qw==
X-Received: by 2002:a7b:cd10:0:b0:3e2:19b0:887d with SMTP id
 f16-20020a7bcd10000000b003e219b0887dmr7974048wmj.25.1681154175783; 
 Mon, 10 Apr 2023 12:16:15 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b003ede04deb14sm18677422wmq.48.2023.04.10.12.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 12:16:15 -0700 (PDT)
Date: Mon, 10 Apr 2023 15:16:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230410151532-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
 <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Mon, Apr 10, 2023 at 07:03:01AM -0700, Guenter Roeck wrote:
> On 4/10/23 02:56, Michael S. Tsirkin wrote:
> > On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
> > > On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> > > > Statically allocated array of pointed to hwmon_channel_info can be made
> > > > const for safety.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > 
> > > > ---
> > > > 
> > > > This depends on hwmon core patch:
> > > > https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> > > > 
> > > > Therefore I propose this should also go via hwmon tree.
> > > 
> > > I am not going to apply patches for 10+ subsystems through the hwmon tree.
> > > This can only result in chaos. The dependent patch is available at
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> > 
> > Doesn't it cause build errors or warnings there?
> > 
> 
> Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
> on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
> I have not seen any such reports, and I don't immediately see why that would be
> the case. Please elaborate.
> 
> Guenter


I'm not saying that, I just assumed the vdpa patch fixes build.
If build is ok we can just wait for hwmon patch to get upstream. No
rush.

> > > or wait until after the next commit window to apply this patch.
> > > 
> > > Thanks,
> > > Guenter
> > > 
> > > > 
> > > > Cc: Jean Delvare <jdelvare@suse.com>
> > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > Cc: linux-hwmon@vger.kernel.org
> > > > ---
> > > >    drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> > > > index e695e36ff753..65304354b34a 100644
> > > > --- a/drivers/vdpa/solidrun/snet_hwmon.c
> > > > +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> > > > @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
> > > >    	.read_string = snet_hwmon_read_string
> > > >    };
> > > > -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> > > > +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
> > > >    	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
> > > >    			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
> > > >    	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
