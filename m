Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7163E1C14
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JD8AGyFu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D94B3414A1
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 08:03:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D94B3414A1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JD8AGyFu
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EHnVaIWZNOsl
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 08:03:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D701E4149D
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 08:03:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D701E4149D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703491435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wCwTTNNyqrMfZw/hNOREXjBR0xNOBHLOAENENPZLEbY=;
	b=JD8AGyFuchz+ctYzFghPlm5vRei5rOD4jSjk8AGl5Pi9scuDSWPm7gGibFw0Vhlth6SFYs
	jdeF+yCsEjPWEe2e9mZb2elUoOVz1b/OqJGvP37nJLxQZiVktbWXfoccV7oGjAdi5heFMp
	sxYdkz0xAMG9YBa/svij0ukiwfn5aP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-fIUDjsIeOSS1SINItALObA-1; Mon, 25 Dec 2023 03:03:51 -0500
X-MC-Unique: fIUDjsIeOSS1SINItALObA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d17446f11so40517575e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 00:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703491431; x=1704096231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCwTTNNyqrMfZw/hNOREXjBR0xNOBHLOAENENPZLEbY=;
        b=AW8xq8zjbLpyhXm09YFYR9NCptJWEBcyXmuFuTWclO7y7IB5YQdqmwb9vt5DWnF/i2
         HFbfsU9s8FbULTRfhSk32OZcM+GEf6yUhBh52Os3GMsFT3nghE1SgupaW9DpoAXrc0yH
         7K+fiXwi2nE4SJ9IfkQMQBq6TzMuQDSxuCGuq4mIwMY1S4LaRD0lrLFhlDvYj3AOlEBz
         J92cJiq9Hr8/W2puFgozV1PAOnXNDerAGl2nUs2I4Dlkwaa8OOGpUdSi5al5OLGsf+lb
         Z4z6IGox7oG+8w4RTOgJ5/jSgGJjqdUEFuKTyy/BUIbMpU0LdkTxAzsYJ3zgV41L3yhx
         Wy6Q==
X-Gm-Message-State: AOJu0YwmqgCUuzIJhzpMT6m5rLXVIRraaT+56/K0RpxpfQdFZgW3tfxV
	0yJGwLMcFKzyMFUGxusR8D7TFZhAqiAx6dtmT3xCs4QpAxyRcY+Ep8d94cp3M0/TcUD5t9dzLAb
	xyaEZ8IQsFpc5wqxNl7RCEihgoyDw3dzKrM4Qrl9rDX1FVG5C5w==
X-Received: by 2002:a05:600c:524c:b0:408:434c:dae7 with SMTP id fc12-20020a05600c524c00b00408434cdae7mr2777987wmb.2.1703491430690;
        Mon, 25 Dec 2023 00:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZgyHSr0SfK4IlMsoMWoOO6taBhyRbYG9Be5tX7F8nmLfhtDinWZt84jKjwnyMxfcf5lIUjg==
X-Received: by 2002:a05:600c:524c:b0:408:434c:dae7 with SMTP id fc12-20020a05600c524c00b00408434cdae7mr2777976wmb.2.1703491430375;
        Mon, 25 Dec 2023 00:03:50 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id w18-20020adfee52000000b0033657376b62sm9789710wro.105.2023.12.25.00.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 00:03:49 -0800 (PST)
Date: Mon, 25 Dec 2023 03:03:46 -0500
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
Message-ID: <20231225025936-mutt-send-email-mst@kernel.org>
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <6582fe057cb9_1a34a429435@willemb.c.googlers.com.notmuch>
 <084142b9-7e0d-4eae-82d2-0736494953cd@linux.alibaba.com>
 <65845456cad2a_50168294ba@willemb.c.googlers.com.notmuch>
 <CACGkMEthxep1rvWvEmykeevLhOxiSTR1oog_PkYTRCaeavMGSA@mail.gmail.com>
 <20231222031024-mutt-send-email-mst@kernel.org>
 <CACGkMEsZDYFuvxgw63U5naLTYH5XNwMTMNvsoz439AWonFE4Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsZDYFuvxgw63U5naLTYH5XNwMTMNvsoz439AWonFE4Vg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 25, 2023 at 12:12:48PM +0800, Jason Wang wrote:
> On Fri, Dec 22, 2023 at 4:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 10:35:07AM +0800, Jason Wang wrote:
> > > On Thu, Dec 21, 2023 at 11:06 PM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Heng Qi wrote:
> > > > >
> > > > >
> > > > > 在 2023/12/20 下午10:45, Willem de Bruijn 写道:
> > > > > > Heng Qi wrote:
> > > > > >> virtio-net has two ways to switch napi_tx: one is through the
> > > > > >> module parameter, and the other is through coalescing parameter
> > > > > >> settings (provided that the nic status is down).
> > > > > >>
> > > > > >> Sometimes we face performance regression caused by napi_tx,
> > > > > >> then we need to switch napi_tx when debugging. However, the
> > > > > >> existing methods are a bit troublesome, such as needing to
> > > > > >> reload the driver or turn off the network card.
> > >
> > > Why is this troublesome? We don't need to turn off the card, it's just
> > > a toggling of the interface.
> > >
> > > This ends up with pretty simple code.
> > >
> > > > So try to make
> > > > > >> this update.
> > > > > >>
> > > > > >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > >> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > The commit does not explain why it is safe to do so.
> > > > >
> > > > > virtnet_napi_tx_disable ensures that already scheduled tx napi ends and
> > > > > no new tx napi will be scheduled.
> > > > >
> > > > > Afterwards, if the __netif_tx_lock_bh lock is held, the stack cannot
> > > > > send the packet.
> > > > >
> > > > > Then we can safely toggle the weight to indicate where to clear the buffers.
> > > > >
> > > > > >
> > > > > > The tx-napi weights are not really weights: it is a boolean whether
> > > > > > napi is used for transmit cleaning, or whether packets are cleaned
> > > > > > in ndo_start_xmit.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > There certainly are some subtle issues with regard to pausing/waking
> > > > > > queues when switching between modes.
> > > > >
> > > > > What are "subtle issues" and if there are any, we find them.
> > > >
> > > > A single runtime test is not sufficient to exercise all edge cases.
> > > >
> > > > Please don't leave it to reviewers to establish the correctness of a
> > > > patch.
> > >
> > > +1
> > >
> > > And instead of trying to do this, it would be much better to optimize
> > > the NAPI performance. Then we can drop the orphan mode.
> >
> > "To address your problem, optimize our code to the level which we
> > couldn't achieve in more than 10 years".
> 
> Last time QE didn't report any issue for TCP. For others, the code
> might just need some optimization if it really matters, it's just
> because nobody has worked on this part in the past years.

You think nobody worked on performance of virtio net because nobody
could bother? I think it's just micro optimized to a level where
progress is difficult.

> The ethtool trick is just for debugging purposes, I can hardly believe
> it is used by any management layer software.

It's UAPI - someone somewhere uses it, management layer or not.

-- 
MST

