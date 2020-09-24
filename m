Return-Path: <SRS0=sVkE=DB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE96C4727F
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:54:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2E32396E
	for <virtualization@archiver.kernel.org>; Thu, 24 Sep 2020 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWzYbEwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2E32396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1CC20869E4;
	Thu, 24 Sep 2020 09:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vlbaxTfFORp; Thu, 24 Sep 2020 09:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 90D6F86999;
	Thu, 24 Sep 2020 09:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65896C0859;
	Thu, 24 Sep 2020 09:54:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1677DC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F25B2874C3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVtXMvbOwTUX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:54:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 657E88749F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600941258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwnMqewnq7ETb4/KjSnn5wUZJcaPqFpokMzIrZDSlaw=;
 b=TWzYbEwC9sY/uRq0ulQ0xOXAez3ZCKdjQ3jdz7M/8EhFepBPUQYSmFLFuzQx3HSlsgYZnv
 QeFXXRLohabfDnZ1m0vRG/FINRz9PeSQgCRWV23uZNsdRxMi0kesk8+EviwKF+4OiXcLK8
 1toR67qf38F0k9wHDDvqeSWwtDA0ABE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-ZLbeInCJOTG2dDcQi8I8lQ-1; Thu, 24 Sep 2020 05:54:16 -0400
X-MC-Unique: ZLbeInCJOTG2dDcQi8I8lQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 609F18030CD;
 Thu, 24 Sep 2020 09:54:14 +0000 (UTC)
Received: from [10.36.112.105] (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83BD95C1DC;
 Thu, 24 Sep 2020 09:54:08 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
To: "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Al Stone <ahs3@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
Date: Thu, 24 Sep 2020 11:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200924053159-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lorenzo.pieralisi@arm.com,
 virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

Hi,

Adding Al in the loop

On 9/24/20 11:38 AM, Michael S. Tsirkin wrote:
> On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
>> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
>>> OK so this looks good. Can you pls repost with the minor tweak
>>> suggested and all acks included, and I will queue this?
>>
>> My NACK still stands, as long as a few questions are open:
>>
>> 	1) The format used here will be the same as in the ACPI table? I
>> 	   think the answer to this questions must be Yes, so this leads
>> 	   to the real question:
> 
> I am not sure it's a must.
> We can always tweak the parser if there are slight differences
> between ACPI and virtio formats.
> 
> But we do want the virtio format used here to be approved by the virtio
> TC, so it won't change.
> 
> Eric, Jean-Philippe, does one of you intend to create a github issue
> and request a ballot for the TC? It's been posted end of August with no
> changes ...
Jean-Philippe, would you?
> 
>> 	2) Has the ACPI table format stabalized already? If and only if
>> 	   the answer is Yes I will Ack these patches. We don't need to
>> 	   wait until the ACPI table format is published in a
>> 	   specification update, but at least some certainty that it
>> 	   will not change in incompatible ways anymore is needed.
>>

Al, do you have any news about the the VIOT definition submission to
the UEFI ASWG?

Thank you in advance

Best Regards

Eric


> 
> Not that I know, but I don't see why it's a must.
> 
>> So what progress has been made with the ACPI table specification, is it
>> just a matter of time to get it approved or are there concerns?
>>
>> Regards,
>>
>> 	Joerg
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
