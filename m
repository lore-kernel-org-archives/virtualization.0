Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51948229B36
	for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504098; cv=none; b=CqJ9dsPZn9j/2LoPtlC9IRNT+cFWx+4yKVWHVwsMeSSoHxSVb+rjVLqLrDTc/aJ6Ue4Z6Whkal5sqvF2xg4+rAiysc1DDx2JqQfvwrZ+Ypwf+fHu9uK9OUtiOW6jd9Mhfi5ZBrtF4o1KfumbdwG9fbmu3oPP7FkI+4EcTXvBLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504098; c=relaxed/simple;
	bh=iXQ18XPUgoYJiSFSxjhg3L0CNHDwv1VsQkAjlNWUKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUnMqBlsQXYvuil6E+AqtE+OEZnbHCnw8b+3P8MDGEYT+eahfvrwCF+jY0519TL4XsebbiTXwtRiP16/WMLohuZq6+LS82Qx4Y7Qol7BRTFYriPpPF1yXg1dm7Tj1ioVdwVN/W1zoArOQR8nZfRVZs6zzzX1bGVeJAgNL6EeNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVCvMzna; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVCvMzna"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fb0f619dso26539995ad.1
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742504096; x=1743108896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmBASaW+GqNY/UJNZ84+vFK6yD9rkYMUDyMz4fd0U0A=;
        b=AVCvMznaCqPgRmjkCaNpg/qrE7e096G+WVrwRcMI9GLKLZOjZ5ZWg5EnfOT5lE1Bey
         /SNGfswmXYrPsVcsikIVr9F3ZpUyaAAc0EujbjNy7DCXvJS2LBHcW04uBmRZxE3Y+zeh
         gqEKuw0412Fh8LGRXO0Zxc+BXv9WTIOT7zzWtlzSXbwf9P9LxwVqwW1eF/HN/iXBJtqx
         nD63cHJHQ+CkBpU5/lLQCGApgWcpqC52K0jkP6s3BxtWIW8wBPvlAV8mNBcBbNkCcOUO
         MPH68WqBlzFLZt/owTKf3RCB6+Nxmc2fkBxoS6QL2Mvho6EpifjGz24QN6vxpL5qCLEh
         PRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504096; x=1743108896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmBASaW+GqNY/UJNZ84+vFK6yD9rkYMUDyMz4fd0U0A=;
        b=UHMMgAhCY3CdP6A9NAN1Symrixpnq298l3W0EjHdtuZFQ1FWWyt7KYZ6anMDM0NaX8
         xsYuz4U/EeGurvoEIwmtHBV1OY64QgKwIVKwhVken0Duh+L4KFjTzcZQc69rWW2DG3zq
         CzWfAotNH5LO86D8NVcVTYiMouQaKSETfs9hGcgHf2RZLb/1kaTFvyYNVUs/GyAcMV7k
         MmWJO9fgx0Xutzjknfm4urgNvkpcAIJXhw77IOtshgijDf+HPTWlo5D6qXOMOjptsd9U
         9YG5KAJk6t5Ta94xrwK84VxiEUn5c0/NZxAgyh5QuDTGZeEP5CgbWxYz7tehgycyKIEp
         kueg==
X-Forwarded-Encrypted: i=1; AJvYcCUMmOK4tlK9pvba+5gnsXq4kj+UMbOv8NabOhbKYVRwnQcEns2PJyWcUTmsT+kHaxISqlIszVPnVlwlgRAgUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoPYcqx2ETtNyHAC40tIiFSOTJePJf3/hcddRCc5SdVhd6e2t+
	VvTXPd3A8cxQz8pXCa2cmarDMH5NYoiomAHZKp0EujVWF45pTBaQ
X-Gm-Gg: ASbGncvQjpx4ObigfZg7ex2lr3EbShAC5bOKxO/s7vsbFY78ddEqijJig5dewOvYfOc
	mgt46AVQ7/8mvE38BeMwKJqB9S+0aCPmIY8X/mjpock7XURvuBgfzF8UTMDcziFWSEr7W1Lo8vi
	/JXM53g9KZ71RFlOBSaKByR5KP6LMrOrX78B4xWBm4QNr2NW4RriNmrvl8eNhNMBX2DO2tWOMjc
	LCauM3ArKo61Ba5BeZeqFzZ9hiOtL+xtUffqNcwWj27xO7Uv0f9eDv/uMLxuxIv3SKV8c7m8C7f
	uM5iSl/LY/wC8QIJEes95i5niRWBrUVoXXljb1VcSsYRahc9
X-Google-Smtp-Source: AGHT+IGVYYQZcFd57VZXj1o+MK4h5npJo8HOGu2ixgfY4o0AjAyD4std72Wt6w9yNTxK+u0HMfnPJQ==
X-Received: by 2002:a17:902:cec4:b0:219:e4b0:4286 with SMTP id d9443c01a7336-22780db462fmr12039995ad.29.1742504096349;
        Thu, 20 Mar 2025 13:54:56 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a24410sm340304a12.56.2025.03.20.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:54:55 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:54:54 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
Message-ID: <Z9yAnhMsupaaVCII@pop-os.localdomain>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-3-fc8837f3f1d4@rbox.co>
 <Z9tCnq0rBw+nETfW@pop-os.localdomain>
 <4de119d5-c9c7-4f66-9e31-91c44a92c773@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de119d5-c9c7-4f66-9e31-91c44a92c773@rbox.co>

On Thu, Mar 20, 2025 at 01:05:27PM +0100, Michal Luczaj wrote:
> On 3/19/25 23:18, Cong Wang wrote:
> > On Mon, Mar 17, 2025 at 10:52:25AM +0100, Michal Luczaj wrote:
> >> Signal delivery during connect() may lead to a disconnect of an already
> >> established socket. That involves removing socket from any sockmap and
> >> resetting state to SS_UNCONNECTED. While it correctly restores socket's
> >> proto, a call to vsock_bpf_recvmsg() might have been already under way in
> >> another thread. If the connect()ing thread reassigns the vsock transport to
> >> NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.
> >>
> 
>    *THREAD 1*                      *THREAD 2*
> 
> >> connect
> >>   / state = SS_CONNECTED /
> >>                                 sock_map_update_elem
> >>                                 vsock_bpf_recvmsg
> >>                                   psock = sk_psock_get()
> >>   lock sk
> >>   if signal_pending
> >>     unhash
> >>       sock_map_remove_links
> > 
> > So vsock's ->recvmsg() should be restored after this, right? Then how is
> > vsock_bpf_recvmsg() called afterward?
> 
> I'm not sure I understand the question, so I've added a header above: those
> are 2 parallel flows of execution. vsock_bpf_recvmsg() wasn't called
> afterwards. It was called before sock_map_remove_links(). Note that at the
> time of sock_map_remove_links() (in T1), vsock_bpf_recvmsg() is still
> executing (in T2).

I thought the above vsock_bpf_recvmsg() on the right side completed
before sock_map_remove_links(), sorry for the confusion.

> 
> >>     state = SS_UNCONNECTED
> >>   release sk
> >>
> >> connect
> >>   transport = NULL
> >>                                   lock sk
> >>                                   WARN_ON_ONCE(!vsk->transport)
> >>
> > 
> > And I am wondering why we need to WARN here since we can handle this error
> > case correctly?
> 
> The WARN and transport check are here for defensive measures, and to state
> a contract.
> 
> But I think I get your point. If we accept for a fact of life that BPF code
> should be able to handle transport disappearing - then WARN can be removed
> (while keeping the check) and this patch can be dropped.

I am thinking whether we have more elegant way to handle this case,
WARN looks not pretty.

> 
> My aim, instead, was to keep things consistent. By which I mean sticking to
> the conditions expressed in vsock_bpf_update_proto() as invariants; so that
> vsock with a psock is guaranteed to have transport assigned.

Other than the WARN, I am also concerned about locking vsock_bpf_recvmsg()
because for example UDP is (almost) lockless, so enforcing the sock lock
for all vsock types looks not flexible and may hurt performance.

Maybe it is time to let vsock_bpf_rebuild_protos() build different hooks
for different struct proto (as we did for TCP/UDP)?

Thanks.
