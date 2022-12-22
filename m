Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B17BC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 06:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 130EF40459;
	Thu, 22 Dec 2022 06:44:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 130EF40459
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=UtaOxFFL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sE0mIT_CfJjh; Thu, 22 Dec 2022 06:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD12140153;
	Thu, 22 Dec 2022 06:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD12140153
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81639C0071;
	Thu, 22 Dec 2022 06:44:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECE11C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1CC2403BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1CC2403BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8S6gwLqwzR8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:44:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 785C340153
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 785C340153
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 06:44:51 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id w37so731038pga.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=086dsIWiKVuDdE5qHTcupmnKCG4y2yzrnr4Huev2NRw=;
 b=UtaOxFFLchWt5Jb/3Qqzm81/vYaqvIO89JpWehCUn/CUHFGzoM5mnpGGBFlYqQAoGd
 HNaC4hz9Wsd4cdrkLx4Nc3B37RZeAXNTTbWL+/LYmA84syobG+0riP0NUwuuMOLk0vM9
 31gmckA5xEiwm+8UXywQe5qkGm3622bwgeIVe534hNeHlbnrHCysSoCqhjwrJwPlkRNH
 xmSbqkhkZGSyFCxhD8DJcIVlOqa5aOvOkcRUxPZKzzjMp46TLQ3zogc3AjHVRg2Hd/hE
 u7zVrjzMsbBqYzgul0riADWu8PTfE+0rGq7xHVnf0NatXFT2v3uTvvZPalPduYNE26Vg
 GhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=086dsIWiKVuDdE5qHTcupmnKCG4y2yzrnr4Huev2NRw=;
 b=XoidwTpxG8yIf0YlOnBMyyBUsktyG4+FiPrXAQisJBQdKPBoXkkpDYOLv14n7xjm9T
 gxkN4AwPANpoqWVLZ7e1fG03wZZ+DkBMTfmPAYUtqYo7shBbSCh+Wose9kqCSoHir2Gs
 0aK+SIxBBixyuNYQlPHP2qBKvafVZYbOIMu0xME5Z3Ytej19sGqmcMuMwA3M9Rcu78bV
 eSQ2s1EHK/q4xgTwT2VeD3gN7jPDNggqAWXyiFEIwRxb5cVPOAzws6Fjj6cTbL1KrxHz
 I6ba4WwQYJTqlCEtBALwnDpWLSLEeOCrw2X7CqkbeExf2axc+1LJ+gQA0WpC/Is6CO26
 hW7g==
X-Gm-Message-State: AFqh2kpAwokHPETknMNhgwdF6KmLnDYDzwuTWfeieVhT7b3r28+5zmwd
 kmXrzqGJwHPp1YlQYJ9rheW+UIdkBfK/EItV5lG+MA==
X-Google-Smtp-Source: AMrXdXt0UcjoP66yyusLKIKTSX4FRsTvLnD0LVdmB5/Zjm2T6SMC5OAPDw1o6lqRfglsrE+itHgRlexlQR8eCOjBmiM=
X-Received: by 2002:a65:45c8:0:b0:48c:5903:2f5b with SMTP id
 m8-20020a6545c8000000b0048c59032f5bmr224962pgr.504.1671691490591; Wed, 21 Dec
 2022 22:44:50 -0800 (PST)
MIME-Version: 1.0
References: <20221222060427.21626-1-jasowang@redhat.com>
 <20221222060427.21626-5-jasowang@redhat.com>
In-Reply-To: <20221222060427.21626-5-jasowang@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 22 Dec 2022 08:44:12 +0200
Message-ID: <CAJs=3_D6sug80Bb9tnAw5T0_NaL_b=u8ZMcwZtd-dy+AH_yqzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

Hi Jason,

Adding timeout to the cvq is a great idea IMO.

> -       /* Spin for a response, the kick causes an ioport write, trapping
> -        * into the hypervisor, so the request should be handled immediately.
> -        */
> -       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq))
> -               cpu_relax();
> +       virtqueue_wait_for_used(vi->cvq, &tmp);

Do you think that we should continue like nothing happened in case of a timeout?
Shouldn't we reset the device?
What happens if a device completes the control command after timeout?

Thanks

Alvaro
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
