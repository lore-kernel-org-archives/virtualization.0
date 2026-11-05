Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860623;
	b=H1wBZvM2V+AUDYtsnD3UwmwTbh/6wnagnTuGmp7GBXQ+6DUbjWsxZzULhR45bJORQntb
	 03413dvb7gHssvkILYN603O5i/37fk6XBElg1oYAkexUPo0UVCd1byV2cRCvZU+ksMx8t
	 SLnxtIA8uMQyUJoWU/EQgnjPFjbZWBVG6tcvMju2AE0kQzq6jihUJZdmIYkII/Ertvyxf
	 DY0m9VCsNjZgQvn4Ffc56FgsidITPgvv/41z8vDRZNQ/S1uS/1drmeFUX7uXUI3wWF5PR
	 2SIiXWU5ITKRYcCj7TRF4AdQWEGUevgvNmnoiPM35Qkuj3V67uJNcrhfFvB0zYsMpwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V9c4JR1l1BlqJLMhXPHekxlcKPXrrtwIQDnuHY/ovTQ=;
	b=F9BhXmVMzuPxH75r06H4TKEGe9HX9+pJYZy84WxsD3o+ITpEa/2mKBbFdlYdCMzF3ah+
	 9QmvOdxCCDqJ2iCDbvLhtCfvLKD2E3UIUsNsrn/FgZpQ91JGWM/YJyTtil8XB77NPZ6MY
	 18do17oXsM+bQrJz/hr42LAMMusHDCBiIGw51D3fAdo0nQXPitxBolatAkXGSEqzbht19
	 wpyCLBleMN4AWMOS1DFeNKoYCxb9KokKCmlcI84F2FkJfNocZ5hkzY31XXe1Jv823mEXa
	 1GH20cRgzDfTZfLyOWvn9D7wHSS9ZG54qN44dAcLn1uI9i5ImZonEwTyrSgTu9P9WTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVu7qavQ;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E2606A329
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 06:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D14E2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVu7qavQ
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so2944472eec.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 22:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793860622; x=1794465422; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9c4JR1l1BlqJLMhXPHekxlcKPXrrtwIQDnuHY/ovTQ=;
        b=nVu7qavQe4gkiJXLQ2cVHqM0ifmeCaTP6HheD1aD4a27G78InBzJlwPJBUFXz7obSk
         25y1oKLMZNWrJflqf27YgSPyr8sj+Ijrz38J0TDrVilsiFMCULBkxrLnAVLBDP1V0teI
         3H1JgyGu/MYNkF5If/jkQ5WTDrYwmQdPt1aNgcFyK7L0G7PcERat/H+Sts1N7bSH5atb
         WAfEXNS0lixJSVhD7EkKKGS46Zy8eb+iT0+Nr3OxiYpyZgLNFAsBL9YyFPZLTGAyKRWz
         1lTmEP6p1NtSDkAewzJ335fp14OzN038TjMJMLK92J5SZs4VH4xrT4nU3feesHlNkNie
         4PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793860622; x=1794465422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9c4JR1l1BlqJLMhXPHekxlcKPXrrtwIQDnuHY/ovTQ=;
        b=tCuW2iiLQKCl+JFsjQMvu/bYI89MNX6YgAG3Mcg3ZVFfqDWO+QOwAkgvstrWCAlMxX
         m+w/aSKn4jvvUWwIuueKfeAi8y1/9EDBOeKVW/Y/4h7/nTD21DzPmrl/Egls7sdbefuT
         bsdTpfuPa1srs4LY4pHP0umvhv5wvGSpNwaCcM0vRfSGUUFwA87V26EAv/g92jQw76zJ
         6D9fk67Y3l9rJ36HdiIWfhKKBNAhWZdgKIAMtbaCN3gCdcODDCRtl+xpsU3oabkP5wq5
         thjWk3Na8B0Kltbl/GomvoTayvzMYg8YKgzOJzoWwK2/INmRuuN3NntVZU6T7XLJUBma
         zq+Q==
X-Gm-Message-State: APuU4Z+U1nDMZqsPnTTkLum5dVUhdcg470g9wagvqoQVCp1zVy/DQ/f7
	pEDmP/p8C12CXnlpP6JedWDL2aPVifEYpWObDC11V8VZ0tk+F/07zUQl
X-Gm-Gg: AYBFou3lmNqNPQ66tkmEMY+7zJTpWrDEfeBwrAvLghqFRuAcGKLGcjUUhb3dlh8PdSj
	fSUEv0hmBUEpPlobU6FemdvH/vWXNXp9i/58v3+oYKa1O/m9tGb6DfCdFn+jyXy7wVHcTQrEc6L
	lJgEJbBRQTT32R/v5ZpfhnpwcqK4OhsKx1gVg3zhYh1pxbrMHEghISlKPZa5nj9thwqV3/8d0f/
	HQvex5CK7ipM97Ri2XgWFdZ9cc7tMLiBiWUVj5LIPhNHDiBX/DthYp/OjJsP+BRzCLWadq7VMT/
	HZG9SYdKvJIbeUKT3IUzsGhQNtMgKDyQBY6/m/Y3txj/yQQKkz4RPFHhcC9JBYXkpKCJ+QPODSl
	og3ipZa3JbAck9dH9BI8ze6ucZnFdGp+hmcTGQFtf7czCdeZ9YPxuR45f85j88eO6Vq6QY57NPf
	3YZRnEEd1KOPtkpUVBUVVqgnuiGKaH9jPz4AobmXAyLk7AGxLymDGaI6xZx2kS9E11LpxZbyoLg
	nLY+FPovTD6CaaAQo9AUuVCd8ILPmFJP/sPO8+BD2A9pDbDU/q9ivJTxHpwYbxXfwHAKaOvT8c1
	3uqJtwxzLgDUPscmvuyqut2a1IuSqHYNU0+mhK63eKckTrDzm1fXqg==
X-Received: by 2002:a05:7300:d58d:b0:369:e8b0:af85 with SMTP id 5a478bee46e88-36a4243a512mr30366093eec.36.1793860621499;
        Wed, 04 Nov 2026 22:37:01 -0800 (PST)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36d34d5960esm13148900eec.5.2026.11.04.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 22:37:00 -0800 (PST)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] vdpa: fix typos in comments
Date: Thu,  5 Nov 2026 12:06:52 +0530
Message-ID: <cover.1793860522.git.hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261102043526-mutt-send-email-mst@kernel.org>
References: <20261102043526-mutt-send-email-mst@kernel.org>
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

v1 was a single patch touching both drivers/vdpa/alibaba/eni_vdpa.c and
include/uapi/linux/virtio_net.h.  Michael asked for the uapi header to be
split out, and pointed out that the eni_vdpa.c comment also says "ENI is
build upon" where it means "built", so patch 1 now fixes that alongside
the "specfication" it was sent for.

Nothing outside comments changes in either patch.

v1: https://lore.kernel.org/all/20260904104440.18772-1-hemanth.selam@gmail.com/

Hemanth Selam (2):
  vdpa: alibaba: fix typos in comment
  virtio_net: fix typo in the ANNOUNCE_ACK comment

 drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
 include/uapi/linux/virtio_net.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.48.1

