Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BFC433E6
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 15:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A6C64E20
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 15:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A6C64E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77B436060C;
	Tue, 23 Feb 2021 15:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iJUGVcaDDj2t; Tue, 23 Feb 2021 15:53:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4B7860619;
	Tue, 23 Feb 2021 15:53:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76788C000A;
	Tue, 23 Feb 2021 15:53:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27DF1C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 15:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2305C86FCB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 15:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lLmT6mcVIbYA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 15:53:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4DF1386F80
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614095595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgJGcqcFSPJ5vSkmpHDztihIciEdSayUVtjWq3dkQvU=;
 b=PSDnJYW8Qox1wOpXWVxHGhFaLt8mc9SMuBGz+enn4OSUMyZtRlzeLxGziP6ji533eWjDAz
 hy8NGHndf8T2Xba63TNF2FKEpbBycm4K4pIFaRaD7wopvcZBZjtkzc3M6VcSspQOZRrcvv
 4ZQZdUQUJbh7yEBBwvSN/JB5Je9vdVo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-S3Byz15RMpChJkhPFYYS1w-1; Tue, 23 Feb 2021 10:53:07 -0500
X-MC-Unique: S3Byz15RMpChJkhPFYYS1w-1
Received: by mail-wr1-f71.google.com with SMTP id q5so7500984wrs.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 07:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=TgJGcqcFSPJ5vSkmpHDztihIciEdSayUVtjWq3dkQvU=;
 b=hT7ca9cnkP3ihyNVGj7iLlvtD54h4aGunaxGvihGFNZO1NRtJviavvFw45o9FV5ISd
 qDDEfTs5DX0lCKF77DJOn4EM45O3ikxQqdXVJjOVFn+cvHLk/anbNsB8B6HMiuJS15YB
 zaLennydrz7bnTbn9/PCDYODbu+060T6lQ2QktALU2qApYj+TRQ+uRL4YJw0gKiXLU1H
 2UvwdYNQ9tu/9drZUSM9lIFGl96Ibc0OhUAFBmXvrFxpV/+6FQ0VvZTFjMSlGB93Sa1b
 hURZxkoKEs2x5XyVRe6SfOTaUgubjX9duUHl1VtzoH70hGZg8qe6TSozkNlezNiqRB65
 ZmXQ==
X-Gm-Message-State: AOAM531dfVWy6SSHhRvpiZzDANuIGZWw9Wx33qAFLgom7axZgfCEqpP4
 t0royFjWAXx+8UewBdLU0CLL7MWjnqx8KDS1KE1Jp1sKAYR5GVbfxyjhUFbzmb/lzdCuW+W7TUw
 /UM2KkTOCxVsGZCEaToXGK9CwlHq00YJQf98/ObV1CA==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr26096863wma.135.1614095586690; 
 Tue, 23 Feb 2021 07:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydM5phjkLB5zeQ0CabZfvHx0EcHMjVL6rvsg+VYExkMFngHWiwDIFnl51krSfVPzO/nS3Cgw==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr26096842wma.135.1614095586566; 
 Tue, 23 Feb 2021 07:53:06 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id g18sm3217030wmh.17.2021.02.23.07.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 07:53:05 -0800 (PST)
Date: Tue, 23 Feb 2021 10:53:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Subject: Re: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Message-ID: <20210223105232-mutt-send-email-mst@kernel.org>
References: <20210223061905.422659-1-jasowang@redhat.com>
 <20210223061905.422659-2-jasowang@redhat.com>
 <533886b3-9979-7a51-5b44-eeefad242cdf@roeck-us.net>
 <CAEUSe7-g=O_=G1fzjLwjQH1taj0YZYKt=874mUxcM-qGv51+9g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEUSe7-g=O_=G1fzjLwjQH1taj0YZYKt=874mUxcM-qGv51+9g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, Anders Roxell <anders.roxell@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Guenter Roeck <linux@roeck-us.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 23, 2021 at 09:50:35AM -0600, Daniel D=EDaz wrote:
> Hello!
> =

> If I may add to the nit-picking...
> =

> On Tue, 23 Feb 2021 at 09:23, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 2/22/21 10:19 PM, Jason Wang wrote:
> > > We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> > > lot of confusion. E.g it may break various default configs which want
> > > virtio devices.
> > >
> > > So this patch fixes this by hiding the prompot and documenting the
> =

> *prompt
> =

> Greetings!
> =

> Daniel D=EDaz
> daniel.diaz@linaro.org

I have just folded this patch into the one it's fixing,
so the commit log doesn't matter. Thanks everyone!

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
