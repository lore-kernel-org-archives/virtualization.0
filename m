Return-Path: <SRS0=Ae13=GB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F5C433E0
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 09:06:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34186207CF
	for <virtualization@archiver.kernel.org>; Tue, 29 Dec 2020 09:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34186207CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A4D032043E;
	Tue, 29 Dec 2020 09:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTEvsET0mPto; Tue, 29 Dec 2020 09:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 804F3203C4;
	Tue, 29 Dec 2020 09:06:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5778DC0893;
	Tue, 29 Dec 2020 09:06:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 663CCC0174
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 09:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4524D86D2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 09:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6OmZEG4BYV75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 09:06:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 47F3B86D17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Dec 2020 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609232789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvyfDZkeQCL8rV2xJW4U+VuxPIGRZi/Y/Dwry9SoGQE=;
 b=Ya+ZnclfmRceIXFFjbwc0ug/EBwFUwpB2Gq2bwniKX+ZpVG+Z1HAJ1iZ8WtSJUiDpHT9vC
 CdgRO3T26bWUXrxYTmC0OA4tnrNaaoRxISsG1wkv5YGdk+A8be7yfEHv+M5ACeROVMfpTO
 DbHGf2podq6gc32mzQsVSD+5SuzZL8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-LZ63T34gNgafwl5dz5SPhA-1; Tue, 29 Dec 2020 04:06:26 -0500
X-MC-Unique: LZ63T34gNgafwl5dz5SPhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2AE59;
 Tue, 29 Dec 2020 09:06:25 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BED360BE5;
 Tue, 29 Dec 2020 09:06:20 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: use false for bool variable
To: Tian Tao <tiantao6@hisilicon.com>, mst@redhat.com, jasowang@redhat.com
References: <1609209869-10354-1-git-send-email-tiantao6@hisilicon.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <483fb688-798f-c09d-cd73-0932c5fbebf1@redhat.com>
Date: Tue, 29 Dec 2020 10:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1609209869-10354-1-git-send-email-tiantao6@hisilicon.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

On 29.12.20 03:44, Tian Tao wrote:
> Fixes coccicheck warnings:
> drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment of 0/1 to
> bool variable.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/virtio/virtio_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 9fc9ec4..85a272c 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>  	 * actually in use (e.g., trying to reload the driver).
>  	 */
>  	if (vm->plugged_size) {
> -		vm->unplug_all_required = 1;
> +		vm->unplug_all_required = true;
>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
>  	}
>  
> 

Thanks - the patch subject is a little weird ("false"). I suggest

"virtio-mem: use boolean value when setting vm->unplug_all_required"

Apart from that

Acked-by: David Hildenbrand <david@redhat.com>


@Mst, do you want a resend or can you fixup the subject? Thanks!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
