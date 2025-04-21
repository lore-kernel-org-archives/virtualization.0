Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BA2571DC
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745205961; cv=none; b=Q5AewSK7bUap7jkwW5ntL1DIlxaDfO60MCX2jCkmM1BdH2qDXGibS8kBT7b194iS62G0eMTFCuWD0h4Wqr+bqXGJzY0oRtiEV4Vr2KhMc2qaEHQizWDFJaxEOoLmO4xv9oF0LtS1fCAFlYYndnq/lixStvh4aNJ2MoCeOBXpRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745205961; c=relaxed/simple;
	bh=LDRqlt3pdVBe6W0Gqdk6DfxwzQkTyd2euV3LqI0Bh2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jK44rVQL/IGsrmtdRi3+BOWXdWi630731BsvPOkn9zum+qSVjkJXvcSKhxpUhXiZm1yt5bCc+Y+mvqyNRT7adAilkImFwXl+bj4jv62IQi33Wbimu69M3VCTzOYrCdBi8yEhQ6E57x0kE3J5yIUVs6nBfKB52RzKVu6D4eytC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fnt3SQbY; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnt3SQbY"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BFCC40768
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nVIqYaDHPs4G for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 03:25:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B525240759
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B525240759
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fnt3SQbY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B525240759
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745205957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDRqlt3pdVBe6W0Gqdk6DfxwzQkTyd2euV3LqI0Bh2M=;
	b=Fnt3SQbYITJki6NHxHbqvp2yx7I6EeIOrOeSWVU4vHSK30K6Th5bLTCR0p133CbVU02Jum
	uOuQ1l0hInCjKFaqmW6HFkMqDtdEw9nP5zvXuzsz5qMYqhEwceKgTZkE+FLTP5qqwNXlqG
	T39DsAZPNQLYR/snWtTbSPWS5+9AEfo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-HkU6tsP0MFmzoIyxnA5lFQ-1; Sun, 20 Apr 2025 23:25:54 -0400
X-MC-Unique: HkU6tsP0MFmzoIyxnA5lFQ-1
X-Mimecast-MFC-AGG-ID: HkU6tsP0MFmzoIyxnA5lFQ_1745205953
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30828f9af10so8090557a91.3
        for <virtualization@lists.linux-foundation.org>; Sun, 20 Apr 2025 20:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745205953; x=1745810753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDRqlt3pdVBe6W0Gqdk6DfxwzQkTyd2euV3LqI0Bh2M=;
        b=jEfqgaDX/Z6SPh19YEoVYycyJ09sLIfBsygdKnIPXeb6Gu42Nw9/jjTAh4Op5wc4tM
         YS4xwdwvPruC/21BapwfZku2bz3tJMP5K2Ma4UfnLTpF8/IOcTtIg/NChEKFpdm9zdhQ
         Fs06uK/Hj/051qmiA4/QuRYiANzGOCvbJ4G6eYRF+2fO0h4jaIHraXbniBRFHlalV3kQ
         oQl8jyvpx7pVf0Lh/DMjSq7kgS22OyP4qfnVgWT51Omz2WTSyBLmd4ZgfgwTqb330GLg
         k89glEcgCNNBSccKDRcBCacm2XyewwBkiDNdLssFD4VnVqHRcWMTSeoBi5wFLttsuoMB
         SKog==
X-Forwarded-Encrypted: i=1; AJvYcCWisWwk4NLchGmJUMFdbd5zJmoZdOtQVu+U+3e9qvgrQHH4+tjnA9+b/8/p7bSVFwwVaoSbB9kGYN87Ldr6Lg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz/xOdxNMYBilwexZUmLDd7LB7/0uDfCOmOlM0DkrF/11mV6gk6
	iVCI+yAiUs38bOcK4DFG3tuxyQLfGNsXk4+tTuGhdBFt9gP43Fg31W1geju4isEei0r+s0mPF4d
	dKqFAHadTWW+VV7MkMuRccz665FG313sGC2g1g2XimAwoiXDfvC8ltRYxT5p2tAr/fGBAMhAXQP
	LaGXR1qDJsIppR4GarKMPdQBlRihA298dS+EvEGgDVkD7VALBmNoXuFw==
X-Gm-Gg: ASbGncsO9+QbDJjpSHEBRrbS5DKfIvmAcDZZunoIKedL/KT5vFbOYxaz8f5HvdeQywN
	ROfZoKvRmx9kvXEXN0bU6RDrQXxpqQ2sYrXPLNlyjVbH6HyJkqqDI3Ki1LCDqxb6lhz349w==
X-Received: by 2002:a17:90b:4d0e:b0:2ff:72f8:3708 with SMTP id 98e67ed59e1d1-3087bb698dbmr16031399a91.17.1745205953165;
        Sun, 20 Apr 2025 20:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRn4aaJLEWKifGdZtxb0xG0ZX1rnp7AGSHkwS8cLatxxEFkRFOLg4s2lSpvKjRkSSHI3FJP0BYoc1g+518R0k=
X-Received: by 2002:a17:90b:4d0e:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-3087bb698dbmr16031376a91.17.1745205952711; Sun, 20 Apr 2025
 20:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-2-lulu@redhat.com>
In-Reply-To: <20250421024457.112163-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:25:40 +0800
X-Gm-Features: ATxdqUEzFhmXZvex8E_M5MI68rpAe_dfLzO2jQT5TrbK-mfz02wSE_-vO-a54DE
Message-ID: <CACGkMEsR-t1j3d3Hh7FkHDWrjCRoyB17JxCwiN8Fqkh-zJiyVw@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gEO3XbIfDHA_tgZrevvyoBLoweEl4g-HlV6a4mE78Rk_1745205953
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles, it confuses some
> legacy userspace applications, therefore, we are reintroducing kthread
> API support.
>
> Introduce a new parameter to enable users to choose between kthread and
> task mode.
>
> By default, this parameter is set to true, so the default behavior
> remains unchanged by this patch.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

