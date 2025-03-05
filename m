Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D0FC0A
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133172; cv=none; b=uDhqDMXRo4LJ23vXrb/LMT/6btp8bFlYvP1jNPOjsxjJzlgfm4klqC+sCFJWiuoTkiT8okDmnYTwuWawbBmUtc2Z4Ne5FtPvq7sPsOFd1sj1wL373aqw146svxQAOMKinKYU7UH27gbC7GSD3fn2HFxg5K/2kSBVKo5MmiCW03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133172; c=relaxed/simple;
	bh=yumEBOrSKRVXTEceLp63BWKfaVOLc1xa6xzRclgxWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqonKoYtVJwOrj+LTBdJHDQY7LTSRSbsbq3NezV+h9I0zpvaCV7Wst51OuafDbr0VC4kb9erKpbea3Hs3cRea04cPy9iGQNtyXRiMbuKylrXRbIKEGrLlvOiC+1hCM48NcBNC3jsreqovSnCS3P6ENdOj5WQUF2DO4WQMCkwjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vpkz5G1i; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpkz5G1i"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3FA5605C0
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 00:06:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FoRfrufKBgDb for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 00:06:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DFEE46069C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFEE46069C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Vpkz5G1i
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFEE46069C
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 00:06:05 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22385253e2bso85037275ad.1
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Mar 2025 16:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741133165; x=1741737965; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bX8gifnWEanUXpwx5uYv2DpmwKxBi/IwZcv/puhYts=;
        b=Vpkz5G1iCjRsuxkiF1tyZNEl51ykZBXj/COwOb/QEYNPOG5CqtQ1kOMNVL7Vc2VJtg
         zk2noPPegKEE1IsU/7rzL1fkFGC8arizKDJvrSN4eJ1+j2xFgYDQgpbm8ffv+3P9cbyI
         BmHvW3BeOyGgdyP2++f2XiW/lDHdd60VSRk/udg9Vl9eEd0ofWbiOLQN1uwXOgSKK/Fd
         CQfZskPGV/L5kh47nH0bny5g/krUaAnVuHyo+EVBw49tbITXuQtuoO+1COl9qxsNFfO+
         6JI9PGR/Nn9IAxH4bWODTu6OEtRsyWZPLsF06N8Ca91S0EXwbJ/xrjjlB0MqxkXtKt96
         wpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133165; x=1741737965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bX8gifnWEanUXpwx5uYv2DpmwKxBi/IwZcv/puhYts=;
        b=sB9ZxhXNPTr7Ni0wL9GOMHJckvXv68ITRcNlLHP0g114j7pgL9XEWmDzd9hfdc0Bal
         OlhQL3z9glX29PIOuHJ2KCBYooPMQEr6Dhh7od3fJUwoL1ikf9Oq0Ms1BJd2W3EMGpw6
         RIT3knAcqIBGioMlqEPVw9NgMCMzo6ljfKAtMWvMfioCMD4NZdrrCsxfOIg8gTJp+U1c
         B87CMidlHIx0L1wL+mSfcHmhYgMq6uyfM9L3H0Mq7sPeNkBmO7V9Gp+/tfZe7SYd3GEE
         s4mnWegu1pWqUnC7djemaYs08TUUpTDhlfDQciMNSY/0h1QrMfV9/2AN3Fwz+mfPPCTg
         Q1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0DBH1PnoxSkCXrGWmDqZGbB3ETu9kN70vCroepBDR9FD9lcbsnb6jlO/txlZEnZZdXDpysMLDHsUGWd5aXA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxYA31CUdJaJwqKXZVo4kx1Q5OIyvWcwwT2yVq2DS4Nibgy16h1
	Wd/FehOd7lolDHNfqeV759nv+X1wFAcY5NPR7+CqPHiUumm+R7Tc
X-Gm-Gg: ASbGncsDfuuVtiS/owG/ZOArPzeIAPO0ioVhIynymibLLCR75Z+ei+BGM92NofsZxDo
	f3r9pPkIW+eW4czHPNv+3iai0LEvW9uO67ezMaXqXqFrHJ9gsBJlIsrQ2YjXp+l2XZWz5P9rPG3
	vPk416T4cddrUI1XcIqCSPO45o9Cr8XfT6ue68JlPgBGdx8F+u1E42Br/a3j9mdPxSQ7qZgLGQ0
	OJQE0prPsWciciMPYWJhEKCpcOQZXOx2w5P2IvQ3tTHBP9iWo27r/Zn30HXxTQYNotb5u7VXbgi
	jsFTrR81n6OY3FEhk5TdubfaFXCvzTzQDNTJYFeYu6FSCzlhdesrlj2BqqPl6KWjdw==
X-Google-Smtp-Source: AGHT+IH4ftklKoOo2W4okOysYcXlnHpssR8tMCp5JJW1u2ezJYFalFzx+cpxzztCmDjNwc5X5W1I0w==
X-Received: by 2002:a05:6a00:2311:b0:736:728b:5f1f with SMTP id d2e1a72fcca58-73682c89fb9mr1219777b3a.19.1741133164866;
        Tue, 04 Mar 2025 16:06:04 -0800 (PST)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7365bb4090csm4251725b3a.35.2025.03.04.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:06:04 -0800 (PST)
Date: Tue, 4 Mar 2025 16:06:02 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116172428.311437-1-sgarzare@redhat.com>

On Thu, Jan 16, 2020 at 06:24:25PM +0100, Stefano Garzarella wrote:
> RFC -> v1:
>  * added 'netns' module param to vsock.ko to enable the
>    network namespace support (disabled by default)
>  * added 'vsock_net_eq()' to check the "net" assigned to a socket
>    only when 'netns' support is enabled
> 
> RFC: https://patchwork.ozlabs.org/cover/1202235/
> 
> Now that we have multi-transport upstream, I started to take a look to
> support network namespace in vsock.
> 
> As we partially discussed in the multi-transport proposal [1], it could
> be nice to support network namespace in vsock to reach the following
> goals:
> - isolate host applications from guest applications using the same ports
>   with CID_ANY
> - assign the same CID of VMs running in different network namespaces
> - partition VMs between VMMs or at finer granularity
> 
> This new feature is disabled by default, because it changes vsock's
> behavior with network namespaces and could break existing applications.
> It can be enabled with the new 'netns' module parameter of vsock.ko.
> 
> This implementation provides the following behavior:
> - packets received from the host (received by G2H transports) are
>   assigned to the default netns (init_net)
> - packets received from the guest (received by H2G - vhost-vsock) are
>   assigned to the netns of the process that opens /dev/vhost-vsock
>   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
>     - for vmci I need some suggestions, because I don't know how to do
>       and test the same in the vmci driver, for now vmci uses the
>       init_net
> - loopback packets are exchanged only in the same netns


Hey Stefano,

I recently picked up this series and am hoping to help update it / get
it merged to address a known use case. I have some questions and
thoughts (in other parts of this thread) and would love some
suggestions!

I already have a local branch with this updated with skbs and using
/dev/vhost-vsock-netns to opt-in the VM as per the discussion in this
thread.

One question: what is the behavior we expect from guest namespaces?  In
v2, you mentioned prototyping a /dev/vsock ioctl() to define the
namespace for the virtio-vsock device. This would mean only one
namespace could use vsock in the guest? Do we want to make sure that our
design makes it possible to support multiple namespaces in the future if
the use case arrives?

More questions/comments in other parts of this thread.

Thanks!

- Bobby

