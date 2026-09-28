Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1624963C1
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590345; cv=none; b=CBqE/Ak6Nu6j8xDRi8Z5wv7ZyKS6qvhOpM2OBXENKpa/gStcZ2kLGnUM8gqmLMhrQNqlxqCE1KZ64g6hLV/SlRc/eNskD6CItuP+JRq14MCPqHhrUhuw6N+/ufVRNF7bAcYhx9vLqCTpG3AN08UfQ+HFNNnG4Ccy4ffR6G/bkSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590345; c=relaxed/simple;
	bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hnh3eh5id6NPsF6rRfCREe19FoiL7sOboTLX5KD12mQmWiJ9iwkCiwO+qcWr8MNQ7rhfsOQM+Z4Nvlo3mAHRLNYjJtwB5A9HjNaUHjxdE4Tn78g24cvpQYuGD9EQ9hKgHdIpVNMI8gOHlqHw+lsdQEUNZAyIhlBuoAeIbA8c9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbU1sgCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbU1sgCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790590342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
	b=MbU1sgCWFx/DMvWxVd9W0y/NvxOESu/txFx+qy4fNLaduvqpThDjGO0QlUIPQkDRUO9Nnq
	txtvKnREwkPE9l1ss1M8NvrfYsW/k6xDZcOyzvPqxNMR6nY6+tMW9K7RTmWT35KnZ98Fy8
	INN174qjP6QitNTwFlDDv0Q/CTlaYMM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-ko2AiSPCO-asPit_Xff0Zw-1; Mon, 28 Sep 2026 06:12:21 -0400
X-MC-Unique: ko2AiSPCO-asPit_Xff0Zw-1
X-Mimecast-MFC-AGG-ID: ko2AiSPCO-asPit_Xff0Zw_1790590340
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870663a5c4so1269876f8f.1
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 03:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590340; x=1791195140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
        b=RvWYIInbOhrNOoxomnczmjRZqsoaZ+5J3QAmmw/IaDs5GJdRhEgDI6wewD1Od/dRqE
         T18qmEDw3fol5VuIzcnhjHfa9UbJ8emlxZN/E/lk28DamUVTJnLh/fe6tTR4JV4h4B8o
         l0oLefVDxMSj/A8eHNGbPR7QeeTViCjsKT142Pn3POegH71WvPisS+xQKYUQlTQIpEJB
         +YcZWXq89YMI03D7fxaztQk5on9/p/CU4C+40oLKaYJSu37X+pxkWtywdbLLJHrsI4HF
         8s0bcV8sCv2oWTomvoMinHVNsSiiCiMIppmfdD+wQqkxa8JLJZe2Sz6H81iylkwvQXs/
         zApg==
X-Forwarded-Encrypted: i=1; AKwUvBzrZmDq3eAy/1HUoVA9+VUvkaMI2BsH9C7dd6Osi4+lHZUy3ukb4favWXIChrABPnfGHqM3iph7EpZQKap7fw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfJjgfGSQVMXU+F/JJfzHtDd+OzR2RNHY9ZkbQVRyPspdmiRWz
	5lzq1XZTawmSXWF4aPDzq6YrJwwwlEYuAL/EoQ3EOwpofwaXUTOSl2PDe3s2c7ymBO3PyAMBWix
	xpcdT1dLfT5P1cOheYVwyqjKQOPnGeYJqGVlPW9CvrviPJ9l6b7aeOcPRoXwNC2LmdCJj
X-Gm-Gg: AYBFou2XELsCjNp2L9ZiivLO2PvMN9OlRCaP4/WaO6BqkdcxgqSzNc6UGOh24Nd3ehr
	CBF4zwRchUM1xx/Odvwc0HCVrS6sUOW096IuF7H+patjuq1pDa7OVLanki+qSY3GuYVXwLB4BQe
	Lvqt3EejDWrChsBz6FyNdrtPGBKMG3+7ih95dk9TPLyvmzyYYvdp5wBD/GiOwKrOA3vywSsgT/J
	rL2bmCv2ZAC8uAdlDBsa5fThk3A1fykh/5JtWz5bVklAhm79zDLNazPScMaseJ+DNGHw3A1+5wT
	HQAb8Rgrn17FbHEI2tLx17xCIWovh+S/WlDv+dNV8ctb6zqLLP3epHbjcs504Wt67gbGCeBG6sG
	1ZiCcKQMzIp29bB9NlmVEDEHQ8IPuDsm3woc=
X-Received: by 2002:a05:6000:401f:b0:488:8111:6f56 with SMTP id ffacd0b85a97d-48881117121mr15322483f8f.8.1790590340164;
        Mon, 28 Sep 2026 03:12:20 -0700 (PDT)
X-Received: by 2002:a05:6000:401f:b0:488:8111:6f56 with SMTP id ffacd0b85a97d-48881117121mr15322447f8f.8.1790590339801;
        Mon, 28 Sep 2026 03:12:19 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm25765327f8f.9.2026.09.28.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:12:19 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:12:16 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/8] vsock: simplify error check condition
Message-ID: <aro9DiEB3GPIMnMu@leonardi-redhat>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dpOaR9rA9usJEWkLO2O6Y63cL1foB8h3D7FsA1JI7Z4_1790590340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 22, 2026 at 03:14:56PM +0200, Michal Luczaj wrote:
>On success, vsock_assign_transport() ensures transport != NULL.
>Drop the redundant check.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi

