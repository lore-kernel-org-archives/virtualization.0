Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379F217656
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426781; cv=none; b=F2L0fyq6lcejLS8DKSK/kYqX29kKKyKJKsxNZi4yEPOPT0AOGke+NT31/DPsrMgAzuWK2100MGi3DtUO9Ocdif4g1jQXKkYrmkk2KFDQLp2nxeMz1EziPXjX7OhfltJK7Ho+B3MT/CqGGE2RuobWyvL2ezClgLjcJhROamnsuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426781; c=relaxed/simple;
	bh=nOOZA+iN0ga0CTphyM/C05+qgOczZ68TEd0WLotUewg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CtYTxXCgW1gyYRz8YQ7m3gwrc4UD2hy8qAb+jpsyrce3buNxdVA6CegxxMwHCIing5U4cqov9cYkeaVgOh/A8rRs+Us4+yPOlZjub+xq74Art52EXa7Zw58Qmt58wqSsl2IJY0lSJQqn9VWLZQswews65eFQkkLua2TKUgA0/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPfGwjJ1; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPfGwjJ1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7DC6F40F0F
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 12:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4wwjqsAj5Do for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 12:46:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 711C940F03
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 711C940F03
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OPfGwjJ1
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 711C940F03
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 12:46:18 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7b6ea711805so93420785a.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 04:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736426777; x=1737031577; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaPMLCUZXOj8V/TsoKhneA/pbfWV2N1nHu6od460Xzw=;
        b=OPfGwjJ1sCpGC3vzAoC0kQUciUSA65invGouNN4ee1TDmp9d9oXWnIEDXUZAMWXVRW
         3kun3t1exa68zddch7nA/FB2NEPwwINWtBztvSM7ulZsjBGooP2VISSY6TXuXDmSKDOF
         WwjZm7tYDjFUnZB8qRK6tJshRYonLPnjs4zBi8185FyDHo0ci3GsbTSBpavIiRgtFTmy
         yt3gvMLC4Zbd4qIWH8mVK+ppwb27NxvzPIKv9KDTOKdnL0cI/ICW7lL+UM8BG5oT9oaJ
         RrgmM2FfbK+1ZYV5aVi2LeW8AP+11PXXryn7CM69jbgqrvxT6izDvd4dIEcsygj4QAWH
         tYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736426777; x=1737031577;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kaPMLCUZXOj8V/TsoKhneA/pbfWV2N1nHu6od460Xzw=;
        b=Zjp5A7BdbpgmTWRv61dPIn8cmQGBTDmlDHECCGJFr7pNn0XFgZJFnlWoxApeC2mLO2
         +AI2AJLHeA/5PP5SDzC+TlbFZSOoWLdVMBNXKdS9koe3FO8wpg/qHSJvY5cm75ta1DoV
         abtmsnPpacv4Fsapk1OQAiGEuG7GBMbzvSUh/Fnhmg/1JQSlF4dFlnvXjlugOFaxSFSR
         WoTyf0QCFVzzxWIUPlx8vieci3cLvft6BI8lXC4EAlyRSmvznl5Ik7LSgxXR6ffzdG2T
         t0f07KJcKDS7tVjtERYjzDV0vw50UnmV9dhN56lfukXPjOH1UkSt8vgvmBFIj77Vu7hk
         pwNw==
X-Forwarded-Encrypted: i=1; AJvYcCX9+rxr62E7IA45gT973Ecm68N1EGBX1rWasi0/w5L6NwOI49xd7HqFvTKXh2zsPU6amst3rXWBgdYmypmYNA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yxt3LCPQul9u9o4ywjgWLaxm5mVXm6OS+bFWQfKjm03C2JtUE2x
	1vc6L+md8HbwnmtJWp7DR1z5lfczPXz8IJhlBewd+MuyFjujjV7J
X-Gm-Gg: ASbGnctd2eaipR4HkipSxlq5pXD6u1mYKHFqnYJHrOynAuEpqYzpFsKlKJ/iJ5OxW0w
	wdVWIzX5I5K/QVp0ufF98vZiGFbrh1Rl+UIfgJKlGb9mBpthM+S2ieomR5j5wP0Lojh6fu2O0VL
	vA7ujVeDSVMIh7ueC2MQbLQC7+mmzdivK+VHMl1xV41WB3wOTDV787FrB0N9oayb8Of9vptlJ1s
	eA5cDlP7sVAoLYtqlduQknxIvodModYspB7ooLemqjhJDUCCyqmVfq1cDsKmbxX1wb8uhsnLZrN
	Q/JpDRoXfayGvtjs0foFb7ttKBeM
X-Google-Smtp-Source: AGHT+IElltpq0Se5BPymgSR44p/+E1b35WmaB/SUjKp4ksNe7YwiYRSh+K5j9T3I6qKRunWydJbAbg==
X-Received: by 2002:a05:620a:444f:b0:7b6:f1be:4f7e with SMTP id af79cd13be357-7bcd9755084mr912637385a.26.1736426777023;
        Thu, 09 Jan 2025 04:46:17 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516068sm62500685a.100.2025.01.09.04.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 04:46:16 -0800 (PST)
Date: Thu, 09 Jan 2025 07:46:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
In-Reply-To: <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> >> tun used to simply advance iov_iter when it needs to pad virtio header,
> >> which leaves the garbage in the buffer as is. This is especially
> >> problematic when tun starts to allow enabling the hash reporting
> >> feature; even if the feature is enabled, the packet may lack a hash
> >> value and may contain a hole in the virtio header because the packet
> >> arrived before the feature gets enabled or does not contain the
> >> header fields to be hashed. If the hole is not filled with zero, it is
> >> impossible to tell if the packet lacks a hash value.

Zero is a valid hash value, so cannot be used as an indication that
hashing is inactive.

> >> In theory, a user of tun can fill the buffer with zero before calling
> >> read() to avoid such a problem, but leaving the garbage in the buffer is
> >> awkward anyway so fill the buffer in tun.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > But if the user did it, you have just overwritten his value,
> > did you not?
> 
> Yes. but that means the user expects some part of buffer is not filled 
> after read() or recvmsg(). I'm a bit worried that not filling the buffer 
> may break assumptions others (especially the filesystem and socket 
> infrastructures in the kernel) may have.

If this is user memory that is ignored by the kernel, just reflected
back, then there is no need in general to zero it. There are many such
instances, also in msg_control.

If not zeroing leads to ambiguity with the new feature, that would be
a reason to add it -- it is always safe to do so.
 
> If we are really confident that it will not cause problems, this 
> behavior can be opt-in based on a flag or we can just write some 
> documentation warning userspace programmers to initialize the buffer.
