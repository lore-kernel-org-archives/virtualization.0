Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF028E3E
	for <virtualization@lists.linux.dev>; Mon, 27 Nov 2023 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoCvHwdX"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso5905079a12.1
        for <virtualization@lists.linux.dev>; Mon, 27 Nov 2023 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701096879; x=1701701679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKtyx+UMuR8/33vOi2Ysy2TZL9FV3DMoqu+lFty52DE=;
        b=hoCvHwdX8qArtoKYjfgSg0l/PDgphbL/x+obICB/f5ujCfNfVM+ggga/hpeiwnu6KJ
         K9t+5misuZPVotalpHJ/tb4a8Yvo5Rye0G8qERvysiWcMkLhkA2M04EzeK8C1q5Gmcrk
         hh6ClSTdP8NLM6Zt7BBLSPpySouGrTegzsXnyuXA/N2CliD/z51KnkVxFeK4l50p804h
         qvC6Cu3tcZef/X0s1dI0gZ1yzanqFYf1nwKE5i4wylP1to8Tl7lphP5q5HKSzD6pLRi5
         H+fd88ueskz+lKZxm3k4v+00cRyxYYVF3vwW/Zz0jIDLgpCYES4w1qoqTEksfb/NpVZo
         aTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096879; x=1701701679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKtyx+UMuR8/33vOi2Ysy2TZL9FV3DMoqu+lFty52DE=;
        b=fTBB8C/PSWGCMb143CYDLVms2Wk+M71DJauY3sjz4oxY7+yzxCEYbDJ5RiT/ElAmCN
         p5hu/3ExnBXfbEKincgs3l8BAuhX0dHC2+Z1PIWumHmdPlJ9tUf6ggGxTxrEFzPDalwz
         jJfL0VsGQVlLfiXGCiv1A6LxJW/OY9NteYBXcyS+sMl4PAhtjYdGa4eyEhU1tFMPpnKi
         UdZKveQtHI+OSg/FV8Hc60KrYfo+fOi93kixspkiyOsOT+/jJfUY4bzAPdaw6qzE20Fu
         biaRlLN9mE0Qm+cSMzbrMnWa0stQlwQQDPGHA5PC8KKsxmwUq/j+GiOXPqini0ii0qc9
         AP9A==
X-Gm-Message-State: AOJu0YyTRxVt3tEBGRhbEKLxyo1wD6jn6Dd5MmXrbjR4IixJTBhTdWk7
	9AnaSkASzmqrlpurPaLWbPE=
X-Google-Smtp-Source: AGHT+IHVEZfCfaD/cpM2uQc6CXbmyZRdVVIlu3vcaSF26lgLfvjs55eOZX8pqw2IBlAtYb9Lq5pZtA==
X-Received: by 2002:a17:906:130a:b0:a0e:e58:42fb with SMTP id w10-20020a170906130a00b00a0e0e5842fbmr3415840ejb.14.1701096879392;
        Mon, 27 Nov 2023 06:54:39 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:158f:ed00:5d13:a893:4139:6a08])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906074d00b00a0c3b122a1esm2888763ejb.63.2023.11.27.06.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:54:38 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To: jani.nikula@linux.intel.com,
	kherbst@redhat.com,
	dakr@redhat.com,
	zackr@vmware.com,
	marek.olsak@amd.com,
	linux-graphics-maintainer@vmware.com,
	amd-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: TTM improvement and amdgpu fix
Date: Mon, 27 Nov 2023 15:54:35 +0100
Message-Id: <20231127145437.15060-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi guys,

TTM has a feature which allows to specify placements for normal operation as well as when all domains are "busy" and don't have free space.

Not very widely used since it was a bit inflexible and required making multiple placement lists. Replace the multiple lists with flags and start to use this in amdgpu as well.

As future improvement we should probably re-work was "busy" means for a domain as well.

Please comment and/or test.

Thanks,
Christian.


