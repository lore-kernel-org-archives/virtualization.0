Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EB3F65EE
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779729285; cv=none; b=OPFumpyJU7RLEWG+rRwMVkDXhgbop9z3Ni56Zq8GxZ/B+Re8U9OquyPzyc7JIH/p/hzuryMf/3WP5VPPjMKIV/xGbax0Ki33LBFq4mfgtacQ3udnbW9TC9VMv8rF3uMeRY0OduFhN+muQ44wz+BoQa3/6wDcpGUSqjw1DlLUKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779729285; c=relaxed/simple;
	bh=2sV4pz6YR0OYuF0/R7iMTf2Mnfa/i7KDjcdfesmU1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2YaWVzr57Qu0nnO0hVVH030E6Z0r73lltGn7SGoVomElyPqAC12REHV02NiLpjcLUIG0Q2lUnHSXaBt0rV47UKTYSj9SKYDlZnlbPUEYOMLozTgDNY/RbsKygHasM2Jqug+eaZ949Mq/ar9rt6VhWMMlbdnDOGo38WVDTSYCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ4C8i5C; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ4C8i5C"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45297094718so7594316f8f.3
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779729282; x=1780334082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBpakHiyp2Ixi6ETxg8xxyuYG4nYq7ywoAzoB8P6KoU=;
        b=GZ4C8i5CRV4tUV6TTlFfo2/Wu5MI2LTwjxAWFXthRCPCteBU3T0O/u0tuOZ/t+ngeM
         A1CbfWK02gLAdNfvYjhkNnyfQznjnQ5AJgGWVidKBTS8OAZg7MGnaeKGgELPkxoxXZwD
         i5YSnZi2gyPiqwfRGWPY+vSWf5sCGy5aksYpYqFzsF3UYMwE9fcsynbqpBRV5HqvR/hB
         GaojbhDQJ2HD9bW5V81WC3tkNFHOpL5pl4byWfMWQmmARYNvZ/jf2fKW2hqxWGYAbxV4
         doWpQ+p0l5tMgjgiZgvHmgqDkJuQBADGOdMJd0PuAWjEeof1F+92FiZezGvQcChY0lVR
         PGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779729282; x=1780334082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBpakHiyp2Ixi6ETxg8xxyuYG4nYq7ywoAzoB8P6KoU=;
        b=FtJ/MF+JTAS54mGJVzBzVgTByBlxWb12ogUtnR7hF7AtT53I6o0A5W6F5dZTt66fB6
         SQQx9SyVCSu9Pf+6x8uWaP6jzc7xauiNBPwXBXCJpeR1NXIAq+FvrZQN9eDuznPU4xmS
         iAwbAK3fqSplaQPfidIPNasBy+AioRExxJI9cZvuKIKAuazCsd/IW4f8jk3FxoWkH94z
         VTDNRt709dkKuLGjThPFEhl5fHLqb5jf18G9+/exdEjsagevQ2lmSgIzPux05w2y4AKS
         BvDYEEQg5fjLtBl8jEvhdd6rUgOfWRQEQ92ZGD8lGNvOcEcqIwtwv86+kuPxkdXwu0Pm
         KWNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bMoBkRpb5ZNG+wxV3/M3/3iVdijdT+PIrRYOefjRQSrFa17z7pJPDob5F2OzuvqTcnDH5dhb89s1665tNxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0TSS4kONdJCmlJA3nOs1Q2y4Woz45noD+LfdmM/p3fGSx95xp
	IDRh+c3byWBTBhT3DQOVuZSmU6QwPuniL59u384o196fVzdT6YmK/qSH
X-Gm-Gg: Acq92OFZyd5LunEVa9y5I8a9QrktQHq8H/vR48IKJ6NMnbmf9OZvBB86nKftIa6GeK6
	E0Irvjl1oK5TVDkjdPCUWASODDa5Rv0NgxZW/eDitukpLc08Q5wohK1h4VuZQeOCYGBVFmQ2414
	TP26eunZsBhAejbAyzotvb7EZE0VAzhq6BE3G/6gAd+5o8Q4JFSkiyRvX72kE0ZAY9S9PXiwUgW
	Ri2pzvdp2G6eeQ+9rb5ISLuHR0gHjAEU2CwcjlBIBwZVo2cCOSV6lw/6SEboE1TXD2e9TKe5NUZ
	b/U+WSpCLJDYDFSVHL0mXjX3O2DPNDxwNKs+UyNDeygFoDbfD52WWsSI060KmiVudaAlcOoVcSd
	7kmlOzfDONKfQn2raHzJy2Ddmy24Fj3xE6ECzOes1iPzszSaBtf+3aUwRRGsbdssenUhrXyHuKa
	dRK9D/GkJSLyhoVaR9LYnY2IN/8tMUgBB1DllNAoJKJTVOef3xpkiXJxXsCWhOFd4e
X-Received: by 2002:a05:6000:4606:b0:45e:8727:be87 with SMTP id ffacd0b85a97d-45eb36aa72amr24711421f8f.15.1779729282272;
        Mon, 25 May 2026 10:14:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d7167dsm28840763f8f.35.2026.05.25.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 10:14:41 -0700 (PDT)
Date: Mon, 25 May 2026 18:14:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, davem@davemloft.net, jasowang@redhat.com,
 stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525181440.5a6cdb43@pumpkin>
In-Reply-To: <ahRmBTnNMrg-oano@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
	<20260525115314.3cf310e6@pumpkin>
	<20260525083859-mutt-send-email-mst@kernel.org>
	<ahRJS2bN9Bw_AKyo@sgarzare-redhat>
	<20260525155322.240fbd87@pumpkin>
	<ahRmBTnNMrg-oano@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 17:16:18 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, May 25, 2026 at 03:53:22PM +0100, David Laight wrote:
> >On Mon, 25 May 2026 15:09:54 +0200
> >Stefano Garzarella <sgarzare@redhat.com> wrote:
...
> >> >Indeed, I wasn't thinking. For this to even get close to overflowing
> >> >we'd have to have almost all of 4G available to the 32 bit kernel taken
> >> >up by this single queue.  
> >
> >Except there is usually only 1G or 2G available to the kernel.
> >And all the skb would have to contain no data.  
> 
> `skb_overhead` was introduced to prevent exactly queueing skb without 
> any data (essentially containing just the EOM for SEQPACKET) that we 
> plan to fix properly in some other way instead of queueing empty skb.

I think most of the network code counts skb->truesize so that it limits
kernel memory on the queue rather than the amount of data.

This does rather rely on the low level code setting it to a sane value.
Last time I looked some of the usbnet drivers lied badly.
(IIRC short packets in a 64k buffer with the truesize set to the data length.)

You need to do something to limit the number of single (or even zero) byte
SEQPACKET messages that can be queued.

-- David
