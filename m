Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE47DC46467
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 09:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4983981000;
	Tue, 29 Nov 2022 09:13:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4983981000
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=resnulli-us.20210112.gappssmtp.com header.i=@resnulli-us.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=J7yjw9sX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3YOJ3xXZJQVJ; Tue, 29 Nov 2022 09:13:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08F9881253;
	Tue, 29 Nov 2022 09:13:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08F9881253
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5DF6C0033;
	Tue, 29 Nov 2022 09:13:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C85CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2474C81253
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:13:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2474C81253
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QSnO698lQr3m
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:13:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2742C81000
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2742C81000
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:13:37 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id x2so18909167edd.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 01:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20210112.gappssmtp.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zm9HqCcqV4Dc0cSiKD6aK7hsPan9Fp9lKsI9qTmKRFo=;
 b=J7yjw9sX36UxGxmYw6J6YGmmd23lrXJd+rxYAlk/qp/nRkWqD1daIKOd0KY+KoJwiS
 56JVBv1JgvwGUkypEs+fiC8JdcoIDskYDHjAXUOVu1fl30On+vmq0SrGFl8avkIk10LQ
 W/rWzVzxZvSV1Aon8LV/TKyzq8wuGNPO0fLVzs3yIweVSay1Qu0yuaYsYNCKnb5Wfznn
 mCUzS/H7kXFr39zmcsBPrfcI7sOMmkEmpL5B8VyXikvJOdr2wPPB6XzGrynk86BVGBsq
 k9xTm1n2FaTTLzX6DwufXxlexOfP/EZpXaeYzMSRkvd7K4al6CBqWZcKe9UP+oglFilL
 0UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zm9HqCcqV4Dc0cSiKD6aK7hsPan9Fp9lKsI9qTmKRFo=;
 b=MYIwEJCcTxsJQYpVzbNc/2BJASxRcnUZo8TVuF/+UdtBwyeFRb5K1TlQhsVQlk7pWU
 h7GiNVzNJH3iYI3iFZz3tZ1Qd1m/ppCMqDflvP87Rr4lTm5MFuhWo404PVeINAhWJWTO
 rM4ucuqi5PqSBL96lz+JDV8biECJJNgst6Ut6tXj6+qSZyxBY2oLTHn2RGYizE8Y5yBV
 e4Qa7nHBnGI0OTtk03DLSEH6U51EIUOy2Kg3ph1UMCzArPp5Qf3GStfuxzk8bNPoTxFV
 Elbu9l+w7RiZlQuSYfZ6LI5yuL5S37S+IJMRm0zstw6RyjhZSOukJvtGKq3FjR7jBrJ4
 upRw==
X-Gm-Message-State: ANoB5pmpkLSvBc2JHLm0eOYO0cNwsRlft3EHiApEiFTt/yCkuPqD4fn3
 rSY8WwuRepCx/b0TQIIGs+6ZQQ==
X-Google-Smtp-Source: AA0mqf5yJnVC8Zc01rktsWBuaK+b+xSIG973AWQKsMM2AjYT+sdkNhxPDpfsCf1yXXosDVjwyZoXyw==
X-Received: by 2002:a50:ee96:0:b0:469:d815:6b09 with SMTP id
 f22-20020a50ee96000000b00469d8156b09mr33202156edr.288.1669713215837; 
 Tue, 29 Nov 2022 01:13:35 -0800 (PST)
Received: from localhost ([86.61.181.4]) by smtp.gmail.com with ESMTPSA id
 y12-20020a056402358c00b0046ac460da13sm4702121edc.53.2022.11.29.01.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Nov 2022 01:13:35 -0800 (PST)
Date: Tue, 29 Nov 2022 10:13:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC PATCH net-next 10/19] pds_core: devlink params for enabling
 VIF support
Message-ID: <Y4XNPtIVgkWsbA79@nanopsycho>
References: <20221118225656.48309-1-snelson@pensando.io>
 <20221118225656.48309-11-snelson@pensando.io>
 <20221128102953.2a61e246@kernel.org>
 <f7457718-cff6-e5e1-242e-89b0e118ec3f@amd.com>
 <Y4U8wIXSM2kESQIr@lunn.ch>
 <43eebffe-7ac1-6311-6973-c7a53935e42d@amd.com>
 <Y4VEZj7KQG+zSjlh@lunn.ch> <20221128153922.2e94958a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128153922.2e94958a@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Shannon Nelson <shnelson@amd.com>,
 mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io,
 Shannon Nelson <snelson@pensando.io>, davem@davemloft.net
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

Tue, Nov 29, 2022 at 12:39:22AM CET, kuba@kernel.org wrote:
>On Tue, 29 Nov 2022 00:29:42 +0100 Andrew Lunn wrote:
>> > How about:
>> > 	DEVLINK_PARAM_GENERIC_ID_ENABLE_LIVE_MIGRATION  
>> 
>> Much better.
>
>+1, although I care much less about the define name which is stupidly
>long anyway and more about the actual value that the user will see

We have patches that introduce live migration as a generic port function
capability bit. It is an attribute of the function.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
