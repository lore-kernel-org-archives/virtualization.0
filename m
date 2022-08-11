Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024A8C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F9534182C;
	Thu, 11 Aug 2022 13:57:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F9534182C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C555/5M5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MGAt159OI7Ae; Thu, 11 Aug 2022 13:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74E81417FA;
	Thu, 11 Aug 2022 13:57:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74E81417FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26E1FC0032;
	Thu, 11 Aug 2022 13:57:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF34CC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A51CE4182C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A51CE4182C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_jXIhL2kCuu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:57:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75C68417FA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75C68417FA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660226247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=affarGx84Vio11tis73UE7PHQcPVD+DI8+ugfRW+1TY=;
 b=C555/5M5GlyqST7ZEUTaa+ZvK/D2fQWnM0U+ASh4YxfGgTVVuBQKw39d8rvgSV2+Wktryw
 /ZTR0fTpgbP3HYtKaE/AtzFOxHffcKjBA53QQk047qJJnf4c/falWF1l/PW/vyQJd57kzp
 bmNJ6aEEtMp0bCkeY3kogAkI0L/U/F0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-O60Jw5PPM_2IfMiVKTP4Vw-1; Thu, 11 Aug 2022 09:57:26 -0400
X-MC-Unique: O60Jw5PPM_2IfMiVKTP4Vw-1
Received: by mail-ed1-f71.google.com with SMTP id
 z6-20020a05640240c600b0043e1d52fd98so11143423edb.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 06:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc;
 bh=affarGx84Vio11tis73UE7PHQcPVD+DI8+ugfRW+1TY=;
 b=hqdNJjhMbRmJjdJZHN0cgbkCPAyNugmUSOJxZpdw3LC+6/KKTPcezb7d2W4cjqT+z/
 zNR1pYHRj8MA0VI2F+XZ3MuwJY15BazCRUONe91sJE2hSnI9/5815YaYMAaJfQwvFVio
 0oXdKJyGaVPcLNnsUSW52+lWl6pxCkS2vfMrsm/8H6Z5CqAWjKzQZwIs+UbKU10BZKpu
 ZNRg6jwr1SE8hg3lmQH1BAiLFpHVAaSuMURJgMHSj+QoQz+8HEkdTqmvC3yIGPc8atLb
 VXuZcBUQC/vfy9PqymcGUB3qqV1Lp5X9sTK4L5RzhpUo0nouExE82nZQBUYI5L2cgpqB
 MAVA==
X-Gm-Message-State: ACgBeo233JYX7P6XADcD8YX9ruubQ88bdh4Qd8G8ZnguoHAkFtYaaEhs
 OZZOAzAMohECp1oZIXMlduoQ8SdbeGy8VthDQyREZRkQDRiWzCukmeTwWcab0jw+IE3QnRugzDj
 OvdHTN/gIWWWjSDKWEvV9VOK1iwcUprHixNm97F9HoA==
X-Received: by 2002:a17:907:7347:b0:730:ec0f:fd5c with SMTP id
 dq7-20020a170907734700b00730ec0ffd5cmr22914427ejc.187.1660226245027; 
 Thu, 11 Aug 2022 06:57:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4s/hnCBaghYUh5gSU7gbDFNIq0YkkUbwy3aB1boS557sDjokxsn57S/yK/yRA0k+NJuxCoHA==
X-Received: by 2002:a17:907:7347:b0:730:ec0f:fd5c with SMTP id
 dq7-20020a170907734700b00730ec0ffd5cmr22914416ejc.187.1660226244836; 
 Thu, 11 Aug 2022 06:57:24 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 z3-20020aa7c643000000b004424429afd4sm3330607edr.16.2022.08.11.06.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 06:57:24 -0700 (PDT)
Date: Thu, 11 Aug 2022 09:57:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 2/2] docs: driver-api: virtio: virtio on Linux
Message-ID: <20220811095251-mutt-send-email-mst@kernel.org>
References: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
 <20220810094004.1250-3-ricardo.canuelo@collabora.com>
 <87czd6dha1.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87czd6dha1.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bagasdotme@gmail.com, kernel@collabora.com
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

On Thu, Aug 11, 2022 at 03:46:46PM +0200, Cornelia Huck wrote:
> On Wed, Aug 10 2022, Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com> wr=
ote:
> =

> > Basic doc about Virtio on Linux and a short tutorial on Virtio drivers.
> >
> > Signed-off-by: Ricardo Ca=F1uelo <ricardo.canuelo@collabora.com>
> > ---
> >  Documentation/driver-api/index.rst            |   1 +
> >  Documentation/driver-api/virtio/index.rst     |  11 ++
> >  Documentation/driver-api/virtio/virtio.rst    | 144 ++++++++++++++
> >  .../virtio/writing_virtio_drivers.rst         | 186 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  5 files changed, 343 insertions(+)
> >  create mode 100644 Documentation/driver-api/virtio/index.rst
> >  create mode 100644 Documentation/driver-api/virtio/virtio.rst
> >  create mode 100644 Documentation/driver-api/virtio/writing_virtio_driv=
ers.rst
> >
> =

> (...)
> =

> > +.. rubric:: Footnotes
> > +
> > +.. [#f1] that's why they may be also referred as virtrings.
> =

> "referred to"
> =

> (...)
> =

> > +The ``probe`` method does the minimum driver setup in this case
> > +(memory allocation for the device data) and initializes the
> > +virtqueue. The virtqueues are automatically enabled after ``probe``
> > +returns, sending the appropriate "DRIVER_OK" status signal to the
> > +device. If the virtqueues need to be enabled before ``probe`` ends, th=
ey
> > +can be manually enabled by calling virtio_device_ready():
> > +
> > +.. kernel-doc:: include/linux/virtio_config.h
> > +    :identifiers: virtio_device_ready
> =

> Hm, not quite sure what the actual expectations are here: Should the
> driver set DRIVER_OK in its probe function, and the core only set it as
> a fallback? Michael, Jason?
> =

> (...)
> =

> LGTM in general.

Generally driver should either call device_ready
or defer adding device to linux in a scan callback.

Doing neither is likely a bug since you might
then be asked to add buffers before DRIVER_OK is set,
though e.g. if you are interrupt driven things might work
correctly.

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
