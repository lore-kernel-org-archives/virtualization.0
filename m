Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4F3CBE7F
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154016; cv=none; b=FoNz7Sa04ws0l4PQZb1vxY5T6q2ZWkv/ttgPV9S8yxRVC3gPrcpALWYemXnKimgr8qy0abQY7ua0JqdFDN4xKREqJFSuKikQxmRuc831bqNJe5nJSueimoxMVgHGFi67XDK4zwzKcC9RPzxesPqzxlZaRZacttGqaRYc4x8NygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154016; c=relaxed/simple;
	bh=4bEE7/evxgVFxFrQjNkTpCnr3NfrIbvjDU6l3pDqLBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WWVgXyDDMuJBBWZqPPcqtr3R8TV1EMz/FJkk1dEWtKqu2xssAhb8dYWqeOLD5bdectkeYNM9Lx/JUn2w9eK+afOt3BO0BVCd2WfjINvnw0Sf9vgrsS7K3w7+ry3+GmJ8tHsDet4V47/Lk0fx0x6H/l0d5+UhvUu+ouLQ0DYpYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E482xUwa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E482xUwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778154014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Q/vWrC5xWscbTi81RXlhZXCborygAcFcCvwCv7P9u8=;
	b=E482xUwa7mXMWjjDdYl+DhGaXqILDmtXyWffobnVB1MCBzJ1NdbJXeGXdBPgmxiu7XAKh5
	Zj0wAe4jfzuZdgQnIryEQU7MaMx4j5us30/0cYOhK5UDUD0CqCcGFbjglgxEDKmS70cBwX
	J2UKAAgY78TNk3DFT7fArY0O3hG87+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-dQY0UMRgNyG1SFnIYhatlQ-1; Thu, 07 May 2026 07:40:13 -0400
X-MC-Unique: dQY0UMRgNyG1SFnIYhatlQ-1
X-Mimecast-MFC-AGG-ID: dQY0UMRgNyG1SFnIYhatlQ_1778154012
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a36715dso541857f8f.2
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 04:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778154012; x=1778758812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Q/vWrC5xWscbTi81RXlhZXCborygAcFcCvwCv7P9u8=;
        b=fZ5WatEXQ4KQSLjXYUukgEX7+J6eihiJK9U+S95iGZivfZHDK6rIxsqPJo0tsIfWKN
         UblRWZgiPI72ZziBBY73npz4bznxrnnAza3xxtgEKstEct3TRTftuBIw3Kl0IVLwLl9l
         bOQ26peDZT/6PLmoB3S/fn3f9UNAefU8SrZkgCdYIZPDaS4DsO8B7aBvp4noyWivXKyZ
         avZeXbOBqUOD8ivKImhV22mNp08YmeDwUiqHw/hNxNQ9l1p6v8/58KZbHjT4DHraeMAE
         DkJXxIVo0S1lNu9KVdB/QJQ7uxM95HMSWukeDVVQ+1NBU5vrYcggj8TPuquZQ3t/gae5
         pLaw==
X-Forwarded-Encrypted: i=1; AFNElJ+wiO3yzkoeUqAluyryMK7XZKDlQo0iQAYJo0gkkpI92Yi7kTroVMEugZrDZaheNn4mxuah9TlGnmlAszQ4tA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3sRez9l6O9l6CqLbrf2X+UbyOkDeiRAOfeZQyziOjsVPlwxEH
	pSel9amNTOeWJEEwQHFJiGKBXb+2c/hRkyzQdKWj+eMnfC7yewuZgozUp96ZTETCAz4TTOZ5M+k
	Lfjxt2LexJUvapKtbvRLdN3unAaDMGBi1KcrsWTuIsBIMog8jOPvbk/E8ad23sVfaWN3n
X-Gm-Gg: AeBDiet0YfmeUagN/17bo7rNCxe+0rPK+iojwexKgagd8h46r4PbyLUv0SyzmjnpCV/
	ImmfDO2uOToRLXsdkMlQ6BP03DrflnlCZ+ozbU0GSs7/atUUJs32C9EkZXsZA6f1juml6UZIKJd
	s8n9nXnm+rfJ/SBxVY1G8P1HEl6Kc0loYYsvn2XLi2LVLsTkdG/Dzvxs6X2Agu8IgntVPEfcSq1
	ZRp9UdPaID7Hxk2A5FtPEbbPqxaJNod5uWijXE020/NR7vLpYeH5u+LNnDWDKnwR2SAH3IhqPYS
	NVI4kRItB0QE3ZGAENrMLIGqSu8Rcl9+tDn119iwg29QgimnmvPD4DkSlgVLsG4b4WPQepyNAka
	wDFdFSbk08Ysk6MJVPRQ7KTotN9sVLmsDu6f5qsKN0+vHNJWXXdOz6I7mZjlpQA==
X-Received: by 2002:a05:600c:34ca:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48e521e6085mr128340055e9.16.1778154011823;
        Thu, 07 May 2026 04:40:11 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48e521e6085mr128339375e9.16.1778154011185;
        Thu, 07 May 2026 04:40:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895effsm114922635e9.3.2026.05.07.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:40:10 -0700 (PDT)
Date: Thu, 7 May 2026 07:40:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: "Michael S . Tsirkin" <mst@kernel.org>,
	Peter Hilber <peter.hilber@oss.qualcomm.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: rtc: tear down old virtqueues before restore
Message-ID: <20260507073810-mutt-send-email-mst@kernel.org>
References: <20260425160906.677660-1-physicalmtea@gmail.com>
 <20260425130233-mutt-send-email-mst@kernel.org>
 <20260507112458.3674326-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260507112458.3674326-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b1hwF9vtiXJT6UrVxf3RN_Ciehc6ujDNzg7tr5jJDH4_1778154012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2026 at 07:24:58PM +0800, Jia Jia wrote:
> Hi Michael, Peter,
> 
> Gentle ping on this one.
> 
> I checked linux-next and mst's vhost tree today and still do not see it
> there. Since v3 already has Peter's Reviewed-by and there were no further
> technical comments, should I resend it or can it be queued as-is?
> 
> Thanks,
> Jia Jia

Hello!
You need to start a new thread with v4 not as a reply to v2 otherwise
lots of machinery scanning lkml thinks it's part of the discussion.

Thanks!

-- 
MST

