Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3618890B
	for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424691; cv=none; b=WfZvgiNgbBk5oF7iJ3oXBPc15VNAOVii76zA7ipRW+p8vsY+oeHYVS1PFDUCfjBcOYDXkh/cq2tnPMhM7OAcXzISgc6/2It6NWACqQxqHL5RRwfwnA9KSepms30Lo8pTdr9MXDgackbMvdj2p3uQf01bT0FmgOyfcTnqbjeTWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424691; c=relaxed/simple;
	bh=b4C+Oy37DV2Kzj7Jrf0dTC698njLjd23JNwPJG1/FcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D7j+FrVMCNQn88AB9YbcS/Qc6Z2r3epVQm4CuqwrYnjp3UsLQc67GL7iRcgn7HGZ5+i2glSnQQbeOr7fcXBhFFur3aejIIhPJLfkifJClMk3GQBdEF0txtJMezxC/SnlB8Y2cjrnFwvmw0h/EseUOlS7E3niu68rPcXpxD/DcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=ieVhuQSC; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ieVhuQSC"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FE2B401D8
	for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 14:51:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEUJKUZgrkNZ for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Aug 2024 14:51:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b34; helo=mail-yb1-xb34.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4250140129
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4250140129
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=ieVhuQSC
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4250140129
	for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 14:51:28 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-e1651f48c31so1992178276.0
        for <virtualization@lists.linux-foundation.org>; Fri, 23 Aug 2024 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724424687; x=1725029487; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4C+Oy37DV2Kzj7Jrf0dTC698njLjd23JNwPJG1/FcU=;
        b=ieVhuQSCUHSfZVx0XnDc4ZlRjsv598i5FD78dCyWXuF0NddYgzYs+k7nvUIgXMVt8C
         p2Ly8wKoeo5CcM/q6gegs/RKsyh+l7pMHU3C5Oyxtzw8/dRYyi67mdWhtg1hDro0nIdl
         NOLRqYm8ol453r/A1q5HRsWQVCUQT1h2MLvWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724424687; x=1725029487;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4C+Oy37DV2Kzj7Jrf0dTC698njLjd23JNwPJG1/FcU=;
        b=iNnBdlGkT+nZFipY6lj1kslL8fnz377GN9fXqWH1Hsx3tLS75V8MtZWNAoc8KFnUTr
         F7d9HAjnEdPBBF+jyUhD0GG+lk4eykr/qQxm4vjr7qXM+nAl2AIm67siHYylD03iVSGa
         hlUc/RUQaJFP/zzfTukYq+KQlExPt48m3L92TnfWKggQIY84XBCB6H4VdWrqhS5/5pTX
         SACzxF4XOfto1kpWHMkYkeIW1lpTadw6ymr1LYoVFHRmjgZlsZ/qPg5F9KUmOiYgk10Q
         3TqBj/YNGrLMiLz71vztD3qnHgdJJKVxz/p88UMUDpIWPDGj6Pq9rPXui0l5EoK5g0nM
         Sk9Q==
X-Gm-Message-State: AOJu0YyFAW4yriU7SRPbbWUjJGjswgrwRQa1JFbhPXVwmlW2Qpwsk7+E
	wKVUNvw4SJBUQJGUgZSTmhjRrfqQE+rf6voGaSSt5ffWvaU3IcAkCqggVhgGNxZqw9FuLkDsRGe
	7Ty4pJg==
X-Google-Smtp-Source: AGHT+IG6JLoQwXGBZb5kz/05HTW1+oRlGRg0Y8dCBjJ8Cxj2vuoaOWbYxxL+QDFhLPXt07y77oLlWw==
X-Received: by 2002:a05:6902:1109:b0:e16:6b7e:94b5 with SMTP id 3f1490d57ef6-e17a86a517emr3398358276.48.1724424686570;
        Fri, 23 Aug 2024 07:51:26 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e46361csm707782276.19.2024.08.23.07.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 07:51:26 -0700 (PDT)
Message-ID: <e7ba91a7-2ba6-4532-a59a-03c2023309c6@digitalocean.com>
Date: Fri, 23 Aug 2024 09:51:24 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] vDPA: Trying to make sense of config data
From: Carlos Bilbao <cbilbao@digitalocean.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
Content-Language: en-US
In-Reply-To: <4f4572c8-1d8c-4ec6-96a1-fb74848475af@digitalocean.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello again, 

Answering my own question:

https://elixir.bootlin.com/linux/v6.10.2/source/include/uapi/linux/virtio_net.h#L92

Thanks, Carlos

On 8/22/24 1:21 PM, Carlos Bilbao wrote:
> Hello folks,
>
> I'm using the code below to retrieve configuration data for my vDPA file
> via ioctl. I get as output:
>
> Configuration data (24 bytes):
> 5a c3 5f 68 48 a9 01 00 08 00 dc 05 00 00 00 00
> 00 00 00 00 00 00 00 00
> ASCII representation:
> Z._hH...................
>
> Could a good Samaritan point me in the right direction for the docs I need
> to understand these values and convert them to a human-readable format?
> hank you in advance!
>
> Regards,
> Carlos
>
> ---
>
> void check_config(int fd) {
>
>     uint32_t size;
>     struct vhost_vdpa_config *config;
>     uint8_t *buf;
>
>     if (ioctl(fd, VHOST_VDPA_GET_CONFIG_SIZE, &size) < 0) {
>         perror("ioctl failed");
>         return;
>     }
>
>     config = malloc(sizeof(struct vhost_vdpa_config) + size);
>     if (!config) {
>         perror("malloc failed");
>         return;
>     }
>
>     memset(config, 0, sizeof(struct vhost_vdpa_config) + size);
>     config->len = size;
>     config->off = 0;
>
>     buf = config->buf;
>
>     if (ioctl(fd, VHOST_VDPA_GET_CONFIG, config) < 0) {
>         perror("ioctl failed");
>     } else {
>         printf("Configuration data (%u bytes):\n", size);
>
>         /* Print the data in a human-readable format */
>         for (unsigned int i = 0; i < size; i++) {
>             if (i % 16 == 0 && i != 0) printf("\n");
>             printf("%02x ", buf[i]);
>         }
>         printf("\n");
>
>         printf("ASCII representation:\n");
>         for (unsigned int i = 0; i < size; i++) {
>             if (buf[i] >= 32 && buf[i] <= 126) {
>                 printf("%c", buf[i]);
>             } else {
>                 printf(".");
>             }
>         }
>         printf("\n");
>     }
>
>     free(config);
> }
