Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B015EA3
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgCeQvdH"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4A9C81EB4
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:37:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4A9C81EB4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PgCeQvdH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s59wiWWFFaEI
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 09:36:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B75B81392
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B75B81392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701250618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmfiUoMGCSqDA5zypbVWGdwfGo6gARdw5ZkS+2p63ME=;
	b=PgCeQvdHwLgr8Z0EWYoyCPRavyvUj8sQ12uJ6jix8NC7l9stSeCQM/En8QlYrqOofHVh4/
	rG2c+9+5+LMGidwUbYQV0zkJ31X/AzQveZZuuUHBKuV3UwdACc26Lgn0qk3tjkR6jNOLP1
	KLtyuhFCLxGLpfRwrBC8okiXiKWuGXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-uiCuPBvVNu2RhGtIO5Rsmw-1; Wed, 29 Nov 2023 04:36:56 -0500
X-MC-Unique: uiCuPBvVNu2RhGtIO5Rsmw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b2a386e8dso42883925e9.0
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 01:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250615; x=1701855415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmfiUoMGCSqDA5zypbVWGdwfGo6gARdw5ZkS+2p63ME=;
        b=lEbYg0ae5cnNu57S3hAsHfm5kiWr/W5Tvw2cSfJAAJrE/jWh0fIBGo6H5hxGC2jb3G
         ZvOYxoQzQpSwzg/sBn4U2tv4/yuBECN0E9or0L5Emr5vVUHFDbG7reI6D/SuiUZnIKeF
         yMm+nbzuzi2CNmi0HEpTgtk3qiVSPm0TUNgPH/gBzBBNsVtBzhv5SAAgN5Oc5uwbVteD
         MtllpkaXPE3lRnOs3m2J3YrKpcTitalgmjGVh1+9UgJtgmAA5jekx04maU/GNHPqtIs2
         H79jzewyEoPSElJHsPVkD9GeU2CMlzJlgS4Qf9ebKiUaRc9zUP7GxV6zsyv3BYX8nuAN
         HaTw==
X-Gm-Message-State: AOJu0Yx6DrSVCfEPag85cRAiFCmQeiLBC28QiLnshl1a5IFsssiQrJ1F
	rYkaUlePMlkEl8o6lIGbxjvzmoAxWuZoLPxD0GqkUs49+zlv24GZn/ss4kBT3gk/ZJ18409TpJl
	E9cKZcjnjW03ccRBx1VbQgRC/IZmyCYfBAb0aDfLBkA==
X-Received: by 2002:a05:600c:46cc:b0:402:e68f:8896 with SMTP id q12-20020a05600c46cc00b00402e68f8896mr9785471wmo.0.1701250614866;
        Wed, 29 Nov 2023 01:36:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4BRcthRqpUqHsj2H4jRhD7y7b/qGrQhDTQGqXi1seM0N+RIMB0GeDrMRO80d/ClXyeYP18g==
X-Received: by 2002:a05:600c:46cc:b0:402:e68f:8896 with SMTP id q12-20020a05600c46cc00b00402e68f8896mr9785450wmo.0.1701250614447;
        Wed, 29 Nov 2023 01:36:54 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040b43da0bbasm1518805wmq.30.2023.11.29.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:36:53 -0800 (PST)
Date: Wed, 29 Nov 2023 10:36:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v3 3/3] vsock/test: SO_RCVLOWAT + deferred credit
 update test
Message-ID: <grwpjitnh6jqlougrw2b5xibuclos3tpgyxv5exgcbnvcy6crp@jt4o2hz6pk6n>
References: <20231122180510.2297075-1-avkrasnov@salutedevices.com>
 <20231122180510.2297075-4-avkrasnov@salutedevices.com>
 <mklk6i6frkms33qntatlejbyl2czf7sp4quorkuxy6lpwmmlcn@foknxen36olr>
 <be8b1d3e-7032-76dc-042c-9513a933a0f3@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <be8b1d3e-7032-76dc-042c-9513a933a0f3@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 29, 2023 at 12:16:54PM +0300, Arseniy Krasnov wrote:
>
>
>On 29.11.2023 12:16, Stefano Garzarella wrote:
>> On Wed, Nov 22, 2023 at 09:05:10PM +0300, Arseniy Krasnov wrote:
>>> Test which checks, that updating SO_RCVLOWAT value also sends credit
>>> update message. Otherwise mutual hungup may happen when receiver didn't
>>> send credit update and then calls 'poll()' with non default SO_RCVLOWAT
>>> value (e.g. waiting enough bytes to read), while sender waits for free
>>> space at receiver's side. Important thing is that this test relies on
>>> kernel's define for maximum packet size for virtio transport and this
>>> value is not exported to user: VIRTIO_VSOCK_MAX_PKT_BUF_SIZE (this
>>> define is used to control moment when to send credit update message).
>>> If this value or its usage will be changed in kernel - this test may
>>> become useless/broken.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>> Changelog:
>>> v1 -> v2:
>>>  * Update commit message by removing 'This patch adds XXX' manner.
>>>  * Update commit message by adding details about dependency for this
>>>    test from kernel internal define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>>>  * Add comment for this dependency in 'vsock_test.c' where this define
>>>    is duplicated.
>>> v2 -> v3:
>>>  * Replace synchronization based on control TCP socket with vsock
>>>    data socket - this is needed to allow sender transmit data only
>>>    when new buffer size of receiver is visible to sender. Otherwise
>>>    there is race and test fails sometimes.
>>>
>>> tools/testing/vsock/vsock_test.c | 142 +++++++++++++++++++++++++++++++
>>> 1 file changed, 142 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index 5b0e93f9996c..773a71260fba 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -1225,6 +1225,143 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
>>>     }
>>> }
>>>
>>> +#define RCVLOWAT_CREDIT_UPD_BUF_SIZE    (1024 * 128)
>>> +/* This define is the same as in 'include/linux/virtio_vsock.h':
>>> + * it is used to decide when to send credit update message during
>>> + * reading from rx queue of a socket. Value and its usage in
>>> + * kernel is important for this test.
>>> + */
>>> +#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE    (1024 * 64)
>>> +
>>> +static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opts)
>>> +{
>>> +    size_t buf_size;
>>> +    void *buf;
>>> +    int fd;
>>> +
>>> +    fd = vsock_stream_connect(opts->peer_cid, 1234);
>>> +    if (fd < 0) {
>>> +        perror("connect");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    /* Send 1 byte more than peer's buffer size. */
>>> +    buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE + 1;
>>> +
>>> +    buf = malloc(buf_size);
>>> +    if (!buf) {
>>> +        perror("malloc");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    /* Wait until peer sets needed buffer size. */
>>> +    recv_byte(fd, 1, 0);
>>> +
>>> +    if (send(fd, buf, buf_size, 0) != buf_size) {
>>> +        perror("send failed");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    free(buf);
>>> +    close(fd);
>>> +}
>>> +
>>> +static void test_stream_rcvlowat_def_cred_upd_server(const struct test_opts *opts)
>>> +{
>>> +    size_t recv_buf_size;
>>> +    struct pollfd fds;
>>> +    size_t buf_size;
>>> +    void *buf;
>>> +    int fd;
>>> +
>>> +    fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>>> +    if (fd < 0) {
>>> +        perror("accept");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
>>> +
>>> +    if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>>> +               &buf_size, sizeof(buf_size))) {
>>> +        perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    /* Send one dummy byte here, because 'setsockopt()' above also
>>> +     * sends special packet which tells sender to update our buffer
>>> +     * size. This 'send_byte()' will serialize such packet with data
>>> +     * reads in a loop below. Sender starts transmission only when
>>> +     * it receives this single byte.
>>> +     */
>>> +    send_byte(fd, 1, 0);
>>> +
>>> +    buf = malloc(buf_size);
>>> +    if (!buf) {
>>> +        perror("malloc");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    /* Wait until there will be 128KB of data in rx queue. */
>>> +    while (1) {
>>> +        ssize_t res;
>>> +
>>> +        res = recv(fd, buf, buf_size, MSG_PEEK);
>>> +        if (res == buf_size)
>>> +            break;
>>> +
>>> +        if (res <= 0) {
>>> +            fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>>> +            exit(EXIT_FAILURE);
>>> +        }
>>> +    }
>>> +
>>> +    /* There is 128KB of data in the socket's rx queue,
>>> +     * dequeue first 64KB, credit update is not sent.
>>> +     */
>>> +    recv_buf_size = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>>> +    recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
>>> +    recv_buf_size++;
>>> +
>>> +    /* Updating SO_RCVLOWAT will send credit update. */
>>> +    if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>>> +               &recv_buf_size, sizeof(recv_buf_size))) {
>>> +        perror("setsockopt(SO_RCVLOWAT)");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    memset(&fds, 0, sizeof(fds));
>>> +    fds.fd = fd;
>>> +    fds.events = POLLIN | POLLRDNORM | POLLERR |
>>> +             POLLRDHUP | POLLHUP;
>>> +
>>> +    /* This 'poll()' will return once we receive last byte
>>> +     * sent by client.
>>> +     */
>>> +    if (poll(&fds, 1, -1) < 0) {
>>> +        perror("poll");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    if (fds.revents & POLLERR) {
>>> +        fprintf(stderr, "'poll()' error\n");
>>> +        exit(EXIT_FAILURE);
>>> +    }
>>> +
>>> +    if (fds.revents & (POLLIN | POLLRDNORM)) {
>>> +        recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
>>
>> Should we set the socket non-blocking?
>>
>> Otherwise, here poll() might wake up even if there are not all the
>> expected bytes due to some bug and recv() block waiting for the
>> remaining bytes, so we might not notice the bug.
>
>Good point! or just use MSG_DONTWAIT flag for only this 'recv()'.

Yep, right!

Stefano

