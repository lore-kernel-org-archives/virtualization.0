Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522239;
	b=e18OmLIs3q7GqLHnW6AmbcyZZ6z0bl7sYIxNiZotOA2DPAiGB/V4i57h/fjsfz6mJyUM
	 2KjJvPSbehTPSSZCJOL6HnO9fIIQwSoEUfU7meoMPPUWrb1/uS15vcfBRqxJkxRTMO5pB
	 NeUEWfInbg4p8v3WbbtMOgFGpaQDxeH9MLIg85gER7O3xOrFAw0QKmdtf5EAR9CpTclko
	 4YJOLSaBHrElP+iVYXnXZEv2CnIQ4B8aKcGpV/qDnCq58tjmrmgY14hLSWr8iMdWfvQw7
	 ROEPXJKA59PHQMiJuitSLlBongTY6eKnD3SFy0A7VHxDkEw0x+/LltHdCw70nBuFAQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TNtaF0DLgYxwre8UJL5XaZV5dHuYhll67t5b/hqMCng=;
	b=uwou4N5VmDmsyFpoe9wsKZHl/katz3eZcuaakwy9MdD/tm9NmWudT3wyTrjsyjgEAovM
	 MnDy3hihP1xEzUWYSLpagJP3rsKWD/6G2V0Pb/E4Xvuy7741nqEs3Y2UgObNz8KhkV0IA
	 C+ffXBurLoQEP4rJardZHiLwr77KVnG9eTviCr/HNAE6JFM2j270J5DcsLEHvmnmKHGLr
	 KximSxVhKMc1+q3xO7RiVysbWiD/d/2ZWQvuh6gYFs0P9PtrbdN1gP/ZCUV7o/BDS7GG3
	 DrWsi2+A/sVlaoMt5iwFwxeiDUOf4Dh8M7K9ERjJz8pY83qf6/l7lTEkzfGDjJWpmYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BeUHGopn;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFB606A31E
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3FFB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BeUHGopn
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-451a49abd8aso4478526fac.3
        for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 04:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795522237; x=1796127037; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNtaF0DLgYxwre8UJL5XaZV5dHuYhll67t5b/hqMCng=;
        b=BeUHGopn3iG62mYrkqMCVGCtZTgNiRPSC64Xx2LGF+5/hgjf3x4q+Qb+Ad1gsGfgPU
         XzKQZnGQoAO8zPnZiRgsj0F5zzeCbamTRqaleONLmjH20CcjMjxT6mbknnzqlp/8F3cZ
         JdtsmzU/uiYMp/MKD7AG0wN+7G08uvN8+hSQhY/ftekJDJlifs6LQLKJ2sXrcww202L1
         qibUiSW6bfO+bRJNad5wDlnn/gKTLE3dL4jhYK7nhhzQJXd2jcsbFGMx3WZgMQmyb8aA
         6eHcb6wcpepoEV4tMoz+B/JxZG9Ambx1xekoxdaxs5J0zADCQ+JU3yKTkXPqyU6SQxZm
         972g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522237; x=1796127037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TNtaF0DLgYxwre8UJL5XaZV5dHuYhll67t5b/hqMCng=;
        b=f+IKbunK57lMrZWgL7t8d4S9wZvQmyK45rnXuQi2z0f7OB0ZyyODwxYotwflM4zbh4
         wlgv3hzZeqR/r0NPipe67gwc11vnbgpI8HyKjBzfNQba8c2vMXWKC9OQg1SIc0FsTQlh
         eViNNFLO2ICY33MuwwauvvDgyxy3AlcFpfDQwjjR6fSx9rIUXMvVw80j7ACDOxTnsFMz
         N5WFIKwzl4VO+DZI3jFRlg9oGcqvE5yxSbzP8B7mE5CXty7se5+4heH4JQZXEA923k/1
         /jlEMT0Ia7dFlW1FnzyA99SG6CtbigfYReSa9hlbd7y7+HOElAQQUM0cIQmPdMCwKayV
         vOhQ==
X-Forwarded-Encrypted: i=1; AL+hErEFN5QKvr+Pb6X/LTz1n2zOhWmeg1V4FhoIt8HgB5Ul/+AHvOCTIGLXUMYNg0gHp1fVepI/xNs9fQ39bpyIEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z81xsfpukYSr2oigIOLty5hehvsIUOKFKgmTADXG8iBu25ze144
	U/7X2pym60la5ovYaTw5Y+1aAaCSdXAIzB/svXBWlfTABdROfC3acWDKq9N63wpbknc=
X-Gm-Gg: AZFdTZdUQIcf6HnslY+9GP53sU7lqT5yGTfhKdfAQ6LvWz6HjDhowH1+M4mENSCdOWB
	F/nL+ISOV89MwJdVfe+ueo8oEyA4EOBimdj8xz1dRdK2f8t/gMS3QGj/oZg3gzjqvSQYSHTbP0u
	Ev9FJFqKRPHiELYCriqB5hdufJFwB8Sx8IuCVizQix3GY9h4VMTtxx3/NqSMlbXBFnY8A7WAWt0
	KWtSavQyAAZm1ShCvoqRNLk5HWegwwCDgMWhvlbFVlJ3XFg+C3OOyiRnsG6FGEZKFTyJ7AN/e5V
	Zx5mH10Tgpfiev//E4MtLPLeo6Gef5TMUrC0oDBQ7NET/nfBZE3nvDYeO70uyWeH5rSYRVz3tA1
	5LZpaOxKCxznzAmWxaC/6I/HZApx7eqvD5oKa7mJIlU4jWWcdIj/KXVCD9A94I1dsgv5TDucYok
	j1ItkDyvjvoF/+8lUA/+ZnmBrrOKFPBSjH8L5IY7SoSYscmL8YtcFeFG+a59qDv9j8lDpEOA8vw
	/E8BUgiOlOo+rQUqEjTyrMrHVE10dnleXLMu5gcLACpeKaSXFXxspij8SaFnPD+761pfqO7Ilw5
	Q055Er9hSSbrhA5smnh3srw=
X-Received: by 2002:a05:6870:e08e:b0:48f:e0e5:a1f8 with SMTP id 586e51a60fabf-4bc8492648bmr14119241fac.44.1795522237361;
        Tue, 24 Nov 2026 04:10:37 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm15053309fac.3.2026.11.24.04.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:10:36 -0800 (PST)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Kyle McMartin <jkkm@meta.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] virtio_pci: limit Oracle DSC2-200 virtio-net to 48-bit DMA
Date: Tue, 24 Nov 2026 04:10:30 -0800
Message-ID: <20261124121030.38490-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261121063742-mutt-send-email-mst@kernel.org>
References: <20261109184253.531677-1-vlad.wing@gmail.com> <20261119200654.1048266-1-vlad.wing@gmail.com> <20261119181557-mutt-send-email-mst@kernel.org> <20261120171435.83458-1-jonah.palmer@oracle.com> <20261120123500-mutt-send-email-mst@kernel.org> <b8ff5bab-d08f-42b8-9c88-e4665ea3078c@oracle.com> <20261121063742-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael, Si-Wei, Jonah,

Michael, please keep the quirk in your tree. A firmware fix only
helps the hosts that receive it. Hosts on today's firmware, including
those booting stable kernels, need the quirk until their firmware is
updated.

Yes to 51 bits, given Jonah's testing. I will send a v2 with 51 bits
to replace the version in your tree.

Jonah, Si-Wei: will the fixed firmware be visible from the PCI side,
for example as a new revision ID or subsystem device ID? If so, a
follow-up can limit the quirk to the old firmware and give fixed
devices the full mask.

Thanks,
Vlad
