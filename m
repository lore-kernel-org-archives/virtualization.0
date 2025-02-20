Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAC1DF735
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740085509; cv=none; b=QkPFPG99z5P1LNfWS7WJ3WUgX9XqKUl0g3vO4Xi/3EFUm6ZyJmKJV+0YfcTVEOQiEEXZ0ImNHIIkr3HbPY+dmaSCB7QLb73mH403JdPEald1/WO5rQArsBczEXPWDTQc+TPTCmpxlY71djK6tE6FB4sfZWq8LFY18731WwjPCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740085509; c=relaxed/simple;
	bh=yO0vl3vl6r85XRczqqyFXg3rFR9Qwz/DloafjuQ7Igk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijstmmLlgHx2wOdzN9PGhMDXTwrE3c/eTJiCZb3P3Vl8znZx0mNyJcgxQqJguEPqgKS4N1oLp27c3GwGhjpFpCxGoy2noYWOezxFmp/HNMMzkYbBbAy2qBU3h0xrQlMkyDn4Lmq/CmHKCNmpzBTs2EBBkg320McI+0mYaLOaHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REiFEBh9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REiFEBh9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bfdfb3f4so30766845ad.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740085508; x=1740690308; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oxhd4XT/zCoDOMejdSRLbrpeHrRuTkeG6alk6G3I8Q=;
        b=REiFEBh9Mut61XM9nR9YtLIx/2b+ZM6/eoV2PfdBs6rW1RQYuuWIeQO4GctZ5plD0R
         2kOEueh6hEsBwsK13zXk5wf5EHukwx3UFv1KvgHMyRdQEbugHb10pwEOKDZYsxc/uJPV
         gqppf3XdNe4aee1wJyf+xSTyIPkhFFM2D631xswsTV5pzG+BvJkr2QpO9xgHL08/J3O9
         UlT2s8K+SuBA9zELrbpBfdBwc0W4+V+I2pafUhMDvhii99/NFwdVkhics1694B0P+3q8
         ddVtBUBp4g0uNvHh01J73Cv8NOmaLOo3lLaQ0qth5yormPLY2/Pj3lE8EJVji2TIeVm4
         I9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740085508; x=1740690308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oxhd4XT/zCoDOMejdSRLbrpeHrRuTkeG6alk6G3I8Q=;
        b=WX8Gllaco6lDZwQBh4QtKiIOrSq/N36bjeVSqKu96u2n8JCfLnK0T8vbjnSNU2ZZ3d
         Mkyo5uutK11Nn+zSHoEduRbofL81pm7szGD1Nyos1tKzI0qModA+Mdw9wRMWDxzv9XSA
         T0TuwBS7s052Nu4pjgY8Fs+xrJg06qOaRUuE0696xXGaB+zyXBLdCt7SHDHHuqGeHBDt
         Z9W0ILx8AN1P6gqtJ9jy04F9RS2MgLM56/YbdyPm2l+mkwgU+Hdbkzg1qLFBvBC/u1mI
         WVAWZeKKGlnEgPVSAW0wrYHQdEEQg1sZFj9EBcDI+WbQoJ70BAPwsKhbCAUVWFmIIPsR
         glXA==
X-Forwarded-Encrypted: i=1; AJvYcCW5tX/retGBpxXLcFfK6pi66YAEdqDxgzXIu5Ij7R1LheFfYRQUpaegzz99f2sx/hpboz1rDV59HRRA/lpXMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwECGSmFfscnymkVBb26AuPSTqLBT+H8aW0ZEX5q3MadnbRTcao
	4z314WT7wg4laHeun7pOIjgwQ3o2tyq2UTOA7WrWI8O67tuYojc=
X-Gm-Gg: ASbGncuTzESheIPIrM/aEVstZEvALxLqjuZVJ5RELGo7Xg2QOuB3Fu+ix5B+fdZ2mvp
	i9G3jGe3KVhe7TgYgmq7s3S2h4JqUfuRW3W0Rnq1rCI3vsr2GQvS4rdt2fhp05Ei7HI+O3W+vYX
	I2v0Ee59+rx+1dR6bPiKegl1EfCHNWHulHhT1pqGMUuZKlX/tVF0PtGMCpIT7oTyyC13ycvaV8y
	tN47+bpWH1o9EWgJgkyO+p6ZnKC4fuKBuXtNOY2E1QMXXs3I7UScgrFEziE/dYdzK+V4VqB/aG/
	iPcz3t4B62W6A1s=
X-Google-Smtp-Source: AGHT+IGyI5hMvhiDLYNc7OSURvPKm2QVi6I1a+B2WeRwUY5Bk4xeWkg2HE+1oCupSYjRz9XCcRNZHw==
X-Received: by 2002:a17:903:41d0:b0:221:337:4862 with SMTP id d9443c01a7336-2219ff50e97mr9604975ad.15.1740085507661;
        Thu, 20 Feb 2025 13:05:07 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5586141sm126353825ad.227.2025.02.20.13.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:05:07 -0800 (PST)
Date: Thu, 20 Feb 2025 13:05:06 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 8/9] net: check for driver support in netmem
 TX
Message-ID: <Z7eZAo3M06ZnLMve@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-9-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-9-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> We should not enable netmem TX for drivers that don't declare support.
> 
> Check for driver netmem TX support during devmem TX binding and fail if
> the driver does not have the functionality.
> 
> Check for driver support in validate_xmit_skb as well.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
