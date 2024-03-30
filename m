Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85441C0DC9
	for <virtualization@lists.linux.dev>; Sat, 30 Mar 2024 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789346; cv=none; b=C4p91rwEddhKEKm4u70aI78DR0MOM5XpQ2d4r/pqdtiwtW01h9+52cl3eHPrWAYlqQifo4Uoi5ZD44vbVygN6KEBSGqGhPwxxvDgzPMAi+mfMp8AKaL8PlXpahvUq5Ic4hvmJxoWT5i/ovLLIYiZyyKDeS3H7Ro/SWXpflEsYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789346; c=relaxed/simple;
	bh=cG5S+JlQSNwbyc3gVBwNnpu42UAF6/3bXloXVCJ5xto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm+97QimfSL7/cg82HhuasAE9Dj7Jr/pVys8FzWPUgl2wNugBfiF3pGQcq+owVdEmIWGzib9TFzfsAtxQ+y1EwKIzJ0SgUKh8qoJOaILTFMPiQFRMw4dY+WCIsyk0Opzhs2zpfhB6NU/Axv37TevqUMZPbsghg09sen6PYxhL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoUpvCl9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoUpvCl9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711789343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ox4bLWBHssSahIs5vyxVp5VuZqHQaMHkELMh6pm/WAU=;
	b=YoUpvCl9gh7tuXb0DiF1hxewoOCb9pXsSDWy21Q1hBx/3WHTr8PiJy7haeTrcEzJacurqI
	zUFXvrrYdeomS/A0+rWYdnKI75kNrW2th1uDXvHkT0AeU55SiwvD+52lTIemCXy33uJ4/U
	Y/K40GucHw7Lf40VsN7tyoamqpu1E+Y=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-_MPijFbAM3aEj-ICioEFOw-1; Sat, 30 Mar 2024 05:02:21 -0400
X-MC-Unique: _MPijFbAM3aEj-ICioEFOw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so1822119a12.2
        for <virtualization@lists.linux.dev>; Sat, 30 Mar 2024 02:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789340; x=1712394140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ox4bLWBHssSahIs5vyxVp5VuZqHQaMHkELMh6pm/WAU=;
        b=LxVtTbNSamIzHd6LdqX5lgRLwbqa+gp2wJd3Q0ctlDtgVwXeKsVgIO2BoyA8JUJ5J3
         7tIKGaG0Zf7TlgRq1u6BdqlpsIgB0FHb47rEoz3cP7FcFgArT3YFsvZWwh1qhOU+z1iE
         G7erDgCpuykhwVqAR0N+x1bKSUxS5HABUZv0itrknZzQQuRZfnpMg2hUviCL9Rwy4aKU
         7ChMhPThWCOvOOg9A2thXc509JG4/2AW8+hMBML3ALqZ0aenDj05DqDWzUCVGnC4b6pk
         D3YHQBxGlLXdimzHBgw/HVRrzH+ux5y/7itYTYfNxRQlI6oKwjJ8Qc8SP5uKr7c0Oc0e
         AnhA==
X-Gm-Message-State: AOJu0YxJCzV3+ru+FdLtYaDws3ZRoYc41ncg6uUAG3Xjx47nHaPMtrMQ
	nN4+zw/joFyUhag7ZxDFWbOt+GQ4RxA9+AZGEDpbf+OHS/AhvsUwihPv30xnwNm82AQzcCPC4P1
	t0g94moKHCA+BENxQc7/OzD+MzXxQ7n5xjk8SPEudA7OXTzj1RHwYESgOgIBQ0Xi3
X-Received: by 2002:a05:6a20:12c3:b0:1a3:c4f8:e9ab with SMTP id v3-20020a056a2012c300b001a3c4f8e9abmr4041433pzg.46.1711789340001;
        Sat, 30 Mar 2024 02:02:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+p/3De9y5/QlaUrTE+vbSXYudi66PREZzXboJoWujecgs+DaAf6ZzPy7h/4IF/TlSveFIgQ==
X-Received: by 2002:a05:6a20:12c3:b0:1a3:c4f8:e9ab with SMTP id v3-20020a056a2012c300b001a3c4f8e9abmr4041405pzg.46.1711789339663;
        Sat, 30 Mar 2024 02:02:19 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id br8-20020a17090b0f0800b002a1f77bde90sm5220353pjb.46.2024.03.30.02.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 02:02:18 -0700 (PDT)
Message-ID: <8faa07aa-d330-4e3f-95b7-26437d448beb@redhat.com>
Date: Sat, 30 Mar 2024 19:02:11 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
 stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
 yihyu@redhat.com, shan.gavin@gmail.com
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
 <20240328052814-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240328052814-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 19:31, Michael S. Tsirkin wrote:
> On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
>> All the callers of vhost_get_avail_idx() are concerned to the memory
>> barrier, imposed by smp_rmb() to ensure the order of the available
>> ring entry read and avail_idx read.
>>
>> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
>> the avail_idx is advanced. With it, the callers needn't to worry
>> about the memory barrier.
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> Previous patches are ok. This one I feel needs more work -
> first more code such as sanity checking should go into
> this function, second there's actually a difference
> between comparing to last_avail_idx and just comparing
> to the previous value of avail_idx.
> I will pick patches 1-2 and post a cleanup on top so you can
> take a look, ok?
> 

Thanks, Michael. It's fine to me.

Thanks,
Gavin

