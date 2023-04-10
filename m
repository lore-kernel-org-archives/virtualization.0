Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648DDC76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 09:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6FF481F57;
	Mon, 10 Apr 2023 09:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6FF481F57
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UorRnd9+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qfby_z2kFEph; Mon, 10 Apr 2023 09:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9AAE681EB5;
	Mon, 10 Apr 2023 09:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AAE681EB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68320C0037;
	Mon, 10 Apr 2023 09:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0656AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7AD74098F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:57:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7AD74098F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UorRnd9+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RXXJwtWPVYxT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:56:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C8A5408BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C8A5408BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681120618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bIev1Ni0k8gVQrBtjaksm0sBj4Jib/zWqJaw/1JzGaY=;
 b=UorRnd9+reM1IPq5mIfk/A3gcMpdDFzyOIjWCk/VMhD4kAyGKCPTkJIjzAHMYNn9VXQSNl
 mH7Y+kE0Mp9pBi5kUIncMO5tscfCfc1MLDNWPVKZSxsP/Tk/oPtDLlr0NvpnA0YudXUimx
 kZQ9CZS6NzB59IZsdseLJuOkc0Jy87E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-91iC-zQTM366oyJSTf3q4A-1; Mon, 10 Apr 2023 05:56:56 -0400
X-MC-Unique: 91iC-zQTM366oyJSTf3q4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 n28-20020adf8b1c000000b002d660153278so546100wra.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 02:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681120614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIev1Ni0k8gVQrBtjaksm0sBj4Jib/zWqJaw/1JzGaY=;
 b=JG03kZHM40fGdpPYINxoKLPe6bzeHUj1kEA+UrNvXmWHN6/SIEIeX/Oc1xCpxK42ne
 x55PsT6gtKLZnKXvghi0UjD5dxLhHHjmh4Un41querHMCep7PtI6djooJ2jWbLWBWm/r
 E0FARY7XMYTMkqOi2SxZ8u1ZoxrnyWzceoI6DIG9usxoeplbTKFg7W3EBU5+JS88Y+9g
 dTEa9LEASq0MMRyxNBu8eyyIpMeqKpJqOivI2qBO1RU52fQnDFkXkMoEv2vlbvzEFPbw
 bgSuFMPHDmLVwu1AlfgPHkPLbcv4LB/B6lbb2xGO7SjKi3/kM8e6MA0SURENg95ginze
 AvZA==
X-Gm-Message-State: AAQBX9cnNzjEZC7TrjZU2xw0vzusdhHqN5lgawJXqgySXpnKOHFL/E10
 yk27VjBjIfh4KInz1NFQSwKWlmvvrdjev/IcOG1axjza62NGluhcAP4eJOXfKP/R/9ahvpONVvT
 Y5+mD9i04MlaLBOfGukgOFuXFqEm3jT0p7MgBv7WeFA==
X-Received: by 2002:a05:600c:4e44:b0:3ed:de03:7f0a with SMTP id
 e4-20020a05600c4e4400b003edde037f0amr6709506wmq.10.1681120614486; 
 Mon, 10 Apr 2023 02:56:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIvGgfLFCNVAdSw6k5gAj7OmN/nORKbwKTw6UxO28aEz4zeHj0RwHxbx+gO7F9M4ln+QKv6w==
X-Received: by 2002:a05:600c:4e44:b0:3ed:de03:7f0a with SMTP id
 e4-20020a05600c4e4400b003edde037f0amr6709497wmq.10.1681120614217; 
 Mon, 10 Apr 2023 02:56:54 -0700 (PDT)
Received: from redhat.com ([2.52.31.213]) by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c210f00b003ee20b4b2dasm13099189wml.46.2023.04.10.02.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 02:56:53 -0700 (PDT)
Date: Mon, 10 Apr 2023 05:56:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230410055634-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
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

On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> > Statically allocated array of pointed to hwmon_channel_info can be made
> > const for safety.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > This depends on hwmon core patch:
> > https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> > 
> > Therefore I propose this should also go via hwmon tree.
> 
> I am not going to apply patches for 10+ subsystems through the hwmon tree.
> This can only result in chaos. The dependent patch is available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

Doesn't it cause build errors or warnings there?

> or wait until after the next commit window to apply this patch.
> 
> Thanks,
> Guenter
> 
> > 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > ---
> >   drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> > index e695e36ff753..65304354b34a 100644
> > --- a/drivers/vdpa/solidrun/snet_hwmon.c
> > +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> > @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
> >   	.read_string = snet_hwmon_read_string
> >   };
> > -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> > +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
> >   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
> >   			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
> >   	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
