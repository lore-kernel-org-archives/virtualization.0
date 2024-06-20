Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8E5579F
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872348; cv=none; b=YKSscFNf0kj2mqrD6q39mmM2j+kItUJHaljT/9kzWF5df4qpWkZ4y/Fn8dXI6dtPl35U+s7a0rcnUUvfPCshrFHJFu5Jg/h9NB0oHztdv13TRz22JqR/dFf3sNsugsQ60WJNpbCOnqROVHwZAv6feDkmkd9BhUz8SYzMAlTZcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872348; c=relaxed/simple;
	bh=GQNRhUjmNKYB0xE7ASaE6oaKaYPy3J1MSACbDVFZWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cksicKa/E7rJnAbJrs53GQ8aQ1QMStNtYYuX4fqFVvTSOFpHZJ0m2+f3CKhKzHnP1gPcC53RF1BDSUwqipYMwBBw3OI2ctKNddyL8uEgu9iT/KZNW+BsLWHO8zPDhQAE3fT6H0nZayxd0tUHfnvGy70yyKbz3rG8zOpZbnNYTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xtxo184g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xtxo184g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDDbMoWZfx/vXxAx/4Eg+jzcGaLWU8gh+nxmgU1GRuc=;
	b=Xtxo184g5HqCxPURx4YB6LUufrgmkPtVqfmlCYpIWxoEkapW+q92gyX4CikrONI+7b7pXy
	V9z+kSGG5KAZ0Liarv4P3Fh0anlN0p5RqNXugamLKxaK2bE2vJOn0+oYhbeY+qCUdzkA9x
	LiJwJOJbyLxPdcMA1JezlAjlIENK2O0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-nNgfTmu_NEKlvdOb5183dg-1; Thu, 20 Jun 2024 04:32:23 -0400
X-MC-Unique: nNgfTmu_NEKlvdOb5183dg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6efe58a1aeso25980266b.0
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872343; x=1719477143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDDbMoWZfx/vXxAx/4Eg+jzcGaLWU8gh+nxmgU1GRuc=;
        b=IUwsumWS/lE8Oqs4S2VJ6CsYfFEXYNreIlmy3K/i7vboxfnC3UNiNPZlxbVzl/RXk1
         /O8k07TYVE87iEAS8yAdt1V6p1ko3+XAlGLeZbpLFgw7Gouzh/TIqoTZvdK+c/uWJtNY
         Rg1sO37GRu4reEa6l7RcwbUa9SloEwHBnTsgilyJLVbWY8Qt1u2E9j5K1jkNPQW7F6uY
         12WX9xqyVR9eMzsDZZyUDoAbEsN1MIaUDRgR2R6utec5Cukz8AkBKwqnf2Ku4XDFgOa/
         HrDj9c3xmo3oZCvmfO2OXqa9EpNGwyiNo/WgAHLOrC8gkjlUlrWY3B8YTJVwDvOfukiM
         E42Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOOgsJ8/XzgR5n/JdZ+OMdc2ny+8Kl86Wv9QlFcnwbbJ8KYviW0f+3XrvB1dRCBMxE01nS0bjhqRnUrRk5hTIUpHrPoeFFS7vYqsCd0c8=
X-Gm-Message-State: AOJu0YwDFC9N6z1j6h8il6Wf8xyWD7h6jNSKkp6BJP8Lti/MGj1h9Jxv
	dvTq1KWyE+FL8EyFTHYG8R82Q3neeIOPsBOcDBuMmBwoUE6r4pRRUJVsxngEK2KaGhCdL8wo5do
	lsnTORfKcUHjOoXabGLLb3teGHLT6WzUVEvgMtn0CllICEOsbHJy52hRLG3dPOGQj
X-Received: by 2002:a17:906:2602:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a6fab648b9emr212075666b.40.1718872342624;
        Thu, 20 Jun 2024 01:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmi3doNwpOomaLDgEbZMUZ3ch8SbQR86SfC/uSFp3Z5frtzLHKiBLh4szJKHSYEPJKzsZ6Pw==
X-Received: by 2002:a17:906:2602:b0:a6f:4de6:79f with SMTP id a640c23a62f3a-a6fab648b9emr212073866b.40.1718872342152;
        Thu, 20 Jun 2024 01:32:22 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f988cdsm739390966b.193.2024.06.20.01.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:32:21 -0700 (PDT)
Date: Thu, 20 Jun 2024 04:32:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240620034602-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1718868555.2701075-5-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 03:29:15PM +0800, Heng Qi wrote:
> On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  
> > >  	/* Parameters for control virtqueue, if any */
> > >  	if (vi->has_cvq) {
> > > -		callbacks[total_vqs - 1] = NULL;
> > > +		callbacks[total_vqs - 1] = virtnet_cvq_done;
> > >  		names[total_vqs - 1] = "control";
> > >  	}
> > >  
> > 
> > If the # of MSIX vectors is exactly for data path VQs,
> > this will cause irq sharing between VQs which will degrade
> > performance significantly.
> > 
> > So no, you can not just do it unconditionally.
> > 
> > The correct fix probably requires virtio core/API extensions.
> 
> If the introduction of cvq irq causes interrupts to become shared, then
> ctrlq need to fall back to polling mode and keep the status quo.
> 
> Thanks.

I don't see that in the code.

I guess we'll need more info in find vqs about what can and what can't share irqs?
Sharing between ctrl vq and config irq can also be an option.




> > 
> > -- 
> > MST
> > 

