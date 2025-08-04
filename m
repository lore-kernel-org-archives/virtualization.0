Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8814AD20
	for <virtualization@lists.linux.dev>; Mon,  4 Aug 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323075; cv=none; b=S5hiXep3ezWI/KkszaP62lipPr7O7CyvzmK+skiwTSyEs9nGJFZ7l/T0bfitgJqiy1ryMShnP7s94ZCSyMqWwYA5dJ7GIBIFauqvwoP0ud4mqEM1bIi4ByfhtKRkOeyzqKLYCdyEhio+16vghb8Il7dzeOpOHZnAIwN02R6hzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323075; c=relaxed/simple;
	bh=pDVC7rFBszGbUr0AQQyyEXmDE6L9VQjbDNm8JyUEdWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=URbS4d45Z7m+NdVNdumSfuJB8mdMHnq96af9DOZR0qsft4U3WB08TKlMNd7KaY2Zz40N9RsbCuWtkbAywU9gn5zrwbTQjquKoGQCk3MJFQrcYQu4+eqlRsJFkxMXtW7R+kKmYQIuLIQoOGF4OE57SDG47sxvGcQXj0o3v+lnUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGyskVcT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGyskVcT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754323072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9mUgdLRs3w5PT298F337vFTebghvsVRguazdU4qoq0=;
	b=YGyskVcTwjsLHREB+QQt4AOZcGB+wlB2AW8wQdojvfL2Hucvdrhw8MC+lKGTwtb4J1UlD/
	urDWUMitm1HEotZRqqxehBFKTK15dacSA0CiMWvFCTBU+OQk91Vuquw1NbMkWCkbs45F+J
	nEKnPpmSkAWuOJr3zVEwIgrydIPpvsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-gxVTsbBmNYi-jg-ZHfMRYg-1; Mon, 04 Aug 2025 11:57:51 -0400
X-MC-Unique: gxVTsbBmNYi-jg-ZHfMRYg-1
X-Mimecast-MFC-AGG-ID: gxVTsbBmNYi-jg-ZHfMRYg_1754323070
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d30992bcso29142965e9.2
        for <virtualization@lists.linux.dev>; Mon, 04 Aug 2025 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323070; x=1754927870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9mUgdLRs3w5PT298F337vFTebghvsVRguazdU4qoq0=;
        b=NdeGVda//iwMOFBQa2Pgep4PtZu2AbKgGnxoWg0RJHa86vUMivU6qyf63e6sYeYGHs
         Gp13ofyWYXJAQ4oI/m7/P95sIKJgaHZjjSsEFRDd8boma+csCmAyvWqSOee/wMlIow31
         zAfdWYWJbxXNLc/jHTHOltj8O94f30Q/dGP8p5VajIxKLJP6QPVinExYIORgTHqzzOuN
         BGaFCiK8+PY/rrHn/b0LuoytEgnZfCYbrOBo9ESFJ6a1/RV7TJmV3i3D6OZPwZLW4CcK
         rZozpTvIHcObrWJxH/ppDyq7cfTpnsfVjktPo5KFMLe1Wq8qu5o9pRNgnLHhVXpSaTB6
         CElA==
X-Forwarded-Encrypted: i=1; AJvYcCWXrFGoiDLXJsKLmwkDJZiD/lrfkUhXf73KaCWSEe1EKMgc2dZjR25co+qM3DnhS51LE+jTb5hGJ1TuVQ+FZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YytkzvPKsh68ET5R4Pv0ghD8DRKh+GqDQrxfJczzHFWVTDQEcp8
	RaUa91HaqzhTkT7kB1fI3kVxqrpWjzG0lpV88DBoFPBgLrI0q0HlAV0iJK6OVjxBCtbKtV9Tpf1
	rr3yyL8Wf14J8+iUTB/+SUnzZHAWf5AaJKdouew+twmM2ZK6JL5lHHwx+IgDL8kXL3eNA
X-Gm-Gg: ASbGncvyqjRMlPwJRKk2gDS6zkoGGnH/q6xElyorM2o7Zs3rhc+vN4N18cJEzg66By2
	9WXwLwQmAzieOK/hJ/thuQSU1wWIubkX0cd/zSq9fArLFodrQ8y5s+KZpWFOQt09kGTP7B15OB2
	GvGz7WSDMnGHZvFMEF4bwbagVLbxG5C98FQflbfVxyhimIXjAgapExmV3NNt3xTkB0cu8Gx/e9n
	q4ZzmnTkflV6YQNAbuP1mtwnEHDJECiFw5jOTWThx8I3PGvjlI9TOxqkLich5DsysNt2isZIAwI
	VFIteBriAdyr8YzbH+RfpKWjy9xHlQ+p
X-Received: by 2002:a05:600c:19d4:b0:458:c059:7d86 with SMTP id 5b1f17b1804b1-458c0597ec7mr60423685e9.10.1754323069737;
        Mon, 04 Aug 2025 08:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvZfiMjphP3x3l4zUqhsolAK9PHooH9Tsp0BlG/3TnfFNZ2tCNNeobV4uf7R2ru3mb+8//yA==
X-Received: by 2002:a05:600c:19d4:b0:458:c059:7d86 with SMTP id 5b1f17b1804b1-458c0597ec7mr60423395e9.10.1754323069333;
        Mon, 04 Aug 2025 08:57:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm6166517f8f.31.2025.08.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:57:48 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:57:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com, will@kernel.org,
	JAEHOON KIM <jhkim@linux.ibm.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] vhost: initialize vq->nheads properly
Message-ID: <20250804115728-mutt-send-email-mst@kernel.org>
References: <20250729073916.80647-1-jasowang@redhat.com>
 <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuNx_7Q_Jq+xcE83fwbFa2uVZkrqr0Nx=1pxcZuFkO91w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iJPF2jeTnXwpOiM1suh0nZjZj8vXPbLdxthbvffBtrY_1754323070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Aug 04, 2025 at 05:05:57PM +0800, Jason Wang wrote:
> Hi Michael:
> 
> On Tue, Jul 29, 2025 at 3:39 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Commit 7918bb2d19c9 ("vhost: basic in order support") introduces
> > vq->nheads to store the number of batched used buffers per used elem
> > but it forgets to initialize the vq->nheads to NULL in
> > vhost_dev_init() this will cause kfree() that would try to free it
> > without be allocated if SET_OWNER is not called.
> >
> > Reported-by: JAEHOON KIM <jhkim@linux.ibm.com>
> > Reported-by: Breno Leitao <leitao@debian.org>
> > Fixes: 7918bb2d19c9 ("vhost: basic in order support")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> I didn't see this in your pull request.
> 
> Thanks

in next now. Will be in the next pull, thanks!

-- 
MST

