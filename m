Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBA1EA85
	for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725790; cv=none; b=PG3KR3r/ksAlC41E3Qak2BBOq54lnZWEnQZTFQsJyye7HunwaT71rk4LMgDn3RhwGGxYtI4qi7792ahsDAgcD6zE05h5BJQCZ8ixww5kRZJ9pRQb+zOOzb2GAubWJJgwTko1nuIMegNVl/mJdp6NLvkzA+YDg3u+QS3IQseJeOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725790; c=relaxed/simple;
	bh=qd4JfM9C7XhNkDZ9MKhcRdWS74czpvCBniJo+nnNLbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F1HjoiRUJmWeSO2anyN4HAaJhUw7kvHSEtYNjoZ3l2PokM2j+MJ8PvpxPqJh3zttuWdujvRn/ws7JtOBVQ14Ea89GMrnW4f4MwjjqZlrnY9/2CltOFISoQznW8Da85UwL/1G6elBzsZ9Q5WH6mnhP20iIXRnD0w9ZIic4Bp1qAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxqjWXdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxqjWXdj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720725787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qHMyJXBeRkRSNluth1L1mz9hL7fSL3Kwm56sBWnC+jg=;
	b=BxqjWXdjwZOFsSrrvBoM8LHeJQfp8nTxqaGxv3cR2jJZHbuNLuSncq8Mm0JAffOY1Sp8H1
	bfqgH0RzsTz1jtBf5pFrNjghhbrpSREoPGoDW92otwe4iMoWiWNLR0oQnlJ/582y8sGFht
	7mzwUTL9A0wVaaQ4urnqYjvKoW22jlU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-t3PVDG69Oc2e6I_lWKC_hA-1; Thu, 11 Jul 2024 15:23:06 -0400
X-MC-Unique: t3PVDG69Oc2e6I_lWKC_hA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee8b7eafffso11831931fa.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jul 2024 12:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725785; x=1721330585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHMyJXBeRkRSNluth1L1mz9hL7fSL3Kwm56sBWnC+jg=;
        b=AYDc5iVBLNQRhZFMbZ7WlGlE06U6oPdWW8Qb0ccpYfuTxT+a+I7IcUeKNLFQ6JIfN0
         C3Ph3AiSEDIkss6XBeAUGnKZgxCt0TWmtIjwYELxKVxm20LH52/gNPK7Vl4TYMMdNf8C
         IlLeeXuiZhbeEYwQCFEL+BgwFA9Nn1Jbv410Sif12YQ6HGaDKAUM6WkWLn+I3d/89dYz
         TmsTJdOHSWASM5wMU1Iko7gHV3ZuJGvRMB7WIuGOF5u8PfxcwETFGF+CePE8BgbQ3jjI
         pApLlIrivsYOx8XoCpSn+eCtSDKK4x4zlB+u7hUy4Phv18LC1rjBdfgfu9HwYh/kxsy3
         wqJw==
X-Forwarded-Encrypted: i=1; AJvYcCVMz3V8YCEu5Woa0akCKizw8diYtegav/YlyosJ79iJ4VmV90VgIE59PJ4qqZPAD1ppDdveg8XE6QL2Aa8jQlx7Ed2EK+oGj3HQc58FNzk=
X-Gm-Message-State: AOJu0YxcKsBayAV0xY42Ec2XkMGmO866ti8efZFjLSgmfc/fmmN5Q9yd
	a/u2nikLcVZx4IGNpjKGXW+Qqq08+OzUlHHrexnUJGEDCxeqf4b6mC2+652yad9GS/UE2KV1TsR
	5yRdfsBeswlMkSNyhXq/WyjUnAfXKaGWVK2S2h1wdpxIpYgcLRgXTG2E81Q6KaBX1
X-Received: by 2002:a2e:8691:0:b0:2ee:6a72:f006 with SMTP id 38308e7fff4ca-2eeb30e3ademr61595751fa.21.1720725784994;
        Thu, 11 Jul 2024 12:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlcdhPzF+B/x+wWIA8iNp5tqQGZgR9yQ+XfTnwuaunKMFe59pESZv2NmWVtBCYCvMz/J6DmQ==
X-Received: by 2002:a2e:8691:0:b0:2ee:6a72:f006 with SMTP id 38308e7fff4ca-2eeb30e3ademr61595591fa.21.1720725784330;
        Thu, 11 Jul 2024 12:23:04 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:2166:83a4:d566:a055:a5a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7362d9sm125253225e9.30.2024.07.11.12.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 12:23:03 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:22:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] virtio: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240711152235-mutt-send-email-mst@kernel.org>
References: <20240602-md-virtio_dma_buf-v1-1-ce602d47e257@quicinc.com>
 <ef8f00f2-210c-454e-a7f8-ab724a18bf96@quicinc.com>
 <b8b23dc1-7df6-489d-9638-db64a89c8a83@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b8b23dc1-7df6-489d-9638-db64a89c8a83@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2024 at 11:43:18AM -0700, Jeff Johnson wrote:
> On 6/23/24 10:36, Jeff Johnson wrote:
> > On 6/2/2024 1:25 PM, Jeff Johnson wrote:
> > > make allmodconfig && make W=1 C=1 reports:
> > > WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/virtio/virtio_dma_buf.o
> > > 
> > > Add the missing invocation of the MODULE_DESCRIPTION() macro.
> > > 
> > > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > > ---
> > >   drivers/virtio/virtio_dma_buf.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> > > index 2521a75009c3..3034a2f605c8 100644
> > > --- a/drivers/virtio/virtio_dma_buf.c
> > > +++ b/drivers/virtio/virtio_dma_buf.c
> > > @@ -85,5 +85,6 @@ int virtio_dma_buf_get_uuid(struct dma_buf *dma_buf,
> > >   }
> > >   EXPORT_SYMBOL(virtio_dma_buf_get_uuid);
> > > +MODULE_DESCRIPTION("dma-bufs for virtio exported objects");
> > >   MODULE_LICENSE("GPL");
> > >   MODULE_IMPORT_NS(DMA_BUF);
> > > 
> > > ---
> > > base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
> > > change-id: 20240602-md-virtio_dma_buf-b3552ca6c5d5
> > > 
> > 
> > Following up to see if anything else is needed from me.
> > Hoping to see this in linux-next :)
> 
> I still don't see this in linux-next so following up to see if anything else
> is needed to get this merged. Adding Greg KH since he's signed off on this
> file before and he's taken quite a few of my cleanups through his trees.
> 
> I'm hoping to have all of these warnings fixed tree-wide in 6.11.
> 
> /jeff

not sure why I tag it and it gets cleared again.
tagged again hope it holds now.

-- 
MST

