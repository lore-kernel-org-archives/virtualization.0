Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628F242931
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144204; cv=none; b=JLNdk89uS61mVCtOcflz2j8OcQBF9DoVzsNpsOUsKzDy6atQSFCXTb9Q1prj6n1/at+OCVWG7yimTUgo5EZExesx67aFYX6Jxxx9vRWNleuqE6Gq9G1aQ0Y9DyPXxd2NDj6v7l/1CMzq5fd5oQSWpN+785q4zBfGIG9qa4UJBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144204; c=relaxed/simple;
	bh=DOIjY6fFpbE95CM/j9yHxC7tRYy5BEyUaDAQBe9HJVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Q5Z1zpfm2iLKm8BandIFkllPNMOKPmxzYUv0C2N1ZmhDal+yFo/B4c8LSGpm6mryHENL0jUoVje8eDVoonPAuh3J1QFwt0/O85ZPNuuzOPRW6jLcNsKUgSHRipIDi5fPnMFAiJo/MeBQ8hIdBG2KUKQxo/c99aTgkDAN1jz6EaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVflbIDP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVflbIDP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747144202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRJWWcDi335/6emxoMHlLpNhiFKBt6kQvU2GZV5NCuc=;
	b=YVflbIDPFg7zSJzDbaT9iACRJF69TqHz+e9GTM+bmeDIWWbEvN1562VOrLH4PaoFl67Ivi
	ZGsoTrwreea47udqeCLDiOTdjRHkYX4wfsIMqbxGSIaexoHiwqwz5uIw2gSZhMmXlkpTX/
	nnZprL8yXFUR3xwI0g7IcvEDN0mBHpg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-0wJ9pTQcPSi3ejNexs2Reg-1; Tue, 13 May 2025 09:50:01 -0400
X-MC-Unique: 0wJ9pTQcPSi3ejNexs2Reg-1
X-Mimecast-MFC-AGG-ID: 0wJ9pTQcPSi3ejNexs2Reg_1747144200
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0b662be0cso3709595f8f.2
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 06:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144200; x=1747749000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRJWWcDi335/6emxoMHlLpNhiFKBt6kQvU2GZV5NCuc=;
        b=YD6wgcYclhcN6ZaqAHg116jtNuP++/2yR02TOZlNz7IdS4CVGvyZHNcow+tNzP3UMh
         8fVnv9nKJNdYw5nXQCSp/oW7RZgjFNGyQg07ex9+jKLmVECzcjiPd/uViw+3enyPL29z
         ivp3rZ7y1nLPOQ2cWMyvyYD1+FxBuf41S0cqtfUfUM7PmV4RzrDjM/lhhETLpweDL7zy
         rwcXc4oUe8D2wudM/qFWQ7ggaNNIHQ2AWBvenfYKj+B4lkGYAINfBsur6svt/NuS25m6
         fZm7P4AGtt/Xuz/u7F2NjbsELfGE1s4e8r/ZoPa5vLmOxCmRbGW9c6yoyrpXiZboEwNQ
         Kz/w==
X-Forwarded-Encrypted: i=1; AJvYcCVp1IIPMwRjMYvDHq5DhDMYyZ4B+E0sPdEMMO+EQsB9aBLz2G2XVkL1Uazzs4QzeRIfEjhDAmDSuYIcaRatOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNifgMaFdeyoHz1a380aaUmY1DnuKH1NMZnzrOrcAv4AjHzpG9
	dm3zoCoDoThAp/N+f9lfHSzjrTnjsLayfG0E7ue4TH2r9+Y8p6RDqOyp/gGf8uVo6mXTtJAd18I
	XWWvE9wPcCLL8DADENwC6NyprIQFo1cQX7H1BbPZpx1tBJevkHJzTJ1o6xAS/ao4+
X-Gm-Gg: ASbGnctZWiMuDgZfP57EEBBTmhp9xK6vmGt3P18xo84hN5mFtb0SHjZr68Z8Dxkquwt
	BNQKzq85i7bk/H9deyoImSHJB47A87slZdf7/+h2EwbSzY88b+NMxRbksS3KcyrVLnm5G8VgC1E
	kMsbTsWorSnHGiqDQAum45M2+/NfDOTPRKAvJtKgYnQY77fhc/Gs4hK0/Xtt0HDHz4vjsV8/j8k
	NwXtrWo2G1BgKn0dwlkOXC6dlW7EPY3HN90dEodG3L/x8pjKYBknM+k2rhujgS7+JEuhN2rfJGF
	e2BxMxZRFNNtWr0=
X-Received: by 2002:a5d:64c4:0:b0:3a1:fdfd:8f9f with SMTP id ffacd0b85a97d-3a1fdfd9039mr11285636f8f.1.1747144199776;
        Tue, 13 May 2025 06:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqs1aod1h//wk1qXe7kfyq+Liu2mtjZ/6io3a96s7Mn7jyQrUj9pR6kY5xZUjML6dt37F9jw==
X-Received: by 2002:a5d:64c4:0:b0:3a1:fdfd:8f9f with SMTP id ffacd0b85a97d-3a1fdfd9039mr11285598f8f.1.1747144199249;
        Tue, 13 May 2025 06:49:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2e9sm16213702f8f.75.2025.05.13.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:49:58 -0700 (PDT)
Date: Tue, 13 May 2025 15:49:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 2/2] vsock/test: check also expected errno on
 sigpipe test
Message-ID: <pjobj2gw4632k7sxhbekcms4klneqr3boik7gbnx5vvsqvdm72@c3ifhmjjkiwi>
References: <20250508142005.135857-1-sgarzare@redhat.com>
 <20250508142005.135857-3-sgarzare@redhat.com>
 <8d1206d1-1b62-48a4-a304-23e13c1316a3@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8d1206d1-1b62-48a4-a304-23e13c1316a3@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: clu1WA59KHS_xbz-W7Tz861pzJqMm_3SKCFK5iUbG_s_1747144200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 13, 2025 at 12:41:17PM +0200, Paolo Abeni wrote:
>On 5/8/25 4:20 PM, Stefano Garzarella wrote:
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 7de870dee1cf..533d9463a297 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -1074,9 +1074,13 @@ static void test_stream_check_sigpipe(int fd)
>>  	do {
>>  		res = send(fd, "A", 1, 0);
>>  		timeout_check("send");
>> -	} while (res != -1);
>> +	} while (res != -1 && errno == EINTR);
>
>I'm low on coffee, but should the above condition be:
>
>		res != -1 || errno == EINTR
>
>instead?

Ooops, copy & paste where we waited successful send().

>
>Same thing below.

I'll fix both!

Thanks,
Stefano

