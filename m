Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00486C76196
	for <virtualization@archiver.kernel.org>; Mon, 10 Apr 2023 19:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 874A760F2E;
	Mon, 10 Apr 2023 19:14:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 874A760F2E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P/F8ehYu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gU0_PSkqKt1h; Mon, 10 Apr 2023 19:14:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA6A460E92;
	Mon, 10 Apr 2023 19:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA6A460E92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B23B7C0037;
	Mon, 10 Apr 2023 19:14:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 262CEC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 010DC81E48
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:14:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 010DC81E48
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P/F8ehYu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r8jD5ASXGLn5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:14:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 987BF81E44
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 987BF81E44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681154071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V929y0DuvK7xtChWhUBw/eFqjVuZ3zFTuJadDMK7r9I=;
 b=P/F8ehYuVXRwObVrKbBbr3dH1EXhyKwBNPktBGkwtXLJtwgfXidlqEPvKFBfgIdtLbW/Eb
 GXl8EHfVzPwrbb/hMtY+ZOu4dGQjtn8V5FToeLqh68mMDySUfys85sMPs9BUhP/3k9AbIh
 CaBXucsMT7mehQcErbBjEHpNodqh8MU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-XEdCmjcUPLKyL0066fVu5w-1; Mon, 10 Apr 2023 15:14:30 -0400
X-MC-Unique: XEdCmjcUPLKyL0066fVu5w-1
Received: by mail-wm1-f69.google.com with SMTP id
 t8-20020a05600c450800b003ee6dbceb81so1050824wmo.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 12:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681154069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V929y0DuvK7xtChWhUBw/eFqjVuZ3zFTuJadDMK7r9I=;
 b=GzdUusp9Nr62a7oIIYt3wv1CqqJ4CLq1qNG+J8xC0G14RFp6CmsC2KYr3ePAyhv5sU
 k5LfuSSAVmm9vHMGoI6zM50rcJvmOd0vDhY7WOLpNc/WGNwYnE94izxsAWEByJziaHTw
 omgdJ7Wx2ZfFcMLmgqUfuFhXQTbfau/khVSTLtP8uYGJV1+MMs4CoacQjTQISDVMqUW9
 DAr7fr16vK5JxR6DnL7Nh8w1RT7bU+ClVPWRGE3mjwxHBGffjKvVndUeXboUDn/GGQaX
 SYZIoFa0nbpstsQjq4kqXL/SEY0zLBqQXaqRe8rrmB1wIVIUWqE395q+dp2rgT728b2X
 t3Cg==
X-Gm-Message-State: AAQBX9eaEu9fVFMqJbKfQb2wToqqf7EnXdce9kClFPBRuZdYacEuagi0
 HVO/QCNsp54yyt0lfi0TySCqTF72CelF4rDshAgqlunSIJ5OrjryDIq2x1fmdVqbzXeoP1oGdVi
 XWxWYjsUmBLtHy1I+oFSXMrC8bnHyuCJyOZUMk3qA6g==
X-Received: by 2002:a5d:494c:0:b0:2c7:6bb:fb7a with SMTP id
 r12-20020a5d494c000000b002c706bbfb7amr6847043wrs.54.1681154069154; 
 Mon, 10 Apr 2023 12:14:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZB01v4hRzyu7pDWRWnh2OLlh5MZFbKYbk/7NuN3PZ2CE4+XympLGJoeAWb/QCYhp3Tn3l29w==
X-Received: by 2002:a5d:494c:0:b0:2c7:6bb:fb7a with SMTP id
 r12-20020a5d494c000000b002c706bbfb7amr6847028wrs.54.1681154068798; 
 Mon, 10 Apr 2023 12:14:28 -0700 (PDT)
Received: from redhat.com ([2.52.10.80]) by smtp.gmail.com with ESMTPSA id
 e10-20020adfdbca000000b002ceac2ccc4asm12473201wrj.23.2023.04.10.12.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Apr 2023 12:14:28 -0700 (PDT)
Date: Mon, 10 Apr 2023 15:14:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230410151317-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
 <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
 <a6e07080-0c0d-0461-52a2-768d60af53c3@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a6e07080-0c0d-0461-52a2-768d60af53c3@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Guenter Roeck <linux@roeck-us.net>
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

On Mon, Apr 10, 2023 at 06:48:12PM +0200, Krzysztof Kozlowski wrote:
> On 10/04/2023 16:03, Guenter Roeck wrote:
> > On 4/10/23 02:56, Michael S. Tsirkin wrote:
> >> On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
> >>> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> >>>> Statically allocated array of pointed to hwmon_channel_info can be made
> >>>> const for safety.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>
> >>>> ---
> >>>>
> >>>> This depends on hwmon core patch:
> >>>> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> >>>>
> >>>> Therefore I propose this should also go via hwmon tree.
> >>>
> >>> I am not going to apply patches for 10+ subsystems through the hwmon tree.
> >>> This can only result in chaos. The dependent patch is available at
> >>>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> >>
> >> Doesn't it cause build errors or warnings there?
> >>
> > 
> > Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
> > on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
> > I have not seen any such reports, and I don't immediately see why that would be
> > the case. Please elaborate.
> 
> My tree and patches are extensively tested by kbuild and there was no
> warning reported (when the above patch is applied with above dependency).
> 
> Best regards,
> Krzysztof

I don't know, I assumed the vdpa patch fixes build. If not,
I think we can just wait with the vdpa patch until after
the hwmon one is upstream.

Thanks!


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
