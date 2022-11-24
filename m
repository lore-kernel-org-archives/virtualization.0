Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF405C433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 22:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41CB341188;
	Thu, 24 Nov 2022 22:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41CB341188
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=yKiWgOET
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p_9L6YTuYC3Y; Thu, 24 Nov 2022 22:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F330F41181;
	Thu, 24 Nov 2022 22:10:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F330F41181
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F708C0033;
	Thu, 24 Nov 2022 22:10:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B34BDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 811D781EA4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:10:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 811D781EA4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=yKiWgOET
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DeavayVasuiI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:10:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6BF381E88
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6BF381E88
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 22:10:23 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-14263779059so3259308fac.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 14:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tJriy8T+Dp7numAP/PAb8otpZwa4UoEnYrg7T64Mug4=;
 b=yKiWgOETSH1m8eLZVCRcLVDq+5s5yG+mrYIlxYoHHSSPqoYYTBRVaJME2X7Il7xDjs
 ElCqVE8ICX5VTGL8u0gm05TGwt0Tc0PDAl4W00a05qweUSlg7Rd7/FROEHlSnCKYZhGR
 vLUokMAo+ujVVmyp9M0lN8pJYzHEFmOdE9P+CMnFyytjCj5jaaZttp+FDq1qyCJ2lXER
 uCPYfW2SFXwODdu7YXrlTainRoVznLxIaTwCSBQq00imsudJFp90zCFQ4prLOw44F+ZE
 bNsXinea/FAlXwnvIpYO/DXvrYVLUGnAFwzHXoYp+IRV8YWcdO+FQgrUNohZYnS8y1O4
 yyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tJriy8T+Dp7numAP/PAb8otpZwa4UoEnYrg7T64Mug4=;
 b=ln6JmTWi8WrkbXqLS89a+HArj8BIP52BPL9EUhq5KxywuEXPVhJZcGUU80HOVRdR2Z
 2QIxg1iEvbXbPzgq9l57AbjTXnd1A+ffIX6k2UAme+YP27O9wkQtNRM+amCp3WXvKV+D
 yVrKEytzEvfwBW+m1FgtBFes9WcalS/qovFoYjG5pLZa029Jw8bwI78p7DztpBH3mF6x
 30u90y1Eel0tPNVB8pOQTShE3DIuCG0X5AdhMe15SdolH2z+t3uiaf2gz2E26A76RnP9
 KLk2CDPaBl7fFMoiX8KnJejm6ZjnjtkUIC3Yq3hB0/xQ6t2XF6RPnyYXsJnKyjyiyW0B
 eQJw==
X-Gm-Message-State: ANoB5pkPFYXu2xdRVfN4nKndeE8muaTcMcd9bdhm4uiwBbBwyxqzolWE
 gR4R6leiQyDtZYnwboTanO+bah6Q+KKz7zB5MNIisA==
X-Google-Smtp-Source: AA0mqf7zbgep0ICXwSX2uwG8tNely6nY8t6LUi/MZM/uB7FilOkvTN+fCYOKURf7M2NvUtlfXZ3UWNEV2L30E+VfWs4=
X-Received: by 2002:a05:6870:6707:b0:141:aba2:f9c4 with SMTP id
 gb7-20020a056870670700b00141aba2f9c4mr9638090oab.273.1669327822902; Thu, 24
 Nov 2022 14:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
In-Reply-To: <Y3/WXWoV1jcJnohR@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Fri, 25 Nov 2022 00:09:45 +0200
Message-ID: <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

> I suggest defining a separate UAPI struct for this ioctl.

Sounds fine to me.
I could use the following struct

struct virtio_blk_lifetime_ioctl {
        u16 pre_eol_info;
        u16 device_lifetime_est_typ_a;
        u16 device_lifetime_est_typ_b;
        u16 padding;
};
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
