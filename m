Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99466381BA
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764371; cv=none; b=jmM3+9qQ/iwIqSSpPVvPdSvGnSnTSHDloY+E/ZVBa3WhjJpoikxuqe7x16OKyE72IFT1CuJLib4Vg4H/tyPlmcL9HVq9o9JppIGeEkICSYeHE2DH3kU9th8j32Xapfqypja3vqf4DRYhjEl1HiUEHlg5IqcrEycSRH+1vbe4+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764371; c=relaxed/simple;
	bh=pOSlkUulYyw5/O4A+X0uYoH/0HZhuQNeAcLk38o/IBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAdQsDSm0VVPLTszzP7SGDXpOhTB0AQ31OSXUHchb2/wN88cdGb0SOSCrqm5n4WnGRsF/qUDkTOY7PQSE9kWjPsrIxTIG56hdmiDZVOjj8RUzAYn1TnaoDk+pSprBYyLvNd26aukMJsUyW7tc2uj7XShi8xInEv7qYQkU+65sBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dM9LsHcV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dM9LsHcV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5262845a12.2
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710764367; x=1711369167; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOSlkUulYyw5/O4A+X0uYoH/0HZhuQNeAcLk38o/IBk=;
        b=dM9LsHcVX13OzjDrrZL2gMWEXmMSg4pIlP4U+RJ/DGlMdznkwjpB/p90w/mYTV4Xyz
         5C8cX18tV8hcDEpYZ0eRtqdVdJWuaEvO3BfjNlmWgLHqa5L+EkONOUxeyclKLjXmkESf
         emyrinasvz1lbp1St4hy5AAhpSaoNCUEXzKuXbW/QooYmVW7Nln9t0U2DHmlaj7xNO9s
         bunBRyn3PtKqam5YlDxle19U/vQZZA8qV2TPr+ZLI4Y9EBJolvoiUDJ0VrMZfRxQOp6I
         W66jxUVvpyU4YGAL0YAed7IpJtgdJFg7BNFFjQdTUd7ogx5bCAQHeDqN1cGXhAO3CUHP
         G7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710764367; x=1711369167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOSlkUulYyw5/O4A+X0uYoH/0HZhuQNeAcLk38o/IBk=;
        b=XmbuOE9oRjTpdj/aiDeXPnMqKFxGrqE/H+oxjxdk99OSAKg7dLsaF19/stLXfyFaN1
         GQGAe52eQj4xCp/1mewJsblsUsrdNgU9K0hzCNP5g/es2t9/mpPJQmXt9gypyX6L+DwB
         hN0ceSngivEyW+vzQBXM/IntF7aWq0GRPgh5SuKbjEsHA/5oUi8n96xKTuJfQcFEOl4S
         YmvNFhEU29t52hVp2WFCb4DOj/rdYhk+ubuIGLCYUS8jv7FoZYmySTlSPoGIwcDQDupC
         VlCd27FZtJ+DuwuAgmq5C1/8zQQNEVODpuu+wYgCbgW8YMU5TRBci5TY05oVq7fTM/vs
         oK0A==
X-Forwarded-Encrypted: i=1; AJvYcCW5SKaYsvjZj84PadRFjwqPDtf8CvsYRyqT7+n/j2sKYBV9Hiug6tt/Xz/6zXD/44hGlJo4U9HbxMlPwMNUsyccehIt1YZ6FRnvy/1Xr1o=
X-Gm-Message-State: AOJu0Yxk4IbvJBb4no+D+E71ig97roGTS7eUpy7Xc8C/fGJoXIM1WwmN
	QLFVWn+fk0XjLul17vqP1TvXEgL12JT+nUdtN2TyfDYuthdMRsO2HzLTXTQ59yM=
X-Google-Smtp-Source: AGHT+IHF1tEj7gb/YwVHDW9BOuby74iZuApmYgSUxT3zLZ2JgfbTwLMWpYsP7y0MGCfo/Ko64/Zs/w==
X-Received: by 2002:a05:6402:c13:b0:568:b391:4ec8 with SMTP id co19-20020a0564020c1300b00568b3914ec8mr5028130edb.12.1710764366639;
        Mon, 18 Mar 2024 05:19:26 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h13-20020a0564020e0d00b00568b163c4easm3421073edh.11.2024.03.18.05.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 05:19:25 -0700 (PDT)
Date: Mon, 18 Mar 2024 13:19:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <ZfgxSug4sekWGyNd@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>

Mon, Mar 18, 2024 at 12:53:38PM CET, xuanzhuo@linux.alibaba.com wrote:
>On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
>> Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>> >As the spec:
>> >
>> >https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>> >
>> >The virtio net supports to get device stats.
>> >
>> >Please review.
>>
>> net-next is closed. Please resubmit next week.
>
>
>For review.

RFC, or wait.

>
>Thanks.
