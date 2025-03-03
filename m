Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597224FC03
	for <virtualization@lists.linux.dev>; Mon,  3 Mar 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020375; cv=none; b=QxORuWFg7NmPwHG2ARgVo2meMtTnu/oEKXjm4uqdCLUAyZ2YPzBw+VLAbNn03hwbDA0dIOd7M7EaqfJ5rf5VGVcluU314p+oqhLZwb26uIvfhKOYZLnbcwVxMOfbqvjY5oIrX9gpnA3lDxs1qpeA6AZuqFSsLjJYFtuYY75dF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020375; c=relaxed/simple;
	bh=4a3Js/QSUPm1CO0AmuaBEQTQLE/ky9K8nLFdDZq450M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHHflSydyn/qcgVEZMRE9f9XqWyHpuyt95s9xK8OqEe/qZnnWMdRTuwGC65KF7acazZjnvblDZ6QklTIboeukT8rCRYTguv07RpVQVwuRTRLgS6VNoKg6yu5PuW7wANU2YxJuzD8PYaBLaQe6J5+hu3IXXpDS7hk14DUl9vp77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xd/JcQ6h; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xd/JcQ6h"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd049b5428so42868216d6.2
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 08:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741020373; x=1741625173; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X1eRghCbAiXOwCl3h9CNpVTl3lfWmjRfbNCLQzdf/o=;
        b=xd/JcQ6hpk0y+8Y9sgUCageeVcwIXWDsFg/Yb3xISwbod3KJKEMUm4xrDoz2ja2kly
         3CI3YSJdxgXlJTSsFuTlc5Cp2/Tf6DpQrfQgrYkvFJspj8JH7t2zOL+H0gpWH3mkLEfj
         TpM06KF1bo4VEqyISElNd26Ays/FD1xzYXndI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020373; x=1741625173;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8X1eRghCbAiXOwCl3h9CNpVTl3lfWmjRfbNCLQzdf/o=;
        b=h/wogyYq8eqKmGmSRL1tfqLVthMOtbCiXO+RuQIL/ORpP5INBbHpdpmor7Nw2QNYjq
         gl4zmqFXdy/YHxJbELzk59Z2JzRx58ILergodi/btPN1Ow1yiSxTm2Xl3XcklpnRRdEJ
         kySFpv8az/afhGpwO6Hf5vfWqarhFJQcnHpCC0sny9YScykvTC2YCovvcjBWoLhhQNGz
         L8k1UzyX3X/Q0jPO4Ma1iOihg+4FabXaADhsqDK5nyGEp81a4jleyMftFLs2NZDavEte
         q8HU1ZnaKfs21NHkkh1ASwEfFQymIW1oK7KA7nrkgL45/TcvodEm1I0vs817qncDvPP/
         Vz2A==
X-Forwarded-Encrypted: i=1; AJvYcCXfGpDoKEZ/e0jPBRUVgTyYh2WP4pz+Ywj9qPegsdMn1Sylu4/mdTOBuI1/VKdYLwLOQ3cwZa301Y3j8gvJlg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5+J8pqbVocOptMnZ/o4Lx/U7yPqr1Sln0WePy6/xxdLpaYTss
	pNF0K70UHQ7e+bq9PSUC6k7lQmZCXZBkaI95Tb0Zvau8t47YwhuaEiuCz03RC+Q=
X-Gm-Gg: ASbGncsCDmlhtfi1cYIBNbxhkP6PaqEa0XyMcQMtwC5a6znEG8KOUpyVmmBrGPh1hmH
	n7TtCmK9CkT67UDIdmVma9ptkanUd9PNoNJ+t/QwCOnz/m90nw+/aN64nz57bhJuA4zrsQA1cyj
	H3VYuqnzlF4Y40r1gP2ni4+RTLjWvJdey/Tm6qT5+qlGMZkV5aNaXm4cOOSbdxqz2HO4BOsDJGv
	yZ/AlG6KBLqkDtfNHd6K01YspzPvMouTaFKnt9DZvT0KPIpKPRodaP6pNrELDwkfdbOcpLgXGoe
	/3UyDpAb0TAMT9qPCRlUdfOcV6BASFt8sPx3hQkqcyjuma7gmajCWIuVxv3zeenmHsMuXmxzmTj
	K2VHHi6I=
X-Google-Smtp-Source: AGHT+IHkzyITDdW3vLOmKpMop+SV7m+wXZtHTB86svSFry2DpAQLcSAU+s3Ys44u2tdDtQuD6QzsPg==
X-Received: by 2002:ad4:5de6:0:b0:6cb:c54c:b782 with SMTP id 6a1803df08f44-6e8a0d84e3dmr230430596d6.32.1741020372960;
        Mon, 03 Mar 2025 08:46:12 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653667sm54834896d6.32.2025.03.03.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:46:12 -0800 (PST)
Date: Mon, 3 Mar 2025 11:46:10 -0500
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
Message-ID: <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
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
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228182759.74de5bec@kernel.org>

On Fri, Feb 28, 2025 at 06:27:59PM -0800, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> > @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
> >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> >  		struct receive_queue *rq = &vi->rq[i];
> >  
> > +		rtnl_lock();
> >  		virtnet_napi_disable(rq);
> > +		rtnl_unlock();
> > +
> >  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > +
> > +		rtnl_lock();
> >  		virtnet_napi_enable(rq);
> > +		rtnl_unlock();
> 
> Looks to me like refill_work is cancelled _sync while holding rtnl_lock
> from the close path. I think this could deadlock?

Good catch, thank you!

It looks like this is also the case in the failure path on
virtnet_open.

Jason: do you have any suggestions?

It looks like in both open and close disable_delayed_refill is
called first, before the cancel_delayed_work_sync.

Would something like this solve the problem?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..457115300f05 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
        bool still_empty;
        int i;

+       spin_lock(&vi->refill_lock);
+       if (!vi->refill_enabled) {
+               spin_unlock(&vi->refill_lock);
+               return;
+       }
+       spin_unlock(&vi->refill_lock);
+
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

