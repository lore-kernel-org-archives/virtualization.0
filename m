Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3C7C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DA2F82343;
	Fri, 31 Mar 2023 07:45:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DA2F82343
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiTJwIf5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Pj8SXrgDvXL; Fri, 31 Mar 2023 07:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BF594844B0;
	Fri, 31 Mar 2023 07:45:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF594844B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 825CAC0036;
	Fri, 31 Mar 2023 07:45:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5688C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB69B41946
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:45:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB69B41946
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiTJwIf5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id azN0yiQbvReC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:45:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57EA9417FF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57EA9417FF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680248740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ijuijWfOviH3p+YNIe7G3DYHHIm8VDsoLsYWWShhetc=;
 b=HiTJwIf5A7LW7AGRDNqEVl58SyHwUDQ16rVXavVRgkniA3karpRsS9bE7tBs5jd65E1sA2
 Hkkc7ytM4oRGZlNOIiqv2rNz2yhX/fTMrW3LI39YAafxdQtylNXkVMDazW2sQdFvAO+ked
 4tx6u5PedTmigSeNWj+Vj3kp0ZRUKmk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-p0WigoRfPSGz0bHLmlIHxQ-1; Fri, 31 Mar 2023 03:45:39 -0400
X-MC-Unique: p0WigoRfPSGz0bHLmlIHxQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 r19-20020a50aad3000000b005002e950cd3so30987247edc.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680248738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijuijWfOviH3p+YNIe7G3DYHHIm8VDsoLsYWWShhetc=;
 b=nLzwd2AndvdG8QuDTLQjSDyJCDWSKbsGhdVEdKbH5xDiz1FX9Kwd6E7qJyduYiqVCx
 cKzLcbS0hk5fH3h7lGbTTMVAqeJ4audJWr63/p5coq91dcDYUMfHUzePqLpFITzg+YS8
 IPQA57nSobTOWI342a2dOHmX2DM2i1moPNzscazvfr8Yn30nStZGxuVWnrc78xZUiC3V
 V19g4Hs8P7+sGFM9EgRUrW2ZCVH9n+vgXObqabjaezYh96f2nxayr/RNttUJlMxX2hS9
 RbmrOqcrMw+QZyX0cf2wZKaxPyldlwMXi+IdaiLrpMDxO2kA1VaNW/lB8ZG1aR6iq4A1
 B3xw==
X-Gm-Message-State: AAQBX9e2lGI7/58JFt+Dbw8SRdNQUkH6HvsMrFxk0PTG8D6PvYRL4YQ3
 F/haz+3ccnI/IvIXJFyPWgZpAWkqD+sm0RlG4Od2ryNi6RyVeMPwhvicX16VWbrEqdemJrvdqpR
 RYVwhzn2O42ev5f/aYzMPfHzNrA+vqmL3pwTi2Jv/pw==
X-Received: by 2002:a17:906:5785:b0:93d:1c2b:bd23 with SMTP id
 k5-20020a170906578500b0093d1c2bbd23mr28486741ejq.39.1680248738075; 
 Fri, 31 Mar 2023 00:45:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350YS3/z+4R+xl2x92XT2RXYCogfvtYmw2I34NDhSWzTMLR1o5S98t+qcxg+NZzy9Jd9gHuGQoQ==
X-Received: by 2002:a17:906:5785:b0:93d:1c2b:bd23 with SMTP id
 k5-20020a170906578500b0093d1c2bbd23mr28486717ejq.39.1680248737742; 
 Fri, 31 Mar 2023 00:45:37 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 dx21-20020a170906a85500b008d044ede804sm677526ejb.163.2023.03.31.00.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Mar 2023 00:45:37 -0700 (PDT)
Date: Fri, 31 Mar 2023 09:45:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v4 5/9] vringh: support VA with iotlb
Message-ID: <3jqstd75xs6f2pn7pwjxnkphhan5bk25er3ord4rw63545htu7@vgngick7zfco>
References: <20230324153607.46836-1-sgarzare@redhat.com>
 <20230324153919.47633-1-sgarzare@redhat.com>
 <ZCWIXZbeWanvPJA3@corigine.com>
MIME-Version: 1.0
In-Reply-To: <ZCWIXZbeWanvPJA3@corigine.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

On Thu, Mar 30, 2023 at 03:02:21PM +0200, Simon Horman wrote:
>On Fri, Mar 24, 2023 at 04:39:19PM +0100, Stefano Garzarella wrote:
>> vDPA supports the possibility to use user VA in the iotlb messages.
>> So, let's add support for user VA in vringh to use it in the vDPA
>> simulators.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>...
>
>> +/**
>> + * vringh_init_iotlb_va - initialize a vringh for a ring with IOTLB containing
>> + *                        user VA.
>> + * @vrh: the vringh to initialize.
>> + * @features: the feature bits for this ring.
>> + * @num: the number of elements.
>> + * @weak_barriers: true if we only need memory barriers, not I/O.
>> + * @desc: the userpace descriptor pointer.
>> + * @avail: the userpace avail pointer.
>> + * @used: the userpace used pointer.
>
>nit: s/userpace/userspace/

Oops, good catch!

Copy & past typos also present in the documentation of vringh_init_kern
and vringh_init_iotlb.

I will fix this patch and send a separate patch to fix the other two.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
