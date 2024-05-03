Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0126AF5
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751992; cv=none; b=tk23ydQPYUPLa1P7lZta7lPbpuby3HG3xZBvzTu6QbuyPmXdazVeJmI7htyHzlHnRF1/xM1G31PyxGS9rESEQ/lbB6TG3e+CUQYFtVkWr+novybJJigLuQwhCFVgLoXiaiNU/Lsi8pY+cyYeBvVYuMKphz+drO96Iy86mgDi2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751992; c=relaxed/simple;
	bh=62Oiyyi9HhrZbSTOPmcYG6s9RTji4r+qlEEYxy+w26Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fFnpLrs4YAwc9de/LT5yH9CuOpWeRtmgITfp/KWX5u5ipxnPN2+lFInDOH3RuS2GvpckXbIbWeEPtQFPn/UZf9vzFLKwKhtqG94FJKulZUD3xHamFd06s9mEL65vZR1n6eRB9GmQRr8OxpZZHZYg01hRPzhLOxxeL4cQsP+wI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feTpfLDA; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feTpfLDA"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9D5B6067E
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 15:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYx-hsexdr_5 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 May 2024 15:59:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=longman@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F03DC6065F
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F03DC6065F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=feTpfLDA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F03DC6065F
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 15:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714751988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dotrxA6jk+pxTdtbX79vKTZRiS20tBeZ4KHr0DfXaIM=;
	b=feTpfLDAq0yxzM9h0QljkSWeUb5QNX49p2id/UdClaHwW4+Hb7igE4h0hbmE30LtLa5qqK
	pWFXCdTa8IH+YrYyzsuHzpvMqySbjRIKJDPJKw+0aakhHyrKuCsQYQDmGWKWH8b3cQUlyo
	uDB/LayYP2NEu7FffdEsCIvfnZi1gzY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-YsEe4rRvPmiC4aoDpGZaTg-1; Fri,
 03 May 2024 11:59:47 -0400
X-MC-Unique: YsEe4rRvPmiC4aoDpGZaTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E1C93C3D0CA;
	Fri,  3 May 2024 15:59:46 +0000 (UTC)
Received: from [10.22.34.156] (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6C1B2166B31;
	Fri,  3 May 2024 15:59:45 +0000 (UTC)
Message-ID: <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
Date: Fri, 3 May 2024 11:59:44 -0400
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
From: Waiman Long <longman@redhat.com>
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
Content-Language: en-US
In-Reply-To: <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 12/31/23 23:14, Waiman Long wrote:
>
> On 12/31/23 16:55, David Laight wrote:
>> per_cpu_ptr() indexes __per_cpu_offset[] with the cpu number.
>> This requires the cpu number be 64bit.
>> However the value is osq_lock() comes from a 32bit xchg() and there
>> isn't a way of telling gcc the high bits are zero (they are) so
>> there will always be an instruction to clear the high bits.
>>
>> The cpu number is also offset by one (to make the initialiser 0)
>> It seems to be impossible to get gcc to convert 
>> __per_cpu_offset[cpu_p1 - 1]
>> into (__per_cpu_offset - 1)[cpu_p1] (transferring the offset to the 
>> address).
>>
>> Converting the cpu number to 32bit unsigned prior to the decrement means
>> that gcc knows the decrement has set the high bits to zero and doesn't
>> add a register-register move (or cltq) to zero/sign extend the value.
>>
>> Not massive but saves two instructions.
>>
>> Signed-off-by: David Laight <david.laight@aculab.com>
>> ---
>>   kernel/locking/osq_lock.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index 35bb99e96697..37a4fa872989 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
>>       return cpu_nr + 1;
>>   }
>>   -static inline struct optimistic_spin_node *decode_cpu(int 
>> encoded_cpu_val)
>> +static inline struct optimistic_spin_node *decode_cpu(unsigned int 
>> encoded_cpu_val)
>>   {
>> -    int cpu_nr = encoded_cpu_val - 1;
>> -
>> -    return per_cpu_ptr(&osq_node, cpu_nr);
>> +    return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);
>>   }
>>     /*
>
> You really like micro-optimization.
>
> Anyway,
>
> Reviewed-by: Waiman Long <longman@redhat.com>
>
David,

Could you respin the series based on the latest upstream code?

Thanks,
Longman

