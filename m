Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C256ECAAD4
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 15:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F09B610DF;
	Wed, 31 Aug 2022 15:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F09B610DF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN4xYTIs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWzj2iKEEToI; Wed, 31 Aug 2022 15:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 83B6C610DA;
	Wed, 31 Aug 2022 15:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83B6C610DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 609D7C0032;
	Wed, 31 Aug 2022 15:01:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BCE1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57C7F418AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57C7F418AC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CN4xYTIs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pRehCmX_RvCF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:01:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5376A41891
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5376A41891
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661958082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QihsBjiZvNOELw0Rtm2S0fzDvkyeBUo3nxHPcuLxME0=;
 b=CN4xYTIs7++jrtEWLJnO5ZGH1F4er7cUlipmP9/bTGZ9r/osgFct6DBuqmJtwwGrAt6cgc
 55K+/WScp5U5Khhk+Xq9e8eP5x2NXQy7WsIdyejC90+OJx1ud3L3EIX1e2oSCQNUFdLeAl
 m8Hu7M9dF9qW3JlC/OSStwUYUdzr8Ek=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-rsAfYAwUOH212GukbWNnIg-1; Wed, 31 Aug 2022 11:01:16 -0400
X-MC-Unique: rsAfYAwUOH212GukbWNnIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 910051C01B34;
 Wed, 31 Aug 2022 15:01:15 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37F82403344;
 Wed, 31 Aug 2022 15:01:13 +0000 (UTC)
Message-ID: <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
Date: Wed, 31 Aug 2022 17:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Content-Language: en-US
To: jasowang@redhat.com, Greg KH <gregkh@linuxfoundation.org>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
 <YwxvXFiuRqGxRgZH@kroah.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <YwxvXFiuRqGxRgZH@kroah.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: guanjun@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, gautam.dawar@xilinx.com, elic@nvidia.com,
 dan.carpenter@oracle.com
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

On 8/29/22 09:48, Greg KH wrote:
> On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
>> If the VDUSE application provides a smaller config space
>> than the driver expects, the driver may use uninitialized
>> memory from the stack.
>>
>> This patch prevents it by initializing the buffer passed by
>> the driver to store the config value.
>>
>> This fix addresses CVE-2022-2308.
>>
>> Cc: xieyongji@bytedance.com
>> Cc: stable@vger.kernel.org # v5.15+
>> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> Please no blank line above the Acked-by: line here if possible.

Sure.

Jason, do you prefer I post a new revision with this single change or
you will handle it while applying? Either way is fine to me.

Thanks,
Maxime

> thanks,
> 
> greg k-h
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
