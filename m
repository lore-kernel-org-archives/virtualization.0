Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9DF59162
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774427; cv=none; b=b2DyoP37VpukCmuJOyNDP4DW5u58LultebNHXmpYSJvbotyvAtJk+Y4VsHCpUnX9Dpf9q9kOifyWzwga9fnAvzeSJ/wrzzbkOphMTDrfDf4qRjqwG+pQaXwi2GUKe9RF5+haAyxgMKgxbbO3beEfwZfxKyBGEXBx8mXp9+YOgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774427; c=relaxed/simple;
	bh=HbGa2OPDrW1btTMtK6Lox9/dGpxHQnDUa2fRGEVQEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knQ4+H72jDenMoEUduCRmmZhz7qvP1nUvdH4csUUBc8hY6KaECYfrhSiO/0dp9ZZ2gocUwnHi+CRIc1sYO3nHbUMzTvLd9BN80yAg6f2EWs+GtO7SP4xYwxmO8mQDjJrrhiZcsW1r1Q+gtSMIs2QDJfGw57r9amnf0Vqtk6vwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6krOpFy; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6krOpFy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73A2F606A8
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 22:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6Ay1kuoApbh for <virtualization@lists.linux-foundation.org>;
 Fri,  3 May 2024 22:13:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=longman@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C6DB6606A7
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6DB6606A7
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V6krOpFy
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6DB6606A7
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 22:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714774423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXJGg6Yv+cev4+++4ag1dpaYqLQ1DRjklZr5exWF9PQ=;
	b=V6krOpFy7CNhCwUnfYutkbDGHI1z9mhJRGYKYiZKeonkaXCQ91s6ME8lyShXRp1HQC2IYh
	7lSx9x30JDL21caZb5F+2FZ9ZAj4OAcEuD0HXVXSLhX5T1UQvZLXiaFh9LaZQH0sP55J4U
	9CXJOuffv8wD2w8HS8ZmBuqnqgnfrWc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-ZoJOM9MwNsKw103QBC28Mw-1; Fri,
 03 May 2024 18:13:39 -0400
X-MC-Unique: ZoJOM9MwNsKw103QBC28Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23E9B29AB3F5;
	Fri,  3 May 2024 22:13:39 +0000 (UTC)
Received: from [10.22.34.156] (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67F5540C140B;
	Fri,  3 May 2024 22:13:38 +0000 (UTC)
Message-ID: <8373c730-2e08-4abb-8d21-fd9a76116d2c@redhat.com>
Date: Fri, 3 May 2024 18:13:38 -0400
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
 <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
 <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 5/3/24 17:10, David Laight wrote:
> From: Waiman Long
>> Sent: 03 May 2024 17:00
> ...
>> David,
>>
>> Could you respin the series based on the latest upstream code?
> I've just reapplied the patches to 'master' and they all apply
> cleanly and diffing the new patches to the old ones gives no differences.
> So I think they should still apply.
>
> Were you seeing a specific problem?
>
> I don't remember any suggested changed either.
> (Apart from a very local variable I used to keep a patch isolated.)

No, I just want to make sure that your patches will still apply. Anyway, 
it will be easier for the maintainer to merge your remaining patches if 
you can send out a new version even if they are almost the same as the 
old ones.

Thanks,
Longman

