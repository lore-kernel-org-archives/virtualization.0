Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797E4C0015E
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 14:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6F8E42088;
	Thu, 13 Jul 2023 14:52:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6F8E42088
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqQewhQY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSADlNJHQL0S; Thu, 13 Jul 2023 14:52:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F5AB42080;
	Thu, 13 Jul 2023 14:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F5AB42080
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 121E9C0071;
	Thu, 13 Jul 2023 14:52:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20EBAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E18DA613B4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E18DA613B4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iqQewhQY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eP-nlh23_Xvj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27E2C613C7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27E2C613C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689259928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5E6F9ats4BLmlQpCisZt6wT8CnApvl7BR9/00bgFE+o=;
 b=iqQewhQYWuyGG5NmheYFNcFwDNuvgKxpM1gcahmssW+mVSmgl15qre01edEuMdkTifKPAq
 sdgNX+TbyeFRirdpOXuXwvrEi4QoVhYQ0NROsGRHQ1skkXMgLvloMBkbrDt9E14tb8cKra
 0vaNF7PY5fImUO5X1+xBYzd8t8lk4TE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-M0PoO5ZWP5277DolMHAhDw-1; Thu, 13 Jul 2023 10:52:05 -0400
X-MC-Unique: M0PoO5ZWP5277DolMHAhDw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso464272f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 07:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689259924; x=1691851924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E6F9ats4BLmlQpCisZt6wT8CnApvl7BR9/00bgFE+o=;
 b=ODe5XVO4eK/ESLOedPvAnQx/Xj47L30tcq2WWtF7tVo+H56j4cCeuZfZImWeHfv9bt
 mmzwvNCZuXhbQObi62KCT4MgRjFeOnLWavXEMfQzb+qnU8xIaTGN2rynifCeeE3Mq+mS
 o0BOCdCJJPoDjausvKxMyvTrHjq7EVa+Norg9vAhA0epBLVV22IWUbxls16dVHRVKKnc
 pbtRzWw18tYicXNtnZp2WRZ4dUQ51Y+8jzbvynzFNskgv2UN9NBq7HT9mTxStJZqXBZ+
 wLWcUKokkgtv1VQfqAhfJfI48OF93MV18j32xSPu5JJdMhmua0113bXmUbp+UWkAWMWq
 dBrA==
X-Gm-Message-State: ABy/qLb7N+fDzL9/RsU1ehGQw47FQ0TVh++/8nB5xx0u0ukkClFOBF3G
 PJx3NYPno58NpFM6jb4ASeJpSk2YWz+x98yfPmmVOdNp9tmb3Lf8nEKEToeMUFrWIsN1kfDpooz
 451BYSj5JSsx3QySUfRCJWkigLBVbEsVcuTW0syjxUg==
X-Received: by 2002:a5d:4e8d:0:b0:314:ca7:f30b with SMTP id
 e13-20020a5d4e8d000000b003140ca7f30bmr1958303wru.54.1689259924770; 
 Thu, 13 Jul 2023 07:52:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFRuSHTNPf9qN+kahsoUR/nmIalfm3YfEdwlFil6U+7gTdTpuIDAdjWTT/+bCM2yDuYWb+3kQ==
X-Received: by 2002:a5d:4e8d:0:b0:314:ca7:f30b with SMTP id
 e13-20020a5d4e8d000000b003140ca7f30bmr1958277wru.54.1689259924514; 
 Thu, 13 Jul 2023 07:52:04 -0700 (PDT)
Received: from redhat.com ([2.52.158.233]) by smtp.gmail.com with ESMTPSA id
 s15-20020adff80f000000b00313f9a0c521sm8253520wrp.107.2023.07.13.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 07:52:04 -0700 (PDT)
Date: Thu, 13 Jul 2023 10:51:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230713104805-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZK/cxNHzI23I6efc@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jul 13, 2023 at 04:15:16AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 11:42:32AM +0800, Xuan Zhuo wrote:
> > Added virtqueue_dma_dev() to get DMA device for virtio. Then the
> > caller can do dma operation in advance. The purpose is to keep memory
> > mapped across multiple add/get buf operations.
> 
> This is just poking holes into the abstraction..

More specifically?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
