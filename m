Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188C25632
	for <virtualization@lists.linux.dev>; Fri,  1 Mar 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318449; cv=none; b=dZDFE/c8AoNN75eRtpeZGyXJWebXngSmDdc6R4Q/ZAF0nx7S1MkK9yK6SFJIN+0KEozpe6pyzMs4Yk0Xfv9OE7OcSkT8T/ZX3K5PA/OMaCNarfo+aAqwm1ftycHn4rvT330peUr46LWYVHt+Op/4P4yisj07BQWGoniqgzR0co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318449; c=relaxed/simple;
	bh=GhGyYeMcg+ZkjHYxc/VcT9ZUA/XQeHgcdI1Kai7omcM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gGW+3e+VQo/OPH7XMDcDjgVlTk6KhKVh3PqhXocY5ftQBCYKNvcS10Hs0j7knuuShZvdVi8htCqPm9hhzibq5ss+1JCTvPzn4jEQI2iWmPXfIB5AvTsYgLVNoTw+2Me5cymi7eoXNZH/u8IXQTYmm4orvVvNXsS0yJbK6trEN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV2GO+Fj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV2GO+Fj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6902947c507so13736626d6.3
        for <virtualization@lists.linux.dev>; Fri, 01 Mar 2024 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709318447; x=1709923247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+DSHj2O6nyP38vAO2Q5xeXvc8PasKQXCBn1/ZiY0e0=;
        b=FV2GO+FjlEuR+kTs2aagU5o2HhSqFLG9gg7wM0YpGQz5/3FQhwohzeMqTrkNqie374
         tbV4YeTCmK8yVqvGsKSd5C66qjw3hJB3QXIsSs9R6QZfeV38XdSHN8Kx//cw0UZ3Nczr
         CJMxzGPib0qHrmzHsV+V6Do/FChtpCfZ+q0eHb1sxI3Q3JGLAdhqUFH2+rGWC0oU9Zec
         QKjUsp1r9PJHIsSFy6VRWazzCM6HNzKEsIoIILnAAdtp0AMuRVl77G6OZo55sv2Xh2mW
         noGgM/q41wBMehzDWdh0bCLn+LSuhYcy9inKyWkZPYmGUu9I1XpJ6JkqQcS2xDWXQgTV
         +pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318447; x=1709923247;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+DSHj2O6nyP38vAO2Q5xeXvc8PasKQXCBn1/ZiY0e0=;
        b=K7q03PlWmOKqtnQhHDnfPEpX6E2OQcwt6FoFe8jHj4I4OYmYQumJMd3GpRp+jFO5nU
         dVQcmbU1M0WyJq1EIszw28eWvx05otnYBVw+TYBrVLMCpKlar1H12ltRr+v9iK7ngFmQ
         MRvWgsHQpU86twdUD5YL6skcms3/Z/fAeqaCamdk3651Z4u2ZvTCLqlUL58RIk/7+RXH
         BTytMrKoIl2VgDoijkA1pLXAPyx1oFJzkVYn0XZ3PEFAhjwZvJ2pZYQOu5u4mj38+bxw
         VlAbMyJA+VHIuNa8CxQ4uEB0Wz89117XnSJzG8lw+tbE5i7ubMeUoZ4VhYDZOTIGbyzi
         x8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUURjWIGG50UqbP+VHpqk0CrDrpkowDjsdzB/NltTVG6jRO2XkHEzLZ4YR3VhSrLu4TAz9dWI3+spyx6EeqgLWFqqXBIjs8h7YE39lRxn4=
X-Gm-Message-State: AOJu0YyxKGGLLA4iNPyM4mR8j69zKNICx+Rp99cqLyTH7J55IyG3U8w5
	OZwXE/Emgf38YiHl50j+nOeP+XsMQO7RBF8SJ+CAxwmUT3i97tP8
X-Google-Smtp-Source: AGHT+IEHn5c+uVkAgjlwPDH96t0yuU+j7oeVXqnt5aR1eMRI0HHontd/eYJbeRcpsU+nl4/66M8uhg==
X-Received: by 2002:a0c:ed30:0:b0:68f:4d2d:3f38 with SMTP id u16-20020a0ced30000000b0068f4d2d3f38mr2632279qvq.46.1709318447133;
        Fri, 01 Mar 2024 10:40:47 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id qp11-20020a056214598b00b0068fef74fdb3sm2137813qvb.59.2024.03.01.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:40:46 -0800 (PST)
Date: Fri, 01 Mar 2024 13:40:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Yunjian Wang <wangyunjian@huawei.com>
Cc: mst@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 jonathan.lemon@gmail.com, 
 davem@davemloft.net, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 xudingke@huawei.com, 
 liwei395@huawei.com
Message-ID: <65e2212e66769_158220294f@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZeHiBm/frFvioIIt@boxer>
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <ZeHiBm/frFvioIIt@boxer>
Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Maciej Fijalkowski wrote:
> On Wed, Feb 28, 2024 at 07:05:56PM +0800, Yunjian Wang wrote:
> > This patch set allows TUN to support the AF_XDP Tx zero-copy feature,
> > which can significantly reduce CPU utilization for XDP programs.
> 
> Why no Rx ZC support though? What will happen if I try rxdrop xdpsock
> against tun with this patch? You clearly allow for that.

This is AF_XDP receive zerocopy, right?

The naming is always confusing with tun, but even though from a tun
PoV this happens on ndo_start_xmit, it is the AF_XDP equivalent to
tun_put_user.

So the implementation is more like other device's Rx ZC.

I would have preferred that name, but I think Jason asked for this
and given tun's weird status, there is something bo said for either.
