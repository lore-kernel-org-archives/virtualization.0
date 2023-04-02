Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D8C76196
	for <virtualization@archiver.kernel.org>; Sun,  2 Apr 2023 12:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1F5E416AA;
	Sun,  2 Apr 2023 12:32:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1F5E416AA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QNsdpB+G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkCP0Y6JtFtA; Sun,  2 Apr 2023 12:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1E9141682;
	Sun,  2 Apr 2023 12:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1E9141682
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E9DAC007E;
	Sun,  2 Apr 2023 12:31:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8DA9C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A243860BFC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A243860BFC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QNsdpB+G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YIXKZ6aHIFGy
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:31:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1062560B1F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1062560B1F
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Apr 2023 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680438712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+cyPian/Vg5b3Cz08zkh/8cSmGP4Giu8pGxwQc/81E=;
 b=QNsdpB+GTesQoOHmGIflaEu+wq8zk3/87qoq6i0SfQQ9K6ppw0HXmN1acpeMWcz2+OXDY3
 PGizoHVCVxVCB0I6OkqqcMcBpL1nqam3BEFJ3zUf56JPDXIfO4ivguCXXYUCkLjB1CzPgj
 y5XoqtzmJlDsQM2Ml1PCSjIU57pjykI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-pOdv-gYHNpS03ldAdjZkhw-1; Sun, 02 Apr 2023 08:31:50 -0400
X-MC-Unique: pOdv-gYHNpS03ldAdjZkhw-1
Received: by mail-wm1-f70.google.com with SMTP id
 o7-20020a05600c4fc700b003edf85f6bb1so14656200wmq.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Apr 2023 05:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680438709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+cyPian/Vg5b3Cz08zkh/8cSmGP4Giu8pGxwQc/81E=;
 b=2X3In1GKHNvsDqY73clReXw3Tb+5pwUWncFlmnYrWcc+s3fRpwEo2u9I+N9GeJhoWV
 fStjwfGaJaSeSm4dU4WPkGfzB4BFWePMOVJLkYM/HK/kpdwLtgchZdDo8wUV/Dc+ZA/N
 z5N/veb6qPkG0P9mAaz/S5T07IwF6e9EFtgUB2pfz4I+CelBgWkZJe8O1f/Qobe5OIkb
 aO82hyGkd5kTM24NVsMxBYUl8a0bRffdrtmdJZZ7mKsvtqoQwmuIGprFtYbvT59LeKHU
 fL8NYcovinQowqYEv9tvL6ie8dc8XCaxLXeseJqaQZgRhb4KLHW55MS3k1o5yO9NCODi
 8GPg==
X-Gm-Message-State: AAQBX9dRyKkWZWEC/pPwpAfjeK3o4zu+NQsJZ86Zq2NozSDc7reRNOw+
 qEDUfzXQZ5qDz1DoNcwUyCmteGohaeuwYd/xWjtmsB2t5cnpGnlToBd0n50vO4sdUqlSYq14rj4
 fhqmclPRYyZ0hfEkOp/ZlwRFH0AOLnpypPEHqp0Ef2w==
X-Received: by 2002:a5d:58f0:0:b0:2e3:99d3:7a5 with SMTP id
 f16-20020a5d58f0000000b002e399d307a5mr11919471wrd.24.1680438709540; 
 Sun, 02 Apr 2023 05:31:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8dBVYrTrnC/pOquIOK6GJ2jGoP7F3J6f9aZ1yCwfY0LHHeVSPb1Rgg1/f7QjmU8PsGTt8NA==
X-Received: by 2002:a5d:58f0:0:b0:2e3:99d3:7a5 with SMTP id
 f16-20020a5d58f0000000b002e399d307a5mr11919462wrd.24.1680438709185; 
 Sun, 02 Apr 2023 05:31:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f9:409e:df7a:e17e:33ee:5358])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a5d4852000000b002c561805a4csm7200822wrs.45.2023.04.02.05.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Apr 2023 05:31:48 -0700 (PDT)
Date: Sun, 2 Apr 2023 08:31:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH 0/2] vdpa/snet: support [s/g]et_vq_state and suspend
Message-ID: <20230402083052-mutt-send-email-mst@kernel.org>
References: <20230320101817.680402-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB47230415F00797EB85F0CD41D48B9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230327083313-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47232709E64E84D002A5CF80D48D9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47232709E64E84D002A5CF80D48D9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
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

On Sun, Apr 02, 2023 at 08:36:20AM +0000, Alvaro Karsz wrote:
> > tagged. in the future pls CC everyone on the cover letter too.
> 
> Ok, thanks.
> 
> I'm not getting responses, should I resend it?


Hmm maybe. Remember to add "PATCH resend" in the subject.
git format-patch has a --subject-prefix for this.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
