Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640666;
	b=i6NfYU0SzoATIB0eLfckap26HZHSrV2M5+QID9WfL5S6u40hLSEI7T614vZkp4phE+Fk
	 r9bHm94yLNdX/m/3c8olrGWL1DmorJseLcr9tqtuWqp66i+/Ec78aVQhUCwkdADUm3Elx
	 KbAy52xMYA5xntGVGr0xtxC6pu0Ad9AZLvjmFRnl87/EegT5VDWZigsLXUEyKXLGXYGek
	 rXQHV/cmLh5U89YZaXHW1IQqY2NKx2mTHJIdzNlO+jwHfDvxrpLTaYdSWD6eEAaWs/pb+
	 tH5fFkg5mRXQmEm7r9yl8rfCnSQxp3AobFe5H6cL1brWfsbQGYDTdz09sdnGhpHvgag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640666;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
	b=LyA80MLQ7cZFn26mGWZch/yEGHFGz3WfYy1LtSuCzodZ26pSOex8FnJ3B1veh2rcuufj
	 14esoKeZorZYWRdce0g1UiT3vWZ8PBDAx+qFWtm7Ln4mEaHy/YNJ8NQ91mX/X7Qrxi4TH
	 XRmjrdASk0iFKS/l/wiQTqCmrOxSf4FkBEVw0zcRMS3cKl1OhXTTx6PsnB3YDYRqWyhNy
	 3RT80BPF9ZoEKdhgPUdXaCqkFf/OC8aeAuwPR4uB0+ZrPXL4ii4yGp7YfUjwbn0KeNORh
	 oR2uJ2OHs+D4aWuRghs23jBv+FCUg5mhoea1JxGNhh9W8713Xw1IeW8jj4BjTcmYDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WO/weqq/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B3606EE8E
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8B3606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WO/weqq/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793640664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
	b=WO/weqq/mBliiL5yMRKjE/qPlDM3IwxJfG5ikevaMuZ7pnw6yd6/1+jmTIh4GuunYICdEp
	8Eple4CV1QLH5zp1UeweuSzs5djw0Mt2uJjyWXcxt/kb/xD1gmLhtjMxM/N7wl0zKMaRtk
	q0IoPsf9XfbiqXfQKSJQCYlk6jDthRM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-NN9w31nWMi6P2ki4JrzUEA-1; Mon, 02 Nov 2026 12:31:03 -0500
X-MC-Unique: NN9w31nWMi6P2ki4JrzUEA-1
X-Mimecast-MFC-AGG-ID: NN9w31nWMi6P2ki4JrzUEA_1793640662
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso28795595e9.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 09:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640662; x=1794245462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RMGM2tdquFW2b2zOYAB2Tk8dbjfkSZIp3K0bLlHl7I=;
        b=bbtEWuFNzruZjXuwAlG888/cT/+wNPF9a4ieOx/pRxtG8/sGrLaJrKWiOQcBd1OdsI
         7EnzbjqxhwgSz0kwz404pU9Z2tsVvK0EhEvSXN2ZKrc7+M4rMI28O5yCV3O7Vy1LyxGA
         nUUHMVM/PPebM+TVoNkpG0GeAWcO8PAQRjG3/tKewaOQoENjfgPGJEtt5NPN7ai5wJty
         Any1XrGbcmE5tna+MtKsNxanSwbx6TwQ7MWwEV3HzR/vf042DdhekBHC5HAphVrgBKu1
         SlLcfLK7PdrRYqS6I3idZjUGmJlpHzNBftxGGTRp0ae1vXdvhNuRPI8S9EdyhwleMrhX
         6zsg==
X-Forwarded-Encrypted: i=1; AKwUvBwvAlUsiBm6PR3W3r690dAx0ppPicwj/iIpuz8hZXeayWDjmXrTqihsqn0AArJSzdAgMMYTsrnqhG8aoGXu/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIfyMC7lqBy1BAnMkZ45AMZ9Ndn7OVEjFwFcXFbjrwwX96UM4Zi
	+Uyy6iz7X4bEqZIP45HK9hYj6EKjduAAUzrE0tNJ9a6u/5zvD+FGO8SJrFtLeN8S6aeEs4PnaUp
	iHtbKhT/tsPhBdzNpkjy/Nu5IFidXCvpdsVS/6KAICx/7cw7jcN+MkcXjybwtWcyJtoBj
X-Gm-Gg: AYBFou2ft5Bq86LVhtT8SC9EWPCmgseXvdJ0U25ZUoOwSbEqBSTy7MdPsdVZbY7i5Ha
	KlYnFjJGOdtX3hDPuaESog9Q2/URF8Cjbh0kaXClSd4MGZwrSVZAqSBAX8+h3m69NMCf/NqUfA9
	tpMmV+u/H0NFEpp9SifRiYouhyJIx6AxzjRy1dZifCoP/7DnG6DTL0VU0FycPKM/kMmna8/TG/6
	Ay1ZzXELMofH/eUykHFJRqxm9sAJNoW74luPYUHIT07Du0qms9DBlE/eftPSA+tVRF/AJF0dLlw
	TRhg6E4N1v5UVjnr0LH/3zQwbxlXYW1El/WmKdAa7+/t5Lmd9cYkrp304g3M2IwPIPHJH95VkYh
	GvSIhEy2Uf9OgY93RupSWSROMZWULNTTkKsCpFjmbuw==
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4ac1709ae70mr245615645e9.15.1793640662120;
        Mon, 02 Nov 2026 09:31:02 -0800 (PST)
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4ac1709ae70mr245615175e9.15.1793640661652;
        Mon, 02 Nov 2026 09:31:01 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa953d35sm1240835e9.9.2026.11.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:31:00 -0800 (PST)
Date: Mon, 2 Nov 2026 12:30:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lianjie Wang <karin0.zst@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Message-ID: <20261102123049-mutt-send-email-mst@kernel.org>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
 <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
 <auCkXHi6IulXgm7v@wang0.localdomain>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <auCkXHi6IulXgm7v@wang0.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YOV5W6iYnM-xnsaO3itkA3OJfoc9CFRZN0-LtARSVfU_1793640662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 10:53:16PM +0900, Lianjie Wang wrote:
> On Tue, Oct 27, 2026 at 01:06:41PM +0100, Paolo Abeni wrote:
> > On 10/22/26 20:26, Lianjie Wang wrote:
> > > [...]
> > > @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> > >   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> > >   		hdr = p;
> > >   		qid = le16_to_cpu(hdr->vq_index);
> > > +		if ((qid < first_vq || qid > last_vq) &&
> > > +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> > > +			return -EINVAL;
> >
> > I think the above check could be simplified to:
> > 		if (qid < first_vq || qid > last_vq)
> > 			return -EINVAL;
> >
> > squashing the following in virtnet_get_hw_stats():
> >
> > -       if (enable_cvq)
> > +       if (enable_cvq) {
> >                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
> > +               last_vq++;
> > +       }
> >
> > (likely with some meaningful comment).
> 
> Thanks for the review!
> 
> I looked into this, and I think last_vq + 1 matches the control vq
> only when all queue pairs are in use. The control vq index is
> max_queue_pairs * 2, while last_vq is curr_queue_pairs * 2 - 1 for
> ethtool -S. After ethtool -L lowers the queue count, or when probe caps
> curr_queue_pairs at num_online_cpus(), last_vq + 1 is the receive vq at
> index curr_queue_pairs * 2, which is not in the request. The simplified
> check would accept a record for it. Since the ethtool -S array has
> slots for only curr_queue_pairs queue pairs, with the transmit slots at
> its end, virtnet_fill_stats() would write the counters of that record
> into the transmit slots, and can write past the end of the array.
> 
> Would you like me to keep the current check or change it in some
> other way?
> 
> As for the comment, I would add the following above the check in v2:
> 
> 		/* The control vq comes after all max_queue_pairs pairs, so it
> 		 * exceeds last_vq + 1 when fewer pairs are in use.
> 		 */

didn't get v2 yet.

> 
> Thanks,
> Lianjie Wang

