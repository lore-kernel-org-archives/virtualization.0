Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCC1E885A
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168173; cv=none; b=sKskL9vv5WBQopBRi3PXoITQ41tVtO8RoeWlIyZC5NpE+wccbFJqiTIcecDD6iXcS9Nxr9rvpZdo9Qdnkb6TC8X+TsHB/3iuamJmcXO2o2XxtgtJC9tYnNGOSIjv4Q51muz77Xc9NLArEVderqYTLnqAExVCaoIFUC2timSKHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168173; c=relaxed/simple;
	bh=ekKXpimJWy22uIkS5AsFE3xQblvl2h8os3O06ForToQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtr61InyXzDZZyWowIqFoW3sh594vXFpK9i4xsaCAmhBIQ7UoYFCULznRTBUcbPFhILCYXMr7UwdPDsyvs0T0KuVko72Zh4T39AB4Sfl1EWnImhuceB3iOsAhabYvrfFoYYfE1CMGbt2GfgR9LU7pLQH3S9htF6Zg0aFlgaBKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb9/S1cR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb9/S1cR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c27fc587ebso19782375ad.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168172; x=1781772972; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekKXpimJWy22uIkS5AsFE3xQblvl2h8os3O06ForToQ=;
        b=Zb9/S1cR5IXoGxAHKmcmO9JKsDg7iTjT9X4ANRmHBNg39EJ8QWa+wy/wDBl9fFQHnc
         SFSoGeD+T0JMamy1QhlYEUuedNSYyRPkMR1zp3q2WusAn7v5zh1xVhWtnkBF1dFRGfy/
         BFB+kjrTFq/fUdDQ6rjYZyPYGRZ7ddmYxSxAjXqk/iigsisTG/hhrsgPaYietpU25SZA
         dQFJTTXCeeDD+Z6XYdwVQu4zbUTZTivta2z9+Mlj8AYH2pzs5Yd38etRSDR7Zw9dsrQi
         vEQINAd89DWShTVu4kv1z3DIgNtGXXIyuYUW7wpNjPksDOegAnAO8PmoMzGf70+SyMv5
         K96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168172; x=1781772972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekKXpimJWy22uIkS5AsFE3xQblvl2h8os3O06ForToQ=;
        b=Q+xw/0FRZqwK/cjrqRBqvLnJTAt/NfO7y9uSv5YkG8/U+PzQcgPoAjiJfi9ewNqXsT
         PQ4nOXZt0ucsgd1MFtwb7BXksZHUgFnHidm4KMD6yNTWRtRVy/g75OkZAcitIXTXGM1u
         /cQTw08lh0Rs/BODvkkv54N3/JnAb0krRxGp7iLwN8yduSg4to4e0iiA/D3wFTxjQQj0
         JHt8Vq0SYNbc6L9KB+l3dJm80kk7sI6JDtZfH3CW5TUhjKHBsQ+40np1385SaKLTON/V
         eh2ZExnfxrEr7dZmOS30g8AioM7WjjHd5jm3dRdPA0HQ8BG+1pVVxM0NXuegKZFKY9bb
         a8Cg==
X-Forwarded-Encrypted: i=1; AFNElJ/W6pOLctcdupdgOCla3o69o1yCHUTJUPvnkG/Qs3J+iwtnAMdSMEeIQAvwoo4wnHUSF64guWDlgYRQizHyNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPm+M7RG9tz7b6wHlm4GovxLiJu8RIbtMWoArcd3FCYb8UpCTx
	rhcCuP4HA2+rY6rr8Od8NFFMqCYZdMJIjeqvu8LPOR388ffxrLZP+WyRCKW07Nm92g==
X-Gm-Gg: Acq92OH8txTbBAJSEstbnHlGVZv4ehoUSr+1rzToWGb7T7oeWM2/rh+P1D2juGt7gzj
	FPj+/7a5AB6NorqfPZ288eaWaW8INx2iySm/73uOQA8AyrPy+cUQRp5LLqjWs1hgFpV9/TvjoJp
	BXN9tJc6x0Gqgc25OtK7PHawXeCuN8gE5xMVUWrGl4ZFwjfDkpAL537p+sHbcZ4LILve22RuExK
	fNClAvnN2U+GsYjxNPMGRyNr997qrevF9Z1EXlbpGrcOU78C2DqVMk72DIYm9Kj8pHVlCMSbcMi
	951p0mOLnMLtMLOKYa4FxDTF+HfkwN86t22SRonwL41C/fyPMOmrKwPSlwrWCSUDPgLE3jG7WIF
	pMtJGdhPXwWiZrnBugn328OobiKfpeXA9PkWiEV0+M2CgpHX/VbeEBYke1PNYk5wJfN5qOIQb9n
	5hY4aVx0Mz9Ytiv4E0s/QbYldE3SUMr3a0CeHj3SCkDcH5h5RaDG7/XSf12ljHP/sHwDs1Dg7M0
	EoFzA==
X-Received: by 2002:a17:903:f8c:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c2f2a780bamr21367275ad.31.1781168171973;
        Thu, 11 Jun 2026 01:56:11 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fab9sm271803255ad.79.2026.06.11.01.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:56:10 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Date: Thu, 11 Jun 2026 08:56:18 +0000
Message-ID: <20260611085618.626923-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aipzlgTKa1OuKrwg@sgarzare-redhat>
References: <aipzlgTKa1OuKrwg@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 10:37:30AM +0200, Stefano Garzarella wrote:
> Thanks for this, what about fixing also hyperv_transport ?

nice spotting, hyperv_transport.c:326 has the same open-coded check.
Will include it in v2 of this patch.

Raf
