Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209A47A64
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325788; cv=none; b=IdY/oJddtEnkIQdATplNvS95tzlKx2XM1/xj/9BQzSIrqon4K9vZvF49sg5EzvyFqw3bzu31EcUEZLBjQ4fIk1k9o4z1kpV4ZRZE6MEv1usZRwC6IteQqttvhscvWZCXpxVvOYrq+d79ZfKnKE9IWnyyvqazDh24dLETDMcUP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325788; c=relaxed/simple;
	bh=4gaXHqV6PBG8eLYOq1naKtKS7INYAhuagTI8C/vxEFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+ImIXEZ2IVWA7PFTP+XyDdCOBLCsUMseE5TFxwmpciyl27k8i9g4ex6N66kRFBpJoMj7svIONUg4oMDeJioqacjGqdiN8BrnZeNHfhQ3BU0Pmvmsmh9R2bAH+SmebP47fM1eCO6atUZIfn9e0OazBSd/DsJpia51b4HdLWDD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i0w2CiKB; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i0w2CiKB"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso60989705e9.2
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719325783; x=1719930583; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4HQEiQtNx/5gJTpqeYzkuyf/BdlFVoYwsUPb5ZYPxs=;
        b=i0w2CiKBRrJWazhYa5LbqRrqxGCUu9R05SzZVHU3g8nIUGwZ+Zmri2BWUbVrY2gHOx
         q42/vpuwL7m8P8qceGgHUoWEmzi/t/EJg39SeHfEKHsnauiN+GPaLLAqwZXM/UfmC+7v
         1Xw3GlSgySnPaAeRcJf7FlrAVSE0S45dWH1mwI94dg0WjiilX9SeGJQ2gzNQHsb2V4lJ
         9rMbweyoTQDUgqKTqxdGZRnT6+9BJ8ilBdwFaCeXPJSweEyJ3OX7dL0Z/ieIrKD8AbeA
         CeulLGg+B8MNM3Go4uArtQPqxvulIi3q+nVc50GJcX8y2AduiNue+HYq8SY5g7KoKCpc
         KFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325783; x=1719930583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4HQEiQtNx/5gJTpqeYzkuyf/BdlFVoYwsUPb5ZYPxs=;
        b=j+9hu0nFFQQ2AnHLjLouQHwfGewK7c7eXTeg0rIG7jdFN5kDP7Vm42Fk9ktb+bY13M
         ZLexbWcfSCCbm92N08yXvaEwR4jaKeWXQOiYBqp+HgPrjRq8zggICJ/tpOpYoC9su4jU
         aua9Eydz+FhNQna1dNqD+mEMJu57Ta3t9zQXCM/3W48gfslAvqPbXJ2JNMJjGioTxA95
         CtbOCq979KMBr8Qcscha1z1av4tSR1dMYPvWUUv3vPxP86Aeo/u8zWPcENmTdRVQZwMW
         G5Krumuciv3YH98qK2AVHPo9R+vFLbjk/qUhre1pdx7K0zEnkE+spqlDf7PKUKZlOVrf
         phSA==
X-Forwarded-Encrypted: i=1; AJvYcCXo+PFEoioWjc6CnAi3gcjzh54e+VPu83Y6brl02ro1YbA21/hPtmhLeazbgfteXUO+qQE/NAWuF8RGyHqoqWhPefTTXdmJH8V4+Ch03FE=
X-Gm-Message-State: AOJu0YzENKjzSnViV8FX3tKR/leo4Y2MgI63Jhi6gtY8omPqPcRcwxek
	DoekiAvxTKucj6eUaDpTZZ7fgXijmaTuRNUZOQFs/GcH8i5sw4wQYSS528pK3TA=
X-Google-Smtp-Source: AGHT+IHsKwkqp4kKPGhhfzDzaF8w56M7nEnLjd623903Fe9imsM5gacvDAHGNZN4dAAOuWZfCkHA8w==
X-Received: by 2002:a05:600c:3042:b0:424:aa40:88ae with SMTP id 5b1f17b1804b1-424aa40890amr4247235e9.3.1719325783184;
        Tue, 25 Jun 2024 07:29:43 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b636bsm219443985e9.6.2024.06.25.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:29:42 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:29:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Feng Liu <feliu@nvidia.com>, Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of
 busy loop to wait on admin cmd result
Message-ID: <ZnrUUmIVivTFNAqh@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624090451.2683976-8-jiri@resnulli.us>
 <20240624072340-mutt-send-email-mst@kernel.org>
 <Znqk3LaiyhKhb2sg@nanopsycho.orion>
 <PH0PR12MB5481C79EC78C589800FC865BDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5481C79EC78C589800FC865BDCD52@PH0PR12MB5481.namprd12.prod.outlook.com>

Tue, Jun 25, 2024 at 02:53:57PM CEST, parav@nvidia.com wrote:
>
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, June 25, 2024 4:37 PM
>[..]
>
>> >So if you are changing that to a completion, I think surprise removal
>> >needs to trigger a callback so the completion can be signalled.
>> 
>> What exacly do you mean by "surprise removal"?
>
>PCI devices can be removed from the PCI bus while the driver is running and with outstanding admin commands.
>Pci bus's remove() is called and this needs to notify and complete the outstanding commands with the error ENODEV or similar.

Ah, I will need to maintain a list of running cmds and use this in in
this case. Okay. Thanks!
