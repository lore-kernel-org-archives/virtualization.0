Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E941B970
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640996; cv=none; b=gKzw+q8anpWHQhKQUz6wCNM4uSJ4I9xMpDKaFWrlEdTIWL3OS1z+g3zwSI33cXlnvjBKCTP4iGAzWrubLMy1d3wSldtly/IbqO7V5TvwNlAO8VHoLTdud6nLfywSN9ljFmWdFi3l+Vk75TAQ/WDNp5WRV+RtykziwufTnUbMA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640996; c=relaxed/simple;
	bh=+wbrMXHI1K3udEIdhQFfHU1ul3eAvVPemeTSl10tqzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hYFfQ9B7+RH4LQU9A5tWB4vrswjeDNDpe5OH0XvZUm9iaamXh0Ga7FqdE2hhd416LETKWBTWud/IiiLygpA/l7Z2yiDC8yUU+p01ydJvsnWryavRjBFc6fnMl4+u8aqgDu1HZA9wLM5R33Qo8o7CYXZdbwHIjeFc33VZ0shZrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIBJZSWt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIBJZSWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718640994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POQUo9ZYFx2TRBMxz/20fM6AHmLGnv+tvZ6Yfe8E564=;
	b=JIBJZSWtM4sX+oh07ckZUbvRYNGDy7m5K0pxdk7aWSAVJJkLReejtMefeJB7nI0a/OZn8n
	HNYjzMsNrvWwJipJqzjWGNWZVJutZo/sn+vVpRGnPtSIyuh5D74pSlzHTFVH7aECFy022s
	VqaYLbEZcphmvgkccdTJCGBlhqvNV0c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-NQITA-kqNKqfkFg82oBobw-1; Mon, 17 Jun 2024 12:16:32 -0400
X-MC-Unique: NQITA-kqNKqfkFg82oBobw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebea1c1124so34956681fa.1
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 09:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718640991; x=1719245791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POQUo9ZYFx2TRBMxz/20fM6AHmLGnv+tvZ6Yfe8E564=;
        b=XWGpkb3coB8wJEI9knAq/HGE2yQWWYHb8HO2aojG1KbWKuSvPl3CPhNGXvL4UmjZ6+
         VEs3omTj9LyEeKT7Tcnv6NkOoY1RJ5K/xunRYvRAK7s356+R5MWzd389EMFLv1NXGJRU
         cb2dXAcCY16Hr26RuCN6HrKdqIXULMlzRofrOk77SUtdqHV4itXC3EouqQbj1co2FlUP
         x3G3k8A7MQuRVzbDA/q1Ur8oOHGksAS72BqJLVSfdeNe4UI6qtO8fyrXQdndCcqhewIr
         TP8BC0AH/lVc5E66tucVCjxbxbamQPm7PuKShfmgPz+Xx+MAUZk17RMSRHjubBBOBHuN
         b70w==
X-Forwarded-Encrypted: i=1; AJvYcCUV1D45RnoMkcZjX3zttZN0gCg0amAmWnwJ0B14fPgDhCj2WGlGFSUqFAubfvTDPQVMHi4DfTPaepW6oEYevZq7JugI8Ss+UpjExBJoD94=
X-Gm-Message-State: AOJu0YxX3FY8t+5Mt3FaZQn+DB4wc7mEmdVokfRp8sLPqcPlKTvaxVxt
	PY8SgGyCZuAAQZS935HStiNqZl7+M+rDbbs8UaSI1XHUNq4A0nBAdH9WALAp6eb/m/aJexFejEc
	bf2R3xI9Wt8SubJ5GWlJ2ok5ShDFioGLGm5N/1YFpPir9Ve9rMHJThc1RaFkfJypO
X-Received: by 2002:a2e:b60e:0:b0:2eb:3281:5655 with SMTP id 38308e7fff4ca-2ec0e5d13c2mr73095881fa.26.1718640990988;
        Mon, 17 Jun 2024 09:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENS3KQDOp3objS9rqmf8lxn0GTyDBxVOhps/4Ykbq3BO9fpHje+C9/neMWBdUOIIrAR/h3uA==
X-Received: by 2002:a2e:b60e:0:b0:2eb:3281:5655 with SMTP id 38308e7fff4ca-2ec0e5d13c2mr73095621fa.26.1718640990425;
        Mon, 17 Jun 2024 09:16:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec25647ec2sm7042141fa.56.2024.06.17.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:16:29 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:16:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240617121448-mutt-send-email-mst@kernel.org>
References: <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
 <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
 <ZnACPN-uDHZAwURl@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnACPN-uDHZAwURl@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 17, 2024 at 11:30:36AM +0200, Jiri Pirko wrote:
> Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
> >On Mon, Jun 10, 2024 at 10:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> >> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> >> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> >> > >> >True. Personally, I would like to just drop orphan mode. But I'm not
> >> > >> >sure others are happy with this.
> >> > >>
> >> > >> How about to do it other way around. I will take a stab at sending patch
> >> > >> removing it. If anyone is against and has solid data to prove orphan
> >> > >> mode is needed, let them provide those.
> >> > >
> >> > >Break it with no warning and see if anyone complains?
> >> >
> >> > This is now what I suggested at all.
> >> >
> >> > >No, this is not how we handle userspace compatibility, normally.
> >> >
> >> > Sure.
> >> >
> >> > Again:
> >> >
> >> > I would send orphan removal patch containing:
> >> > 1) no module options removal. Warn if someone sets it up
> >> > 2) module option to disable napi is ignored
> >> > 3) orphan mode is removed from code
> >> >
> >> > There is no breakage. Only, hypotetically performance downgrade in some
> >> > hypotetical usecase nobody knows of.
> >>
> >> Performance is why people use virtio. It's as much a breakage as any
> >> other bug. The main difference is, with other types of breakage, they
> >> are typically binary and we can not tolerate them at all.  A tiny,
> >> negligeable performance regression might be tolarable if it brings
> >> other benefits. I very much doubt avoiding interrupts is
> >> negligeable though. And making code simpler isn't a big benefit,
> >> users do not care.
> >
> >It's not just making code simpler. As discussed in the past, it also
> >fixes real bugs.
> >
> >>
> >> > My point was, if someone presents
> >> > solid data to prove orphan is needed during the patch review, let's toss
> >> > out the patch.
> >> >
> >> > Makes sense?
> >>
> >> It's not hypothetical - if anything, it's hypothetical that performance
> >> does not regress.  And we just got a report from users that see a
> >> regression without.  So, not really.
> >
> >Probably, but do we need to define a bar here? Looking at git history,
> >we didn't ask a full benchmark for a lot of commits that may touch

It's patently obvious that not getting interrupts is better than
getting interrupts. The onus of proof would be on people who claim
otherwise.


> Moreover, there is no "benchmark" to run anyway, is it?
> 

Tought.  Talk to users that report regressions.



> >performance.
> >
> >Thanks
> >
> >>
> >> >
> >> > >
> >> > >--
> >> > >MST
> >> > >
> >>
> >

