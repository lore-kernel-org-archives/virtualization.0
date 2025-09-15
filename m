Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C2279788
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975030; cv=none; b=WUuro+YqQngh//Zx9RkT71mjEE94gGipYRRnWN0BssnTHzbgPlX6scMhpCk9Nu5u6eZLLhuwwsg7vAA0v+lv+C0CH+SVqXcvS3ypC3eNdn3fUooUIWzDLVEjuqJ4sSdTgMF14qpDSz/jRGFV9rS+o8dAK+eqKlMEVMm/hCkTfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975030; c=relaxed/simple;
	bh=Deus/OWdVLZ2R3WKItEKOGVXH14LkytRL6v3j0WjP48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nYOUPkJ3tUCIE9F4W/iWtadqhGLUE7fHZV5beg1CUKTaITujvX4jh6gG2C+h1Rob8ONqe2FinwPmf4I/O3U/UIp0na+16RTRi40tsoNCcAge56DuxpNIyJibKrU8a70ZFenRA5egsyFBDo7z/LM89J92MdBOt7pEGv9h0u0fUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3cdnVJF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3cdnVJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757975027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGRejJG0eDtlNIu2fdRBanuS2WqJ6w4xAk6USL54XjI=;
	b=O3cdnVJFlYtMPQ4ye7kOXcFiwhm2K5TCQJ0xVSQwBeNbw2kJDyX3wFwhyAUG2HGURIh/cU
	Kr3tvtniybzCFn3vhOSAgwmc906E0DD+JwyVJROreNtpO5qU4UHogOXJRgjbS05CJogmV+
	HdG82lq/YGkh4H1DaFFgrBZ42S0x+lo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-XRGB6ZsgNImIulGp_nrd_Q-1; Mon, 15 Sep 2025 18:23:46 -0400
X-MC-Unique: XRGB6ZsgNImIulGp_nrd_Q-1
X-Mimecast-MFC-AGG-ID: XRGB6ZsgNImIulGp_nrd_Q_1757975026
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b04145e8615so324981566b.3
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 15:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757975025; x=1758579825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGRejJG0eDtlNIu2fdRBanuS2WqJ6w4xAk6USL54XjI=;
        b=CbzNAUHA4W4B7y5QrTVfVXdUJjRrvCXQC0uZ4Wyo3cUx9UAPYjdzo+n1nc+QdJD8w1
         a3usmcXhB02E178OUHPYOLF5l6oR1wPaLZNrtJl1HugGG3jyZnIAc9CLjAWgGC46025y
         kTmvDFjFx8ufGjMt28Dfr9OSX3gTyiwIFHHivOimGrYHYKn7jGjoijDnGcfSb+zh9K3o
         PgQdgA1uyWmc0Rg72uBe9S4YGH88VDyXkppzmZ+vz5/6R/+Q4eHT7MJOEyutPhAIfrpR
         syRRoTP82O0w5IBVrL140oAFsxli7ff1qG02dbiXH8GyE6TDkEm4610sQ75fEEqcoLYE
         OaUg==
X-Forwarded-Encrypted: i=1; AJvYcCUGKkoap9EsL4Wnwc5YnfD1sXWoI7ZP11KrQvux8yN9wM8e5DLA19TY4uyIw0laugH+k/Olmx7G5+sZNr0w/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtBqHUzPTBxeKUTrXIHTG+hJE9DqKZDwOWm7d1uj0/xHAt0TfW
	pXxAvNctKQtp8YQ8jqZE+NoeU55L84NzEu2p7P+9b7r/MJi7vCb4xt5DK3zuEvfXGBV604J5dZ9
	9QxLGstsQEK58xFYkue8SCgex0NZQXBdOneJ1r4WTrDU5OPeMXZPP1Pv1EKSgEt2laJdCM4Fy06
	rR
X-Gm-Gg: ASbGncsgldiLiTo8y20oLg9GbBW0I7TpDYu52T9D5EZU2PnbtY2ShbbFPzeVn3okUpZ
	kOFGSneGm/9+UfF1gzPDjngqzYCb7BZDb01DGPaTuu1LzckYmE0fSbVG0egL7EoAUgqOIOWQadb
	Xz4HY13MWwCZRxpPRhLuFdF72pePlPJ4HWTNpnvnL5gV2kh2sIIcX7rDqPC81mX/ucgzOt32Sy+
	E+PrjePwSTuRWOD8zrMa7+FDYm1oIGDSYgpgz1zJwoWdFJNul6+Jvlzd0mWkLfcggrrkBzHN+4q
	w/QXpQyKd/Hmp8XV72F2RtkbNNqD
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b07c383f22bmr1387709566b.51.1757975025366;
        Mon, 15 Sep 2025 15:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pGzLsoXLRChFyMRuXFtC2HnABVGjt1L9MQILzU2f9q6UKgKHj6iY8Hiri9BM8h4OsvMUXA==
X-Received: by 2002:a17:907:3c84:b0:afe:7909:f42a with SMTP id a640c23a62f3a-b07c383f22bmr1387708066b.51.1757975025017;
        Mon, 15 Sep 2025 15:23:45 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62edbc829b3sm8379978a12.28.2025.09.15.15.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:23:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:23:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250915182232-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <aK-f45qszH2VEzV7@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aK-f45qszH2VEzV7@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7KBgmmsMKoeotC9An1EWQ4GObg2HO9NlRFtC4ZqiLIc_1757975026
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 27, 2025 at 05:16:35PM -0700, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Sebastian Andrzej Siewior wrote:
> > On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > > Michael,
> > 
> > Sean,
> > 
> > would the bellow work by chance? It is a quick shot but it looks
> > symmetrical…
> 
> Gah, sorry, I flagged your earlier mail and then forgot to circle back to it
> (for whatever reason, I didn't entirely grok what you were suggesting).
> 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index bc738fa90c1d6..27107dcc1cbfe 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
> >  	 * freeing it below.
> >  	 */
> >  	wait_for_completion(&vtsk->exited);
> > +	put_task_struct(vtsk->task);
> >  	kfree(vtsk);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_stop);
> > @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
> >  		return ERR_CAST(tsk);
> >  	}
> >  
> > -	vtsk->task = tsk;
> > +	vtsk->task = get_task_struct(tsk);
> >  	return vtsk;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_create);
> 
> Nice!  This fixes things too.  Either solution works for me.  Or maybe do both?
> Attempting to wake a task that vhost_task knows has exited (is exiting?) is a
> bit gross, but even with that hardening, guarding against UAF is very nice to
> have too.
> 
> Tested-by: Sean Christopherson <seanjc@google.com>

Sure let's do both.

-- 
MST

