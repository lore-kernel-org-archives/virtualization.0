Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06162364EAA
	for <virtualization@lists.linux.dev>; Sun,  6 Sep 2026 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712367; cv=none; b=U3uStuX3WYDkWONVMzdVnGKi0+y9J/4rV9+iaVL3ApveYqgGBqwURTjxnlYu40r/9i4B0iSBE0Qm3C3eo3O0zfRmYtmFu3bGHHT9SESJ+h2LojNYTjmbF+OI1jFceThZxsc1fr568T2VZuRB7rMpnAA/twsuR+Js5yzhxMgV/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712367; c=relaxed/simple;
	bh=VC9CS50hEkPgNN2KRwyNAMzImJHMiYhWfiuDpnpliw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsA3TaEED/8/dzpa5PVbBnozYN33w30KNzfDiwAOuCY99O51lRjpG0e/CPjzfRcb3bUPslIRKXMgOTv9VomwnGfTspiy525HqnHd+Hw6lnuJefr4bii5QSXySbRPnTA6KdbhL4NFq5sPz3ss+BoaxIVkeI0fW6XqDhivNs2X80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2TAfvEE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2TAfvEE"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso34222575e9.0
        for <virtualization@lists.linux.dev>; Sun, 06 Sep 2026 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788712364; x=1789317164; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=a2TAfvEExh1MUqzjOVVZ9x8jj4aYwZD4hg3Kk8qAcMQ+G002rIvu9tiyDOG95eJGLM
         jAMN+9JVSm3UTRMLolJ+xxTcxxj8QuV5ZJtSKcxJ8IPXguVPBC1RUBapqzLmCLjabEhk
         6KaN4IGKwoooLOFN+y2tF1UB6cxlLZ0Drewi2xHCPdxi7C9mWj11ZOtX6wraz4ISO0Ro
         LMKLZghXoamoFkPr0Dq/tH9ci2PTD5KCaEiovUdjFonVq5uErjWVLamuh4anbjE1ghfm
         2MGWVj7IGMXlqrnEZio7PELhWqvJq5FAYlSxKIBU91Q3fXdDHD0LXxl31DURRILZTNx7
         qtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712364; x=1789317164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oSMRVQ2ffl+GqdtcpJsergu6EJ70aiuLEE/q2zryERM=;
        b=efYzRqtoDFtJCJ5KIlkA/WOkTdJZ12Py0fKsZyLhyJSF3l4NeCFQ08LAlb7hcj9kGm
         RIEreHCaTN/d66vCcmBnOmsIFawMnJICXuOExUusWkHqDtzv4emtQkuV2yswzlRgi0rF
         fo6tcsh1wmdMbegmbBxSYmmBTbdoTSG3DnvlmnNDSaC+bnPAXepCSdoo6K54skhtkEaT
         Cqb7NoMN/zISxOvdZqwpLSfCBOvJ1MgHGiXANJIBb7Kr4dU/GC+VMl6e7/t7cYxf4YiO
         pF0OkRUYaPVmvyexziQTEhFn4hv+4f26JEzk7ys9HSCDQkeSPXja0MssVeiHbcKON9K+
         JmzQ==
X-Forwarded-Encrypted: i=1; AKwUvBye+0ST3pBdbYXdaVx+NgZGtA/jVCmhZpIusZzhaInryrrAtNsE1RHlSfLrW0YTNnQgcXWiqvyzTVoNVboPpw==@lists.linux.dev
X-Gm-Message-State: AFuF++lSeB05CEYKaowx+fi2Q2c6KpO2ggpfO06EQZnARgKRRfnA7kMg
	IzQXAGwKFYJfNB0DjTU812dC8DIsKiHuwH8x7CeD2xc/5vM8egGQo4er
X-Gm-Gg: AYBFou3DK3awjFUsLeq4cGJDc1owycjd6QNXp6Frl+0W+5TJXh1HnAua2Q9fmf5zi5f
	4G9tRIrBRrmh6LN0aBoH9o2ESpCiaM8fqaZlrglV+v1AsX7y6SdDJUhzdi9+gDmXlIbdRq4xPsB
	aU4Q26X+mwWMHYqchIvb6BviF/vISGimjcMvb4d3S9gcEjR4aELCra47ViL341V1X1ScUMixvQQ
	Eqii9Bfx0e016+ypQfH+K2wFJFQZPRk7MqqxcRd9BdbkLsGEB6772UK1wznZEXojZsCzqkBi+72
	C/F3kR2PxcA+U47EQTXROgx1vM/ScWSI+ZHGDmF2XU5U04livJGjPhSFJzWEKM3aOArnI1NrR4R
	0FgzvYwalhohbGkx45+6hodk4ff2kvlI87xK9KXuP1fG2ooAdMAj43P92Mfb+8RPtJz/pl/YxPb
	43DFuJA4iV5ADAX8FA4pyxVUAZ4FshDNpXISHGOhLpPfJ4U9oprqCTsf6PpmLPjCGfciBi9TcNe
	Obw+4bgSszV7DCHf/M6HJ/5TjW8MrneB+JiTJGeQqPVDG4oTl+Pv8aXb7oVuBAWQwKSQEPuntwP
	bC5aNOb95uBgFt4fLkjF7QNhvNeomeOpQqPClCPMU6VVhZw+gvUAjd7NM7HdeVLF1XTOAwuIkKr
	E7pVe
X-Received: by 2002:a05:600c:8b04:b0:49c:fc6c:be11 with SMTP id 5b1f17b1804b1-49cfc6cc0c3mr138648845e9.23.1788712363826;
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm21761428f8f.8.2026.09.06.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 09:32:43 -0700 (PDT)
Date: Sun, 6 Sep 2026 18:32:40 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, 
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-input@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <ap2VJkoIsBbsqcNm@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260906025249-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906025249-mutt-send-email-mst@kernel.org>

On Sun, Sep 06, 2026 at 02:53:05AM +0100, Michael S. Tsirkin wrote:
> You didn't send patch 3.
> 

I resent it to just you now. Mail must have gotton lost somewhere.

If all else fails, it's on lore:
https://lore.kernel.org/r/20260905152059.89560-4-kmehltretter@gmail.com/

Thanks,
Karl
