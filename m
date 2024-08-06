Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811662BAEF
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962762; cv=none; b=LR/VKimOGc7Nk1go1m55l94ZkOH9KxWPwmyr3PNSscqqX7WdAbAMWeRcOD9e2AgPSVvJWLld60fe59PmXiP2oLw5SA9fZro/OTqnHi0z8XiJwHeMZ06UrJxyej8PJhdfp7c1uXOQ45ZG2rVX0y884zaJdbZPuye9Mazxme/kepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962762; c=relaxed/simple;
	bh=E9l70jJaQyykusgTWUUnXUryASZQduz2DF5zqC8MC9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c9jwfMaYzjI0dajaNN5kLDSoUB3i0afUe2wPu5gsOiCfZdO/7rXNh7B4zPmMPyKB4T4XqZTSp72TQjol01xyOTTGtAA7m2nNptxdSb5tjl3S1JQiNds2jWEm2VZ+0zZ6/7J9PJZN9EQuFRd+Re3bA9QKvOw+6/cyf/vk9QRpcRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYqf8dqc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYqf8dqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722962759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX/lxI1uUCrTuqOtp1jkVmgILXL7/YWiaTAaM4Ukbkg=;
	b=LYqf8dqc6N8jwqlM52+A8BRo8YCkF5rCH/byc8E3aDPyiChTbquTCEpn/eGccDWTQx7FqB
	cx81bnmP2gAweKwUdfFwsCl0P6GZL7iVoT+1F1b2gAabAr/GP60nRSUwJh+Z/Hf1GyWXU6
	WE5AlxQOdVOOChmYCzbIN3J+yCog+m4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-G8kPB6cXMM6_pD5XwlavZQ-1; Tue, 06 Aug 2024 12:45:58 -0400
X-MC-Unique: G8kPB6cXMM6_pD5XwlavZQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a113d5cd1eso347269a12.1
        for <virtualization@lists.linux.dev>; Tue, 06 Aug 2024 09:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962757; x=1723567557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX/lxI1uUCrTuqOtp1jkVmgILXL7/YWiaTAaM4Ukbkg=;
        b=ZHnaV3oOvviUPFOq86uux/nR8WY36pJb6HpkXTDdMr6lD1XsAqfcEuWYBarOzGb+xa
         SIwH6BLayrPo959cdVxoOO+xKf+HgrOWEo/DPqK+tq66Sai2kryMHNnnWNpQn71NyQVI
         4HA4bZJ8LloxEC/5z84UeoFWa/aJnLD59hqFaJC//IAvh4YDblg5G9S5X1sMTNIGj+qI
         X6/4J/e7iyUdF0l522gREcMuGrKNiVHcvmrqyDNdEL8KEnVQn8ua5ZABOxwzXtznAxb0
         NNYTlLm+g1fb/nH1dW4J+X4OoPLYxd93EL2NZvHPeGIUXNyG8Y1M55YbriCZmr6hVUDq
         ++1w==
X-Forwarded-Encrypted: i=1; AJvYcCWTLyuynn67YYQmiP2SDlV/nxfM05GwfqsGsbvuCrL2MV+lqTaUK3WAG8M0Y4StQR1C93w8evuF0NsjyG5s+x7Ahs/bt5+Oz7Jd15yXm5c=
X-Gm-Message-State: AOJu0YwWkEyuOpgduaUO0EZHRInZOQLLlTMKPW4twJLoenXXRtcOIP7w
	U18xHs8FqymLgU8pkfdNadvJ69H8oJLoVXISc736yLTypffAW3oi/tvcijY3yuoEcZbRpaADV3c
	hSAxIyrj6x1q6S4GzlEiUEy/Z4edZf5bgLGzEs5MGy5gyCTO7IYA+iJm+Mq7T2KX0
X-Received: by 2002:aa7:cd69:0:b0:5a3:619:949f with SMTP id 4fb4d7f45d1cf-5b7f56fbd6fmr13590406a12.32.1722962756761;
        Tue, 06 Aug 2024 09:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESyQrC5UzGzF64K7apX07hUu3twGVSZOhtmGTLXe8INI/Ij1pbHzqjoqEDGmV/r2tnzicC/Q==
X-Received: by 2002:aa7:cd69:0:b0:5a3:619:949f with SMTP id 4fb4d7f45d1cf-5b7f56fbd6fmr13590380a12.32.1722962755874;
        Tue, 06 Aug 2024 09:45:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bb6609d7afsm3140107a12.52.2024.08.06.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:45:55 -0700 (PDT)
Date: Tue, 6 Aug 2024 18:45:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: luigi.leonardi@outlook.com, mst@redhat.com, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <uhrf5ctkvc6ic7frpfndtdf66u66lonhfgane7bigb72damukf@mjavswunu7ve>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
 <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <20240806090257.48724974@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240806090257.48724974@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 06, 2024 at 09:02:57AM GMT, Jakub Kicinski wrote:
>On Mon, 5 Aug 2024 10:39:23 +0200 Stefano Garzarella wrote:
>> this series is marked as "Not Applicable" for the net-next tree:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
>>
>> Actually this is more about the virtio-vsock driver, so can you queue
>> this on your tree?
>
>We can revive it in our patchwork, too, if that's easier.

That's perfectly fine with me, if Michael hasn't already queued it.

>Not entirely sure why it was discarded, seems borderline.
>

Yes, even to me it's not super clear when to expect net and when virtio.
Usually the other vsock transports (VMCI and HyperV) go with net, so 
virtio-vsock is a bit of an exception.

I don't have any particular preferences, so how it works best for you 
and Michael is fine with me.

Thanks,
Stefano

