Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC914F78
	for <virtualization@lists.linux.dev>; Thu, 16 May 2024 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834951; cv=none; b=pdLTcwNC1vim4jqVfBJxc5DzvC6bkEQakDXych5iXYVFa5I3ytD6MBgNbVUiOi8gJQdCEF5qx+n7OGcw6/endixupeWopGKODtJO0NrbFZOEN1yQpYrO5jsOrbeMGig0bXczDLdTJ/d1AKon2ptb89L8yxYBugEkjbcVo6q0o+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834951; c=relaxed/simple;
	bh=qLZDBF5EWCwproRuemf57u8gvHVkIMpQFM7Cuf8J1rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfTSDNWHMkxIuy3+S0U06HcpeSbfZRvOwpX8JpZWw2/e6XJ2pot9p5KKxBoA2WQjA3Yyszii2Yj7fzf3pe80P+7IIgZI1a/tyuHzS6Zn3xJ3LOD5fksQmZBh6PHDkVrsXeMQrArNWxTPDgBEz9OcixE9Wfs1o/IlGv57OPO2drY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJHpKd+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJHpKd+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715834947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXGIN3lTx6JmVu73hytVZe24/+ZGwq7tQPSepFAG6Ps=;
	b=GJHpKd+r9bjxFiTOGQC7tkZJcGFmP+yvMyYQp2cRmM/m8/67VdnyCBPAQGESR8NpT8MKwh
	j6ZMiDxRb9gFpQBi064cXpVStVtm2ObsT5n/Vnh82UKj+LhlIEwdVuy7nxRWZI/C2S95Ti
	2KQe6l77NzRKbEk4TIfRIXBAgrDMpBc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-yRVSW4hIN-iREVis2SeHVA-1; Thu, 16 May 2024 00:48:51 -0400
X-MC-Unique: yRVSW4hIN-iREVis2SeHVA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b3756e6333so7299908a91.0
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 21:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715834930; x=1716439730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXGIN3lTx6JmVu73hytVZe24/+ZGwq7tQPSepFAG6Ps=;
        b=WNor9XToOvSIPseZyTZzsDzLZeTYSUGTpBhI8eOpKKRvk4ImUNFigZZ+DUdX1wSbbc
         BymZEOJ35ywUI82qAJW910E7tJFio2Hl4V/kib+NU+2bDpMHoE19OM0jUcMDgjXIkWdk
         j6JQ3Th1qPtcQ2JH+JD0rIuiMs+O0OXNq9yUa1Q+mAs5wDJuGGX3k6+jAGoMTPzAYh73
         hlAxZkW0RUKPptnu79LxPQefXM49M7mffqpxTEnuQamzaqsG8gB1AHFv+fOSrtFgNvXH
         vbx2ybVgIxAXbvFmaBgRRUN5dWmB2drjm+4NVm4WLme5PnKMHmuQpw1JgHwhW1c5FALh
         OpIA==
X-Forwarded-Encrypted: i=1; AJvYcCWA2TfqKqdd1/r3Kbna3G3RYX0/q948PPhzpwmQfwlzvwhxBhRhCSEM03Ld5kkrrLHmx5AW1/nUYR/t/qhJFiqqyaxm5LsfzM0OrjxtL8A=
X-Gm-Message-State: AOJu0YwFKMuPCK8geE6cub4jPtk2xcFnRTVvL+ui59x29pyLQu/3E8NM
	tDuttSRDo2twnvGx2RktTCWzkS5+ozhjFDhgoGH4qcwoU/+eH3Sx3gFseBPYmIowSNpGX8KGhmV
	71RSFZb16NC01xQm5LPX2/UaxieUOnFg3P6TyQo+Of1BijzNI5iIuYy8c65fYeXOg8+lRUFNYQr
	Ahi/YM7ZVJWcUbfxFV3M+u373vtTSNVfg2wSBEFvnZVt93wkxwMQ==
X-Received: by 2002:a17:90b:124b:b0:2ad:af1c:4fc with SMTP id 98e67ed59e1d1-2b6cc76d23fmr15154539a91.25.1715834929990;
        Wed, 15 May 2024 21:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4IRfRXIFfQnuhk3r7xQUPBRdzs0tIxWZqixotZ5qq8Y2oueZ43GZWpesIXvDQS/HD/Dky6THvLmhbN3MZsuU=
X-Received: by 2002:a17:90b:124b:b0:2ad:af1c:4fc with SMTP id
 98e67ed59e1d1-2b6cc76d23fmr15154527a91.25.1715834929585; Wed, 15 May 2024
 21:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion> <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion> <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion> <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion> <20240515041909-mutt-send-email-mst@kernel.org>
 <ZkSKo1npMxCVuLfT@nanopsycho.orion> <ZkSwbaA74z1QwwJz@nanopsycho.orion>
In-Reply-To: <ZkSwbaA74z1QwwJz@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 May 2024 12:48:38 +0800
Message-ID: <CACGkMEsLfLLwjfHu5MT8Ug0_tS_LASvw-raiXiYx_WHJzMcWbg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 8:54=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Wed, May 15, 2024 at 12:12:51PM CEST, jiri@resnulli.us wrote:
> >Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
> >>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
> >>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
> >>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
> >>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
> >>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
> >>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
> >>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
> >>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
> >>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
> >>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >>> >> >> >> >>
> >>> >> >> >> >> Add support for Byte Queue Limits (BQL).
> >>> >> >> >> >>
> >>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >>> >> >> >> >
> >>> >> >> >> >Can we get more detail on the benefits you observe etc?
> >>> >> >> >> >Thanks!
> >>> >> >> >>
> >>> >> >> >> More info about the BQL in general is here:
> >>> >> >> >> https://lwn.net/Articles/469652/
> >>> >> >> >
> >>> >> >> >I know about BQL in general. We discussed BQL for virtio in th=
e past
> >>> >> >> >mostly I got the feedback from net core maintainers that it li=
kely won't
> >>> >> >> >benefit virtio.
> >>> >> >>
> >>> >> >> Do you have some link to that, or is it this thread:
> >>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e=
1bc3@redhat.com/
> >>> >> >
> >>> >> >
> >>> >> >A quick search on lore turned up this, for example:
> >>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@=
gmail.com/
> >>> >>
> >>> >> Says:
> >>> >> "Note that NIC with many TX queues make BQL almost useless, only a=
dding extra
> >>> >>  overhead."
> >>> >>
> >>> >> But virtio can have one tx queue, I guess that could be quite comm=
on
> >>> >> configuration in lot of deployments.
> >>> >
> >>> >Not sure we should worry about performance for these though.
> >>> >What I am saying is this should come with some benchmarking
> >>> >results.
> >>>
> >>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
> >>> queue pair:
> >>>
> >>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
> >>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
> >>>
> >>> RR result with no bql:
> >>> 29.95
> >>> 32.74
> >>> 28.77
> >>>
> >>> RR result with bql:
> >>> 222.98
> >>> 159.81
> >>> 197.88
> >>>
> >>
> >>Okay. And on the other hand, any measureable degradation with
> >>multiqueue and when testing throughput?
> >
> >With multiqueue it depends if the flows hits the same queue or not. If
> >they do, the same results will likely be shown.
>
> RR 1q, w/o bql:
> 29.95
> 32.74
> 28.77
>
> RR 1q, with bql:
> 222.98
> 159.81
> 197.88
>
> RR 4q, w/o bql:
> 355.82
> 364.58
> 233.47
>
> RR 4q, with bql:
> 371.19
> 255.93
> 337.77
>
> So answer to your question is: "no measurable degradation with 4
> queues".

Thanks but I think we also need benchmarks in cases other than vDPA.
For example, a simple virtualization setup.

