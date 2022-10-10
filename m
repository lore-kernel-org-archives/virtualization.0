Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61963C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C34F54088A;
	Mon, 10 Oct 2022 17:11:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C34F54088A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbpjDQ9T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Irz-NmNwp24S; Mon, 10 Oct 2022 17:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CFE1A40860;
	Mon, 10 Oct 2022 17:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFE1A40860
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 999C9C0033;
	Mon, 10 Oct 2022 17:11:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98181C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FF8360C15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FF8360C15
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbpjDQ9T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f-mij-LL-zxa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6127860736
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6127860736
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665421870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9NfgzGmgVHxFqR0Y0j+fAt5NS/eJLSM6XJubr6jJOw=;
 b=YbpjDQ9TUYiDWT0Htzu5gHxr7op2G7ioOMp7tehlEU413AIgArtjJucSprApneJdITsKz+
 knD5NNOSMGsU5lyicWEj3fRuWAs+eJCgdNaiSCEBUfgeDNBs0ldDqAJlXrTDAI1gD35oAA
 8vpWiEkLvUCzprPv9Cd5voq/PdlAbw8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-xX4O4hPiNWK-pBFGNWBoFA-1; Mon, 10 Oct 2022 13:11:08 -0400
X-MC-Unique: xX4O4hPiNWK-pBFGNWBoFA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c5-20020a1c3505000000b003c56da8e894so3096031wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 10:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P9NfgzGmgVHxFqR0Y0j+fAt5NS/eJLSM6XJubr6jJOw=;
 b=DmcnAqobf/OtgM529PpdXAas9gbJHfRwjy+hPzJZYI7k69B3IxxgPwDyZjQYUzPq+C
 lG0jgOheJeeTWiIOzhsKpfPhi1e6N0+KV7tze3JSdX/OzOc90CUFLc0TFzzNrvWeKpz6
 fKkbUESEaCZLwBrbgww4xhc/+E5f4FfgyRjJeCtz/NHonQp49aQ0He9u/dx8F4ZeBGe8
 LdSQEX62HtBN6KrlC1mc59vAw7Nq1RItHvZyy4Qz6/VQPpSGQCjV6UnQCWE3jWkfk9pg
 SOjD0OTtkDI/0wVHsCAc2Qj8KAKycF2qk48HzI9hIbnr36qYmZnvZSdHBK3I70RDwd64
 DArQ==
X-Gm-Message-State: ACrzQf2sNuG3e29vPC7L3K/6wxyS0Ss4e54OvCR7Lc/8MmLRPOYUBwc1
 3FYFc59DfR+am7ju+rA0eLACOkslo1+V7oN3P6oIa64q+zMumt5jP3uTs5fiCsmDXXv0msxBMr1
 GLmpZbnCC2Vr+q2rxaO7xdwWSlzyYERc97sOloKQJSw==
X-Received: by 2002:a05:600c:3d86:b0:3b4:b65f:a393 with SMTP id
 bi6-20020a05600c3d8600b003b4b65fa393mr13839072wmb.0.1665421867816; 
 Mon, 10 Oct 2022 10:11:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4paSlcEHu77wmfd4kPloL/5aD3D2LVHIS6yHrVgvgOo7XBb0n0lXt/WK+JV+UeHSyU/3B+oA==
X-Received: by 2002:a05:600c:3d86:b0:3b4:b65f:a393 with SMTP id
 bi6-20020a05600c3d8600b003b4b65fa393mr13839044wmb.0.1665421867568; 
 Mon, 10 Oct 2022 10:11:07 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 u16-20020adfdd50000000b002238ea5750csm11814353wrm.72.2022.10.10.10.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 10:11:07 -0700 (PDT)
Date: Mon, 10 Oct 2022 13:11:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RESEND PATCH v5 1/1] docs: driver-api: virtio: virtio on Linux
Message-ID: <20221010130951-mutt-send-email-mst@kernel.org>
References: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
 <20221010064359.1324353-2-ricardo.canuelo@collabora.com>
 <Y0QYTq7KW9C731s0@debian.me> <877d17n699.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <877d17n699.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, kernel@collabora.com
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Oct 10, 2022 at 03:43:46PM +0200, Cornelia Huck wrote:
> On Mon, Oct 10 2022, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> =

> > On Mon, Oct 10, 2022 at 08:43:59AM +0200, Ricardo Ca=F1uelo wrote:
> >> +
> >> +References
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +_`[1]` Virtio Spec v1.2:
> >> +https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html
> >> +
> >> +Check for later versions of the spec as well.
> >> +
> >
> > The version checking should be made comment (not visible on the output):
> >
> > ---- >8 ----
> > diff --git a/Documentation/driver-api/virtio/virtio.rst b/Documentation=
/driver-api/virtio/virtio.rst
> > index 70b3aa6bcf5518..4f3abbec4e8b2c 100644
> > --- a/Documentation/driver-api/virtio/virtio.rst
> > +++ b/Documentation/driver-api/virtio/virtio.rst
> > @@ -134,7 +134,7 @@ References
> >  _`[1]` Virtio Spec v1.2:
> >  https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html
> >  =

> > -Check for later versions of the spec as well.
> > +.. Check for later versions of the spec as well.
> >  =

> >  _`[2]` Virtqueues and virtio ring: How the data travels
> >  https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-tra=
vels
> >
> >> diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rs=
t b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
> >> new file mode 100644
> >> index 000000000000..e14c58796d25
> >> --- /dev/null
> >> +++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
> >> <snipped>...
> >> +References
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +_`[1]` Virtio Spec v1.2:
> >> +https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html
> >> +
> >> +Check for later versions of the spec as well.
> >
> > Same reply.
> =

> I don't think we should hide that in a comment -- unless you want to
> update this file every time a new version of the virtio spec gets
> released.

What do you suggest? Just http://docs.oasis-open.org/virtio/virtio/ ?

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
