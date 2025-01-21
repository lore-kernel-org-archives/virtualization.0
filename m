Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF381F3FD8
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470681; cv=none; b=RT7o2Y4awfU1Gb2rhUfwca3+arZ5IgpK6M+nWR5JXaypmQwRboBG3uPtkM69a13M9EArNSVtkBhepwnFVMQxc25IP/zQqKF0lhXHazurhIsJRhbHAAsEM8TEVEbMdGwPRzQGSGJqjqdpCRm0ZSSXYV8udEkXvhd2MNnaYZvApF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470681; c=relaxed/simple;
	bh=dzv8d4QgxaaAASlgBbRSTstXZHFvO/eJVQg5Xx7cZgw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sBRj5FrwuzsCwDCz3vuluM9DS9MLTWAeI9hChsVTTzVB2e48gEH8FoEsw3/ABgDL59rJk/fkaJc9pJXqG+T+nN4bsvmXLd/Umm159XJtTct7qQJzxSyfd1HR0i3Ru7pgeCIrfpea2JcJgvBYeWM9V+y/TjNsO0NfktsxotTgKMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gN/Y55Yg; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gN/Y55Yg"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C850F41783
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 14:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsZTJX-TBAEB for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jan 2025 14:44:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9849641780
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9849641780
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gN/Y55Yg
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9849641780
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 14:44:38 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so206595285a.2
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470677; x=1738075477; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyktx4GLlCScfqAq7gUKHdqOkhKWGMD1Q4f5V2suP8g=;
        b=gN/Y55Yg2PAvVLkoP8t+I1zvIxSUIN3mvpwpS2z2DMDvZmqCnTXofOH9Kv7sDnkbBo
         Gt3PUwC4ywqkD4csEaiOJWel3sfvW3DHXxMYJTBrmzpUimFws+AbRN8+fdD/OVkIq5wL
         u9JAkLIkiKa5A9RWRRUcwdb1kmTzFeKdf0vbLzRyJ2izRaNcnqo4s3pzc8gzo8ieQeQD
         Zt66d6OJ0M0tqCdIiMLnPiQ++Q4nYMJtAk52aj5BkU0NRAz2AwVpY5rTwZdwgXbI5ipY
         fkSM1tsU0GzMEKXgrA/+eLu+TDN4q9j7LbkWwCTXJgJ0AmiymIJd5s5kFV1Bz2bzZz9W
         txDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470677; x=1738075477;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jyktx4GLlCScfqAq7gUKHdqOkhKWGMD1Q4f5V2suP8g=;
        b=PsKCL+KLgQPWmFt2dE44X0CjB4O1coDsLUkSOqKFOGqny+E/EAvwQaHP3Mn/IDmeQg
         ZJ6BTEJApe5IjynTj1KOFxY0hL1AkjCXGXY/unAAWCiNFRNX1g4Rxzpx+Zt0TX+wgy3q
         z15o+3Rf8yuJNML3dOZNfwWO5QEJIJHMx7Yzh/3YBd39LSz2ZBtnbQu7mFRgbzyRkJzp
         p6+diG9lgIqK+62L96JqsZYn7DAfvQHRXNPRLjkMIDeHUHXaU583a0KXC1nam6brMX31
         +8GMfwXS+It5xri2iQpQIVSIeY69p4v1k+RMrgfkTrh/BjnBXfJieZ2/gpNJnt3b3q1R
         T55Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjDzIHTREEn3wrp01VtdmqicLGPLcJ0xJO35ouXRdS2g1YjW/gLVG9QSbIwgDBO289m4IZqPUNAwmycWDHKQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy2fBwspY6E9TXrEwB3QKQzu9pi6dYBqElDoOGrm2Zp+ptwTzCJ
	rAoj+wf98h5vneTO5YlVLQIA8WR5eIpN73qHP1vb4a65k8XDx7VZ
X-Gm-Gg: ASbGnctY2eYx24Xf0O1qCoyj7xI17i6M7CyC4bCDWMt7kP58wXnke4Zk2RHH6S4FSRs
	4V/oqt4iU1MDswUhgGvpVaWKngcqNgOUtBIo6kEAsuDF7xnQN/szf/5B2nJxCyHBH+sYQWl50z3
	NmwI1y8sX/UA6T74/72vaqnF/ZzEpSfdEccUgghbYYICzt/A7bNw2nR+BhCxxEcHsAue0lJfrLc
	vOr+dB8bzpKVQN3YwpFeLPEOHImEe8ZgECvWNShL0qK9KtXN17wrmoyzZ/Pa/O9AKr5D4GWs7bE
	CDPI+2BHdCC0N76hj1pkczkbeqeYUG2xMzfoE1xwuQ==
X-Google-Smtp-Source: AGHT+IHtIG5gIIPDS7Z+0e7uts4N1XZIUfZImZcQSkO2xO7BtbJzbDXJHLc7zxNeNompcCwG5inecg==
X-Received: by 2002:a05:620a:4416:b0:7b6:c4c7:ece6 with SMTP id af79cd13be357-7be6324fc40mr3090213285a.40.1737470677189;
        Tue, 21 Jan 2025 06:44:37 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e258c82a6sm34065981cf.59.2025.01.21.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:44:36 -0800 (PST)
Date: Tue, 21 Jan 2025 09:44:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
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
Message-ID: <678fb2d43a668_23e15a294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <92675e51-cbaf-4905-8cf8-dff741a26db9@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
 <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
 <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
 <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
 <92675e51-cbaf-4905-8cf8-dff741a26db9@daynix.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Akihiko Odaki wrote:
> On 2025/01/20 20:19, Willem de Bruijn wrote:
> > On Mon, Jan 20, 2025 at 1:37=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>
> >> On Fri, Jan 17, 2025 at 6:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>
> >>> On 2025/01/17 18:23, Willem de Bruijn wrote:
> >>>> Akihiko Odaki wrote:
> >>>>> tun and tap implements the same vnet-related features so reuse th=
e code.
> >>>>>
> >>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>> ---
> >>>>>    drivers/net/Kconfig    |   1 +
> >>>>>    drivers/net/Makefile   |   6 +-
> >>>>>    drivers/net/tap.c      | 152 +++++----------------------------=
----------------
> >>>>>    drivers/net/tun_vnet.c |   5 ++
> >>>>>    4 files changed, 24 insertions(+), 140 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >>>>> index 1fd5acdc73c6..c420418473fc 100644
> >>>>> --- a/drivers/net/Kconfig
> >>>>> +++ b/drivers/net/Kconfig
> >>>>> @@ -395,6 +395,7 @@ config TUN
> >>>>>       tristate "Universal TUN/TAP device driver support"
> >>>>>       depends on INET
> >>>>>       select CRC32
> >>>>> +    select TAP
> >>>>>       help
> >>>>>         TUN/TAP provides packet reception and transmission for us=
er space
> >>>>>         programs.  It can be viewed as a simple Point-to-Point or=
 Ethernet
> >>>>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> >>>>> index bb8eb3053772..2275309a97ee 100644
> >>>>> --- a/drivers/net/Makefile
> >>>>> +++ b/drivers/net/Makefile
> >>>>> @@ -29,9 +29,9 @@ obj-y +=3D mdio/
> >>>>>    obj-y +=3D pcs/
> >>>>>    obj-$(CONFIG_RIONET) +=3D rionet.o
> >>>>>    obj-$(CONFIG_NET_TEAM) +=3D team/
> >>>>> -obj-$(CONFIG_TUN) +=3D tun-drv.o
> >>>>> -tun-drv-y :=3D tun.o tun_vnet.o
> >>>>> -obj-$(CONFIG_TAP) +=3D tap.o
> >>>>> +obj-$(CONFIG_TUN) +=3D tun.o
> >>>>
> >>>> Is reversing the previous changes to tun.ko intentional?
> >>>>
> >>>> Perhaps the previous approach with a new CONFIG_TUN_VNET is prefer=
able
> >>>> over this. In particular over making TUN select TAP, a new depende=
ncy.
> >>>
> >>> Jason, you also commented about CONFIG_TUN_VNET for the previous
> >>> version. Do you prefer the old approach, or the new one? (Or if you=
 have
> >>> another idea, please tell me.)
> >>
> >> Ideally, if we can make TUN select TAP that would be better. But the=
re
> >> are some subtle differences in the multi queue implementation. We wi=
ll
> >> end up with some useless code for TUN unless we can unify the multi
> >> queue logic. It might not be worth it to change the TUN's multi queu=
e
> >> logic so having a new file seems to be better.
> > =

> > +1 on deduplicating further. But this series is complex enough. Let's=
 not
> > expand that.
> > =

> > The latest approach with a separate .o file may have some performance=

> > cost by converting likely inlined code into real function calls.
> > Another option is to move it all into tun_vnet.h. That also resolves
> > the Makefile issues.
> =

> I measured the size difference between the latest inlining approaches. =

> The numbers may vary depending on the system configuration of course, =

> but they should be useful for reference.
> =

> The below shows sizes when having a separate module: 106496 bytes in to=
tal
> =

> # lsmod
> Module                  Size  Used by
> tap                    28672  0
> tun                    61440  0
> tun_vnet               16384  2 tun,tap
> =

> The below shows sizes when inlining: 102400 bytes in total
> =

> # lsmod
> Module                  Size  Used by
> tap                    32768  0
> tun                    69632  0
> =

> So having a separate module costs 4096 bytes more.
> =

> These two approaches should have similar tendency for run-time and =

> compile-time performance; the code is so trivial that the overhead of =

> having one additional module is dominant.

The concern raised was not about object size, but about inlined vs
true calls in the hot path.
 =

> The only downside of having all in tun_vnet.h is that it will expose it=
s =

> internal macros and functions, which I think tolerable.

As long as only included by tun.c and tap.c, I think that's okay.
The slow path code (ioctl) could remain in a .c file. But it's
simpler to just have the header file.
