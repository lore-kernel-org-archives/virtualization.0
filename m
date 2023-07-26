Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F09C04A94
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 19:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4257240878;
	Wed, 26 Jul 2023 19:28:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4257240878
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bonIRYzF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqu0AOzwoSSD; Wed, 26 Jul 2023 19:28:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B6BB40858;
	Wed, 26 Jul 2023 19:28:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B6BB40858
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62AE8C0072;
	Wed, 26 Jul 2023 19:28:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68AA1C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42A70611F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42A70611F0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bonIRYzF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gukkizpU1Ttd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F264060EEE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F264060EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690399694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBYGyYK0iPA4MuO4cjNy8AeihMzqvoyBhSpsNQnELVQ=;
 b=bonIRYzF5WUuACRIzV+/fqVGuw+G6U0REd7XVjZE8/KXhraxbHe6SNbNWOfX4anFa9ARtC
 206KKrsEl0+UvGh6/2LYYZZEU86jKevpFz4sIJ6v9j0TVkqnQqlDwrfEfvbny6PTJKJ6RJ
 XxqcEOQypzGEYDjagZwqKeVBvoy5QAE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-GmqFVTXnP_iUrcpM5XdDvw-1; Wed, 26 Jul 2023 15:28:12 -0400
X-MC-Unique: GmqFVTXnP_iUrcpM5XdDvw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-97542592eb9so2452366b.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 12:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690399691; x=1691004491;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBYGyYK0iPA4MuO4cjNy8AeihMzqvoyBhSpsNQnELVQ=;
 b=NW5UzWYpFt7/w+s/JsoM4Wfe5SDJ9DodPxdaFUyvnR/ZLZOmU3ybq+bv+hyxbBSme9
 KfoBCXSTABviDIws67iePnLLRcXSmrNHeFrdKrk2zwxfcvgPn0JRJnt+mW//Ks/FXUmj
 m6nY2/HpBXviQIxuXzjmxd+EKUozus12QOiZG2iP8zOLqQfO7Rdfao8JFH4lB/6ZKXVk
 HK+ddbBRR0mRewOwuVKi3bYy9GjR4XMfYVb0RiJhM1pSIt60nPa0vAETEv6xABBCHUFR
 VqKxmU48TkQ9jEcZISWmArGzHAow/dsBL2gxjnPDGnYiSvCVSMmwNksb+vMz1fD3fHNz
 sR3Q==
X-Gm-Message-State: ABy/qLaViU2Erxto74c3KkSpix/z+LT2pf0Cu9LveMC1bBDDrr8SZz71
 D+X7NbPczxDX50wT3XZMLPe5icmAJnS8IljCMHcTvd/FAF5X5ZaNi9TASkVOyyzyc0DsADn0tFG
 XSVcftpU7TJqPv568k6vz53dZcPQuM6FYm6cjin4a5Q==
X-Received: by 2002:a17:906:73d2:b0:977:4b64:f5e8 with SMTP id
 n18-20020a17090673d200b009774b64f5e8mr77236ejl.57.1690399691107; 
 Wed, 26 Jul 2023 12:28:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEB3K6JMck1ac1f464TqyfWgTHbDN5xtNZOdH/v6uERGyDJNp7Z+YZYwiz0Y8OJmkArTNaWxg==
X-Received: by 2002:a17:906:73d2:b0:977:4b64:f5e8 with SMTP id
 n18-20020a17090673d200b009774b64f5e8mr77230ejl.57.1690399690832; 
 Wed, 26 Jul 2023 12:28:10 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 f21-20020a170906049500b0099364d9f0e9sm9932603eja.102.2023.07.26.12.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 12:28:08 -0700 (PDT)
Date: Wed, 26 Jul 2023 15:28:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH 0/2] vdpa: Enable strict validation for netlink ops
Message-ID: <20230726152719-mutt-send-email-mst@kernel.org>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
 <20230726143640-mutt-send-email-mst@kernel.org>
 <8a97e0d439d74373605b00dcaef91108ced9e5ee.camel@nvidia.com>
 <22afb03057250ab8d37ab977cd210719ecf0bcd1.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <22afb03057250ab8d37ab977cd210719ecf0bcd1.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linma@zju.edu.cn" <linma@zju.edu.cn>
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

On Wed, Jul 26, 2023 at 07:23:50PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-07-26 at 20:56 +0200, Dragos Tatulea wrote:
> > On Wed, 2023-07-26 at 14:36 -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 26, 2023 at 09:30:48PM +0300, Dragos Tatulea wrote:
> > > > The original patch from Lin Ma enables the vdpa driver to use valid=
ation
> > > > netlink ops.
> > > > =

> > > > The second patch simply disables the validation skip which is no lo=
nger
> > > > neccesary. Patchset started of from this discussion [0].
> > > > =

> > > > [0]
> > > > https://lore.kernel.org/virtualization/20230726074710-mutt-send-ema=
il-mst@kernel.org/T/#t
> > > =

> > > Cc stable with at least 1/2 ?
> > > =

> > Sent a v2 with stable in cc. But looks like 1/2 breaks the "fix one thi=
ng
> > only"
> > rule due to the many Fixes tags I guess...

I think it's ok.

> Or my lack of understanding: I only now realize that "Cc: stable" is a ta=
g in
> the patch. My bad. Will re-send.

you also need v2 on subject of each patch.

> > > > Dragos Tatulea (1):
> > > > =A0 vdpa: Enable strict validation for netlinks ops
> > > > =

> > > > Lin Ma (1):
> > > > =A0 vdpa: Complement vdpa_nl_policy for nlattr length check
> > > > =

> > > > =A0drivers/vdpa/vdpa.c | 9 +++------
> > > > =A01 file changed, 3 insertions(+), 6 deletions(-)
> > > > =

> > > > -- =

> > > > 2.41.0
> > > =

> > =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
