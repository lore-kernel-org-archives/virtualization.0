Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130190;
	b=K+9r46d63Z5NdTKDISOZ3rX+s7M0Ktd6kWSPhckl5TOtNRYxXufIpEVXamDJH/WuipRC
	 hPdBJTDI58F9dqc/UEGtqsuUMkEDL8/SSiA4srTzk8Bv0mlZfFvR1y29MMvYKbauyurZW
	 R2MaK4nyOzHr/8yxSGsSyoojtjJz0UDC7eb1aB1Mmq9mTS/pZqT2vwjBdNnPxgyjJwRUx
	 oWr5/j4aSyplWAE6l1KKjpQfQoAmkwgqT35PaY8OedTrGc9S+seD8oZh8bnT/F/BAZ417
	 XwyIPS0oHqWn60ZzBPTH/18ubhIm5eT8M03+EdumITxbXBDmHS0GIIkkZoYgfl8Q09g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130190;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=oVWM2kH+4GlaP5AbRPjeostHeKcF0t7gkregb35fNl8=;
	b=aBFylJgx9qyPw4WP1z0G5lcA4x9ZuLFQO3Kqb1DdK1+pwkrv5ffpWi7N7HczQ/3hrLa2
	 SZp+9Ghlp/elGXZ3I4ixkvt5g7teBhDafTnVyW7WLKNbigEMDYQM3YvSSmD98OVKvckJk
	 Ip2l44B2ffjJqu6tUxg+4Mt4V5Vlmva9EmQalOiaNC4VNNS/n0M3RujA9tMhIVYH6XiMN
	 YNYTSDyX3pkMy+LNLZt3CKkbMqBj1kfwwM9jnSZeIK51onEVkfIzG1R0fmh0wJdp6FjX+
	 w5pkX7mJRQW/cZ1RbSzN0/9ypqdemAd3/HtskTWW+1LMKh1qRm6JKZDzKHbLbHGZJBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3gJ5aeP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCF606A32A
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 23:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFCF606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3gJ5aeP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795130189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVWM2kH+4GlaP5AbRPjeostHeKcF0t7gkregb35fNl8=;
	b=h3gJ5aeP/aeI4iuqjF6XHtz9no2cBYrAIOVCt612oKFGwOXaVwdU1Ueo6poaCgR4ONPnIU
	W8ElkSsmyOzc5YbVjlk/oHzBlq1y4zizEdaLjN47Sv1VpdMi6x349Oj387yEXffr2ztVTC
	KRlmsxYJRcIN8bF+UosnQfZLbKlAL2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-vV6s0NcUODe-2nklPLcFBw-1; Thu, 19 Nov 2026 23:16:27 +0000
X-MC-Unique: vV6s0NcUODe-2nklPLcFBw-1
X-Mimecast-MFC-AGG-ID: vV6s0NcUODe-2nklPLcFBw_1795130186
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso973885e9.0
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795130186; x=1795734986;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVWM2kH+4GlaP5AbRPjeostHeKcF0t7gkregb35fNl8=;
        b=0bU6DIFiJKQy6lrYrUzjh5eUkH13yHKUn6v1aMxQNgb+uIDcDe66fdgeSsVtqP+m4T
         tTU88seM7fcrp4nruMe9nIZPE614+m5n/P3x+xfPbtly7EahU2KhuD3tAUF4H6BdvleL
         Vu+e43tiG5nEFpvPYIln8+Vs9h9T6vrQAZK+/bfgocrtCQiqyU0hqBrGptQLsijFnJO+
         1Kfk5E6KUcZvxfqQ8MKVjB99euhau7gyokK1hUN3ZW5r09Eqwi0Uqazco/p7vy/1xXi9
         P8Cc0Mm0Yl8wfBOj2cnQFrKETIQu7HAaWTnxwTQAhctflD1xvxxWDEsPgnqWywNwYXo3
         FYkg==
X-Forwarded-Encrypted: i=1; AL+hErFFjvZe47mFFDA+Q84DdmefeLlDygLYDreA2QnWvhzKP2orNYq1LO2RsoWIuChCRANV/TPnqyqO4Ih9TQ/68A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8r9nTiS5Itrccgf8cs6HG+/sJxSy27WmG84mBSSmdaAF3tfnze
	NdivE6L2VHj84wVge4qVVwqvS335nn4cYAmo+VdQCz397uqsV28dng1xGfMqiLuNKvI8Tm+atD5
	8z+cOQmA3NfAG1kNxvdIx6VYbbju6TDfdfgn6rKq3GhPnrJgyr/PC7vEiNc9XffyktTfq
X-Gm-Gg: AYBFou30/ae/pat+XnrfgaLa7XUXcBBL0LMPE4k+SZPslu3Ee/BZdbVOzDwNbJVNiGK
	dDcItPQ38EdMSvOAJvAA99NdcLiXZHIE/aVHet9QGDhAPzZV/EIeycbg9vhU6FmLWBWpDPBfozO
	6NVLLCpX+FIPu45wLgoN6+mr/dmVRsJtXM6KU1RIa8GN4ennDUVb7HUVviadbRUm4LGh0cskSd1
	RG6nrz5ow4hBcV0hto5zE48NYkAqTBQyfL9VvTcIx4OvXrhkXMBKkiNC2ZKMFU/MuxN9/AyPXfY
	1JwcSES8wGLG6vXUwTHtexwAQ8f6XMvJ/vYYpRKLfZ5Tcj/c6Nf/4xsXUXVNy2k+8RMTG+GbGgp
	65vukc64L/RIrMo4zbPxuI/lZlfT5tAws3tHpvu8n3g==
X-Received: by 2002:a05:600c:3b91:b0:4bb:7e4e:de53 with SMTP id 5b1f17b1804b1-4bb8881059bmr26235875e9.12.1795130185904;
        Thu, 19 Nov 2026 15:16:25 -0800 (PST)
X-Received: by 2002:a05:600c:3b91:b0:4bb:7e4e:de53 with SMTP id 5b1f17b1804b1-4bb8881059bmr26235155e9.12.1795130185256;
        Thu, 19 Nov 2026 15:16:25 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm44769145e9.14.2026.11.19.15.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:16:24 -0800 (PST)
Date: Thu, 19 Nov 2026 18:16:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Kyle McMartin <jkkm@meta.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit
 DMA
Message-ID: <20261119181557-mutt-send-email-mst@kernel.org>
References: <20261109184253.531677-1-vlad.wing@gmail.com>
 <20261119200654.1048266-1-vlad.wing@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261119200654.1048266-1-vlad.wing@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IqeejZhHQzFoZFUb5RP5IDRNQRLxpHnMhA1PMyFiK90_1795130186
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2026 at 12:06:54PM -0800, Vlad Poenaru wrote:
> Hi Michael, Jason,
> 
> Gentle ping on this one. Without it, the virtio-net function of the
> DSC2-200 in OCI bare-metal hosts stops completing TX once the IOMMU
> hands it IOVAs above 2^48. With iommu.forcedac=1, virtio_net hangs
> in probe instead.
> 
> The patch still applies cleanly to current mainline (v7.4-rc3). If you
> would rather have the quirk cover every virtio function under
> subsystem 108e:1200 instead of only virtio-net, I can respin it that
> way.
> 
> Thanks,
> Vlad

it's in my tree.

