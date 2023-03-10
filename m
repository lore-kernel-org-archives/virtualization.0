Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F43C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 965588224A;
	Fri, 10 Mar 2023 08:55:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 965588224A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMQpjLKn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P43fpAtP0H-r; Fri, 10 Mar 2023 08:55:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 28C9782231;
	Fri, 10 Mar 2023 08:55:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28C9782231
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0201BC0071;
	Fri, 10 Mar 2023 08:55:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC8F3C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6C7641972
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:55:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6C7641972
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dMQpjLKn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrHRewWjd_n0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:55:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D133841959
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D133841959
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678438527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfaGyjJVfm635JeXhSuWAc4er0IJMoVENEv0pUS72pE=;
 b=dMQpjLKnat+JhwTbtU6zDOjcm59QINPhxxh2xZ4DoLTYPaxWS0llOKTlhylOFzgCJd1Hh2
 kbfyfodz7QEqlVLE3uiH3iCL1jmQ0qTIMRBuKD9aE0gE1coXilbWld1iANLkLwYVbfb0iJ
 j69xMXe4asI0q3eDAqo+yJLio2GufJc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-sBDesMI_PEuOUnSTL7HCBA-1; Fri, 10 Mar 2023 03:55:26 -0500
X-MC-Unique: sBDesMI_PEuOUnSTL7HCBA-1
Received: by mail-wm1-f72.google.com with SMTP id
 k26-20020a05600c0b5a00b003dfe4bae099so1746301wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678438525;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vfaGyjJVfm635JeXhSuWAc4er0IJMoVENEv0pUS72pE=;
 b=AeqR2If1CiWtj5IQ6J4K5ePytMBpaBwhALQuWv4KivQBsPxwOit6oEk0oogbJmwMDp
 hJLWpdd0eppVmFa0SrBMs3APCp1ktS67Npvo4XjRL39srPcKNnNHX/Cj8jXwz8rnm/IB
 v0gAbNlvaNzMFDEd4dnlDG1VBn9AZPNwAMYnoBsYUmCIiSW61AgT8fX3vO+maWzAOLfi
 u44Yj3z4nGgbL8Im/eKgeYW+IsQziVRRwUV/VzkNeriSZ4fxC++3gr9izcuOO+MTJNuF
 XgREpYTbN4W1VuuUYnpGvbDUODYuP+hfh52yNsRGelOiPHLqYm6nTM6ENQgW4j5EQ2v/
 Uttw==
X-Gm-Message-State: AO0yUKULC3VIaazUeG3zEZEQrKnUBw2QHj4DaL8eMHzDbRlEYQLWSYen
 0YV6aQZdiUDYPYFq70vu5rJGQHHd++W3Y09/kunRnomkQV9NCYFo4+aEmL95U14wdxGTjReL500
 h4+3YHIvK57sjgU2ygrWuaTuatb8jcdIe97gDpf9B0g==
X-Received: by 2002:a5d:558e:0:b0:2c9:e5f0:bd4f with SMTP id
 i14-20020a5d558e000000b002c9e5f0bd4fmr16454638wrv.18.1678438525521; 
 Fri, 10 Mar 2023 00:55:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+ZCJLrhyjyYuI2NKYdYVdjVvFfujK+H8p82JNRkHzpuum9+WBjmlvVp1x6vFu5g5usem1xCg==
X-Received: by 2002:a5d:558e:0:b0:2c9:e5f0:bd4f with SMTP id
 i14-20020a5d558e000000b002c9e5f0bd4fmr16454627wrv.18.1678438525223; 
 Fri, 10 Mar 2023 00:55:25 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 j13-20020a5d564d000000b002c5694aef92sm1620415wrw.21.2023.03.10.00.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:55:24 -0800 (PST)
Date: Fri, 10 Mar 2023 03:55:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Smetanin <asmetanin@yandex-team.ru>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
Message-ID: <20230310035509-mutt-send-email-mst@kernel.org>
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
 <20221219023900-mutt-send-email-mst@kernel.org>
 <62621671437948@mail.yandex-team.ru>
 <20230127031904-mutt-send-email-mst@kernel.org>
 <278011674821181@mail.yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <278011674821181@mail.yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
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

On Fri, Jan 27, 2023 at 03:08:18PM +0300, Andrey Smetanin wrote:
> Yes, I plan. I need some time, currently I'm very busy in another directi=
on,
> but I will return.


Jason you want to take this up maybe?

> 27.01.2023, 11:19, "Michael S. Tsirkin" <mst@redhat.com>:
> =

> =

>     On Mon, Dec 19, 2022 at 11:24:26AM +0300, Andrey Smetanin wrote:
> =

>         =A0Sorry for the delay.
>         =A0I will send update on this week after some tests.
>         =A019.12.2022, 10:39, "Michael S. Tsirkin" <mst@redhat.com>:
> =

> =

>     Do you still plan to send something? Dropping this for now.
>     =A0
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
