Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F41649C6
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708046; cv=none; b=d9Iwt0ZSzf6Slq6MHthj+G9PvRX/jeHajT08vq/LLa3zk7arprySX1SG+4zOaOJFFG0XLgQH0UppPtK8c/tUGb6Mm/QhE7vR6AMbqDBvC8yPeJ/pnxuKw9G8rB01pe47KcbJKgED1PKnsDt+7Mt0Az5User861DHQOzdpecf0uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708046; c=relaxed/simple;
	bh=XMcLDNucyi6nSPUmygOtXlWNTj77p1UId/vpj/H+HtA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o/5x1kdjSZloD9R+RnkBXBtl8ZJsBIfhYf5DDS3WjHDojHe7cZfnJBKf8wkEJeHWXDp4liulr4XGrx+s8uMA4r89yvUt9nSfpCcmi8kAB89NzjnHK83czUzP+EEHiAJ/I2llAR5tJX7kyAS/dd5N/7eoXe2Rq3bRxKpmSnqq6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsC5l2Pr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsC5l2Pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720708043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pmruj8JQx1mckIvgayGotRB4kpYx01J5hU6lzx2ILak=;
	b=WsC5l2Pr9sklarCVGVqyVXrbDkmiGG6iNtZ9LZ0KeQV8IGQKk/skCHFWbtTHgoRhIIvues
	JXPBAZwc3BqYtjz14xl1yu0YeH1OW78tujg53ap5lTWDu+uLGNNKq4qZbEomGEZfEBBdro
	cSFLLzU24Og/xprIRSflcgha7wWx/NU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-f783N-c5NaCf-xqBgv2Zww-1; Thu, 11 Jul 2024 10:27:22 -0400
X-MC-Unique: f783N-c5NaCf-xqBgv2Zww-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42725ec6d8dso8221605e9.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 07:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720708041; x=1721312841;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmruj8JQx1mckIvgayGotRB4kpYx01J5hU6lzx2ILak=;
        b=Uj+MPDhzuNfbtBR/WcZSHR7p8Cv1ebmY0YnC0UuQ6pFE3A1b+N76NiLgVDRUBlU0ij
         p4uHaXOFyok7fhXASFmV9ZDDVnUtDA3T/0j4bPhsn74Ksu12ii95GXbyDbizjUiapSEZ
         ctOVl0tr9mz2+9RjCwXCgEelirbV5njjcqsyorXjxuSTEgk4RqkgxZ5G8dxXj40pPzib
         A0BKs6hZz7ENcCxYd22Btpd7gfkeDQjijRs3nvFdzGTlUpkHrIxr9bEiLTIj8jVL9v97
         aOgGru28G8yNdYrBA0omAI3zDepk60tNiG7EpDqEYqgNlRXjf2EFY5BmxphfgvlWcHHV
         F1yw==
X-Forwarded-Encrypted: i=1; AJvYcCXkkWJEFmMTBS5azml5EhVAZ9J76CGtOvu0C3WBOcS6pyAbmRruXDpencpV56CYIF/EyTLLZteTf56A7AzUDwRDt2fcjvmWwUSEQZzNZRo=
X-Gm-Message-State: AOJu0YyVIN1QLkfc/IwuQohyvYim4JcaRQpd72X4D7tR194vDrXu+j8F
	s2rZ7JhYJIG4TqYO2FlyV/3fCprSO/HOs/sn0B8dTQjOdhs5kthB/Y5V81njXMweX9Pmc2MjHjl
	nYAX7gqTgZPbFwXlrRdmXyabxtUdALrcd1oRddw8BuaYRxiLRoohSobmOrTka2tAX
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id 5b1f17b1804b1-426708f1d36mr69105115e9.37.1720708041271;
        Thu, 11 Jul 2024 07:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnWMP7EKz4R63Sf6vdBXXcYvsJMKmcS8ZNh8guNp/zMBSdKX64ea5/eGfU35uCKVEDl19oUw==
X-Received: by 2002:a05:600c:2109:b0:426:58cb:8ca4 with SMTP id 5b1f17b1804b1-426708f1d36mr69104815e9.37.1720708040684;
        Thu, 11 Jul 2024 07:27:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d? (p200300cfd74b1cd51c4c0c09d73bc07d.dip0.t-ipconnect.de. [2003:cf:d74b:1cd5:1c4c:c09:d73b:c07d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f737a63sm117471955e9.36.2024.07.11.07.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 07:27:19 -0700 (PDT)
Message-ID: <151cc130-3584-4b07-96e0-765b7efa43fe@redhat.com>
Date: Thu, 11 Jul 2024 16:27:18 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
From: Hanna Czenczek <hreitz@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <20240709175652.GB1040492@perftesting>
 <8ebfc48f-9a93-45ed-ba88-a4e4447d997a@redhat.com>
 <20240710184222.GA1167307@perftesting>
 <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
In-Reply-To: <453a5eb6-204f-403a-b41d-faefdbcb8f50@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.07.24 10:21, Hanna Czenczek wrote:
> On 10.07.24 20:42, Josef Bacik wrote:

[...]

>> So then the question is, why does it matter what virtiofsd is 
>> exposing?  I guess
>> that's the better question.  The guest shouldn't have to care if it's a
>> directory or a file right?  The mountpoint is going to be a 
>> directory, whatever
>> is backing it shouldn't matter.  Could you describe the exact thing 
>> you're
>> trying to accomplish?  Thanks,
>
> The mount point needs to be of the same mode as the root node of the 
> mounted filesystem, or it’ll be inaccessible after mounting[1].  In 
> this case, I want to export a regular file as the root node, so the 
> root node must be a regular file, too:

Sorry, I meant “[…], so the mount point must be a regular file, too”.

Hanna

