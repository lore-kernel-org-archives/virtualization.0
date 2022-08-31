Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5471C3DA6B
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 15:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3503B82FCE;
	Wed, 31 Aug 2022 15:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3503B82FCE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MVZK/yxM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9laSAc09iY-N; Wed, 31 Aug 2022 15:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D351483096;
	Wed, 31 Aug 2022 15:47:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D351483096
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE53AC0033;
	Wed, 31 Aug 2022 15:47:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D7B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3834040C95
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:47:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3834040C95
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MVZK/yxM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbUTfMzOK3Ti
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:47:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 864C240C88
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 864C240C88
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661960836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NxgaFHUehuqjwIf0MKur/TlbgskJq79bsqFn4J7ILg=;
 b=MVZK/yxMCSbqxxVzc/iqFMLWqJhE0D6R4XMTBlQvbffLq8O833oi0fLpVcKJA7SBXsJq+L
 RQxwuAVXhBlehOj5JeEr4F12daZaGMptmXr2KK5Q0LDoqeCTvmT9LWfPHo71l1OrzNQf2t
 adBQfJuqPgPVrkbldmH1Dkg4GakAAGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-A5LStEIwOyKcIOrAqf4aPA-1; Wed, 31 Aug 2022 11:47:14 -0400
X-MC-Unique: A5LStEIwOyKcIOrAqf4aPA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D77F800124;
 Wed, 31 Aug 2022 15:47:14 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C416A2166B26;
 Wed, 31 Aug 2022 15:47:11 +0000 (UTC)
Message-ID: <175a4e24-f8ee-ee9d-d02e-6a61d18a75ad@redhat.com>
Date: Wed, 31 Aug 2022 17:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
 <YwxvXFiuRqGxRgZH@kroah.com>
 <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
 <20220831114534-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20220831114534-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: guanjun@linux.alibaba.com, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, gautam.dawar@xilinx.com, dan.carpenter@oracle.com
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



On 8/31/22 17:46, Michael S. Tsirkin wrote:
> On Wed, Aug 31, 2022 at 05:01:11PM +0200, Maxime Coquelin wrote:
>> On 8/29/22 09:48, Greg KH wrote:
>>> On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
>>>> If the VDUSE application provides a smaller config space
>>>> than the driver expects, the driver may use uninitialized
>>>> memory from the stack.
>>>>
>>>> This patch prevents it by initializing the buffer passed by
>>>> the driver to store the config value.
>>>>
>>>> This fix addresses CVE-2022-2308.
>>>>
>>>> Cc: xieyongji@bytedance.com
>>>> Cc: stable@vger.kernel.org # v5.15+
>>>> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
>>>>
>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>
>>> Please no blank line above the Acked-by: line here if possible.
>>
>> Sure.
>>
>> Jason, do you prefer I post a new revision with this single change or
>> you will handle it while applying? Either way is fine to me.
>>
>> Thanks,
>> Maxime
> 
> I queue these normally.

Ok, I'm preparing the V2.

Thanks,
Maxime

>>> thanks,
>>>
>>> greg k-h
>>>
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
