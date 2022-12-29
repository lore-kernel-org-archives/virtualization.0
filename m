Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D367BC4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 13:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75059818D7;
	Thu, 29 Dec 2022 13:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75059818D7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=SdYoAARI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fix1eM0n_zmx; Thu, 29 Dec 2022 13:35:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 09B6B80D9D;
	Thu, 29 Dec 2022 13:35:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09B6B80D9D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D09B1C0033;
	Thu, 29 Dec 2022 13:35:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B181CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 797BE8124A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:35:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 797BE8124A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lOV97tQHRVn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:35:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8B4580D9D
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8B4580D9D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 13:35:30 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 h7-20020a17090aa88700b00225f3e4c992so10315933pjq.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=twz7FZSW1M52TEDcTj6zYsmniSLychme6Tu3/KhXk5I=;
 b=SdYoAARIrWkLF/qzjmfbm8I4WTCpCbbqthO6xWussbpZGOhJLgm9abKphnpNjKyRwP
 2nQZIySqv2tJrltx5MUZHD/l2u6w+5/SYmNitfNQUZhBXnnYUrs1wuRy/EY6UIjq1wY0
 wsqEMJA5e1lP74xw+DTgPUfXr+EUu7bIjSShUtXIfRcxfKy1pmFHBZzEl8bE1LU7cGyI
 IOJX6Ki/BglSbGIVUJ8szRQctmRfZNeew4GDRl5xVkWZebWicINtQzgsBr7f8fIfBqao
 t1qJtYn7DlUI7o6GAV86DdXt3MTQHSFpPHhXszJiLHNx9+PZjT7C+cCQm5+VfE0y4beK
 YSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twz7FZSW1M52TEDcTj6zYsmniSLychme6Tu3/KhXk5I=;
 b=wtNDC9pfFVlwm1B0HupC7y5B5tgrlpksHf7dmeX3sYryKKAUbd2XRQXI8NbLn7RJTE
 NZvvv1+n8uykxLvKIAPGDi6t3CL5YAFx9943UY9XIn/wcZk3TE+a+G3bje7ZcTyXOPC6
 vseXpul4Ezzbjc9SAmsT7OzNpWNTerWfAl53FWr042BFPg5badx8SL8J797fvtnpeO3d
 Ydp/5SlQD2y2z4hUSPJcKCWCgEotsfGYnlS4FvNUxXKl6uYdomRmHZ2kby8rcPi1Lj/c
 6JDpsqHlq9qbLXlOHNg+tz1Giosd21rZlIJ2v6vU2hyeZco7daZx4erXFbn1i/uLOTld
 PIhg==
X-Gm-Message-State: AFqh2koTvssngx88yOJbjzeIXq5eccjOuU95HPZatFB47hATm9zFP49m
 RkEVFsM2jbAyRXqesMX9/duAtLGRs/4fn7FbKm7uAw==
X-Google-Smtp-Source: AMrXdXt9BYQjseJAtyZXulgatorjwG5qWHt5Fg/d4CGBXKRF7OalLzvNtX6vSXJKVP2MKdjcDuRZOsBYRFTV32aS7Kk=
X-Received: by 2002:a17:90b:d13:b0:226:201a:fdbc with SMTP id
 n19-20020a17090b0d1300b00226201afdbcmr327360pjz.13.1672320930121; Thu, 29 Dec
 2022 05:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
 <CACGkMEtpYomDhJ+oKhXROA8NPMwWKvLfK2TQRZ30g=o_vW8cQw@mail.gmail.com>
 <CAJs=3_C7dGxs6jZjgOGK=gfL-aJh+GJKr5KPE3Q645621mxcWQ@mail.gmail.com>
 <20221229083155-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221229083155-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 29 Dec 2022 15:34:52 +0200
Message-ID: <CAJs=3_BRczfcHCpvV-j3xFM50FUy_c9YOZzYUuXOctUKrXznXQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: explain the dependency of SNET_VDPA on HWMON
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
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

> It's ok. I had to push everything out to next merge window
> though. Sorry :(

Don't worry about it :)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
