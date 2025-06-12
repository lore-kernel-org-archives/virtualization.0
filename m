Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557D1798F
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706346; cv=none; b=RYXS5JCtxFf0G6kFhsKav9PK8vKSbOwMbMo5FkVZyWOlVyXp7oS5CGwpHv2/jWxkfl0W8j72FX1RrYG8hnqk5KROEPlDDm13XtfvDvMRork7nxkmux7zGhKra0pfDMYHYrF0qHyi48GgXzBAAGSC3q2wbN8UuCqRuY0jZU3/4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706346; c=relaxed/simple;
	bh=vii4+vAE/cNdk6rrbsnHbx44XX91OlPcufm+uzCCWrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wdw7XfNGdiFBstYAuB2AbcOVPtyuxrQwWTfeBl/J3ryCd8MgYJc4MTbMgUtL6kvjOwQROuB4Yjnf/ar0byfnstpRcrwfilV+vkFhtKv0x4sOdREa8UjULaak87aQsc6iiYEuPyH5RqlD/NiqW/Ubbnt8dQ9IFEIkq/DxXXXU1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtIgj7v2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtIgj7v2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23636167b30so5466885ad.1
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749706345; x=1750311145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vii4+vAE/cNdk6rrbsnHbx44XX91OlPcufm+uzCCWrs=;
        b=RtIgj7v2bUJEYaUpixmB2TH8NjQK7VVnuC/LSRf5UeKto38xdT6TYyoGe3GuZfq2wR
         V+OlXixBTFelypjyI/0XtuCKmZGwJbyxhLf2KkJ73LkhuNbF2Ty4qxikmRL1RxaYH6+3
         QFh3AzpCE+0kL3y2ClftjaZTylKbxn9dItj5/dJsJiCZ2NBJdDv1K6sEQjbloAfTflcq
         ihwx8CiHXCV/hjNLuumubUpyVHE6+zvz8r3cR/vI64VG8YYREWu60XygEoivg1dGTY8g
         NaCc6ts1RFLJaORprxeJfn54fiaaUz1p0POVbCOPzY808cuvW4ucVtF6zevJUJCqG5n8
         cg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749706345; x=1750311145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vii4+vAE/cNdk6rrbsnHbx44XX91OlPcufm+uzCCWrs=;
        b=RMihdlM80KS67xeiaPvY7oLPzlc1d0Auk+y9iL38/slCJeY0Quoy2xB5pxHzyLYzA4
         TpNSMXSBNAGMx9WhO0LVGwsgwa5UFDKYFVnX1d4A+km4GYWxZbGAOYUUaHnbUEHMJQ6c
         7pt+L+roD1SI6m05JISs3G0pDbUMETpS2XW58WbFudLLphz6HxJ9Lh1ZmMk/H09DABXE
         YsxH8ABuSotrMi6KyAHWk6X7cyAw9f4RLGz+2pYW2zmRtUDo5yozX7nVZd+hVGVgmnxB
         BN+fvygLo7Ml1JO5+MIcO/HGekXuyRl1caUnVF4gzNysI2N0Of1m2T+eC1GfxAEccCHq
         8QDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw/lnKwsQ/iAiA86NME1+FIMko7bM+/DL0WOZ3PlUSnFY48z+uGVYokcRX6HuY15AcOV8TCbnbcrqojxkUmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YypCf+fNSQTQVER60iCIh64WxTnitrXSHb4oyMOmxRlpy4RomLc
	ISF64i/GxD4A3llvoRurcAZYsd8eiiSqgfFJCk+Vb2j/zyis6zyIzuzg
X-Gm-Gg: ASbGnctoyrC2DpS38MVqabdbUe0T07icppiCMW4Ybrovxy6FKDHPfnazSvrnnwTi/MI
	iOnj6CzFE2itgbIMkQ7yEdyfEpkxxntKEt7Qc1ZeDveV411w7QinSTULlX6FuDoH1OdMHf6WfzJ
	h9T289OtIPXEdRcV4ZIDg4rTNJZH+5CEhRPJGSAcMBA9s6AuhTP5e/IKfyducDY2ZjlKKWc/uOY
	ix87/eYQYQw6WJXn3khATnMoAmkXNlHviqSqFyhHUwhvo3BB2mASLkiMcIaXrX4pcFKUY2SPzBz
	69ltVCFaqQXvHf47KVjXCrATWi8teNFFac0zvEnajeY9dCmoa7IjWUanN4F+TTndmHAj8FeTezT
	0E/25alC5
X-Google-Smtp-Source: AGHT+IHcqVGofAGhSc43EaW6uyTom42iW5fqDOibqA0yTFHdAqUwPEUt9Zalv0PruwPswO0c0C3b7g==
X-Received: by 2002:a17:902:e5cb:b0:235:ed02:288b with SMTP id d9443c01a7336-2364ca4bbcdmr29724125ad.30.1749706344723;
        Wed, 11 Jun 2025 22:32:24 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6db2a6sm5243415ad.120.2025.06.11.22.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 22:32:24 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: Oxffffaa@gmail.com,
	avkrasnov@salutedevices.com,
	davem@davemloft.net,
	edumazet@google.com,
	eperezma@redhat.com,
	horms@kernel.org,
	jasowang@redhat.com,
	kuba@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net] vsock/virtio: fix `rx_bytes` accounting for stream sockets
Date: Thu, 12 Jun 2025 13:32:01 +0800
Message-Id: <20250612053201.959017-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521121705.196379-1-sgarzare@redhat.com>
References: <20250521121705.196379-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No comments since last month.

The patch [1], which adds SIOCINQ ioctl support for vsock, depends on this
patch. Could I get more eyes on this one?

[1]: https://lore.kernel.org/lkml/bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3/#t

Thanks,
Xuewei
