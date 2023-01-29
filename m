Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30A4C05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 22:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DBB981754;
	Sun, 29 Jan 2023 22:33:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DBB981754
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TjvB+m9Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQYUKFpVIrfJ; Sun, 29 Jan 2023 22:33:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0B9C8174F;
	Sun, 29 Jan 2023 22:33:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0B9C8174F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C708C0032;
	Sun, 29 Jan 2023 22:33:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5330CC002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 22:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24BCF40988
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 22:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24BCF40988
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TjvB+m9Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dhXVdjyOIVTp
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 22:33:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A91740919
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A91740919
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675031613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/vCgiIjpi7lDX2G2pl/mU/xcfS28czOyjP9ouExjW/I=;
 b=TjvB+m9YDD1FvtL66197QaCS1p5stVzRM3scXG9a5qVG1anyvml7EtIFnaZ1lPrQwcw7l7
 /tT8wpSEzWxeIDxOUjPhRk28bxpbaivojw2mvQNsBy7sIM8EokEaL4UL1tz6HKJOCvErwC
 QTD8mgGMk0dHLka7ap2/Pn0bpiIETcY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-845j5wdPMOWffkA0sKlkGw-1; Sun, 29 Jan 2023 17:33:30 -0500
X-MC-Unique: 845j5wdPMOWffkA0sKlkGw-1
Received: by mail-wm1-f72.google.com with SMTP id
 l23-20020a7bc457000000b003db0cb8e543so3412040wmi.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 14:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vCgiIjpi7lDX2G2pl/mU/xcfS28czOyjP9ouExjW/I=;
 b=I70v4uu1iZOcZE9gRPA7wHUWsltkcEdAq9g+zHEoYaqJsL0c4gqgX3QJKtrGMs+Ebt
 +iSmadfpj7qKMjMcts9xa85HCr7OslyQS/9AF7nnxZyoFq8BPYRMamPzdqX3JcSpXhjR
 x/eVCyuYUBEPdxMLhe7buzctEPpFgwLexrnMxWqLxGOoFFG/fZEqrodoRm3IlsvNMHHA
 tNL6dc5s2G/cJAMNIi2GjIyxpxGM+ptXsBSeQcRYf64rBkOgX/VbFNg9IQ47Z43AuQYF
 Gte0wvFetysz7oVcFdieMwnFlYRsKjXNUCvac6rzLONOq6Q+O2iae3GrtWoeqIi8IaQ7
 e9mQ==
X-Gm-Message-State: AO0yUKUqSvQpiMvDetZnWtL7hpCUuhM9N0wVlDeFcHKI+m7kkU8b9Bpj
 u9fBU6IlSK6prElEyz8XfyeRP/AptG07GHfC0TSbj5p0yTqRz7iIi0GV60aaNllOLHywG/Dnsjh
 izPAGAVzZCJAcpW7+C01hajJw8/b6hKKsE5GMZ4Oolw==
X-Received: by 2002:adf:a504:0:b0:2bf:ae0e:23d8 with SMTP id
 i4-20020adfa504000000b002bfae0e23d8mr19938614wrb.32.1675031609460; 
 Sun, 29 Jan 2023 14:33:29 -0800 (PST)
X-Google-Smtp-Source: AK7set8I7BUkRtGi/Rxw0hzJh9BWvW50ICv0ytFQopbAPGiDJ0T7eGj+CJs02SjD3RVR4wxiLoWToQ==
X-Received: by 2002:adf:a504:0:b0:2bf:ae0e:23d8 with SMTP id
 i4-20020adfa504000000b002bfae0e23d8mr19938603wrb.32.1675031609234; 
 Sun, 29 Jan 2023 14:33:29 -0800 (PST)
Received: from redhat.com ([2.52.20.248]) by smtp.gmail.com with ESMTPSA id
 f12-20020adfdb4c000000b002bfb1de74absm10168012wrj.114.2023.01.29.14.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jan 2023 14:33:26 -0800 (PST)
Date: Sun, 29 Jan 2023 17:33:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 0/2] vhost/net: Clear the pending messages when the
 backend is removed
Message-ID: <20230129173240-mutt-send-email-mst@kernel.org>
References: <20230117151518.44725-1-eric.auger@redhat.com>
 <3fe5971a-5991-488f-cef5-473c9faa1ba1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3fe5971a-5991-488f-cef5-473c9faa1ba1@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger.pro@gmail.com
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

On Sun, Jan 29, 2023 at 06:58:09PM +0100, Eric Auger wrote:
> Hi,
> 
> On 1/17/23 16:15, Eric Auger wrote:
> > When the vhost iotlb is used along with a guest virtual iommu
> > and the guest gets rebooted, some MISS messages may have been
> > recorded just before the reboot and spuriously executed by
> > the virtual iommu after the reboot. This is due to the fact
> > the pending messages are not cleared.
> >
> > As vhost does not have any explicit reset user API,
> > VHOST_NET_SET_BACKEND looks a reasonable point where to clear
> > the pending messages, in case the backend is removed (fd = -1).
> >
> > This version is a follow-up on the discussions held in [1].
> >
> > The first patch removes an unused 'enabled' parameter in
> > vhost_init_device_iotlb().
> 
> Gentle Ping. Does it look a reasonable fix now?
> 
> Thanks
> 
> Eric

Yes I applied this - giving it a bit of time in next.

> >
> > Best Regards
> >
> > Eric
> >
> > History:
> > [1] RFC: [RFC] vhost: Clear the pending messages on vhost_init_device_iotlb()
> > https://lore.kernel.org/all/20221107203431.368306-1-eric.auger@redhat.com/
> >
> > Eric Auger (2):
> >   vhost: Remove the enabled parameter from vhost_init_device_iotlb
> >   vhost/net: Clear the pending messages when the backend is removed
> >
> >  drivers/vhost/net.c   | 5 ++++-
> >  drivers/vhost/vhost.c | 5 +++--
> >  drivers/vhost/vhost.h | 3 ++-
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
