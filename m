Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE3AC433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 07:48:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703B02255F
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 07:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703B02255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA137871F3;
	Fri,  4 Dec 2020 07:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvT7WLAy3i7w; Fri,  4 Dec 2020 07:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25952871E0;
	Fri,  4 Dec 2020 07:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04E4CC0FA7;
	Fri,  4 Dec 2020 07:48:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 641FBC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4D58D20768
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ud7xuc7wE-mP
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:48:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id AA9F320555
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607068132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jGnG0b9M2ziZPf4CQZMAAFmJYUdUv5tCF4bWUtnXQ10=;
 b=L2tXDRR7pA0QOPeM9nE1exyrK9LbakHezT7QUg3gwtenH9xW0VZZERcoGPW5B2JaOlSAZS
 ttmrFeNhYs8d1yBVCgdHtak9cb5JcNzA/49RPeFnDSbvL9ZWsziuoaf0w3cMSz5GPsn9nv
 Wgr60UOn4ZdvOCVPVuzPt5IW5PLSOq4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-q7qTNJkpP7artvY4ssqUYw-1; Fri, 04 Dec 2020 02:48:50 -0500
X-MC-Unique: q7qTNJkpP7artvY4ssqUYw-1
Received: by mail-ej1-f71.google.com with SMTP id dv25so1750867ejb.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Dec 2020 23:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jGnG0b9M2ziZPf4CQZMAAFmJYUdUv5tCF4bWUtnXQ10=;
 b=GVx4OdnGK52rT3rNCrRn6/g0AL/fyNQoZAE4s5zgoYSAuRAG35px0PUc9Vnmm+UVLn
 YlvwiNxdK4TNZOQe+F/eU5OKgrnGIL9SD0TSOPizpo3faGa8+EjRD8ruTbHQUhfctgDQ
 7wI3X/pCG+TU59/cQXWZsvd8zs5OYZdCQ7QTgOUOFlWK50EJAMmXIQkQDEKM+L58uimr
 pUXlaBlZ+V0a6iWwRWxxrDSgKSmjo0yDaADqKvDov5Qpznw8KIKYOfQc0DFFajMY+5OC
 VwXrbfiBzjJRApGvzkmJWEc1h5ya9L+oW2wX/SRrmxLCW2FOusp4zgK5z6DVecou2Sb/
 FcOw==
X-Gm-Message-State: AOAM532cHAXAz9CbJYb2DPcS8qzlUjlfZDmab65x/eq5kQWXSKzUxvm9
 EhlCd2Vkqw9IEcnfTlGHnqigIC43uisJ2GqPeH/iU1/fTvMSUbz75l3+vE+kxInkJOEWE4DOk/w
 PnvqUfMjwuGeT8wZVeKljoupCPODg6DEaU+4Wa35IUA==
X-Received: by 2002:a17:906:38d6:: with SMTP id
 r22mr5764514ejd.149.1607068129459; 
 Thu, 03 Dec 2020 23:48:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgz5jSx8FWg8x7FH/nJSosiNnfP6BLwk5LSwzDEq0BKHCrDA9JCLnDkHjIU910tkj1zf5xeA==
X-Received: by 2002:a17:906:38d6:: with SMTP id
 r22mr5764502ejd.149.1607068129247; 
 Thu, 03 Dec 2020 23:48:49 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id b7sm2562998ejj.85.2020.12.03.23.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Dec 2020 23:48:48 -0800 (PST)
Date: Fri, 4 Dec 2020 08:48:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 19/19] vdpa: split vdpasim to core and net modules
Message-ID: <20201204074846.s2nnyhlcsjxm673f@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-20-sgarzare@redhat.com>
 <920c4975-a3ae-b7f9-ac89-6444ca2e4c45@infradead.org>
MIME-Version: 1.0
In-Reply-To: <920c4975-a3ae-b7f9-ac89-6444ca2e4c45@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Shahaf Shuler <shahafs@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>,
 Oren Duer <oren@nvidia.com>
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

On Thu, Dec 03, 2020 at 09:25:52AM -0800, Randy Dunlap wrote:
>Hi,
>
>On 12/3/20 9:05 AM, Stefano Garzarella wrote:
>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>> index 2c892e890b9e..b0f91ad8eb47 100644
>> --- a/drivers/vdpa/Kconfig
>> +++ b/drivers/vdpa/Kconfig
>> @@ -9,15 +9,20 @@ menuconfig VDPA
>>  if VDPA
>>
>>  config VDPA_SIM
>> -	tristate "vDPA device simulator"
>> +	tristate "vDPA device simulator core"
>>  	depends on RUNTIME_TESTING_MENU && HAS_DMA
>>  	select DMA_OPS
>>  	select VHOST_RING
>> +	help
>> +	  Enable this module to support vDPA device simulators. These devices
>> +	  are used for testing, prototyping and development of vDPA.
>> +
>> +config VDPA_SIM_NET
>> +	tristate "vDPA simulator for networking device"
>> +	depends on VDPA_SIM
>>  	select GENERIC_NET_UTILS
>>  	help
>> -	  vDPA networking device simulator which loop TX traffic back
>> -	  to RX. This device is used for testing, prototyping and
>> -	  development of vDPA.
>> +	  vDPA networking device simulator which loop TX traffic back to RX.
>
>	                                         loops

It was pre-existing, but since I'm there I'll fix it, thanks!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
