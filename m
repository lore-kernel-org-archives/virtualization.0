Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94829ACCC
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022085; cv=none; b=qwkR5n1452h/xkOGJCo/Q1VnLHUkQNuEbjEJTVBGTQCo3LH4xrv4rirVwU0Uvr1cdWIvKs/9U1J/koxW6/nlg/ifaGmQqH5CWlZmBBOlV+YApZeZrOzZsbm13P7fPU3viNFf5XzKF1ogaAfTRx3xLUuMmhn6ff7uy6vlqG875OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022085; c=relaxed/simple;
	bh=ZbJdgOIbkGwBeQnmkTbzv066EyMDgSE02LiXwxp50sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YiT30UFKGkuA4tFzgNW0erkLKrO4uUoSuM9V6VdvJeLN9QJdTWM1XTuof9FK7/HSw1M4hRsiOwbdtvVocrXhFekbbwwvVxbKXOiLU+0m/vLsYc3ZAJoqcRnLCCHWs+dsNKAj/8oJcEoJT68Xrx89VHdqzs8QQNX90FCL3wFRrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJERkcy4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJERkcy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751022082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbJdgOIbkGwBeQnmkTbzv066EyMDgSE02LiXwxp50sQ=;
	b=iJERkcy4hqWCLVJsKvW28JR7CsMRdxFb2I8B0vv9Jt/hY425cIHLjiPq3zNRhbxDf6i4XF
	9Cr8YKGXaB+a6czojXz900sP/UH254HhawzsxiLyo9Tb2sOdAEjYulE9W0wjvB/M4ZzCMJ
	s9lwHhA2hC4wqYpcF8g313SFGmatSKg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-C6d-UFYWPUOGLNsw-AzEpg-1; Fri, 27 Jun 2025 07:01:19 -0400
X-MC-Unique: C6d-UFYWPUOGLNsw-AzEpg-1
X-Mimecast-MFC-AGG-ID: C6d-UFYWPUOGLNsw-AzEpg_1751022079
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a587a96f0aso72847571cf.3
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 04:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022079; x=1751626879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbJdgOIbkGwBeQnmkTbzv066EyMDgSE02LiXwxp50sQ=;
        b=J/yQ7V9ypmCCt5Iy0pTDVhqoH6J42CYJ3eJicPxxW/5LFhTm0zG+GozXrP4HYJcIeT
         XoV/VQAGkOHU8ijTe/PQroGOOduFVGevXcLU0HdGMhqVUFiPd6qAhABCqSahlFSOrfvj
         5OkUAOz4GOiCUSNgR5Qd4QBZ3ndZ2ROzLfqpMT8q5EcPijlvkKeA2OBwdrkIzejg65MV
         iRmlvoO0ziGS43yFQtiDAPRvLY2FfT53lY8q9vAgmW6A4PIqBmWwjqDvWlWRB/bAArdP
         bcazoZJi9IGtfaNXsXM28gDmh4bNHETexgsYoMOfcgfj7BMgocsJO7MFgKpKybDNo4JB
         OSsg==
X-Forwarded-Encrypted: i=1; AJvYcCWkHoFPX73YBwZzgusLEK50SB0ltG7Obm+pTsNwoOcsDqspKX0sdw+iJQOT/0SfsxfbaPffrDHlbz6pcIY0DA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1Mi+j87yzqG8vY1ghr4ze8X0YrmYqo43Ib1B6KPct2pJCUfls
	HNl7Kumf2Jn3dj7a4lwGpGuZh1cRmYaEu6v+5QJfcEFTgEKkIrQe+voUmShonHEIzsBfKSIZwIR
	QDio+LXdwstz7OatY95WSdf5wUlZRChzmEwzH9l9IO6QIz47SQIDvuGpGqjdXKmuh/G9L
X-Gm-Gg: ASbGncsc3JsYdnbLa1S1Izt+/HsNuJMjRhc+CKzt7xtxazmrU/PKeGBTV1gvbTNoZJe
	1THUGk4vS/F4gJ9wBVfy6LyBEbBws7iPowWnTfr2Rl8XXeEMaCgJzMK6Q/K/Kv/TdQxUAz4XZax
	up+wzU5C3x1IelOMZJDV9bxbSWYo/OPfYkjcqrg0kem73J5NFJmcTk0Oz1fGXkD64bIrJkJfsMd
	DsTfFAJ4JdJRj18PyvzaQDSJKITwUh4yJ9Rcyrsfwq0bwuSDaAIdQAosMESFNDWYc/Ce6IZQ4VU
	eNKbcQIFW3SS7fYnWuIRo3dCIz09
X-Received: by 2002:a05:6214:76b:b0:6fd:d33:bf30 with SMTP id 6a1803df08f44-700033b6fcamr44379856d6.44.1751022078481;
        Fri, 27 Jun 2025 04:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI8TS4H6eRA0UouWBKDumbd4mbbqZxeye6OCeaKrfLx9sLYI9IeIKljRoNoP6GNozp6MQ7gA==
X-Received: by 2002:a05:6214:76b:b0:6fd:d33:bf30 with SMTP id 6a1803df08f44-700033b6fcamr44378836d6.44.1751022077610;
        Fri, 27 Jun 2025 04:01:17 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.181.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3f2dsm17994826d6.78.2025.06.27.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:01:17 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:01:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Xuewei Niu <niuxuewei97@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "fupan.lfp@antgroup.com" <fupan.lfp@antgroup.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"leonardi@redhat.com" <leonardi@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "niuxuewei.nxw@antgroup.com" <niuxuewei.nxw@antgroup.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 1/3] vsock: Add support for
 SIOCINQ ioctl
Message-ID: <ubgfre6nd4543iu5yybkmnd2ihbzfb6257u7jjfz4xqk4nhfdu@43yfocr4z4st>
References: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
 <20250626050219.1847316-1-niuxuewei.nxw@antgroup.com>
 <BL1PR21MB3115D30477067C46F5AC86C3BF45A@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BL1PR21MB3115D30477067C46F5AC86C3BF45A@BL1PR21MB3115.namprd21.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PnvJVz1peMj_rrLdrSXnfyJU8P3O_dWNBf-hMXdFSok_1751022079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 27, 2025 at 08:50:46AM +0000, Dexuan Cui wrote:
>> From: Xuewei Niu <niuxuewei97@gmail.com>
>> Sent: Wednesday, June 25, 2025 10:02 PM
>> > ...
>> > Maybe when you have it tested, post it here as proper patch, and Xuewei
>> > can include it in the next version of this series (of course with you as
>> > author, etc.). In this way will be easy to test/merge, since they are
>> > related.
>> >
>> > @Xuewei @Dexuan Is it okay for you?
>>
>> Yeah, sounds good to me!
>>
>> Thanks,
>> Xuewei
>
>Hi Xuewei, Stefano, I posted the patch here:
>https://lore.kernel.org/virtualization/1751013889-4951-1-git-send-email-decui@microsoft.com/T/#u

Great, thanks!

>
>Xuewei, please help to re-post this patch with the next version of your patchset.
>Feel free to add your Signed-off-by, if you need.
>
>Thanks,
>Dexuan
>

