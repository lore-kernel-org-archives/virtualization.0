Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C722414400
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143650; cv=none; b=sncnIW2zFjNc0BACViQdHNqhvYqEWCOkR4IaIvm03QNeq/JiUmdH3u7UqQCEUvePB9y78MmfWTBKEXDBl0o/zXdtc5CzhdIApYl4i0nU9eSc8lZ8cayu7MlXRVCU1ZR2Xau26w7KYjb7gEc/gKBVI/Vtqx26z4lWRJ4ElwHarf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143650; c=relaxed/simple;
	bh=IKOHADwHNZP3jA6qSOzuBaSk53iOphiCQ+dLK5PVi2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q7XlCGe+H+5l4P/Q/nrm7hCR8MmFV4hG1f7UIACc/3B1DWKQhBm/hScmV+kjfi/dfMD6JDFVEMgT3NjVDM7vc0csCt9OdOVTnKj5aM4zwmDqXyIgfRK5+jc+WCnVeamvynyyPMHS9t4Mi4cdAF/BivT5ThAAQdzfeqc0LUTb04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMWDoqlV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMWDoqlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
	b=RMWDoqlV0SOi1tKj/QmMq9myPHMwHLPy5+qXo6slKMKbtNN34y83x+sEXXeHZ7AfeBKNbV
	Rxf8yRWDZ3QjLk8o2yHfdLivoQvVVwWaYs67NKqPac9dME/Po7Kk9S+OzpxWLZ8ByYvxEJ
	VNcvnEGOhAitDOVvW3M2axbEmXC8VjM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-mzVg6ngiOyOUpwij6xwpxA-1; Fri, 16 Oct 2026 09:40:44 +0000
X-MC-Unique: mzVg6ngiOyOUpwij6xwpxA-1
X-Mimecast-MFC-AGG-ID: mzVg6ngiOyOUpwij6xwpxA_1792143643
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dee35b50aso2177711f8f.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143643; x=1792748443;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvLeihu7ioIdym0eRq5JcGIMM6YkZ/1Kjyy9X0VEuuI=;
        b=NVa1EyTbXMiLvGlOZ2z8IRuCaj85UNkqyPyLFCFeo0Ds9lzsVfr7OgnuVL+OPu3fNK
         MsXwGfw9YkvJnijJjtsJwK0oOF8dfqtsYdXm8kVriT++8VIBtESPE1xLj8CfqOd8OMD+
         4nA0HvWuAD4UGkaDYQnRgIJzzjrE9tFtNik5bOMEnKMrL8wggpsNDejcpnJJNKrnhQfk
         plhY8x7OcIBhYPwnULLL/m08z7alTiKKlNSTN5VUGze5TScdCa7hgqQj+RgxkC8zwATX
         /lsCVB8WHqLSmbzJpUZjdbKdv85qV5nWsrECRzXrGjNpyMra7lkqA2Dm31xNQ4oO9GvW
         l/HA==
X-Forwarded-Encrypted: i=1; AKwUvByGHRBJmy4popuxClnLMrpAPAGADMv0yixM/Q8cAtBUh3j+WNBi7aUVXSKIB3FXMwuessqKdgTnO1rTGnoRhw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJUAciVCMF3CFJVtBwHRhUm9dc/OoXtYfn3vmAqhgrl72ECZVOl
	FgtrxcQfKNgJqMnSFJxf/NNeY2rc0YlN6TbhmQ3byWLbSKeO3EKSQQHxcZ4tzf9EWGLiON90NtV
	0LvXcrrPvA459iaVyv8ro/XmIKKcUZTeH6CBMfI9I/4GrQqiu+NNAxm13O0ly4ejO4jA5
X-Gm-Gg: AYBFou3tIrIwFLRWhQdTR8CSOR08aCenDouZOyeOFzkPtdpi82IicpNveE/ZwNDixjo
	QhS3fgoFCK8JmF/t4ajH5HAbV03KJYM7VM6Yu6MDr9HYU5K9SZTT+A+0LjCtmflmlyyptybS6V6
	EdfqvSnrMdcJZfPWzxJ6HnKzujgiUbsmlzQHXZlcwj+5YXlA5w3Q1ezPPSf38NaBqLBIbBpNilW
	I31fdgEtCn7g1ezozDV+OYahij59CwQtepuqEd9la3HFs27/mtJKzyn5wjiQ3mSfdJRAmithAM0
	ZkKglAfBGB+z0kL3zEsp3uHAhIIC1LA/7zZ8VK0SBkNUtcPSpaf63tbCzRBBqEYviyMOqA==
X-Received: by 2002:a05:6000:2212:b0:488:84ba:ae2e with SMTP id ffacd0b85a97d-48dba6f54ccmr42368075f8f.0.1792143643388;
        Fri, 16 Oct 2026 02:40:43 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:488:84ba:ae2e with SMTP id ffacd0b85a97d-48dba6f54ccmr42368022f8f.0.1792143642782;
        Fri, 16 Oct 2026 02:40:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm4255797f8f.6.2026.10.16.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:40:42 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH net-next v2 2/7] um: vector: honor virtio net hdr
 conversion failures
Message-ID: <20261016053930-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <6716834884238de0ab1ab313004044122aa2adbf.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.10294d16149b7@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.10294d16149b7@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ebft12NlWm1Gi524fMQvkm95pryR6LjMJ2seZ9Pua3g_1792143643
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 01:19:22PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > virtio_net_hdr_to_skb() refuses packets whose checksum metadata
> > it cannot make sense of, but the vector raw transport ignored
> > its return value: rejected packets went on into the stack with
> > their metadata unvalidated.
> > 
> > Propagate the failure.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/um/drivers/vector_transports.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> > index e1fb2a76fdff..8b7548458663 100644
> > --- a/arch/um/drivers/vector_transports.c
> > +++ b/arch/um/drivers/vector_transports.c
> > @@ -210,7 +210,9 @@ static int raw_verify_header(
> >  		return 1;
> >  
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> > +	if (virtio_net_hdr_to_skb(skb, vheader,
> > +			virtio_legacy_is_little_endian()) < 0)
> > +		return -1;
> 
> Should this return 1, like the above?
> 
> Not sure whether the verify_header return value is well defined beyond
> just boolean.

                                header_check = vp->verify_header(
                                        vp->header_rxbuffer, skb, vp);

                              if (header_check < 0) {
                                        dev_kfree_skb_irq(skb);
                                        vp->dev->stats.rx_dropped++;
                                        vp->estats.rx_encaps_errors++;
                                        return 0;
                                }
                                if (header_check > 0) {
                                        vp->estats.rx_csum_offload_good++;
                                        skb->ip_summed = CHECKSUM_UNNECESSARY;
                                }


apparently? maybe i misunderstand.

-- 
MST

