Return-Path: <SRS0=Urmt=DX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBEC43457
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 09:00:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415B20872
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 09:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4MYi8FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 43F39888F8;
	Fri, 16 Oct 2020 09:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id osuYvqzxVFml; Fri, 16 Oct 2020 09:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 875ED886BB;
	Fri, 16 Oct 2020 09:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66704C0052;
	Fri, 16 Oct 2020 09:00:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21F1CC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0EC622E70A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOO0Z8zg32YU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 736612E6FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602838826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oygrWY6toZNj3SgGz0MClMg8QLNvLxYmh1V2FbmIngc=;
 b=U4MYi8FEj3OzoqfTXlsO6zcdt7JhHJjIl+xUnhHfX2q8Fy60CpOzIf3DCE9jIctKroUepa
 +7kfb39DqpMT9053qz8Uo24oLAEox6aFcLrze4H6V0dc1cWcU3gKd8e2KzbZmpn+5yylLl
 bC7qJZve9trPvm78aJ0gGRymB1+RC9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-r8JX7_GHM5e6gXIzLgalbw-1; Fri, 16 Oct 2020 05:00:24 -0400
X-MC-Unique: r8JX7_GHM5e6gXIzLgalbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D180D186DD27;
 Fri, 16 Oct 2020 09:00:22 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 882605D9D5;
 Fri, 16 Oct 2020 09:00:18 +0000 (UTC)
Subject: Re: [PATCH v1 02/29] virtio-mem: simplify calculation in
 virtio_mem_mb_state_prepare_next_mb()
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-3-david@redhat.com>
 <CAM9Jb+h=2Wg3qAggjAfBf7yyvL9HU6xns7_giJfw6smkCAJ6SQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <09e63b8a-fb46-c8ae-7512-84b1dd234075@redhat.com>
Date: Fri, 16 Oct 2020 11:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+h=2Wg3qAggjAfBf7yyvL9HU6xns7_giJfw6smkCAJ6SQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "Michael S . Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
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

On 15.10.20 22:24, Pankaj Gupta wrote:
>> We actually need one byte less (next_mb_id is exclusive, first_mb_id is
>> inclusive). Simplify.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  drivers/virtio/virtio_mem.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index a1f5bf7a571a..670b3faf412d 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -257,8 +257,8 @@ static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
>>   */
>>  static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
>>  {
>> -       unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id + 1;
>> -       unsigned long new_bytes = vm->next_mb_id - vm->first_mb_id + 2;
>> +       unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
>> +       unsigned long new_bytes = old_bytes + 1;
> 
> Maybe we can avoid new_bytes & old_bytes variables, instead use single
> variable. Can later be used with PFN_UP/PFN_DOWN.

I'll see if it fits into a single line now - if it does, I'll move it
there. Thanks!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
