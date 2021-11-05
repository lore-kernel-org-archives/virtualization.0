Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A4C433F5
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:31:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6331B6124F
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6331B6124F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 214E061515;
	Fri,  5 Nov 2021 08:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kAoiMC_5OXs; Fri,  5 Nov 2021 08:31:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B30CB605FE;
	Fri,  5 Nov 2021 08:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96384C0019;
	Fri,  5 Nov 2021 08:31:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65798C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 520FA40431
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1iQuai1IqFzv
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:31:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63DD54042D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636101073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPiyoiSRvncHrQx4lUP4gZt2i/XD5//Eik7XImjQZmI=;
 b=YwbzYIINaf4Mc6QUzZjKIMD0x1aRzQ23SizGIGJ4aKJC1OgJcT1GiSnwabz48jQ9zqo+mV
 C0GI1p5i24HawGMyT3aCmmDHlO9BMIoOTHuXc5E90nlG86CaK4bR6PkTljeUlMJ3Hvsg2j
 qjGCraqeb4dX3Q4om8H1a2PZT2dbtzY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-KNhEg7a-OyWYAXyhPrfXbw-1; Fri, 05 Nov 2021 04:31:12 -0400
X-MC-Unique: KNhEg7a-OyWYAXyhPrfXbw-1
Received: by mail-ed1-f71.google.com with SMTP id
 y12-20020a056402270c00b003e28de6e995so8170767edd.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Nov 2021 01:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WPiyoiSRvncHrQx4lUP4gZt2i/XD5//Eik7XImjQZmI=;
 b=SzoQY5QldRZo4J0slHz7/PjjLYynkfgzFHiA5rBwZmlShxJ91Sdw+NH+tROgTqNX3S
 R0E6DaQQgGidXJVf1S0QTSj0+ADeiILFiZIpLjHlTN56bAe8EK8xyeu319C8WJW3w7EY
 4HsLmaFyadymEgBOALT7hptBVrrHH1gXXEHY2fqfIQf5MquqFgzZFBF0BhLLZlC3/tiJ
 mjdc7a1qcDChp9p/v6VwqPhO2jL/QYY8PcmbeXi4Mo1ekGjfgyXsZOF+XG8XkX0LyupV
 XqYcxLt1JtMzZ/v9LFH5TMAeyM1hX+G9hG3bgD+jDEZQUPkn5s1PMWJMjI/GbGU+IiUj
 AomQ==
X-Gm-Message-State: AOAM53297laY2FYCv7Z9qP12QCXDet8AXBLeV4iu5SvBBRtIJAX8Gjy0
 A6HLi7OSsu7YCvVjYYZE7LQX66vduPnMysfBgDMIOITZaMqYYNf6TrfUhnmE7zT5UhSI/EQXbw7
 rAhT3g0KUYPAJJRa61GdwG3GSw5ZOmLedAUvDV+ffiA==
X-Received: by 2002:a05:6402:402:: with SMTP id
 q2mr76653543edv.248.1636101071138; 
 Fri, 05 Nov 2021 01:31:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7h923akD7WiTYrUKfGSfmOMcvIFCqZfZzbM91hCco7x+YgLQ12F58YTT8vDChWZht28poKg==
X-Received: by 2002:a05:6402:402:: with SMTP id
 q2mr76653511edv.248.1636101070913; 
 Fri, 05 Nov 2021 01:31:10 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id di4sm3852618ejc.11.2021.11.05.01.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 01:31:10 -0700 (PDT)
Date: Fri, 5 Nov 2021 09:31:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211105083108.kfubtzdbucs2drzs@steredhat>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <20211105080454.wpvtwa7el45kayem@steredhat>
 <CACGkMEvNZKc2K_bdKxiUmbLzoZL-Vdbc14+uw9Ro-2jzdFMRRw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvNZKc2K_bdKxiUmbLzoZL-Vdbc14+uw9Ro-2jzdFMRRw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Nov 05, 2021 at 04:26:44PM +0800, Jason Wang wrote:
>On Fri, Nov 5, 2021 at 4:05 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Nov 05, 2021 at 11:01:30AM +0800, Jason Wang wrote:
>> >On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> `driver_override` allows to control which of the vDPA bus drivers
>> >> binds to a vDPA device.
>> >>
>> >> If `driver_override` is not set, the previous behaviour is followed:
>> >> devices use the first vDPA bus driver loaded (unless auto binding
>> >> is disabled).
>> >>
>> >> Tested on Fedora 34 with driverctl(8):
>> >>   $ modprobe virtio-vdpa
>> >>   $ modprobe vhost-vdpa
>> >>   $ modprobe vdpa-sim-net
>> >>
>> >>   $ vdpa dev add mgmtdev vdpasim_net name dev1
>> >>
>> >>   # dev1 is attached to the first vDPA bus driver loaded
>> >>   $ driverctl -b vdpa list-devices
>> >>     dev1 virtio_vdpa
>> >>
>> >>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>> >>
>> >>   $ driverctl -b vdpa list-devices
>> >>     dev1 vhost_vdpa [*]
>> >>
>> >>   Note: driverctl(8) integrates with udev so the binding is
>> >>   preserved.
>> >>
>> >> Suggested-by: Jason Wang <jasowang@redhat.com>
>> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> ---
>> >>  include/linux/vdpa.h |  2 ++
>> >>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>> >>  2 files changed, 76 insertions(+)
>> >>
>> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> >> index c3011ccda430..ae34015b37b7 100644
>> >> --- a/include/linux/vdpa.h
>> >> +++ b/include/linux/vdpa.h
>> >> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>> >>   * struct vdpa_device - representation of a vDPA device
>> >>   * @dev: underlying device
>> >>   * @dma_dev: the actual device that is performing DMA
>> >> + * @driver_override: driver name to force a match
>> >
>> >This seems useless?
>>
>> I'm a bit lost, do you mean we should remove the documentation of
>> `driver_override`?
>
>I misread the code which was misled by vdpa_mgmt_dev above:(

Yeah, the same thing happened to me now while double checking ;-)

>
>The code should be fine.
>
>So:
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
