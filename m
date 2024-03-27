Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B415CD69
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547491; cv=none; b=lJnvELc3ol39lzYiBoHmfmnjrakTPQR69NXQ2KHbUxcZQZgqFVqNzHyCjo+FZbQXxicRvattb6l1/remcawbuC4tUgg9VSI8bxa6GSJQ+6Z4VoiwJymiH3a71RUHYHwn7fKf0G26NAhchKnbUKIBCpEXBHgRgn5qBJwR7hFRJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547491; c=relaxed/simple;
	bh=LRh020dt3JvCw/r0YCn85ScWnAbwueBpSbcIgI27W8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz95Gv3/08iTmqvr99mY3+BsB5QVhoTiTsYQJ/W8Cbu4K05UXADwhMNzhs8UdQ7PpJOsM9LnykV1+a5pskDAr0yYHc3kHLLAHhuNlPbgwzrxJV8be/E5VxmWqAvYrqCLYQV/XXFCz/DpOu9El2WqQpZgue4QOfWHXDtrln8bYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56c12c73ed8so4088784a12.2
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 06:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711547488; x=1712152288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcKm7eRThoxP9DS6Fq9W4RWZhYw3k695B/yck6NlVFk=;
        b=soXMsuvAPTaJke0/FLtSg/zGBJLATP0jxTU6wV26+V7SwSzGjgxQBwXnhIgxI5APZ4
         i2WfuVBpPdX6oqucTiDBPQkLxu9bonQroNFNfP+robZyKkcbTDNoUArL+hFg+QiEBGAG
         ZiyVo7RpHkyL9QYEru+6bk348R0A5OGx7/c9939hYHgqr9k2y6xgC4T/0g8mkz/+ZWo+
         3H64Eq4TvxM+jEuFVGgRp8x+4ZRf8B4N/N2ON5+Z8QMbn/HOl7vZWKlMLMrzysD02/gn
         u+vYIHCkKrj2JBNZEQ1Pz9BlMI5yAYqc4NWtOpPkCiSV3Lgidj9W+GSfNU8SaxZPrw6Y
         /EqA==
X-Forwarded-Encrypted: i=1; AJvYcCWXwrwsRoc95moGJJpaNj/hmvw4KkQ9r/+kGsduMEoy1KLzbt7QJMHySfHHtG9trb5mdeDR9i48qOF+C65hrTOXFCFxTBvSXCSp1rSmNNM=
X-Gm-Message-State: AOJu0YwD1c8Oy845ryl2cgA2E/4NaQs26/1jrY5ld9RmDYR8Sed/49by
	rttS89qdeO8SjCr+WKujQqGR9ROOQB9IOSqYg3NnrUbQdU+LDbOc7q7iwrSQ
X-Google-Smtp-Source: AGHT+IFhjYnrjdbXw7KmaYA4ypD1xuTa8d1VPV3peiZKf+9ZHYiqQFI4Rd7Plj+NeUPbD/snQmEOZA==
X-Received: by 2002:a17:906:8415:b0:a46:22a3:479f with SMTP id n21-20020a170906841500b00a4622a3479fmr1138312ejx.21.1711547488000;
        Wed, 27 Mar 2024 06:51:28 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id wr12-20020a170907700c00b00a474c3c2f9dsm4597296ejb.38.2024.03.27.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:51:27 -0700 (PDT)
Date: Wed, 27 Mar 2024 06:51:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: rbc@meta.com, riel@surriel.com,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, hengqi@linux.alibaba.com,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 1/2] virtio_net: Do not set rss_indir if RSS is
 not supported
Message-ID: <ZgQkXfMd6GIEndXm@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <1711503463.632461-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711503463.632461-1-xuanzhuo@linux.alibaba.com>

Hello Xuan,

On Wed, Mar 27, 2024 at 09:37:43AM +0800, Xuan Zhuo wrote:
> On Tue, 26 Mar 2024 08:19:08 -0700, Breno Leitao <leitao@debian.org> wrote:
> > Do not set virtnet_info->rss_indir_table_size if RSS is not available
> > for the device.
> >
> > Currently, rss_indir_table_size is set if either has_rss or
> > has_rss_hash_report is available, but, it should only be set if has_rss
> > is set.
> >
> > On the virtnet_set_rxfh(), return an invalid command if the request has
> > indirection table set, but virtnet does not support RSS.
> >
> > Suggested-by: Heng Qi <hengqi@linux.alibaba.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/virtio_net.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c22d1118a133..c640fdf28fc5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3813,6 +3813,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >  	    rxfh->hfunc != ETH_RSS_HASH_TOP)
> >  		return -EOPNOTSUPP;
> >
> > +	if (rxfh->indir && !vi->has_rss)
> > +		return -EINVAL;
> > +
> >  	if (rxfh->indir) {
> 
> Put !vi->has_rss here?

I am not sure I understand the suggestion. Where do you suggest we have
!vi->has_rss?

If we got this far, we either have:

a) rxfh->indir set and vi->has_rss is also set
b) rxfh->indir not set. (vi->has_rss could be set or not).

Thanks for the review,
Breno
