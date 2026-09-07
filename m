Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F175395ACC
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819739; cv=none; b=VSe1Y2IgRaNskamHOvxWHREWaWeWAh3J0gbr9PmxurSt9BBrO7NN89I3F1R0f03d5Q4FP6GWUthLhShBKd98lV4qAqbXqhDTks2xeRs3g0pFrXhj2iSR5aTr5OqzMIZa1H7/QuK30PaBLQJGQkbLvCiScCnF3fK80yRbxbWk2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819739; c=relaxed/simple;
	bh=DkPnN0LBKMtrFx+X0M2ExaQxqAiphMY+jUqO2hdebNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OkXldfV0vrDyjZxzm6jDhStjpiDKJp5iTaRUkc+tQXAhWApbj1o19Y8kcIYAFZ0N8AkamioQ8vLfe8PhwBDURlY9e+glqNmVDH/PeGMwLP4o9k0NKkwLMM4tv4w6ZgCQz3/kVHcgPVyfwiNguyWGGAKyzQN7R+EfAwW7Ua09YFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lp0IK5LP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lp0IK5LP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788819737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
	b=Lp0IK5LPF0SAXWljyYIgJETY4Zj29VXFLbXzoc0/K7ZKtqe3OGpktWNTyNu7zNmr/D+QoQ
	SA7BgGgaasjbVHayg6kWRfPkwUfHOUF/bMPOOBRLblqLk5lmWGEFirTGUjJsljTzD3i8yU
	8WWZTjUKG0iBNtKWw/1O5bT7WN1aKFI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-JEUP68uQMsGzrhYIv0-NiA-1; Mon, 07 Sep 2026 18:22:16 -0400
X-MC-Unique: JEUP68uQMsGzrhYIv0-NiA-1
X-Mimecast-MFC-AGG-ID: JEUP68uQMsGzrhYIv0-NiA_1788819735
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d1a778b9dso1221905e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819735; x=1789424535;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doPvstU0jM+pOnprTuHLt3cRtMawGYtbfNsIMqB0F1s=;
        b=Wze+QCJMyaCPlUOYNe2jg9I7hMxCqdMCyCkT5mOaqyhmyj+iDjqNaXqvUFOyxzXIBJ
         NLcdKDY+n7ONXxzpl2ZL4+Vjz+Ko9rou1M3BlsbzI6gLm4HYhZabbDxQEFpa0M9j3AA5
         WYKDTXsAxRcAPBN9Ddo9C65if8mJrLl1YGAdQSH3JqXZWV0K8ReODin2Kk7pJHVtfIPP
         TjkZGeKRJWhcvX4Bv0h6gPRd9dE7n90iiD3adezRl9oIaRHC4fbN3CwxHTAqq6MieOl1
         DK0oyfzTaLKsSv2t15CTKfP88JmRxeDPub/pTAMDlpjZTmeXivW4B9Ke6SJJDLJwvFZ0
         CW8w==
X-Forwarded-Encrypted: i=1; AKwUvByRytwVRzLjgkzzeQvGx1BZm5bndeXx61hNgd3XjDGMmB/xJELKZSA5OROflG+L6uKutITDHSrpwNdin7Zs7w==@lists.linux.dev
X-Gm-Message-State: AFuF++ltSGo+xYMBqXeuVmXHh0ATQSDVlyEGici4HqxBapxdoygcyWUf
	X5Wp+NfxGD1avESDdn6F6cA6sT60FiazbGb4tWFopOlq7s4/H0FGfJJF2LUJ7Mu4+ykqI2M8AqD
	5PCt9MkfSzGjwW4hBiz8jdKWNOKYi9UYA4UvBEfsvwlq27j5GSNLNfkba9FKin8s2i1gb
X-Gm-Gg: AYBFou2rm7Hqx2aXf2GfEittXh3eJX+P9yWVGHouBQLVbiLWJ5WIJjbGNSMCYWX9q06
	+OCQNyidKbBgzXTdzejs+BFMqKawKt/Auf9/BYeBvsp0VFgHHP2ovCKltdRvV/XPCAUECv49bGS
	LGpb2Wp9BlgHf3UGKkbop0qzaKny1f1AvloyniojHYHmXyhVwjB1/nLxLptIr5G1IfsUX9JfKUf
	5Hs5BAcFyoAJpw+WGvoqm0wxnlt1vHGzF+cY8/zP5fhyf01HZiGa/Bixn5hODT8fmnhoOGbG9E3
	uSvXNwtIG0Jp3gHLxd/47/nuV9vW029HjlaFBSL3+Q4GJtSPuSQae1U13pko7yqITG4=
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr47086835e9.1.1788819734848;
        Mon, 07 Sep 2026 15:22:14 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49d17d4b01dmr47086385e9.1.1788819734435;
        Mon, 07 Sep 2026 15:22:14 -0700 (PDT)
Received: from redhat.com ([187.15.128.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm24030241f8f.20.2026.09.07.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 15:22:13 -0700 (PDT)
Date: Mon, 7 Sep 2026 18:22:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering
 input device
Message-ID: <20260907182153-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-3-kmehltretter@gmail.com>
 <20260907174559-mutt-send-email-mst@kernel.org>
 <ap82pFlX8enNG0gZ@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ap82pFlX8enNG0gZ@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z61ljbEWmxRvMtcmy_BZ2-Sd5xFaLJXaPFlzM9tJcLc_1788819735
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2026 at 12:15:14AM +0200, Karl Mehltretter wrote:
> On Mon, Sep 07, 2026 at 05:46:07PM +0100, Michael S. Tsirkin wrote:
> > > Assisted-by: LLM
> > 
> > which llm and which agent?
> > 
> 
> Claude Code and OpenAI Codex, each with their current models.
> 
> I switch between them and let one do review, the other
> helps with implementation.
> 
> "Assisted-by: LLM" is the form Documentation/process/coding-assistants.rst
> gives now.
> 
> Thanks,
> Karl

really? not what i see. in which version?

