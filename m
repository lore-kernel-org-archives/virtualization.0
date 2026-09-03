Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068B3F58E1
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427529; cv=none; b=lCBhpvuExvLCjn5RBC+QMyVRDPe/26Q6NH6zWTvDRwLrIVwnGCc8X0gv6w1jxDWQOs99ftfO0y+zboTVVBiVwYveiAjNxVtTPh6ql4D8j/aE0YyflzlllSZNqYotvYK7oWfatdRtI8EccFRzBfUyTY3s73fJt+3f/G9muaSOgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427529; c=relaxed/simple;
	bh=F3bEffyo0R4/edNFXtIcXkcvoM1A7JYlTzpbbIagYxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpxKpvcn60teVF6zarNRCZETubSfck0gw0OY+ZZjakrJ9+y4XaiFGcnTeNOhg7X1460NHioWQE+0vQqxkQORMfnEyvKjE242Sr0ygGF3QE/7giCYXTMSN4c/XdmD95qcEf2EEnzRGQnSysoBo8B91/zamjRmfFF5OThbAMwVgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EF/nHfP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF/nHfP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788427527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PKW0eXtHxdKlv3YbhDeBo6WYo0CMN3NwYmrHCs4Z7w=;
	b=EF/nHfP8gUNZmK6+7HzN6OfePogiwzMYjYBRnFsFto9lqiXbUrQj3rbXilKI28gMJ1MfDj
	eL8SK76khS5c7LIhsC+hZilGPeJ4FpJKB8TY8oNDNUCTmoTiC+xQLrPlalHdckB6F8YbZg
	sW6L/u+YX7v6pOs1V4PbKg3VBNyYAy0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-t_X1kPiROE2CmgXiOxWYUA-1; Thu, 03 Sep 2026 05:25:26 -0400
X-MC-Unique: t_X1kPiROE2CmgXiOxWYUA-1
X-Mimecast-MFC-AGG-ID: t_X1kPiROE2CmgXiOxWYUA_1788427525
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482f41ca436so2038854f8f.1
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 02:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427525; x=1789032325;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PKW0eXtHxdKlv3YbhDeBo6WYo0CMN3NwYmrHCs4Z7w=;
        b=nP1LHFhUpQblmn5cKk4B4jotrGBM6q9cpTIR0zDHVrHub05EK1u9IIP7lp7j6uHV3c
         eurZaQIGL/ejfzP6ojc/AMT8RrovBgNie980LC2zLM1ytnipGQ1eWUYPnLPw8nIUwAzt
         ziFcmJVr7ifR5/ir+PlD76kCAXbAQPdggj5ZurEkrnndiNrktZidqH+F9GqyOFEEXfj3
         SVY0drOyIt/x02dseoX1nBkNmKXdO8QaRM3AnVZEjq/zMj841qZklOxPvlazbow2WEqp
         6muuqe1ApELFDQ9D0Hr23dS8Kbe/RHlXMOoydwffUWabAtrxUAoVMcx9ULQ+52hw3NyJ
         XpbQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6PEZ99r0dNr30yNUXY+AKdTo6psmvzhkINMaK4tRM+aSw4UoZ2u9RvZiZ9JzmN72kTyvf6kNfoGpK0GTxpA==@lists.linux.dev
X-Gm-Message-State: AFuF++nvfCnPQ5AQCjAzn7xbjJkw6U+4Bh+MbR/b04Pk8eov7Z9yZG0Z
	KB4sYVpVF4nEB02ilx/3vEF4NHIO1UNtthq0wwq93Ow0ZvRHKqlZHq5jjVUnIB5WfLeqfq4PgxY
	CQrUdm8D+WFD9VYOqLjC8xM3mi+agUNCxoh4Ou4nWemVpPUfvNIE56tKNXLhi8m9HKcqy
X-Gm-Gg: AYBFou0KgiCMmXVQ9e+3mbrYN1rMS63+Ej527n/do55pAi9O6mube4sgbP781v/GQQC
	FfPyhGd6ptfZeePjROQ9N+Wa9tNun4IZ4l0fqdymyHJSYKtU91XfwPjOMihSUYlLBvMqZGNZyeA
	tPfgyARCA9rcqi6nYc/e77/+28j6f+8Osg2k2eHdEnRwVehybYeeKMuChPxSEDiXPTRSRmgI6W3
	K0Yydm/sLx9jgs0Vh8mzEOmHk3NTG47Ga0Nuw06qxw0cuxB72gZAht/krujgiBuC4UOyaaaDsB/
	yFedgZ5aDNvthh5U3vNyZRbSfNW6+6Kbr3HTjUSTQP/bV8MxSQYysXUXVpBP3V3lCHqCLd0uQXr
	Wq+GzDSzHoW2V1YVvkmSVewVKnNtI+IBnpb3qE1s+t0YRYLFzftJlxddqAZNK4hbBClgo4R12bw
	==
X-Received: by 2002:a05:6000:490e:b0:484:478e:e19f with SMTP id ffacd0b85a97d-4847b6266a6mr21200355f8f.0.1788427524964;
        Thu, 03 Sep 2026 02:25:24 -0700 (PDT)
X-Received: by 2002:a05:6000:490e:b0:484:478e:e19f with SMTP id ffacd0b85a97d-4847b6266a6mr21200258f8f.0.1788427524490;
        Thu, 03 Sep 2026 02:25:24 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm12823430f8f.27.2026.09.03.02.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:25:23 -0700 (PDT)
Message-ID: <fe767fdb-634f-44d4-9a4e-80b2f8c5647f@redhat.com>
Date: Thu, 3 Sep 2026 11:25:22 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v23,02/14] virtio_pci: Fix sleeping under spinlock in
 admin command path
To: netdev-bot+sashiko@kernel.org, shshitrit@nvidia.com
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, yohadt@nvidia.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgg@ziepe.ca,
 kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, danielj@nvidia.com
References: <20260831161109.2999926-3-shshitrit@nvidia.com>
 <178835473723.3394541.8002424749068111766@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <178835473723.3394541.8002424749068111766@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xqr4G6SBc5faf3sU9yds5BsDlfcEZJnWlJyMRg_gkQk_1788427525
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/26 3:12 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 (2) · Medium: 2 · Low: 1
> 
> - [High] The patch adds a new `vp_dev->admin_vq.info = NULL` store in
>   vp_del_vq() (drivers/virtio/virtio_pci_common.c:261) but does not…

At least this one looks real and worth addressing to me.

/P

