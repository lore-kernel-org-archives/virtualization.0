Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D46A472537
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266559; cv=none; b=YroaKfjnKatPrNdRqbDccE/RslWTpxIQoMgqDKZA9E6RVA4CyOve1DYaL0nOXdUSrTV35FwCvd2veCiFPBTlMR67FbLUwuNhzIgqmkAaW7/gDljhBfJNz0bPSXXZ1E4GODAAU3gpmFM1kC3wPy0aZg+PhCMQSG88YrQ4tM0+67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266559; c=relaxed/simple;
	bh=R+zgHjbzWHNJAJSiByZoxeBoJx0H4D0oao8AmHjSzv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Dv99GqCbZkOhRAo8/q0d8fJ8to6K1x9YvygOLYXgU/3X4ZP/lROa+rZ0dtqjU/g1MUccf5D0LaEWd7xScA2ihcRFj3lYF18CtPPoWhen+kKdi9Is1QAVnjnuhI37lKts5s1AOTmdxjvGPTu0LOv2PVIiapT57XgkQPWgzAksiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrQQ97e6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrQQ97e6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785266556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xHDeYJjbxDxQ0a8+BXenwk1PFl2CLayk3cj54C+//40=;
	b=SrQQ97e6h1+Sp57uTqEyv1zCyMtyezXtXqu/3ULcxx0Ku29IUaC3cWmaMQF4TWHdcOSs1G
	iMaCQ/5OReRBWUo0xVAtHNnxA/dlTRwhmOZfopIT/52TwhhuEO+jZFMWLSHmX3QC2A5Uc7
	K1pAm+L3nE5GxNaDR9KIdB9GRa7/T4M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-PvTttpwFMnWmO-KhghKY0A-1; Tue, 28 Jul 2026 15:22:33 -0400
X-MC-Unique: PvTttpwFMnWmO-KhghKY0A-1
X-Mimecast-MFC-AGG-ID: PvTttpwFMnWmO-KhghKY0A_1785266552
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955b84e25eso1156905e9.1
        for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 12:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266552; x=1785871352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHDeYJjbxDxQ0a8+BXenwk1PFl2CLayk3cj54C+//40=;
        b=DY9WxQx14fcpjNcdCD7dXu9Cz0os2fP6ToVqc/6oYXJNCOHwC98YtpHWLf0cAhAiqc
         Y4QZwNdJCUzWD/NlxV+H+Orb0Zjnhvg4yxDceGTu49dOTID43Ht0KcjI/Nlj2/VeGw6u
         Fa1AoR99lUC+EHoowpUdWGam2YyJivdcinnPhnTueutpviePZ9bMZ6eBKeJtu2rlVWqM
         MRoGrpyOuQ8QejWx68v3TuGMjF5H7u2puYZQBCd+kX7JCEgIw1dJXOyVt8keTb8G3zZC
         OTaY6CLU/HE8jQedWTFZqzv8ZOo9CVlNfSqrL2dIRWuJMhI71Tzy4c8pSXvPN+jBMy/P
         R+/A==
X-Forwarded-Encrypted: i=1; AHgh+RqS+07xRHGLwGvO5uEwJm9X684b5j91z2cmHUIQxOp8Noot0vMeUyFKKkC1GeWQnlWBOcuODNdXupUgu2G25Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeWTs3++/GH0XOO3siiyv6SOt7hu0MwW5wrOggdJhb/Rj3qSSX
	DtAY5/TN+lzJ77D99RJwa+QMBa0Xn07t7GNjacjbrwTS7g0nZyB+ivy0kVHBbAogBnPR7KFkZKM
	wXEm0lQnk4E4fVSEYcVysNMm4JRFEO77Ip0uRTv2wg9lECPeys5MPukyVHGt1l/NM+CnD
X-Gm-Gg: AR+sD13bYu/ABAB4rPxVCOATFsY1C+ujypIauW6EctV/K0wuztFPh8ODP63QncSqUJL
	F8jRnG3O3F49mdlcYQLKbegLrnVZRgkvm/ytjJilLWwwljNYu/LcM2VGMlm1ke50O8ndpaVZLoh
	YztE5qC6+oihHEEQ5PO9Hch6YpCmr5GSZ3HluKoT3aBnqIQ010gVaVgK2aw1Im3KHcQra7Q6SZS
	BthaQOBAoZKpBjcb+/kPU3J34uKeE2sOxwcstywwz5Wnpt6Zl0dBl3sXsEmx4mhlcYcX/hkTNxW
	X6yGQkGhQHG6lTv4jWD4oiGSUaWG35JuYMwPn6p1DFy2p7X82EclR+7MZWuK9BjfFdx2hN98CKo
	fzKQY4LdQRs97B90KAYd2UcI=
X-Received: by 2002:a05:600c:1c1a:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-496c60c1c4dmr38408275e9.0.1785266551664;
        Tue, 28 Jul 2026 12:22:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1a:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-496c60c1c4dmr38407915e9.0.1785266551088;
        Tue, 28 Jul 2026 12:22:31 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44afaecsm112946795e9.2.2026.07.28.12.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:22:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:22:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] Revert "tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops"
Message-ID: <20260728152204-mutt-send-email-mst@kernel.org>
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JLmz2UpeMZvKDMWSlQLbFS7cfSOyPE4paMOKis1jgHI_1785266552
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 28, 2026 at 11:22:36AM +0200, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when
> a qdisc is present") did not show a relevant performance regression in my
> testing, but on Brett Sheffield's librecast testbed it causes a
> significant throughput drop in an IPv6 multicast testcase. The regression
> can be pinpointed to multiple iperf3 TCP threads sending: for 8 threads
> the throughput dropped from 13.5 Gbit/s to 9.13 Gbit/s.
> 
> Therefore this series reverts the qdisc backpressure work.
> 
> Making the backpressure opt-in via a new IFF_BACKPRESSURE flag was
> proposed in [1], but a new IFF_* flag needs more review scrutiny than is
> available at the moment, so a revert was requested instead. The opt-in
> will be resubmitted for net-next later.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


Thanks!

> [1] Link: https://lore.kernel.org/netdev/20260709095511.168235-1-simon.schippers@tu-dortmund.de/
> 
> Reported-by: Brett Sheffield <brett@librecast.net>
> Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
> 
> Simon Schippers (4):
>   Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is
>     present"
>   Revert "ptr_ring: move free-space check into separate helper"
>   Revert "vhost-net: wake queue of tun/tap after ptr_ring consume"
>   Revert "tun/tap: add ptr_ring consume helper with netdev queue wakeup"
> 
>  drivers/net/tun.c        | 109 +++------------------------------------
>  drivers/vhost/net.c      |  21 +++-----
>  include/linux/if_tun.h   |   3 --
>  include/linux/ptr_ring.h |  20 +------
>  4 files changed, 14 insertions(+), 139 deletions(-)
> 
> 
> base-commit: b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
> -- 
> 2.43.0

