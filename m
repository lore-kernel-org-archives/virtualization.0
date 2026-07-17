Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC93655E3
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257738; cv=pass; b=gxSLEFfbfzWaNaVN+TOCR56PienSRiQhjXlTuZaU7s7VLRorqPE3yLwpmFH9ELxAI0O/ZeEMGm4/LN3KKL4EI9mJgGIemjxCXkYV32AahxEC3dAeetGcf4ODvcA1v2LfjhtBdmF03BCrFTxz/uAcKmvlEqqsnm8YVtq4xKagV7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257738; c=relaxed/simple;
	bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgEQWqfB3lIbKB0wEbpNU50JZkAAsbUsJIqLW/J55bCmUdmYaPNoHgkIuJLoT5SZd/60I7JqK7xIN9ylT8NMKm0NwkDa/YJRtJhaY8K6Fwtdy6lVhbCR4hIxuJv5dxVEHLFyxlmZJvrRGapg5MN1t/DB2TljoB6wqferzPnO4H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llWQRUYZ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llWQRUYZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10e86e52so239291cf.1
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 20:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784257735; cv=none;
        d=google.com; s=arc-20260327;
        b=dgsNTkGbLiQNsaFSj2Usf06DN7NIlxMmy9D4XBXitDu1di/Ay9JHQOrPlu1N/J9clE
         XTPAKFTOQqOL+wcsWtfQfQ5BfMWppIzA9weqpw6yYkDxuRB32Umyc7aMi5mh+n7ROxSI
         TM4B3SlkwvPQUB3yH3AG+fryjlSsTIDTiCGYWqxmh4Kv1hjJRD+UXkIoCPjI7g/fG8Xt
         abBtdTMgQx+r/YVpW/bCjHHVAu3Tlu4Cf1NhFMcv1L/kc6FAlwlihhFP1Pxo97+jyoj/
         veF3cOqPHH1FceB0ioN6SE+3lmb742UVnxJtI3q3sUmFIeUaEWjQlMv79m0svBUY05XZ
         2Ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
        fh=hGz2EXp8vUA1KmntgXirweFnKlGa1kQWPEnnS5ORT2Q=;
        b=Coz0owAroAKKwjT2VBypWPRORQ9XhNxF3wsxvttbpvrM15IWfgaAUuq2KWA+NBcizF
         xmz75rXC/Xv56oqM/7aUOA467cJsBaQ3pou7EfrIBscfeCoiuvPZmsMxtA8wIcdPR28/
         wLsSpISye1iTjZtMWHZQy1EcNiCzzThPwHsQLZtWkvfPLsa8+y66WyJGFalG6i/QFvJr
         uVgaELmDHZ6T8nN/QW4LvgSIuPctuvpUYlss2N34DxSfTMWZE50dlEBcU3q2sypQmD3d
         W67qXq5XnuK/q0bzYKaGXEYAvMrKZlWGc+6kFoIp2xvE/8CPZSJh3LGzS2yvnnadlkYF
         Te6g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784257735; x=1784862535; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
        b=llWQRUYZKbGO9xqI8AZMBvmbzxMs1fSOnm6znoXDD8Vc7dSXUlDCQJS7C0i90oJGiI
         keuNN/n3I4GSvfdOUTo1guqw19UKZGYJmHs0TQPUk8zerXA450TboOLwEVWroBVNp2H3
         aGVhcnNW96UDMYL1a4vAoJ/jOvCMLnqPIFnVVInHTcngpjci+4oK1IkMaeupj/K6ysTD
         NA/gDDPJBw37vva0eGjVeLcHBGkHYO7SQsOcSLQjNnlUWp9x4pM+eElCt3Uo9LMXM8db
         IdH1pyZZMg/aGxHdME5pl6ZfgZqaqDa5fbJT9iepnD9tqcPRVKnzGT56NLJY3DVB8yRS
         +4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784257735; x=1784862535;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xkE7Fo4sqZ/86+n7TYPmzgcfuvqX35lIQ9Nzu1Gipdo=;
        b=mqj34DlN4/UDPohd9OtRIKGSNL9cSREwzWgsz7ICNwLhkm4FRA5sCHgdhpNt/vjVtn
         N2J057B7YJ98FQaQNqW/hlftzir42Az53JA9gRp9PPvxPKoGZMRUQgcf1oynMIbowrx4
         u5m1Zt7sZCQ7gQfTOgS/iVYjqRXjcRjtb7zExFmEMmJDPAm/9FOTMy5GtNcIq/QO69Ox
         eKNcexuGER8nj8HJAa5xIwscipBaeDMJD4Wl7804Kj/boMMjovaN5o6EsPedwNOw8a9w
         91+P3CZso3UtYeGw/igJDUhoWJrlpc86qX38xZQzGAvfV5MUqixTnv5adsNW6hnEkl9B
         J9tg==
X-Gm-Message-State: AOJu0Yx9SbVQLbwdEGUUTunkc4pzB5G4q1ZBNgokyUfRnS87TMjBCOY6
	XvB2M6nyDkmYE4Z8V6eBA9VEdypvNhy4UFPc5C/ek67HI7d8lxq6jOgzIj52a9sbax5/ezLpPTw
	7OSyapLPqQ5o/AWJ80FK4LTMkumicIjKut1ryyqru
X-Gm-Gg: AfdE7clik7lvutLTxCidlO3YkcIhfqS0k2apTdBclb7FveNbammhinZ8EGgOUaNyMJ1
	ooQFBfBKPzNL2yD9PEnjaGxXQm02uNovyI/EtR3PJESOms36/KedGxjKmE7P6GewXH7/QUeOULu
	KBiykTOK2XE/fcZDmuAjOS8oBMi34AgvYWFeyksPIQtNJNS0qWMSlt83IyIn45NrklRBvHserG2
	MhuB1Os8cbyld6D/Z8GeA3AdfqLwSNmuMI+XVDJvVcuA7GdhCuJ4SxERKkY3iuWJ3bG7GBFUyhT
	KC1AxndFIttCdiTU
X-Received: by 2002:a05:622a:a908:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-520fee19f7fmr3120471cf.15.1784257734125; Thu, 16 Jul 2026
 20:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260717002311.681748-1-linkl@google.com> <20260717002311.681748-3-linkl@google.com>
In-Reply-To: <20260717002311.681748-3-linkl@google.com>
From: Link Lin <linkl@google.com>
Date: Thu, 16 Jul 2026 20:08:42 -0700
X-Gm-Features: AUfX_mxICqJHmAVK8TinFxnPQuIwu8KNDwpqoJsVqWM4NDLatLe37O_LMt6bETw
Message-ID: <CALUx4KTH4-D9ZpTrEikHajp=R2VxXqLACsJC1aOhX_W8+TApAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] virtio_balloon: avoid shrinker execution during PM suspend
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 16, 2026 at 5:24 PM Link Lin <linkl@google.com> wrote:
>
> During PM freeze (e.g. S4 hibernation), virtballoon_freeze() calls
> remove_common() which resets the virtio device and deletes all virtqueues.
> However, the balloon shrinker remains registered with core MM.
>
> If memory pressure occurs during S4 hibernation image creation/saving, MM
> invokes virtio_balloon_shrinker_scan(), which attempts to reclaim free
> pages. Although return_free_pages_to_mm() only frees pages back to MM,
> reclaiming free pages under memory pressure can trigger page reporting
> which might access the deleted reporting virtqueue if it is not yet
> frozen, or interact with other parts of the driver in a teardown state.
>
> Avoid this by adding a `suspended` flag to `struct virtio_balloon`. Set
> this flag to true in virtballoon_freeze() and false in
> virtballoon_restore(). Check this flag in both shrinker callbacks (scan
> and count) and return 0 if the device is suspended, preventing any
> shrinker execution while virtqueues are deleted. Wrap the lockless reads
> in READ_ONCE() and writes in WRITE_ONCE() to prevent compiler
> optimization issues and KCSAN data race warnings.
>
> Fixes: 71019de8219b ("virtio_balloon: Add free page hinting support")
> Cc: stable@vger.kernel.org
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Link Lin <linkl@google.com>

Apologies, I missed adding a tag for the feedback that led to the
TOCTOU locking fix in this patch.

Maintainers, if this series is applied, could you please add the following?
Suggested-by: James Houghton <jthoughton@google.com>

(I will be sure to include it if a v3 is otherwise required).
