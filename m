Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298E2BAE2
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878257; cv=none; b=r9slJo9XPBBEUQH2m8Yu423xqr8IC/x2QrIIKRjEa2EnohNKJ29Wg2vDDBcOXfJ4VyVO9o7BT9NcTtol63N8rpmx6C47soryaGLCYaAD3v9SS3j3bq0sAysItccxyyKDMTykCQKJlMVt6EZYEFsFlplVOCjKXTgMEvnBfLNBbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878257; c=relaxed/simple;
	bh=kKoUm3PO7qYSJlhRKqspHcMFqm6a0tyYtDVoSFqz474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r3M7OUIFl4jnhIkb+ZNddoiWwggMKEz2wIZCGKd/WWlO1MDs58zh0e4tzf1JMlaudytpOT3/e3OsmEbVxm4/dgl7Rr+lIsAFb+ujxiP3lcoe8rCikeqJo21WulfGy8/fw4aElWIny9pcWK8gUfJczdeeCddN4orB7KkUakhCgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0yB4nhc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0yB4nhc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718878254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HpbUlkLZ8ibKoVaeJCN4Dk5U1yWp1DtsYjK01WnZis=;
	b=U0yB4nhcGqy2o1o++LfcfizrdgJLZ6K7uihaRA6ct8KTGFeryFZGQVf3+F8dFJILiFKz2O
	fuYvI10TvdZAZ8ky1vtK4ZhIrXUWSrTm26pkwtBR/+0JI391Gjxqr25NI81RbZgRGfJgS5
	GPmG0JRk8zinjQN+OXd+GFZBH/btykw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-WIDJMQasNyKaCNqreBKObg-1; Thu, 20 Jun 2024 06:10:53 -0400
X-MC-Unique: WIDJMQasNyKaCNqreBKObg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a6fad35a585so35145666b.1
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 03:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878252; x=1719483052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HpbUlkLZ8ibKoVaeJCN4Dk5U1yWp1DtsYjK01WnZis=;
        b=IzPWkfwlBl0+izZkhRuAjDm6ObbTheXM6HJAk8nkpninqHwisxs0HSwmmfep96VxpA
         /rpeGUZ9OF6LOankBC9eIDJBrWlsMP/z3Hv5WrxFcXYfLWOge32HEP1UQWvNRFnjvb9b
         TtNl8kzkQuWqDidCn4A01OFT+1MUgRRxhJU0oUOXoc6aOCLalnV80cZL+jjVvYxTHR+i
         8x255CC4oSahXcISTgDMGegOCoMJ1mUq1FLX/bi+vtf98fvDcUN3bucrbse1JAYmN09r
         qevVz6KbsbuFqEYR5+6uT+exgQ/YzPrbGVvRIkLFDEk9uk38pEI3YD6wAj/p7ylyu3EF
         5njw==
X-Forwarded-Encrypted: i=1; AJvYcCUMUDbtgy3fIhcusNHaRAoDUEDJGZCFJFwa+w7y18Hb1XLXd7C1issxxFuVkorqdiO+1wZSzt2dn9VwG6A0onV7t1s49YogiigooEuuVzY=
X-Gm-Message-State: AOJu0Yx+a2Y7GD1CHh6LaR6YNct5DwGpfd2WmmPTLFtc0LGLQjYHAdch
	4vlwNXpVVnFThQFk4qd3IqnfGMN+TdoXFCU0ePhEjSNjYjB/tmRWRXq7m7uPptA8ZZnaTwFUTLW
	J84OuUyB8ylUKmDsJnRuRW6Kq1iHRdSjLxS2/m5pOfZ7hdKKm9nwpubZDOmiPPVpn
X-Received: by 2002:a17:907:a646:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a6fab60321fmr334918166b.8.1718878252282;
        Thu, 20 Jun 2024 03:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfawUQaD0CC/3GEg4kloU53QXav4qYoiS7hHVhoX5VS5ncH1y5JPi/ciJOk+O7GOYKvfjyg==
X-Received: by 2002:a17:907:a646:b0:a6f:5192:6f4d with SMTP id a640c23a62f3a-a6fab60321fmr334913866b.8.1718878251396;
        Thu, 20 Jun 2024 03:10:51 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f788f46c6sm504148166b.23.2024.06.20.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:10:50 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:10:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240620060816-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1718877195.0503237-9-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Jun 20, 2024 at 4:21 PM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 3:35 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > >
> > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > >
> > > > > >     /* Parameters for control virtqueue, if any */
> > > > > >     if (vi->has_cvq) {
> > > > > > -           callbacks[total_vqs - 1] = NULL;
> > > > > > +           callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > >             names[total_vqs - 1] = "control";
> > > > > >     }
> > > > > >
> > > > >
> > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > this will cause irq sharing between VQs which will degrade
> > > > > performance significantly.
> > > > >
> > >
> > > Why do we need to care about buggy management? I think libvirt has
> > > been teached to use 2N+2 since the introduction of the multiqueue[1].
> > 
> > And Qemu can calculate it correctly automatically since:
> > 
> > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Mon Mar 8 12:49:19 2021 +0800
> > 
> >     virtio-net: calculating proper msix vectors on init
> > 
> >     Currently, the default msix vectors for virtio-net-pci is 3 which is
> >     obvious not suitable for multiqueue guest, so we depends on the user
> >     or management tools to pass a correct vectors parameter. In fact, we
> >     can simplifying this by calculating the number of vectors on realize.
> > 
> >     Consider we have N queues, the number of vectors needed is 2*N + 2
> >     (#queue pairs + plus one config interrupt and control vq). We didn't
> >     check whether or not host support control vq because it was added
> >     unconditionally by qemu to avoid breaking legacy guests such as Minix.
> > 
> >     Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com
> >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Yes, devices designed according to the spec need to reserve an interrupt
> vector for ctrlq. So, Michael, do we want to be compatible with buggy devices?
> 
> Thanks.

These aren't buggy, the spec allows this. So don't fail, but
I'm fine with using polling if not enough vectors.

> > 
> > Thanks
> > 
> > >
> > > > > So no, you can not just do it unconditionally.
> > > > >
> > > > > The correct fix probably requires virtio core/API extensions.
> > > >
> > > > If the introduction of cvq irq causes interrupts to become shared, then
> > > > ctrlq need to fall back to polling mode and keep the status quo.
> > >
> > > Having to path sounds a burden.
> > >
> > > >
> > > > Thanks.
> > > >
> > >
> > >
> > > Thanks
> > >
> > > [1] https://www.linux-kvm.org/page/Multiqueue
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > > >
> > 

