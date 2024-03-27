Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7913E413
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547078; cv=none; b=eVhRlM/2bNZxdh1+syZfF813mnWsN5FTjsCvpDFnuR+qsilEodYSP8d3exNQAMix4mkDTssgrW/SjzYAnSb7Hl/Z00QHzKkTcaHfPnfWdrOOlYOVZ2qSfUUBKfZYdX07bm9CD3vnb6BylfzLkHQ8D76g4KrRLvZlcnbQ+4coW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547078; c=relaxed/simple;
	bh=2xZT353bg+Gd2k0hEm0r6uRcXB+j37Lc80ZKxrL2FNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M28GYBziTQye7HLZ5PjSZQTp4LVgpkFtydwFj+lxzo4BB0uytmNjjQBdm33Sn/2BE45VaXg8vJYCIli1MooYAuxcTVepzlohLJ3c052EO8S/rWgmgdf9OufaUShEwOK28tVf5sYX0D2s+9en/OozX4fZUyhcDBazdlTgLxa/gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso863649766b.2
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 06:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711547075; x=1712151875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLz16fmiK7clzNfffXEiofOH4lXEAbKlwPA6/CgGe8Y=;
        b=S/c0aw4JP3nxXOJDkyLjgGycgd4GsU/mqS8qPTLTmkK9bJ/kifChcvxuTF/Vibxf6e
         86ZEhEF1eREGFgkvGNxKcnFfRdSK9SLjMHW8ex4m6AdnwBMhopkZFN/5mk8StHtJmfsy
         R7Zz1LfjKfvqHIkevaTBMcl+nk/h7duk01+D9lbqGM11J4fXuAJDIoTZiHWtQWhTGE3L
         taa2pAeRXF0bIMeRSy6cjOsGOeC4tDAa7rl4/4q/7tma6x8oJE9CmsIR3t+yMNH3IxEO
         Ci6mPBkxiV0tHypCeNc+5XnUOEQUY+yOLCi//TqPK5/qQzPk5EXAqtFTpeOZNSvtAJqG
         8Dig==
X-Forwarded-Encrypted: i=1; AJvYcCV3vPl7dg3r3ZC+GndoImh8uv0IAqOYSF4qxdTg7IWWq3zzTBNr6XlnYl29C4rT0jhJxAW1RYfHcGrIwHMxUfKY/hIamgiI5Oty94JnqVc=
X-Gm-Message-State: AOJu0YyHtRApnBS6gtBs3/HlNFrkdd1kuv1wdcks6SM9borcOyv1r7fK
	6R9yibIFeh5wayG1z25zkTtnVUXxWTIkqvjgLCuHPg0azAaDjO1I
X-Google-Smtp-Source: AGHT+IHlsqprzpnxJBYeJapDRINLx/aNTv+m24jMPvBz9QGVUn18hEMdVfXDoR7rOZNE4m03xIbPbA==
X-Received: by 2002:a17:906:e08a:b0:a4d:fae7:ece3 with SMTP id gh10-20020a170906e08a00b00a4dfae7ece3mr2030643ejb.5.1711547074857;
        Wed, 27 Mar 2024 06:44:34 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906670b00b00a44b90abb1dsm5439004ejp.110.2024.03.27.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:44:34 -0700 (PDT)
Date: Wed, 27 Mar 2024 06:44:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: xuanzhuo@linux.alibaba.com, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Melnychenko <andrew@daynix.com>, rbc@meta.com,
	riel@surriel.com, stable@vger.kernel.org, qemu-devel@nongnu.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <ZgQivw8YG7XT2boy@gmail.com>
References: <20240326151911.2155689-1-leitao@debian.org>
 <20240326151911.2155689-2-leitao@debian.org>
 <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc5a835b-94c8-4500-b05b-0dd32afddbe8@linux.alibaba.com>

On Wed, Mar 27, 2024 at 10:27:58AM +0800, Heng Qi wrote:
> 
> 
> 在 2024/3/26 下午11:19, Breno Leitao 写道:
> > There is a bug when setting the RSS options in virtio_net that can break
> > the whole machine, getting the kernel into an infinite loop.
> > 
> > Running the following command in any QEMU virtual machine with virtionet
> > will reproduce this problem:
> > 
> >      # ethtool -X eth0  hfunc toeplitz
> > 
> > This is how the problem happens:
> > 
> > 1) ethtool_set_rxfh() calls virtnet_set_rxfh()
> > 
> > 2) virtnet_set_rxfh() calls virtnet_commit_rss_command()
> > 
> > 3) virtnet_commit_rss_command() populates 4 entries for the rss
> > scatter-gather
> > 
> > 4) Since the command above does not have a key, then the last
> > scatter-gatter entry will be zeroed, since rss_key_size == 0.
> > sg_buf_size = vi->rss_key_size;
> > 
> > 5) This buffer is passed to qemu, but qemu is not happy with a buffer
> > with zero length, and do the following in virtqueue_map_desc() (QEMU
> > function):
> > 
> >    if (!sz) {
> >        virtio_error(vdev, "virtio: zero sized buffers are not allowed");
> > 
> > 6) virtio_error() (also QEMU function) set the device as broken
> > 
> >      vdev->broken = true;
> > 
> > 7) Qemu bails out, and do not repond this crazy kernel.
> > 
> > 8) The kernel is waiting for the response to come back (function
> > virtnet_send_command())
> > 
> > 9) The kernel is waiting doing the following :
> > 
> >        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > 	     !virtqueue_is_broken(vi->cvq))
> > 	      cpu_relax();
> > 
> > 10) None of the following functions above is true, thus, the kernel
> > loops here forever. Keeping in mind that virtqueue_is_broken() does
> > not look at the qemu `vdev->broken`, so, it never realizes that the
> > vitio is broken at QEMU side.
> > 
> > Fix it by not sending RSS commands if the feature is not available in
> > the device.
> > 
> > Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
> > Cc: stable@vger.kernel.org
> > Cc: qemu-devel@nongnu.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/net/virtio_net.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index c640fdf28fc5..e6b0eaf08ac2 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3809,6 +3809,9 @@ static int virtnet_set_rxfh(struct net_device *dev,
> >   	struct virtnet_info *vi = netdev_priv(dev);
> >   	int i;
> > +	if (!vi->has_rss && !vi->has_rss_hash_report)
> > +		return -EOPNOTSUPP;
> > +
> 
> Why not make the second patch as the first, this seems to work better.

Sure, that works for me. Let me update it in v2.
