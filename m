Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60BBC433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 10:59:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8769364F53
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 10:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8769364F53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46E7D605F7;
	Fri, 19 Mar 2021 10:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YbI2JdlWteZS; Fri, 19 Mar 2021 10:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD6616058D;
	Fri, 19 Mar 2021 10:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDA6AC000B;
	Fri, 19 Mar 2021 10:59:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DAD5C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 10:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 750AA4AD66
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 10:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1K7-o0ZDApuB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 10:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29F654A5F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616151544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTtCoj7GiAxnLlyHTKHV8c52HQXk/FzWNNseSEaUuVo=;
 b=Gt5ZsDRv6mrNdRzC5St4U/lyrEto/rqhZQq/sn7QOuusOqZHppooU7jafuC5LfaS0MpJd7
 FkZRzplIzT7G5q2vz667RoUE8Tb+9OWrCQL2EbQ7oG/WFRVQUwDprbGsOvk1PCer3LXyQs
 cVCkKG9RGT5XJ1RymEAM7l5qRD01YPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-m6o5VM7IOxGPZsaMPWwlbg-1; Fri, 19 Mar 2021 06:59:00 -0400
X-MC-Unique: m6o5VM7IOxGPZsaMPWwlbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FE245B362;
 Fri, 19 Mar 2021 10:58:58 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 524DB5D72E;
 Fri, 19 Mar 2021 10:58:51 +0000 (UTC)
Subject: Re: [PATCH 0/3] Add support for ACPI VIOT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rjw@rjwysocki.net,
 lenb@kernel.org, joro@8bytes.org, mst@redhat.com
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e7291605-88ca-6e55-11ec-574b2f94cefa@redhat.com>
Date: Fri, 19 Mar 2021 11:58:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-1-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org
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

Hi Jean,

On 3/16/21 8:16 PM, Jean-Philippe Brucker wrote:
> Add a driver for the ACPI VIOT table, which enables virtio-iommu on
> non-devicetree platforms, including x86. This series depends on the
> ACPICA changes of patch 1, which will be included in next release [1]
> and pulled into Linux.
> 
> The Virtual I/O Translation table (VIOT) describes the topology of
> para-virtual I/O translation devices and the endpoints they manage.
> It was recently approved for inclusion into the ACPI standard [2].
> A provisional version of the specification can be found at [3].
> 
> After discussing non-devicetree support for virtio-iommu at length
> [4][5][6] we concluded that it should use this new ACPI table. And for
> platforms that don't implement either devicetree or ACPI, a structure
> that uses roughly the same format [6] can be built into the device.
> 
> [1] https://github.com/acpica/acpica/pull/666
> [2] https://lore.kernel.org/linux-iommu/20210218233943.GH702808@redhat.com/
> [3] https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> [4] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
> [5] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
> [6] https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/

Do you have a qemu branch to share for us to start exercising different
kinds of topology?

Thanks

Eric
> 
> Jean-Philippe Brucker (3):
>   ACPICA: iASL: Add definitions for the VIOT table
>   ACPI: Add driver for the VIOT table
>   iommu/virtio: Enable x86 support
> 
>  drivers/acpi/Kconfig         |   3 +
>  drivers/iommu/Kconfig        |   4 +-
>  drivers/acpi/Makefile        |   2 +
>  include/acpi/actbl3.h        |  67 ++++++
>  include/linux/acpi_viot.h    |  26 +++
>  drivers/acpi/bus.c           |   2 +
>  drivers/acpi/scan.c          |   6 +
>  drivers/acpi/viot.c          | 406 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/virtio-iommu.c |   3 +
>  MAINTAINERS                  |   8 +
>  10 files changed, 526 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/acpi_viot.h
>  create mode 100644 drivers/acpi/viot.c
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
