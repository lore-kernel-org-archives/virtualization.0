Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A087C8C8
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbfFHsVW"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B2C9617B3
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 08:14:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B2C9617B3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XbfFHsVW
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7brQkFEeSGk
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Dec 2023 08:14:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5106061033
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 08:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5106061033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703232870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYt+vp9cI2zldDXVJVhhtrTRhB+2Gs2gvyvghl82FwI=;
	b=XbfFHsVWlEoogf1f9P3BOA1i1mT19xo/ADy7zqScTRtrFUU6ZiIUFPBbhLf4ThXmGlVUXp
	6/SuuzuK6aGhWp3J8ft1hspxV6i6jbTfKJBygQgVTTg27u15WMspEQeXBJCCKj0ZrAEJlX
	+BVjEBqbBVRK93nZCbp/m6qEyvtyy/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-U4VDv8pMPJGXz1RHZJ27CA-1; Fri, 22 Dec 2023 03:14:29 -0500
X-MC-Unique: U4VDv8pMPJGXz1RHZJ27CA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3368ab1928dso582670f8f.1
        for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 00:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703232868; x=1703837668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYt+vp9cI2zldDXVJVhhtrTRhB+2Gs2gvyvghl82FwI=;
        b=kdgzFf2zvaqZOu/tD3pqit87xzqBPshTFojq+ITX8evrOQrGiIK40FrthR+S3pdVyS
         0T8Ke2cDKIcGXei5thbbf/e8Lz/5orKjHt/ueqxOjxHeUyTrTJtSgw7Hz5jgaKkjNaR+
         FZ481uPQmR/SDWINmiJYKrm9dcZvLVf9gGpESzJEUrHvp/w+/KfFLLSq+hRQi1jBaAY7
         0Ry2yu982IyW/mBvg+bFO4JWPm72t0rjR1iCKE52SzSVDdk02uyjHu/LxBYnpWuQKwAj
         OHlCG6vmypwe1lVjSkS/rN2ON1DB1AJCBkcaPy76/0Eb672caB6976F+SpArmmCXOti7
         9r0g==
X-Gm-Message-State: AOJu0YzcUDxTrdqnBf5/Vn2HJOPX2bHvu/BzCYwS51BSfyHv2ES5DOqe
	+0WgaG2S1WGoHdnr76MoNAu6YuBI+FY2UCHmwboa9p5SwCAYWukUrm05prnuEvyPPjgnkZ/eFHH
	UqiaMAsRjFbZvHpy3qjOtSK1x2ewST6hoaBWseHNEQNgqGFc9qQ==
X-Received: by 2002:a7b:cbd0:0:b0:40b:5e56:7b44 with SMTP id n16-20020a7bcbd0000000b0040b5e567b44mr421677wmi.141.1703232868127;
        Fri, 22 Dec 2023 00:14:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV3WtDkqPgvfDOIZCUSjLH1E2hRCsCiUvHhJkQr9ie7p17mzKWPDc8k5Yx2v2DIeZvEyrjhg==
X-Received: by 2002:a7b:cbd0:0:b0:40b:5e56:7b44 with SMTP id n16-20020a7bcbd0000000b0040b5e567b44mr421669wmi.141.1703232867761;
        Fri, 22 Dec 2023 00:14:27 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c138a00b0040b45356b72sm13840236wmf.33.2023.12.22.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 00:14:26 -0800 (PST)
Date: Fri, 22 Dec 2023 03:14:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
Message-ID: <20231222031024-mutt-send-email-mst@kernel.org>
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch>
 <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
 <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Dec 22, 2023 at 10:35:07AM +0800, Jason Wang wrote:
> On Thu, Dec 21, 2023 at 11:06 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Heng Qi wrote:
> > >
> > >
> > > 在 2023/12/20 下午10:45, Willem de Bruijn 写道:
> > > > Heng Qi wrote:
> > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > >> module parameter, and the other is through coalescing parameter
> > > >> settings (provided that the nic status is down).
> > > >>
> > > >> Sometimes we face performance regression caused by napi_tx,
> > > >> then we need to switch napi_tx when debugging. However, the
> > > >> existing methods are a bit troublesome, such as needing to
> > > >> reload the driver or turn off the network card.
> 
> Why is this troublesome? We don't need to turn off the card, it's just
> a toggling of the interface.
> 
> This ends up with pretty simple code.
> 
> > So try to make
> > > >> this update.
> > > >>
> > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > The commit does not explain why it is safe to do so.
> > >
> > > virtnet_napi_tx_disable ensures that already scheduled tx napi ends and
> > > no new tx napi will be scheduled.
> > >
> > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > > send the packet.
> > >
> > > Then we can safely toggle the weight to indicate where to clear the buffers.
> > >
> > > >
> > > > The tx-napi weights are not really weights: it is a boolean whether
> > > > napi is used for transmit cleaning, or whether packets are cleaned
> > > > in ndo_start_xmit.
> > >
> > > Right.
> > >
> > > >
> > > > There certainly are some subtle issues with regard to pausing/waking
> > > > queues when switching between modes.
> > >
> > > What are "subtle issues" and if there are any, we find them.
> >
> > A single runtime test is not sufficient to exercise all edge cases.
> >
> > Please don't leave it to reviewers to establish the correctness of a
> > patch.
> 
> +1
> 
> And instead of trying to do this, it would be much better to optimize
> the NAPI performance. Then we can drop the orphan mode.

"To address your problem, optimize our code to the level which we
couldn't achieve in more than 10 years".  That's not a reasonable
requirement. Not getting an interrupt will always be better for some
workloads.


> >
> > The napi_tx and non-napi code paths differ in how they handle at least
> > the following structures:
> >
> > 1. skb: non-napi orphans these in ndo_start_xmit. Without napi this is
> > needed as delay until the next ndo_start_xmit and thus completion is
> > unbounded.
> >
> > When switching to napi mode, orphaned skbs may now be cleaned by the
> > napi handler. This is indeed safe.
> >
> > When switching from napi to non-napi, the unbound latency resurfaces.
> > It is a small edge case, and I think a potentially acceptable risk, if
> > the user of this knob is aware of the risk.
> >
> > 2. virtqueue callback ("interrupt" masking). The non-napi path enables
> > the interrupt (disables the mask) when available descriptors falls
> > beneath a low watermark, and reenables when it recovers above a high
> > watermark. Napi disables when napi is scheduled, and reenables on
> > napi complete.
> >
> > 3. dev_queue->state (QUEUE_STATE_DRV_XOFF). if the ring falls below
> > a low watermark, the driver stops the stack for queuing more packets.
> > In napi mode, it schedules napi to clean packets. See the calls to
> > netif_xmit_stopped, netif_stop_subqueue, netif_start_subqueue and
> > netif_tx_wake_queue.
> >
> > Some if this can be assumed safe by looking at existing analogous
> > code, such as the queue stop/start in virtnet_tx_resize.
> >
> > But that all virtqueue callback and dev_queue->state transitions are
> > correct when switching between modes at runtime is not trivial to
> > establish, deserves some thought and explanation in the commit
> > message.
> 
> Thanks

