Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0E1D5CD1
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143986; cv=none; b=oZx0yVAOxa6BgW6PUwpXyMEXyBnDPc99YbbjqjJJFsH1xuStBv7oIYziLaJeRJlMf4/3RCjvrn1g8DE5CdyTcRG0ZdGztaNxLK9Qc2+xAyeizx9feuazOHZSRmLkSyxPqXv4sYPdZLRrdJXrl8hdIIvvZkwRymd/LVSRe8he/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143986; c=relaxed/simple;
	bh=0sH/Zz5U3ejyb7A/1UoukQjUMw+jDmh2HmotW9IgiF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=balcAtOpiw6QCE1Gwf7qTjTU6t3UwBD7BqYZ63O18z+33hVmgnEd5Vws9wf8tI32XZC4OUCHpF62lYtCSqy7RpKwQW0290NNrvV0kAhn18UqFk7bGWXrc/Fcyz8sHD6uZ1iJe+CRU2774RyFFELcgul5t5wMp/E6jyHdiM1KpLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g29h2C8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g29h2C8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747143983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/70FQOGYyD+dIqipphYHr/s8Vpxiqi+lh5GlyAwZuY=;
	b=g29h2C8MUve9U3FMF98r050TGHo1TF71rNubBXwve6Y029SiJaPZxRRG8PQPfQxA91XNYc
	XMqJWYCY0Sw0E54XqDMAtBe13gXrmzEy370JjEl3K4ghBEFVYz38TY+jjUkKy4CKeOWiU9
	1FPn0l0zIwpaG8Yo7sSjZP7fxOuKaZc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-4xt7NDK1OWiELKbQGTMmJQ-1; Tue, 13 May 2025 09:46:21 -0400
X-MC-Unique: 4xt7NDK1OWiELKbQGTMmJQ-1
X-Mimecast-MFC-AGG-ID: 4xt7NDK1OWiELKbQGTMmJQ_1747143981
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0b1798d69so2030222f8f.3
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 06:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747143981; x=1747748781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/70FQOGYyD+dIqipphYHr/s8Vpxiqi+lh5GlyAwZuY=;
        b=Mfw3AsxQAsDxrGDN6NN7t33CjR7fOb+RJ/O+kGMd82FBhI+QqnrZfEcNkxK3f88gDG
         LeTxrCc2kDVzL18uXobUJEWPDlliN/8rqhsD1/eWyyRCd/OHeQYyWBHQfTrrhcmFmJR3
         lrAdDl9vhYVa4c2YPCxO5O5KkuZACPt4FM7GbKzaAsShZCNtX2vQodHLoP8/enJ8o4fO
         1JRtgk7wfvPdD/urbrUCbdQXQP7Vn1+CaYKGODa5Y4+uXjtMK1g5NMOCoErL8ddXmFPy
         bveS5I2S/A+AMq7K4pg4Xa7pvanrfUidnmS7AoA40r2Z0Y0c+k0Cx6fVKzpL2gK7H7tn
         L2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXik+uYCGNce5x8qAQbTHtg/OHrJcAy2HOGsWnHooSJd99xksjLO+V5VJ5T9xc0/m8eNKfYODTAggVoNVaxog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx30FR5wMz7uVgQADIAC2sNr/XUrlhJ5MIP7bnd9iXRQuFDAZpw
	a3Fhl70DxCN9/Lv9uVwexQshKKDMkgOVUX/LM9zIgbhomZ/fQ/JwA/Zm/zS6eGoHcOAsnrW8naw
	EqEXkU8jUGiufxTmsxFpS2TX4YagjmR9kN6Gf5PJNhLI/C8uwk4Z8FxG72oCxEkmf
X-Gm-Gg: ASbGnctnBFahAvztttE3ZyqtMcoUJogC9kJEbxTeiYWmDISHTOdWKJh71swO95J9/tE
	kUKIhHvd84/xm5N35TzuJHC2RlpL3V7A78rwFE3k5jIkxMYorPNQyR84aCcw32RGahm4o9n2o2D
	KQjBTpIk2RAt2r48lilh8iz9ZgWGckVwOfrkaEXxOp1ybf3KVvtQfN1X1lRNao4N3IITAGm3kzk
	Ve1hK9WBxtx+PyAygNT1VNQvR2eFzYcmHBTZmkLY1NSsMG6x4m95uaqsl2Xd2X7wPfVvVVrtty9
	23KjFSlX+32OF0g=
X-Received: by 2002:a05:6000:2410:b0:3a0:b294:cce9 with SMTP id ffacd0b85a97d-3a1f643a796mr12918280f8f.23.1747143980619;
        Tue, 13 May 2025 06:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWY7T39rW0AdmPAPBxdBlGBZlPcJ8Npi8waB/6mxTKr0KbpuEtniEFJdEonFVvK7Xgsw8DFg==
X-Received: by 2002:a05:6000:2410:b0:3a0:b294:cce9 with SMTP id ffacd0b85a97d-3a1f643a796mr12918246f8f.23.1747143980005;
        Tue, 13 May 2025 06:46:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2af7sm16485601f8f.52.2025.05.13.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:46:19 -0700 (PDT)
Date: Tue, 13 May 2025 15:46:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] vsock/test: retry send() to avoid
 occasional failure in sigpipe test
Message-ID: <vheia3vqebshkzajzb6qhxppjvj7onvtjezw5pddfl6qqrnrma@h3dpvkla2pco>
References: <20250508142005.135857-1-sgarzare@redhat.com>
 <20250508142005.135857-2-sgarzare@redhat.com>
 <2c5581b9-c0a4-4620-ac82-0a98abfd4d0d@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2c5581b9-c0a4-4620-ac82-0a98abfd4d0d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZkohUfPp-N4zOKvqo3iLQk8c7wjM03Xj-_AhNjSM7xU_1747143981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 13, 2025 at 12:37:36PM +0200, Paolo Abeni wrote:
>On 5/8/25 4:20 PM, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When the other peer calls shutdown(SHUT_RD), there is a chance that
>> the send() call could occur before the message carrying the close
>> information arrives over the transport. In such cases, the send()
>> might still succeed. To avoid this race, let's retry the send() call
>> a few times, ensuring the test is more reliable.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index d0f6d253ac72..7de870dee1cf 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -1064,11 +1064,18 @@ static void test_stream_check_sigpipe(int fd)
>>
>>  	have_sigpipe = 0;
>>
>> -	res = send(fd, "A", 1, 0);
>> -	if (res != -1) {
>> -		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>> -		exit(EXIT_FAILURE);
>> -	}
>> +	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
>> +	 * the send() call could occur before the message carrying the close
>> +	 * information arrives over the transport. In such cases, the send()
>> +	 * might still succeed. To avoid this race, let's retry the send() call
>> +	 * a few times, ensuring the test is more reliable.
>> +	 */
>> +	timeout_begin(TIMEOUT);
>> +	do {
>> +		res = send(fd, "A", 1, 0);
>> +		timeout_check("send");
>> +	} while (res != -1);
>
>AFAICS the above could spin on send() for up to 10s, I would say
>considerably more than 'a few times' ;)
>
>In practice that could cause side effect on the timing of other
>concurrent tests (due to one CPU being 100% used for a while).
>
>What if the peer rcvbuf fills-up: will the send fail? That could cause
>false-negative.

Good point!

>
>I *think* it should be better to insert a short sleep in the loop.

Agree, I'll add.

Thanks,
Stefano

