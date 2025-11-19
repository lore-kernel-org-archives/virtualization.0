Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662E314D21
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539133; cv=none; b=W62IaxhxNtFH/LPIwW0N0F28erumI9/B7ME6rufx1ctEBi84t1w9AkVnO37QU+KpR/HlNo3gBvMMpw4qVWgptmHWhG1z9vZ0VB3MVArGlCBEoKtj7vwtOFYEoCcj7brzQZHvDvHfrmU5kh4SseA8k63PtU9H03fPaZOynF/W3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539133; c=relaxed/simple;
	bh=ztPb0Oi9ktxAOJLg1T9PzO/fl6i4U/jNw5A/87EltNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nzq6QfPa9Z7rY5oPLu8ZApe5QEMM8uDiGqo6Q8ZNCHEvSViFAg7r5HrTwl6oK9gF1djJ+JGys2xFGUEswll9zOwuaNm8JNeONlDC+7f2E+EzcrNlB//fbLa5XMco2WM7HxNj7z6utXMfKaPM9zwJUyHyXtS6f71f2+gTZ8l+suQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrINo+Dc; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrINo+Dc"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F14C84391
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 07:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gEJBiaHIzfA3 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Nov 2025 07:58:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D6A7284164
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6A7284164
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BrINo+Dc
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6A7284164
	for <virtualization@lists.linux-foundation.org>; Wed, 19 Nov 2025 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763539128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1kdukhMv0e5PS6jWRdXt6KYB0O1bYUGO99kB+sjRgQ=;
	b=BrINo+DccAEE2tX0LyKhhQT2rqSJicIfCaf07bGLrkRNasPTkA/539QHRdNa6NZb5FfeEd
	qosCySxBvmmF5bPMI4Q+jyR/WKze+L+vg64T7Ff0VHAmw7diPHykw7ZZamDNcxqqB1ifoL
	E6vPIIrVBBrfBJY0Sgq7KdBaTu2GcHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-a7-_H3beMUe44AgQ6WJp-g-1; Wed, 19 Nov 2025 02:58:44 -0500
X-MC-Unique: a7-_H3beMUe44AgQ6WJp-g-1
X-Mimecast-MFC-AGG-ID: a7-_H3beMUe44AgQ6WJp-g_1763539123
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3155274eso2862627f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 18 Nov 2025 23:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763539123; x=1764143923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1kdukhMv0e5PS6jWRdXt6KYB0O1bYUGO99kB+sjRgQ=;
        b=xPVciBHorJEBrf1gyN8q80E20GQ7ln2OH3Iz4swIRq9VXgohNWdj6xtW4LZDqN/3S+
         mzzLOL6L2dJH71h5BIQuP+jvwopweHv2bFl26tsBu+kdBkQm9BRnhXrXbfzZ5cebm/bS
         OTNMqI1mXa7MQdomzjlbvrOj3VAO2r5f3SBvIyq4XOv3vvZjMhtY7OFCMDAwnLnA4ufS
         BQAo/yjyU/Z/gzHB3ZxIZiPHZePXZCxHljOvDF70YAexny43vfMDqlNOoEGruosu2L3D
         1xT+LLFHGFVeM4RJxU5EaTN/nAzCeQ/tskBMWvW88QRsRxtlaIP4iJDZWf9gly1XvxHt
         1jfA==
X-Forwarded-Encrypted: i=1; AJvYcCWUxQIeE6ZkhfXx1KMsr71+h8hpZ53dfujnKzvQls+m2K9ULv1pcm5q6xo2gF0f4aotLWZkeyxeYyh+cFeJwg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxIhBsP0j2BuU9xitoqQOzpHGnyfBpO1cTI3zRub6uluCS+vqRD
	k/HhUjWDnuS63I2VtMs7uHJEmKhbMCLUqvb11h+ejkoW/3kkLlZKJFPN7SeUl8MSTF56kAVuZEh
	OcJvQwfWVEuUx7hh6Nd620yNVN9W3a3KVuRJrTkMebUT8V3czPDGq/HHwd+ArikPtmZWuZktFQt
	Y2IfKbebI=
X-Gm-Gg: ASbGnctHJ5JoiV3x9QPqYrPzhi/mCPxRhOYJjrX2pyietDCyzBaIhPdS7lRAUIGfuiY
	+R6LXQvscQVFL6AfnwQRlrzBIZHjRaEwWJfGYzbi49xJrqwfqtIYlxR/OP2rhzdi1PniuOyaGXF
	dWn1g8WRTSwtKqlmnPfaO7WXwxI7eo1HTg52eTdiOad2lmxm4A5pllUs1u81IGuGhkvCiqaPUVG
	rMGz758n7M7gHHLBFnsnhXm2rUYoRgmpFG9oxR9duCg8WEi9LzEsvBtr/ZSCi9YuA+olsTk3y0l
	IzNU+v9tCUGY4KmQ8I6djoYNSACUSm8H+wcwsJTCdXxT/Xqwsc8QtsQ1XjjpF9tfU785ZOVJLlN
	bAYAI7vyVeTo/a03nNp7u5cJAJ145Fw==
X-Received: by 2002:a5d:5d01:0:b0:42b:4177:7131 with SMTP id ffacd0b85a97d-42b595add99mr19386656f8f.44.1763539123178;
        Tue, 18 Nov 2025 23:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/d9kIia5C1Rk173uB/q7uMGiJORCrpd/szircj7eTupOsjnjxbBmEFPJg4z/3AWkkns9YXA==
X-Received: by 2002:a5d:5d01:0:b0:42b:4177:7131 with SMTP id ffacd0b85a97d-42b595add99mr19386634f8f.44.1763539122739;
        Tue, 18 Nov 2025 23:58:42 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm35614093f8f.33.2025.11.18.23.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:58:42 -0800 (PST)
Date: Wed, 19 Nov 2025 02:58:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liming Wu <liming.wu@jaguarmicro.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_net: enhance wake/stop tx queue statistics
 accounting
Message-ID: <20251119025546-mutt-send-email-mst@kernel.org>
References: <20251118090942.1369-1-liming.wu@jaguarmicro.com>
 <CACGkMEvwedzRrMd9hYm7PbDezBu1GM3q-YcUhsvfYJVv=bNSdw@mail.gmail.com>
 <PSAPR06MB39429783A41F42FDD82477A2E1D7A@PSAPR06MB3942.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <PSAPR06MB39429783A41F42FDD82477A2E1D7A@PSAPR06MB3942.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LZf3_2qweIKS3IWCLLtbLxmqvgreLzioKx7n5_mSfEQ_1763539123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Nov 19, 2025 at 07:54:07AM +0000, Liming Wu wrote:
> > queue wake/stop events introduced by a previous patch.
> > 
> > It would be better to add commit id here.
> OK, thx.
> 
> > 
> eck. */
> > >                         free_old_xmit(sq, txq, false);
> > >                         if (sq->vq->num_free >= MAX_SKB_FRAGS + 2) {
> > > -                               netif_start_subqueue(dev, qnum);
> > > -
> > u64_stats_update_begin(&sq->stats.syncp);
> > > -                               u64_stats_inc(&sq->stats.wake);
> > > -
> > u64_stats_update_end(&sq->stats.syncp);
> > > +                               virtnet_tx_wake_queue(vi, sq);
> > 
> > This is suspicious, netif_tx_wake_queue() will schedule qdisc, or is this intended?
> Thanks for pointing this out.
> You're right — using netif_tx_wake_queue() here would indeed trigger qdisc scheduling, which is not intended in this specific path.
> My change tried to unify the wake/stop accounting paths, but replacing netif_start_subqueue() was not the right choice semantically.
> 
> I will restore netif_start_subqueue() at this site and keep only the statistic increment, so the behavior stays consistent with the original code while still improving the per-queue metrics.


Please do not send fluff comments like this to the list.

And with em-dashes too, for added flair.

If you can not bother writing email yourself why should
anyone bother reading it?




> > 
> > >                                 virtqueue_disable_cb(sq->vq);
> > >                         }
> > >                 }
> > > @@ -3068,13 +3080,8 @@ static void virtnet_poll_cleantx(struct
> > receive_queue *rq, int budget)
> > >                         free_old_xmit(sq, txq, !!budget);
> > >                 } while
> > > (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > -               if (sq->vq->num_free >= MAX_SKB_FRAGS + 2 &&
> > > -                   netif_tx_queue_stopped(txq)) {
> > > -                       u64_stats_update_begin(&sq->stats.syncp);
> > > -                       u64_stats_inc(&sq->stats.wake);
> > > -                       u64_stats_update_end(&sq->stats.syncp);
> > > -                       netif_tx_wake_queue(txq);
> > > -               }
> > > +               if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
> > > +                       virtnet_tx_wake_queue(vi, sq);
> > >
> > >                 __netif_tx_unlock(txq);
> > >         }
> > > @@ -3264,13 +3271,8 @@ static int virtnet_poll_tx(struct napi_struct *napi,
> > int budget)
> > >         else
> > >                 free_old_xmit(sq, txq, !!budget);
> > >
> > > -       if (sq->vq->num_free >= MAX_SKB_FRAGS + 2 &&
> > > -           netif_tx_queue_stopped(txq)) {
> > > -               u64_stats_update_begin(&sq->stats.syncp);
> > > -               u64_stats_inc(&sq->stats.wake);
> > > -               u64_stats_update_end(&sq->stats.syncp);
> > > -               netif_tx_wake_queue(txq);
> > > -       }
> > > +       if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
> > > +               virtnet_tx_wake_queue(vi, sq);
> > >
> > >         if (xsk_done >= budget) {
> > >                 __netif_tx_unlock(txq); @@ -3521,6 +3523,9 @@ static
> > > void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
> > >
> > >         /* Prevent the upper layer from trying to send packets. */
> > >         netif_stop_subqueue(vi->dev, qindex);
> > > +       u64_stats_update_begin(&sq->stats.syncp);
> > > +       u64_stats_inc(&sq->stats.stop);
> > > +       u64_stats_update_end(&sq->stats.syncp);
> > >
> > >         __netif_tx_unlock_bh(txq);
> > >  }
> > > @@ -3537,7 +3542,7 @@ static void virtnet_tx_resume(struct
> > > virtnet_info *vi, struct send_queue *sq)
> > >
> > >         __netif_tx_lock_bh(txq);
> > >         sq->reset = false;
> > > -       netif_tx_wake_queue(txq);
> > > +       virtnet_tx_wake_queue(vi, sq);
> > >         __netif_tx_unlock_bh(txq);
> > >
> > >         if (running)
> > > --
> > > 2.34.1
> > >
> > 
> > Thanks
> 

