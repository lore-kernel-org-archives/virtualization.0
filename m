Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC18C6379F
	for <virtualization@archiver.kernel.org>; Tue, 21 Feb 2023 13:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5643982D17;
	Tue, 21 Feb 2023 13:40:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5643982D17
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=QS815iKt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57yx47wtuuYv; Tue, 21 Feb 2023 13:40:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB8DF82CFD;
	Tue, 21 Feb 2023 13:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB8DF82CFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9614FC0032;
	Tue, 21 Feb 2023 13:40:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33B50C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 13:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DCE761160
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 13:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DCE761160
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=QS815iKt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vU3noaBsp9Kq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 13:40:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2DB661101
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2DB661101
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 13:40:08 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 z20-20020a17090a8b9400b002372d7f823eso1006705pjn.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Feb 2023 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEYXM4+oHcAGumI0xJQMGPUyilaqpLWqpokDwoNCpZg=;
 b=QS815iKtcOYfULiTMuHFLHjlA8fmfIirKGJGgcdVdUK0tKosuyul5cB7EZ/FBrurri
 oIkZu6z1P74AW4V/l3vDj4kLYwP0uNrX0eRS5XiRmLPS9KfPqTtQ4PLpUAM1RG4tZKMa
 DODYBApDgKXSbezNhFnLpOj258n2sQOJvRnNJ30P1uZXj4RZOFp/PoG4EDmnYDA5tSEU
 33fHFgSUPXqsDVzq3Y6Idjx2ERtsb8qFDfWfHV/Es1PGjcH092WQaxnSREcYo4WJXAGh
 vomDkWWoQ/CE5Wu99+9qMdmrmGpu0yjUiFDKwEMCVfPCMkFjCwIXhaGZZLfmYJ7PKC1B
 mAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEYXM4+oHcAGumI0xJQMGPUyilaqpLWqpokDwoNCpZg=;
 b=eA1HcblEl/c4m6AwABUEfgEpFK7MWKEcS9M9iOI/gE02jnuWBX6forleFCjLTd86tm
 upbb+1ZiN9RXbUrtaha/XHQ0Ua/OUmPw0TGg5wFCkY0uyNFBsM4PLWB+h1rBAPSzSTLf
 fn1Zd+fBKUieEaqsjYyOHvFdyApBEXhEyC5fiCpIcEY2LvMPbQYcR4KvMDi9T9End7Zs
 YrwRb4/BCqzPKWXnUp/nyFXTI92e2QOu3RlIPSL9zaazXGetdWVtuBEprQoT+mGrihIv
 cqpHsEz/IMTZtk+PkDBQbLXdBJ5EoLI7bzRdlciKZzxlASQjSdPkgZgNiZ781auf9kOl
 gdzg==
X-Gm-Message-State: AO0yUKWFSOygb3LJ9AyNDxxJIiYY/jLoSBQSXolzhHA4wD7r4oWT17n7
 oyWnBcP2hAgIJVd9JZ9uyQvZAF0oNLrmF23mq1dYzQ==
X-Google-Smtp-Source: AK7set/ReMS6ZFx7vaUwfqSm9m2t08ArF+D0nk1UAeSPgy8ZukK12KYl9sQ8IXM4xVBs8r6jSi00Vu4gDQtfd1c5oxo=
X-Received: by 2002:a17:90b:3912:b0:233:f53f:95eb with SMTP id
 ob18-20020a17090b391200b00233f53f95ebmr1501347pjb.51.1676986807690; Tue, 21
 Feb 2023 05:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20230217121547.3958716-1-jiri@resnulli.us>
 <20230217072032-mutt-send-email-mst@kernel.org>
 <Y+94418p73aUQyIn@nanopsycho> <20230217083915-mutt-send-email-mst@kernel.org>
 <Y/MwtAGru3yAY7r3@nanopsycho> <20230220074947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230220074947-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 21 Feb 2023 15:39:31 +0200
Message-ID: <CAJs=3_BW+8xL9gvUvUpFwRM_tBVvK3HY5aAQsGboN933_br9Vg@mail.gmail.com>
Subject: Re: [patch net-next] net: virtio_net: implement exact header length
 guest feature
To: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Vitaly Mireyno <vmireyno@marvell.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Hi,

Our device offers this feature bit as well.
I don't have concrete numbers, but this feature will save our device a
few cycles for every GSO packet.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
