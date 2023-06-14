Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930B4EB64D8
	for <virtualization@archiver.kernel.org>; Wed, 14 Jun 2023 14:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 267DF4151A;
	Wed, 14 Jun 2023 14:30:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 267DF4151A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20221208.gappssmtp.com header.i=@kernel-dk.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=tDtX7wA/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVgeW9NVUCLf; Wed, 14 Jun 2023 14:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7AA26400F1;
	Wed, 14 Jun 2023 14:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AA26400F1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51511C0037;
	Wed, 14 Jun 2023 14:30:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 821B6C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A6E5400F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A6E5400F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lmk-3JKqoA1M
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:30:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E015040B82
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E015040B82
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:30:10 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-777a9ca9112so64786039f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686753009; x=1689345009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0swmYx8w65IN2do5ZhI8uQNOc+u/gPEVWo52H9MmMU=;
 b=tDtX7wA/Va7BPa/trJkBkK6diCamMzggWBU6etwXWEYqpcfWKb7VXTBwRwCAhPDoy9
 viNb9tGPeI9wUJqpkZoESIohcOCo1u6yACZfcd7xt+/umXpznxHsDdalL6xcIOUvvirf
 5Y+IgdOgOSAdguJtVMexzSjDWTyRxGQkS5yjuTYGLys26xKRbJgveFMIpFYmTWvdsjoU
 gFCwnC5PmO8bwsD8Sq2tZqFmPNeiFglVMWEsvI93eCRPSbE2o3VakCfM/sZjHGXqkeaZ
 wFWGoojXs7l8Lm+PX5/oK4s5kd0WkKeVxOXS6RqtePVk9SZTXFHCLBSbR/nxPNtR6xDf
 RSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686753009; x=1689345009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0swmYx8w65IN2do5ZhI8uQNOc+u/gPEVWo52H9MmMU=;
 b=huWZUt0gmj8Pz6Gzp1HegiEVFr49lS99VlxFLbGwdQoQ031RswFUwDA0q6EtU2tnE6
 7aa/ooYkyBFloVpRK5h14Use/SA1yI4p7VI5Y9Rjo2cWBPYvTU371jhtM1SHjdSTWiZY
 02NZmCnhUjiMqd0+6DiOzkUv9yos/mUq5ergPF2k73122I2i5ZCcC/wZDiIGa0A6Z4YV
 wxSJotYDN1Dbfl81U8CEKBBU92CuWJHJcdVHlccYLUhjYvxpAxxMw1ydGnCV9LKPntj4
 3v3Cd2uDQPZRDSaKTCFI+pD0TPx+88w67Rf1cKtU4xZdR5EM+hWgKpcsesbwBXapa1L4
 ziVQ==
X-Gm-Message-State: AC+VfDzv2tC4T9INovLn+Zz7w2FymKFVGB9Cm+c8lUCq+hVEJ9j/HY1W
 6NAYuQTCFErdyFW9JIkZTip+HQ==
X-Google-Smtp-Source: ACHHUZ6iz4zUfZv5Mu4cVP29jLWn1A8EmUeZ5ZpkLAGSvXTZf35A5qcx6ZhaKC9MTpODuYZo3kSHtQ==
X-Received: by 2002:a05:6e02:1a2d:b0:33d:c72:4ee with SMTP id
 g13-20020a056e021a2d00b0033d0c7204eemr11712657ile.1.1686753009580; 
 Wed, 14 Jun 2023 07:30:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2]) by smtp.gmail.com with ESMTPSA id
 g3-20020a02c543000000b0040f91a65669sm4807683jaj.21.2023.06.14.07.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 07:30:08 -0700 (PDT)
Message-ID: <a71b0135-8b41-19d6-9766-f638cdd36ca6@kernel.dk>
Date: Wed, 14 Jun 2023 08:30:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Can vhost translate to io_uring?
Content-Language: en-US
To: michael.christie@oracle.com, "Eric W. Biederman" <ebiederm@xmission.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
 <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
 <f65f9809-7f52-5bb1-7e78-f22b813500c2@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f65f9809-7f52-5bb1-7e78-f22b813500c2@oracle.com>
Cc: brauner@kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
 nicolas.dichtel@6wind.com, torvalds@linux-foundation.org
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

On 6/14/23 12:25?AM, michael.christie@oracle.com wrote:
> On 6/14/23 1:02 AM, Eric W. Biederman wrote:
>>
>> I am sad my idea for simplifying things did not work out.
>>
>>
>> Let's try an even bigger idea to reduce maintenance and simplify things.
>>
>> Could vhost depend on io_uring?
>>
>> Could vhost just be a translation layer of existing vhost requests to
>> io_uring requests?
>>
>> At a quick glance it looks like io_uring already supports the
>> functionality that vhost supports (which I think is networking and
>> scsi).
>>
>> If vhost could become a translation layer that would allow removing
>> the vhost worker and PF_USER_WORKER could be removed completely,
>> leaving only PF_IO_WORKER.
>>
>>
>> I suggest this because a significant vhost change is needed because in
> 
> It would be nice if the vhost layer could use the io-wq code as sort of
> generic worker. I can look into what that would take if Jens is ok
> with that type of thing.

Certainly. io-wq is mostly generic, eg it has no understanding of
io_uring internals or commands and structs, and it should be possible to
just setup a struct io_wq and use that.

Obviously might need a bit of refactoring work and exporting of symbols,
io_uring is y/n so we don't export anything. But I think it should all
be minor work, really.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
