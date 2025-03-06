Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAD725A65F
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280408; cv=none; b=IfycGKliBohd1VIuRF2K6Lnfn/NbbRuAbIKtpFWJn4wL9eo0+I/FkGnU/0zZ5PtNywauL35rZCHwLxlqnzyuqoAksuMproNCmuvJ2Z3L7aj82mnKghVFS5YRscEYy7w4RGZ/+nbBazpbRqjVemAT/LCI1yHGhyrhAxphDtKmqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280408; c=relaxed/simple;
	bh=6EHelBLacWleQv44yGckAy3mIbBU9S9fc+Yecr7hfhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEF/U4aS86u0Wxt6aTMO23eWTECy8hvo1pHMNKFUmFqh97kjOmf/qUg5V5bmN1Na9wyi+T/XTtRRLFgU1FqYf1DnSqVvU4aZEtExCgEcDOuRUtWAZC+TyQdqu5XNGt/Kp8MU9Tgz/VuLnJWVJ7hKtffZFpsW25BPPzFXRMobPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ox0VaRn9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ox0VaRn9"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2feb9076cdcso2056252a91.0
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741280406; x=1741885206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQqTHFjNB8mAC6MabLFJci/UUFVOIM/RIyf/FHXgNd8=;
        b=Ox0VaRn94Y7OhZUJhYwZ/o0r067kDL/ccg77feJDwtXDidKthztjwcSb3x4zzNgZK/
         vAi2NqEd76tOszxayMwuBFEwgCIusnh7ECyniYNC5X4vQqiuwn5IouP38lHOlDEPgh0x
         CnOCwGnJDX/+A78cW2oVgmE/jKbToHOf1Zmdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280406; x=1741885206;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQqTHFjNB8mAC6MabLFJci/UUFVOIM/RIyf/FHXgNd8=;
        b=cNZkwV3DhAey8KtEY33LSeRMLyzcD5HPcBreim8Gb/vj3NVBhGDzVehRsCjiq+GF51
         FIiGg7830eI4QZ1ktBeRmOM7/5QdkJ8Of2NVPi81idpZL/PFZlsqDI3MZlu2lFDjHuau
         PMJUZx17fKOkSP3U3eQgWwTuPIdp70jTXRaEh5esNZBkP8WL0uIBRrIjNSEbiUclcusa
         wqRgiC1HGrkx/Gu154jViAQt0uKJxIGkwOErlJNbz5h1WvorWsagpDUWpx0dkpzR6ldn
         xibtnstOjEMGmUQ8AAQgRBwyPjNay87jCpNWKihlc+SqwWbW1RsN/P9IjuqjVr5MFaqI
         4WPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8CUOcvkpPAFBQLqGEurpFj6oLpcQN7znCnp2bftyuICRTi2SCE/h/SU3GbHahvBGd205bhkccl26YbSn3mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCckM4J0DikBncVr1er7DpePT9tiWS6gkBeWttPT13YK/b1SQ5
	iibmySGuZ4kjp0B9PSU2zP6DT7X0ABoXqksbhf+xS4lE7hkAICSeXkzkS8+IAYo=
X-Gm-Gg: ASbGncu9aD+09JctWh8C+2Kq6aOMXEjOBJbpkVS8kFX/yCvavLBlScyjKyKmP2MCIW/
	GkRKE8JuH+elAmFdWIAl5XfQmGTXVlOtTKrj8MqSpDtsE0+6q2jq48YIeozeHXZtH/bFU3Bx33J
	8BjqOIw5GsyBIfvrv16hR54I1Vtm4fW6FVTtO8XgemJVdh+qAGf7X0l5X7OWSQQgqV7xMFRXDnI
	P0FQx3SdSGJlj1uG2F76nYNbQ+pRstQj8/QQr7ZOZQoOnEigQD2qHjF4Ns86VCHxltvNqPCZcbv
	rcdFI62S4TKkm0pZAxIm65DKhXn5UM0bfcrbri8egMShxu1FROhCvLSl2vtJ7Z7FGnd3pFtKM0M
	7rgAW+L9OKx8=
X-Google-Smtp-Source: AGHT+IGMGInMYoKZVtUaLSTFn7K3E/qcMiV7/r81nffI3pTWDuYLKqaB5kMCtQ4fVSMgy49C9wt38w==
X-Received: by 2002:a17:90b:5688:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-2ff49717481mr11337807a91.5.1741280406235;
        Thu, 06 Mar 2025 09:00:06 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff5f6a64ecsm1685585a91.0.2025.03.06.09.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:00:05 -0800 (PST)
Date: Thu, 6 Mar 2025 09:00:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, mst@redhat.com, leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8nUksjJyKEbP68-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
 <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
 <20250303160355.5f8d82d8@kernel.org>
 <Z8j9i-bW3P-GOpbw@LQ3V64L9R2>
 <20250305182118.3d885f0d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305182118.3d885f0d@kernel.org>

On Wed, Mar 05, 2025 at 06:21:18PM -0800, Jakub Kicinski wrote:
> On Wed, 5 Mar 2025 17:42:35 -0800 Joe Damato wrote:
> > Two spots that come to mind are:
> >  - in virtnet_probe where all the other netdev ops are plumbed
> >    through, or
> >  - above virtnet_disable_queue_pair which I assume a future queue
> >    API implementor would need to call for ndo_queue_stop
> 
> I'd put it next to some call which will have to be inspected.
> Normally we change napi_disable() to napi_disable_locked()
> for drivers using the instance lock, so maybe on the napi_disable()
> line in the refill? 

Sure, that seems reasonable to me.

Does this comment seem reasonable? I tried to distill what you said
in your previous message (thanks for the guidance, btw):

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d6c8fe670005..fe5f6313d422 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,6 +2883,18 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

+               /*
+                * When queue API support is added in the future and the call
+                * below becomes napi_disable_locked, this driver will need to
+                * be refactored.
+                *
+                * One possible solution would be to:
+                *   - cancel refill_work with cancel_delayed_work (note: non-sync)
+                *   - cancel refill_work with cancel_delayed_work_sync in
+                *     virtnet_remove after the netdev is unregistered
+                *   - wrap all of the work in a lock (perhaps vi->refill_lock?)
+                *   - check netif_running() and return early to avoid a race
+                */
