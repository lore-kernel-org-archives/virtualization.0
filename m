Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB46C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 11:36:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F92F61390
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 11:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F92F61390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58A0A83F69;
	Thu, 30 Sep 2021 11:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUxJ6skr_iGs; Thu, 30 Sep 2021 11:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6CC683FC5;
	Thu, 30 Sep 2021 11:36:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9E1FC000F;
	Thu, 30 Sep 2021 11:36:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9691BC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E789613D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:36:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nclox7GMudqA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC3CE613CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633001802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2DkrjLmS5cuqV/GQI0XL4Bc/b2l6NbJQU00lS8/LDs=;
 b=KRSE+TeONXKOxPVU34Fu1+zxCX8WTHUCMKBZGZ+rGLDoBMdFkHal+P1aAsz7JUByzWOYcY
 1fcNsVRNCBqMH3rVXaQc2W1LnGAi/ahwB8Oj4kJk/h86We4h/ob1EC9PnjrzHm/tinCu9b
 r82kN3K0Vp+CAO4DQnHJdyD6gXo2NpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-VovEpZTwO3q3Hwz5eSJVSw-1; Thu, 30 Sep 2021 07:36:41 -0400
X-MC-Unique: VovEpZTwO3q3Hwz5eSJVSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0CD51006AA4;
 Thu, 30 Sep 2021 11:36:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 410C719729;
 Thu, 30 Sep 2021 11:36:29 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20210930070444-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Thu, 30 Sep 2021 13:36:27 +0200
Message-ID: <87fstm47no.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Thu, Sep 30 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Sep 30, 2021 at 03:20:49AM +0200, Halil Pasic wrote:
>> This patch fixes a regression introduced by commit 82e89ea077b9
>> ("virtio-blk: Add validation for block size in config space") and
>> enables similar checks in verify() on big endian platforms.
>> 
>> The problem with checking multi-byte config fields in the verify
>> callback, on big endian platforms, and with a possibly transitional
>> device is the following. The verify() callback is called between
>> config->get_features() and virtio_finalize_features(). That we have a
>> device that offered F_VERSION_1 then we have the following options
>> either the device is transitional, and then it has to present the legacy
>> interface, i.e. a big endian config space until F_VERSION_1 is
>> negotiated, or we have a non-transitional device, which makes
>> F_VERSION_1 mandatory, and only implements the non-legacy interface and
>> thus presents a little endian config space. Because at this point we
>> can't know if the device is transitional or non-transitional, we can't
>> know do we need to byte swap or not.
>
> Hmm which transport does this refer to?
> Distinguishing between legacy and modern drivers is transport
> specific.  PCI presents
> legacy and modern at separate addresses so distinguishing
> between these two should be no trouble.

Hm, what about transitional devices?

> Channel i/o has versioning so same thing?

It can turn off VERSION_1, but not legacy. (I had hacked up a patchset
to potentially disable legacy some time ago, but did not have any
resources to follow up on this.)

>
>> The virtio spec explicitly states that the driver MAY read config
>> between reading and writing the features so saying that first accessing
>> the config before feature negotiation is done is not an option. The
>> specification ain't clear about setting the features multiple times
>> before FEATURES_OK, so I guess that should be fine.
>> 
>> I don't consider this patch super clean, but frankly I don't think we
>> have a ton of options. Another option that may or man not be cleaner,
>> but is also IMHO much uglier is to figure out whether the device is
>> transitional by rejecting _F_VERSION_1, then resetting it and proceeding
>> according tho what we have figured out, hoping that the characteristics
>> of the device didn't change.
>
> I am confused here. So is the problem at the device or at the driver level?
> I suspect it's actually the host that has the issue, not
> the guest?

From my perspective the problem is that the version of the device
remains in limbo as long as the features have not yet been finalized,
which means that the endianness of the config space remains in limbo as
well. Both device and driver might come to different conclusions.

>
>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
>> Reported-by: markver@us.ibm.com
>> ---
>>  drivers/virtio/virtio.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>> index 0a5b54034d4b..9dc3cfa17b1c 100644
>> --- a/drivers/virtio/virtio.c
>> +++ b/drivers/virtio/virtio.c
>> @@ -249,6 +249,10 @@ static int virtio_dev_probe(struct device *_d)
>>  		if (device_features & (1ULL << i))
>>  			__virtio_set_bit(dev, i);
>>  
>> +	/* Write back features before validate to know endianness */
>> +	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
>> +		dev->config->finalize_features(dev);
>> +
>>  	if (drv->validate) {
>>  		err = drv->validate(dev);
>>  		if (err)
>> 
>> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
>> -- 
>> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
