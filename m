Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3123A8753
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252532; cv=none; b=kSRGMqMc2CxH7gXgv+jKj8Wd4A0f5VkuK/0AUe+oa409G5Wb+FIXAEL3ZNZIGbpnbnjwH2oAQPELFpe1G/dqiyL5GO/w+K1Q8xDpg50cqvALuoNiXv/0lNMorp/q+BokRnYbPswEbBQk332b2zTcH3L0d3iNVVGJiy0bcK3m8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252532; c=relaxed/simple;
	bh=3pyT+YdpjS2XysUjWOV9STmcUoBSIxn/+89jRe06jnk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EiF517dYQMdMF5aB/sAYKbw12/g2BNusjXGvF8Xfyjxl5KeQiyDZgSVDR84c5K3UriRXYDrIqEXrRk4GSt0JZeFOxYPHCuUeX9hmMwJVodk+aQqI2Z2G/GHCYVRtahGNgWuHu2HKivhXxK9pEf18hm5If/osa/lBQO1ho0TNvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+uNu200; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+uNu200"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7a6e560f580so535778137.1
        for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792252528; x=1792857328; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7HIUZNWScATpZDK2J5WpO4C7vVI8kel4WHjrh6jwWL8=;
        b=D+uNu200VRd1SW410A45LhT/kPmzVqu9ycTOnmCUzfOr9MTdMYF2UfRRKzHf7cTJxe
         Bw8jGAP8TgmHwnaPwIiRzGNyqt18P0ua8fbGe07pnOiAkhdnDPNTYih+sAKWuw5bJBbs
         psFYsp5K1EpZho12FUYAnoAp4aiVZJgTY3L+7Yn1aUA7pIieALDqXq5nL/EPST1DbvQi
         Rfoq65iV/A7sPateHS5zTok4SSRLAcUAKfgbA/CnaqlrAc9or5rt8geoE0YeYQjftlsf
         ni4qa1gNywgAeYT6NS2nl9whT6nLJAXBb6+EqQl+YSC90BhgGN1BX6zfLJEC9BLLWGgW
         SSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792252528; x=1792857328;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HIUZNWScATpZDK2J5WpO4C7vVI8kel4WHjrh6jwWL8=;
        b=cH1yt3Cg1ozMXisCb2PeW+lAFAqKThQ3QVgqZvIONxqZAdnPAjh3N2JpMJ3LIvpBSR
         PpvvX/iSrFseQe2aq+tzxLQxigoREkKUD3+zaBzcwzC8XUZshQxSMuF+rY2b1HOxQO/+
         2ufPKZSSrZp7myXX2EbIcCVkbVUC7TY/Qko7Ec6fmSgYiQXdPow1/gs4QfAQw5doykbb
         rB4JtRBgTp8I9K8v4rEvcJoj+iGGQVeaB5mUljzQ+uqqnEizixrb2rWs5bgmvPNeF+0E
         XmUAqRTb6RuqPIZ0K5F57ovbNB55J8xJ+pZtxmNN/G9FfkQ2+It7dgTkTOyq//hKH2eS
         Cm9g==
X-Forwarded-Encrypted: i=1; AKwUvBzPv00Vjg3AsbjPLWBpyEw9/mj0/T2u0gdk3WKbiTiUpMIkQMMXZVFCNLxw/ZCCjhhOHHxtH14H3O6/13VUFA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8b1uCHiWAnKAmpjqTsOSyB39gdJXmOVJJgXfPZh/tWT7u7QLX
	dyEf0VUul5u8Yu6iq+6fqLrM2o9vp2AhbCnp/f2KpjrshMStms1EFgA3
X-Gm-Gg: AYBFou1WuQafwp2Bonyf3gj0+IslENyVI84Ftycd2KauzWL5WPMysKknRoMTkfk4xUV
	9M5D1M7w1ssEhonmXBI/XS5QpJ3Mx3ePXhBRA/78Yoq8BRy3S0MNhKwnDsSICFH9QwrfCT8BplE
	tZyvW942r5ooPfmEuax5T7Ax3haVSsZD5wzhGs53LLTzQNeBufJ80yKN+/IOJNu0LBOChoE9na1
	ozydC+2IditzEYN9SfHxLjr4PdWyKdQCkY5nLi0F0qf53V2VTwsr9JX1OKbr/jdY1plWezBuNMS
	mNvvXfUTuH/c2Zn2pZiEz6Eo1AYSNfIs9lzUZ6jYd1x3UOQhuQhKRY9gC8KQPX3ThmP7N7Fss8c
	oypOKH269SHYOEyB6R6GC5oLuee4Dh7XSxAVWq1wtggOwQ50CHGYjAtdy0Cp6e0HRVcf96XT+c6
	pmBwJVSo/iHudwOqn/8QwtswnIROrWpDbwlop3RTfec6Ih+YzP0CtYTZBctnzVzLHXndRRB2TEl
	O5uN+clx0WSF/6HAUp5/cqjyZOD9jS0QFxVoE6gAfEKpmyZa8TH6dFNwbQWeOtjdloky4/Wwiju
	oElEG34tS4OulCm9dE9S2XQTNze6TTvkmukfAg==
X-Received: by 2002:a05:6102:441b:b0:7c3:90db:ed50 with SMTP id ada2fe7eead31-7cc369c0e9bmr910776137.17.1792252527694;
        Sat, 17 Oct 2026 08:55:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm492984e0c.2.2026.10.17.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:55:26 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:55:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Megane Hebo <hebomegane@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 mst@redhat.com, 
 virtualization@lists.linux.dev, 
 willemdebruijn.kernel@gmail.com, 
 habte.yibelo@gmail.com, 
 jasowangio@gmail.com, 
 eperezma@redhat.com, 
 xuanzhuo@linux.alibaba.com
Message-ID: <willemdebruijn.kernel.eb0f6ff37e8f@gmail.com>
In-Reply-To: <CAJPVW+nstfbagm9GxQ=i-5J6Xi_aZ52-YiQZeYrzmPD3OmDNiw@mail.gmail.com>
References: <CAJPVW+=XcHDV4aoXt5oAHYh49kX7m5wUxf7TucrcBy+q6MdXFA@mail.gmail.com>
 <CAJPVW+nstfbagm9GxQ=i-5J6Xi_aZ52-YiQZeYrzmPD3OmDNiw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] selftests: net: exercise virtio checksum
 ingress outcomes
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Megane Hebo wrote:
> Correction: Gmail Web rewrote tabs and wrapped some long lines in the
> inline diff I just sent, so that copy is not suitable for applying.
> 
> The attached format-patch file is the authoritative byte-exact patch.
> Sorry for the transport noise.
> 
> SHA256: cd11c3970f0a23ac039cdfcdc6338c20c79dbff3db8fdc93ea53b4b8996437b8

This is not the way to send patches

https://docs.kernel.org/process/submitting-patches.html

More in-depth: with AI it is easy to generate testcases. We now have
to consider which ones are important enough to submit. I think we all
have reproducers for these specific fixes offline. If we had thought
it worthwhile they would have been included in the feature series
itself.

