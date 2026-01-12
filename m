Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A521427A
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768192412; cv=none; b=AqeXfvMdAm7spelizX1tCkpS4LO7wXUmKXNzo2U5FUnXzn+CPZ3BZzlvYXzIKyyb2+rs+PHEaOcnzEnmv0TLDsEY1h13mNS2hc2QHl79n3+zK16Z5lWLOGORidMUztaiLQuXkHOgO0fFAW4kn798O9TntVQqMqbE2T0Dt0z8zUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768192412; c=relaxed/simple;
	bh=JsECp4e88xlO5Vo5MlkaWcurekx6DybzbgYXNqaqYFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f1st18jLqpj7MpepZGvzqWzzUFT3/HKARm1Z8gBBr0JVCtv6tCnB9HnVUXJrOs+WLsBeKXRdvurqS/b/TXFnuhYQHJaw8AXCEGQYkT4S/S4wm/mbGFROWrOA+MsotS6ZHCkf7wgxeRKLgB0ci7hElu4LgIHTP3T3x2aHX2Xv2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VmH9pYUG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmH9pYUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768192398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=APuQMk+mj1Ir7IfbwA6rsBMcZIxIkKakSr4yNu5ZY2w=;
	b=VmH9pYUG/mLi9V1uEPPH2TR8PlbX3ABMRcRmmyeVtmLP2JCOHrvlgG4DFdgrlEPwW6JsOa
	/KnwTPsC2Cgtzv9R/Tar7AlvCi9VxVL8OKXrpuvHcqzt0jxoH/zqNnRyMH8uvGyLt/SVKF
	SSzfO8UiW/eoApudi0+JCfyEYNPMj+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-tUiu7KtbPiarn3v6HAKGNg-1; Sun, 11 Jan 2026 23:33:16 -0500
X-MC-Unique: tUiu7KtbPiarn3v6HAKGNg-1
X-Mimecast-MFC-AGG-ID: tUiu7KtbPiarn3v6HAKGNg_1768192396
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-432c05971c6so2928764f8f.1
        for <virtualization@lists.linux.dev>; Sun, 11 Jan 2026 20:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768192396; x=1768797196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APuQMk+mj1Ir7IfbwA6rsBMcZIxIkKakSr4yNu5ZY2w=;
        b=lPaZ0lG8Gf3Ajz3gWp8P13cmvNGhIQKZ4Tj07J62hKyZTqwhnrOqG1+jCD7FMApdIU
         RSSz3Up6pz8Di1ZHbrOCxPRp22s0yF6oc8epEyzTdo6BxAIRnjJcOr8RPG88UHCpdtiW
         HmaVuXs3vPxYPTZLuOyVrV3aNJvHu6c6CszO6vdUabco0Hpx4mOwYGeFtdWta66pqC9H
         lOXzBTwODVjv1PgTCE9grHeXqyFr4pZxNGw/ghxQlr/XUw3SSjzKwSSljBLe6b0b99L3
         2lyqEUpeczLLBjgw4ZSdGt/ghe8Yqe1E3aFlF2dWpzlDxxtyTcGv0aV1uP7bdqyHzzWz
         +V+g==
X-Forwarded-Encrypted: i=1; AJvYcCX/Rd010EmRN/w2MiM8T73Ni6HOsnFkITuBVUZolCPI1e3i+K/zf/8ds2I/P50U3MSiSIUpY+A4IJ+cnasZ7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1n3HY15wqTV/lw8sJXG53d3V4uNeFeycZO2e1uCVqaB+SmPkr
	y9GWcoLzvVoFtYeB7rooJX+qBQi1DFNUVt7gC3zZ/rW5hASbxmsRAw/0bhO04cefEZUQaTlEun6
	OPoZrO0KNFP25umWk3jXqP1rvUw+b48hGSkr9VHhi44+rHeCFJz89y6ffEuZVok/t1hHZ
X-Gm-Gg: AY/fxX61fZ2FMiaOtnaHt9esl7gNLffgHH8c+Os2AKfc6PIE971G/vp+2G7iwHLiiC/
	PaiY2gotoKmSOdGwov4aAt45eYWTkGYvTyoYQ+9ulfl/sRsGApZbsat/T0gGbuBUuqyrkETL7kp
	xv2HIo3o10L1+V7OY6dguQpbw47xik0ltVuBLcQRiY8zdlRZmSwb8ic9Xp2W+vYYTD63Aa0JUiU
	B7jsswtVkYqhqFR983fRASNYjA7mxhgmG2A8bi2CkmsNMmCf8gFzix3DVXwoDer/oBafzBNhJN+
	/oLotHCsuVk72MHhDaFGR3bO/ee0Xvs3FFoAriD/bPz8TWhpL54GR2ogX15605wor/wHLnxuzw1
	qdlOnz0mM9M55pteG/HWssw5Tx66I8u0=
X-Received: by 2002:a05:6000:18c5:b0:432:da7c:5750 with SMTP id ffacd0b85a97d-432da7c589cmr7999805f8f.20.1768192395668;
        Sun, 11 Jan 2026 20:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/BXpYp147sy8NHGo+1rbRx2BpHOkLFAtFBJEDqcFXZDM5sBWqhXQb6dEWZIhQYfgNrNPMPA==
X-Received: by 2002:a05:6000:18c5:b0:432:da7c:5750 with SMTP id ffacd0b85a97d-432da7c589cmr7999782f8f.20.1768192395211;
        Sun, 11 Jan 2026 20:33:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm35982021f8f.35.2026.01.11.20.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 20:33:14 -0800 (PST)
Date: Sun, 11 Jan 2026 23:33:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
Message-ID: <20260111233129-mutt-send-email-mst@kernel.org>
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
 <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
 <bd41afae-cf1e-46ab-8948-4c7fa280b20f@tu-dortmund.de>
 <CACGkMEs8VHGjiLqn=-Gt5=WPMzqAXNM2GcK73dLarP9CQw3+rw@mail.gmail.com>
 <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <900c364b-f5ca-4458-a711-bf3e0433b537@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: naN3ZruAG5VTd05JcmOwBwW3dw7kC-CoCzUMlX6Px1A_1768192396
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 11:14:54AM +0100, Simon Schippers wrote:
> Am I not allowed to stop the queue and then return NETDEV_TX_BUSY?

We jump through a lot of hoops in virtio_net to avoid using
NETDEV_TX_BUSY because that bypasses all the net/ cleverness.
Given your patches aim to improve precisely ring full,
I would say stopping proactively before NETDEV_TX_BUSY
should be a priority.

-- 
MST

