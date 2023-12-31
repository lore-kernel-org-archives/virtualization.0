Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4EA53
	for <virtualization@lists.linux-foundation.org>; Sun, 31 Dec 2023 02:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6DJKOXZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6F4281DE4
	for <virtualization@lists.linux-foundation.org>; Sun, 31 Dec 2023 02:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6F4281DE4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6DJKOXZ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGoJ-7cOyHlh
	for <virtualization@lists.linux-foundation.org>;
	Sun, 31 Dec 2023 02:14:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8434781DE1
	for <virtualization@lists.linux-foundation.org>; Sun, 31 Dec 2023 02:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8434781DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703988888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQGk7yOrBakLlkSNJ7E5edrKcFI3/TDFPl1TX0TJfZ8=;
	b=g6DJKOXZyKP7k9GgXwoA7ceS7e5VRp7s/Y7KETDO285dBFPXx2+fn9Pifiqo6x54Dp1OKm
	7jpRIZLJuzShcDVK25BugaiCoFjM0Co2/ZxXjxEJBzJ7VDtXmeR3BIBx9x9b4MXwKFEdIo
	n5Zm3pTX66/t49OixWHT73heIUg4ba8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-juMStKzAOYWIOWG4VeLAQg-1; Sat,
 30 Dec 2023 21:14:43 -0500
X-MC-Unique: juMStKzAOYWIOWG4VeLAQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BA55285F997;
	Sun, 31 Dec 2023 02:14:43 +0000 (UTC)
Received: from [10.22.32.46] (unknown [10.22.32.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D3904186E;
	Sun, 31 Dec 2023 02:14:42 +0000 (UTC)
Message-ID: <f04371f9-c2bd-4e66-a7a2-87042f786cb8@redhat.com>
Date: Sat, 30 Dec 2023 21:14:41 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock code
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 'Linus Torvalds' <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "xinhui.pan@linux.vnet.ibm.com" <xinhui.pan@linux.vnet.ibm.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Zeng Heng <zengheng4@huawei.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
 <1015f066d717465191c7b7599257f683@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <1015f066d717465191c7b7599257f683@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 12/30/23 17:39, David Laight wrote:
> From: Linus Torvalds
>> Sent: 30 December 2023 19:41
>>
>> On Fri, 29 Dec 2023 at 12:52, David Laight <David.Laight@aculab.com> wrote:
>>> David Laight (5):
>>>    Move the definition of optimistic_spin_node into osf_lock.c
>>>    Clarify osq_wait_next()
>> I took these two as preparatory independent patches, with that
>> osq_wait_next() clarification split into two.
>>
>> I also did the renaming that Waiman asked for.
> Ok, I'll try to remove them from any respin.
> (Or at least put them first!)

The first 2 patches have been included in Linus' master branch. So you 
should just remove them from a respin.

Cheers,
Longman


