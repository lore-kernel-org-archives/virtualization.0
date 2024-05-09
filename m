Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8315D5B3
	for <virtualization@lists.linux.dev>; Thu,  9 May 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264905; cv=none; b=aMz3EJwckBxJAvO6/ZHT8jUq8MYL8zYiwotIQHWTZ/5u/bsTo5i5DsBXn/LII+fTm9zYBPXIMx4viHPRexEQAVIYcyBLrS3aejKG4QR4tNbvvpDiK6fCczHu/dSdEZiYkMuZK5xLw+L9SOvychB4Vvr0cEC//iSoDPQkSMq6G20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264905; c=relaxed/simple;
	bh=At/PR9xiPBZXIeHupjRi2vL41OmNPl7+MlUPDhRsU7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=X5Xs6g6gloLqR0bt1AsmUnqe86Zaim96lvF4PY/EAbmYi4QPM93EYm0MbwBCFiFPwt5IUfU1usyyWnNaPlOO6XOP7sX6xMO2ZUkzXGfy3vigYCMWjWZW05AFnMIp1M+aiNOD4ueBeMdrd7IXUe+FiqmDqUdZi0pLSrjzHUkfpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG1wibNS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG1wibNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715264903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6yB4R6RD8JSzHt1WCn3E7Onr1qX3r8v4WsayQOTvs8Q=;
	b=AG1wibNSYHw18nJk09deujOtDjUvtl/fFGNUn/zBPdpTVmJQEu8ZwVB8vlbXb+XlA9IGPE
	E00tWecgHpGy7H9YrNG/ivhS66oVvw+NHAG2cnXQMwcPK9XBl17SBWpArUxSEerkucO2pb
	LZDmIyr9NbIDuvL8gTqeEswHHEgwZVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-iuFSdXNdPjmw_kHKeV70Dg-1; Thu, 09 May 2024 10:28:21 -0400
X-MC-Unique: iuFSdXNdPjmw_kHKeV70Dg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41bf6751b28so4229635e9.2
        for <virtualization@lists.linux.dev>; Thu, 09 May 2024 07:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264901; x=1715869701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yB4R6RD8JSzHt1WCn3E7Onr1qX3r8v4WsayQOTvs8Q=;
        b=MLrOPd6VmOp5cYPPGW2Zo1IKJ/mcBySuaCYY6E9siF2o3uzFhtFQH0fIylCwRJIErK
         EDul8HGXh11/ah8Zak9778xZEehPIuwHLyOFqux+NH7KJK54aXzaJ5HBQS0QYTewPmu6
         xVLKcpdZ/EMHd/8dD4TPmWeASDbnt4ys/3lK/SHRcRsB4keCXUT7Sshfs8Rp3n1Z1Yet
         YF93Bdp6CTQ8T8AC0EYoN54BLvgcZCMcmlGN7e2CmKlf6WU9ZdXaYdGhOwFX0AckQW9q
         3Za2oX5sVd2u+MJ5sPCw2KAhDyb2B+MQHdVxOIiqvLoJGeJopwZRlVl4cayWVq1qftKM
         /5vA==
X-Forwarded-Encrypted: i=1; AJvYcCVTIJvbwCBBhMS+NPLbmQAFt9qQJHfRoDiNqokWfidielNspQT0wx7Q4yX/a3IGAifWVIcYmHcw7L5BgMaeu1AZeJsbnNsB8PCJz7Dyj5Y=
X-Gm-Message-State: AOJu0YxnBIv2WsDz8NjlzJzS31VaOgDhxCUPKxUfL7jqeTTpeEDrlKVn
	2xJUgcxeFzlFsvP5bto+NwLveq0ThEDP10yi2vo92phaxpKY2xdaqwsNZoHSQxoHw5l4A6yi1M4
	CwVTym8Jbd9riPS0rAvVmZXBMxEiHMqcf0wqN0KyjSYUpFEcmo52Dtv5RQgfb8vIf
X-Received: by 2002:a05:600c:154c:b0:41b:97c5:ccc7 with SMTP id 5b1f17b1804b1-41f71302dedmr39294125e9.8.1715264900699;
        Thu, 09 May 2024 07:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAt6VE4MW6hKIeo6jWBbU4XjmGfYi89/ka3k4INSe646/Yi+7fF7mU9MnA1C6/BbjQ2e22qg==
X-Received: by 2002:a05:600c:154c:b0:41b:97c5:ccc7 with SMTP id 5b1f17b1804b1-41f71302dedmr39293945e9.8.1715264900227;
        Thu, 09 May 2024 07:28:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3cda:4bef:a79:3f22:9a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe126csm27126095e9.41.2024.05.09.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:28:19 -0700 (PDT)
Date: Thu, 9 May 2024 10:28:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240509102643-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Add support for Byte Queue Limits (BQL).
> >> 
> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >
> >Can we get more detail on the benefits you observe etc?
> >Thanks!
> 
> More info about the BQL in general is here:
> https://lwn.net/Articles/469652/

I know about BQL in general. We discussed BQL for virtio in the past
mostly I got the feedback from net core maintainers that it likely won't
benefit virtio.

So I'm asking, what kind of benefit do you observe?

-- 
MST

