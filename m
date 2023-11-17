Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382C101CA
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Nov 2023 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekY4lrx+"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0284E41FC3
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Nov 2023 08:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0284E41FC3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ekY4lrx+
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NxzuvG24HLm6
	for <virtualization@lists.linux-foundation.org>;
	Fri, 17 Nov 2023 08:30:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1B8541FC0
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Nov 2023 08:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1B8541FC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700209833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ecl6gR/j9l4tmwy6aDtejNzjXal2h/loVpF3cjPsjz4=;
	b=ekY4lrx+1BszsWYkTYfseQEu3PPzUW1lLXgQvCjiPsSY07D/YvpADgszYI+XsK075P4BmW
	5AF0UJeUMeH1wp6xcmWgrrUTmDpFvUKXJEALHB8n24uRG3BwBBRsogKWuDNNMPepXg/5oL
	UYpF/d1xJhfnhSMBoniJ6b1P72Canf4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-eposaAHOO_SU1NtMZBO7MA-1; Fri, 17 Nov 2023 03:30:29 -0500
X-MC-Unique: eposaAHOO_SU1NtMZBO7MA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53df4385dccso1485713a12.0
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Nov 2023 00:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700209828; x=1700814628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecl6gR/j9l4tmwy6aDtejNzjXal2h/loVpF3cjPsjz4=;
        b=exeNyCB3Yz3yX/r7rJ5vDRtj8pbEbyN55yFUwhwWtHy0GuCdrwkK6mW9CjmC5SyMsv
         vrKZOSaZ8gT3cXYCrGp3Hqkv2nfgESBtMDiinC7dS1IeLQKM7zHO4OMisn7AsXKcaclR
         H98ZOrxkY55etrNuN3rqGlk5I/7jb30vHEUHZGOVfmPrD6e5T2mRU9gO9YnYHnvqi5dt
         zvsjfTzU07TxAilH2glKbXBWRRr5GJRIsevEBdzWse7v36BxFPNSYoj6Wuqay0GpLVu7
         Fx/XkSzj188mrgRRgT5XGC3+QxxhHpbVziPN4vatd8B7MF/xHjGt61h+Ipz+BDYiXuzE
         SqZg==
X-Gm-Message-State: AOJu0YxCVIB5GhCguFD3ZHwZHyITJWTrOTJ0jmw1D05iZjvZ316tQjgk
	DEAZqJf0/IAXPQF1ysN7YpLx8a7IJ0cXkR7b5v8mywo3lxw180oCh/zP/AMza/Z4peItf1HbRxl
	AsJthiw8hUjGUKa6BZZo5IaOd0f08I5JPIjAiU51GSg==
X-Received: by 2002:a17:907:b9c3:b0:9f3:18f8:475b with SMTP id xa3-20020a170907b9c300b009f318f8475bmr6952579ejc.62.1700209828358;
        Fri, 17 Nov 2023 00:30:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFPEAnGCm1WVzr07XAT0pN1kw24RqLiQT9EjkeoYuqTICFcy0cLcinJxwF//W1biZMt6dF0g==
X-Received: by 2002:a17:907:b9c3:b0:9f3:18f8:475b with SMTP id xa3-20020a170907b9c300b009f318f8475bmr6952555ejc.62.1700209828011;
        Fri, 17 Nov 2023 00:30:28 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906b28200b009ad8acac02asm538543ejz.172.2023.11.17.00.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:30:27 -0800 (PST)
Date: Fri, 17 Nov 2023 09:30:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/2] vsock/test: SO_RCVLOWAT + deferred credit
 update test
Message-ID: <tbvwohgvrc6kvlsyap3sk5zqww5q6schsu4szx7e23wgg7pvb3@e7xa5mg5inul>
References: <20231108072004.1045669-1-avkrasnov@salutedevices.com>
 <20231108072004.1045669-3-avkrasnov@salutedevices.com>
 <zukasb6k7ogta33c2wik6cgadg2rkacestat7pkexd45u53swh@ovso3hafta77>
 <923a6149-3bd5-c5b4-766d-8301f9e7484a@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <923a6149-3bd5-c5b4-766d-8301f9e7484a@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Nov 17, 2023 at 10:12:38AM +0300, Arseniy Krasnov wrote:
>
>
>On 15.11.2023 14:11, Stefano Garzarella wrote:
>> On Wed, Nov 08, 2023 at 10:20:04AM +0300, Arseniy Krasnov wrote:
>>> This adds test which checks, that updating SO_RCVLOWAT value also sends
>>
>> You can avoid "This adds", and write just "Add test ...".
>>
>> See https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>>
>>     Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>>     instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>>     to do frotz", as if you are giving orders to the codebase to change
>>     its behaviour.
>>
>> Also in the other patch.
>>
>>> credit update message. Otherwise mutual hungup may happen when receiver
>>> didn't send credit update and then calls 'poll()' with non default
>>> SO_RCVLOWAT value (e.g. waiting enough bytes to read), while sender
>>> waits for free space at receiver's side.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> tools/testing/vsock/vsock_test.c | 131 +++++++++++++++++++++++++++++++
>>> 1 file changed, 131 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index c1f7bc9abd22..c71b3875fd16 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -1180,6 +1180,132 @@ static void test_stream_shutrd_server(const struct test_opts *opts)
>>>     close(fd);
>>> }
>>>
>>> +#define RCVLOWAT_CREDIT_UPD_BUF_SIZE    (1024 * 128)
>>> +#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE    (1024 * 64)
>>
>> What about adding a comment like the one in the cover letter about
>> dependency with kernel values?
>>
>> Please add it also in the commit description.
>>
>> I'm thinking if we should move all the defines that depends on the
>> kernel in some special header.
>
>IIUC it will be new header file in tools/testing/vsock, which includes such defines. At
>this moment in will contain only VIRTIO_VSOCK_MAX_PKT_BUF_SIZE. Idea is that such defines

So this only works on the virtio transport though, not the other
transports, right? (but maybe the others don't have this problem, so
it's fine).

>are not supposed to use by user (so do not move it to uapi headers), but needed by tests
>to check kernel behaviour. Please correct me if i'm wrong.

Right!
Maybe if it's just one, we can leave it there for now, but with a
comment on top explaining where it comes.

Thanks,
Stefano

