Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDA12E1FF
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681635; cv=none; b=Qk/aF3kq3tf7szRj7wv3OSJVgHVEEkvAiZphnyQz0avnIPDkqklxHxMNMqACD6FXeNIgvKasOuTxuVeeyp5rlentXwEWx38OQEHS7ukS0dDaIzN/3By4D2wDKxSgH1yp2kHwsjaMg/eue1u6uPduL6Q9+pUvs16pmzuOFrG0IIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681635; c=relaxed/simple;
	bh=M6Q4Y54tcX2mSlvfFlPj/ernw6oyX4Le4JdM01IEiT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ogu16S3fs1ethnVe69DhgrnDYSjIjo/JExkwgJUKKvmFw7SoSnCj4iijkt43IyBZbz+yKHCRsWdtE4ziG9F0T2zuoi6WBXQvpPsyehDmmNdCRT3szFO31+fvhYLO6/lcadksTJDlCKzV3pbeDa1oK+LngIQ+iawj+crwbTpQgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBti8U23; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBti8U23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720681632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gwiURRRyYCMTdBJLlcbFXQzpT51EG6fdosWSqyzJyw=;
	b=GBti8U23ek7MzY9bvNQfPUrqYsEvk9zTvD8B0NMm/vam8YG8G067G9IqjjP5nhur7OZZEt
	8MqwtDpXpsF19l30rqER5NH1bln41sNM57Dpxhw/wW4Z6OPELFfiJx+VzHs9Ce1sXBFGHs
	S0Kx95y/6mYPsOcDrEm5sK+0iKN5ct4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-45rsmnChPMOwlwOzXkr-Wg-1; Thu, 11 Jul 2024 03:07:10 -0400
X-MC-Unique: 45rsmnChPMOwlwOzXkr-Wg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a728c02df80so54574266b.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 00:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681630; x=1721286430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gwiURRRyYCMTdBJLlcbFXQzpT51EG6fdosWSqyzJyw=;
        b=XBgRej656/hktq1U8mw55BcDQQ5eAtv3l5BWwQa9RjypgCiuPhKtFlPs/K87Wfxa5+
         UV5UMKc3SWxOwLuZAVyPMoGvR8Am0MTRSBxKvuGfnK7Rh8KM/Bhc5TDeEOGVRu7Bl/PM
         tgGsaCyMaQxRftXCtsSVnr1gKUrLPFsYtva/AIRUdFWccihg2SIwvJ/Z0m0YQF3qu4zS
         cf3W2Nyy/blD66ksfNANNnxvpLGpIVHgLTptVAO+AffvHohk+9LwyPz2ldRlliie2iA0
         GLcj9qXDfpFr8RLmojBkTsjOqXkHVoGJKNkUeEiER9pBx0Ycf9x9uMZeo++ZgdoLKzdO
         ezSA==
X-Forwarded-Encrypted: i=1; AJvYcCVB2C7pcengDsLGAk3rsJqvx7SXpX7Sspx9p6rNufNi2d1InRe5/Ew0Yshhmuo2qdJx7qz5PqDui0b0T1nvPSVtA5VKzZYoz/W6VXM18fg=
X-Gm-Message-State: AOJu0Yxadrfoo7hXxot5WWupAXBMSfAEKN6tGanXg8YZlcLPBBx4KT1M
	jVQqzUyfuRWfcp2Mkm6zdIK2xCPsob1GLLajLWlqldwjTyjb9hJ85vK5slsJGqezFR3U0zrVPgm
	BA0zS79eu5fNRfkMp2ULgNbxHPHQ4wKImp34JNCK5W/+yIHj9hrJ+6gwqnF1DyDwx
X-Received: by 2002:a17:907:7f20:b0:a77:e1fb:7dea with SMTP id a640c23a62f3a-a780b688767mr673479966b.2.1720681629838;
        Thu, 11 Jul 2024 00:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6fcNSUdwOXzcVw0nvIFIjlIr5dl9NwMN5RYz968tXKLEx4Zbt1Hmp7deL2qMOfvVI3bkxJg==
X-Received: by 2002:a17:907:7f20:b0:a77:e1fb:7dea with SMTP id a640c23a62f3a-a780b688767mr673476166b.2.1720681629127;
        Thu, 11 Jul 2024 00:07:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fef92sm230972466b.125.2024.07.11.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:07:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:07:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, stefanha@redhat.com
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
 <20240710190059.06f01a4c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710190059.06f01a4c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

CCing Stefan.

On Wed, Jul 10, 2024 at 07:00:59PM GMT, Jakub Kicinski wrote:
>On Wed, 10 Jul 2024 13:58:39 +0200 Stefano Garzarella wrote:
>> There is a comment there:
>>
>>      # Avoid changing the rest of the logic here and lib.mk.
>>
>> Added by commit 17eac6c2db8b2cdfe33d40229bdda2acd86b304a.
>>
>> IIUC they re-used INSTALL_PATH, just to avoid too many changes in that
>> file and in tools/testing/selftests/lib.mk
>>
>> So, IMHO we should not care about it and only use VSOCK_INSTALL_PATH if
>> you don't want to conflict with INSTALL_PATH.
>
>Any reason why vsock isn't part of selftests in the first place?
>

Usually vsock tests test both the driver (virtio-vsock) in the guest and 
the device in the host kernel (vhost-vsock). So I usually run the tests 
in 2 nested VMs to test the latest changes for both the guest and the 
host.

I don't know enough selftests, but do you think it is possible to 
integrate them?

CCing Stefan who is the original author and may remember more reasons 
about this choice.

Thanks,
Stefano

