Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB11372063
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164709; cv=none; b=JFsQYt80NOi0IW+7mwuTZkMQujZUkHmxleymwN5lPN6kvJ2E/uwwmT6C4mtZmNpA8hCYUhw2+STUFtyzsbRmKqSooAhHWXCoWbEeKo8m/nY9bJ4KULA1NP2GM1+VfWZ9I+suHvO5hOCwrrB+I9lMsqAZxksx3XbOVgQ6hB2kU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164709; c=relaxed/simple;
	bh=Bjyaxy6d6sDYB0cCMVeZFvsz5568RZUKEAaWTXKM5X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TCzn3XslwTzaPmc0sIUxHqc6vZkjrXrGEJEMKLpcZ4/sHi//QEXh4uvM9ClxB8imCqzb5Ytr+dyi1ZEj7/3+cC58JTawYntF4aBLJeaDSFAroo+jAf2aZgLDaoI8gwDSMYAdPtf5jDjuFRlJFkAnzNtqVLzqrEKd3iSTT9CNKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyUh3VAD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyUh3VAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781164706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RPZeu4WL540NL3gNeV8fLdaGS7lC3tamuCeTPSZyTwA=;
	b=eyUh3VADYVNKbHcdWwtiFbE897N951s+mPAS12EegV6lvNQKIdbG9fA9kj7pdAWQsj2hiq
	aUUT+cllEEBOOIdgN1dVHvJHT5Lwt9MFnNr3PABd9kFS9+MOHLux+bMzda6jJQcKW86oj9
	7/a8U7zx/lK7ZiVJH4z7+X9FG2OfKjo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-1MuiCARQPHGCrxkA4ETuYQ-1; Thu, 11 Jun 2026 03:58:23 -0400
X-MC-Unique: 1MuiCARQPHGCrxkA4ETuYQ-1
X-Mimecast-MFC-AGG-ID: 1MuiCARQPHGCrxkA4ETuYQ_1781164702
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso17888325e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 00:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164702; x=1781769502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPZeu4WL540NL3gNeV8fLdaGS7lC3tamuCeTPSZyTwA=;
        b=N7lOZMSN50k3ZGjzsPFDImM4b7GhbZ4uuIfMGCaCRdPNOckJNVkXQftkiA/s6P6zt0
         3KTz/lbJDofmlmPH2jq7OceDgKwdggHRaSAf0RTP5QNMN806ipUTuK7bcJ32Emq+z2j8
         TJBK2SmgeGZL7bJ7i84HtsAR0j3LcxgTUC83SomnyAUP4j/Pr5sBcUe44Y69W29l8Jtr
         ryh2FzIxUnUDs2fORnQU/8Y7b0WRKSamPoizWRVOFRhODuJ/IM0Ut5Luij93I3suxW7O
         3DSrvufXQOdmtnbUJwQiy4kNDJFzf9DNLW1VwdOSkFXS8FiMEHF4ZWc/P+750w2MZGw8
         bLpA==
X-Forwarded-Encrypted: i=1; AFNElJ/vC0gV9Un7CnzzsefXLKuEMa2a1w53o2LGFRdbB+r+EYMB4J7sQGDlXWYl73ZIqBgWEIiJ23hJL7Hx3osgdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGSfIIU23s6stIuQCAcAS1BbYIdx3FSeQg+dwg5q9dgyLxoFvp
	qd5KdP2xyRaO7viRpui04UbwpWOwuZn0l5tQTwbrEbeBGDqxSC2llLVNFMq//7fg6Dqw8mLkqGM
	1/yD61EH5fUGkE5XGK1PygInz6wnbtzjYZvy+3i33KwItAweRwPOUzLLUMLv5tvi73z6F
X-Gm-Gg: Acq92OGpggF8cc/isbgcChCnGTSiR1v3F2Au3ZGjVWFJ4e3nCzjcOfSWcCVRPnNcp1p
	mJtM2l1T7j7nke4jvMfHoR+3I2AmcAzMTk2H0LlxcF8eofQvAs7VnmkknlyZpzKl/UBrnOzkh3G
	S3hvJMU7PX3L/dKAw4xSsH9IazSqtleq4/xD8IaCvKnfEADtBAUBUc0aYcBmitktET3HYcKKQZJ
	qiGu+cFfREhc19p6h6YV4OWexM0Euquj73TpOR4nEkbuPwWaQm3xcN9HgR/rirn9MKb8eTzjSxZ
	W8qY8lI/hVui/Y598+H1pgkc/KJKoSpN5utKtWQq68N3RpywXUn7GLydG/h0QVyLHD5v1xBZL96
	L3zukp34xtUIm5gquyV3ciEQwIsLd8l12OHZzkjLPBMdZuIMiTNbnpg==
X-Received: by 2002:a05:600c:8b31:b0:490:bb3e:30b0 with SMTP id 5b1f17b1804b1-490e55dc1c0mr20745585e9.4.1781164702054;
        Thu, 11 Jun 2026 00:58:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8b31:b0:490:bb3e:30b0 with SMTP id 5b1f17b1804b1-490e55dc1c0mr20745215e9.4.1781164701625;
        Thu, 11 Jun 2026 00:58:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm76254621f8f.12.2026.06.11.00.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:58:21 -0700 (PDT)
Date: Thu, 11 Jun 2026 03:58:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Kees Cook <kees@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org,
	alan@linux.intel.com, tglx@linutronix.de
Subject: Re: [PATCH v3] hwrng: virtio: clamp device-reported used.len at
 copy_data()
Message-ID: <20260611035035-mutt-send-email-mst@kernel.org>
References: <20260531142251.2792061-1-michael.bommarito@gmail.com>
 <aio83ZWadVTiuNpR@gondor.apana.org.au>
 <20260611025916-mutt-send-email-mst@kernel.org>
 <aipn8sIAQ6Ai2sax@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aipn8sIAQ6Ai2sax@gondor.apana.org.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8eJdbW_cVvWD3kxJO6ubXR-VwiL3a-1-Q7SOhc6kDqQ_1781164702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 03:46:58PM +0800, Herbert Xu wrote:
> On Thu, Jun 11, 2026 at 03:30:14AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 12:43:09PM +0800, Herbert Xu wrote:
> > > On Sun, May 31, 2026 at 10:22:51AM -0400, Michael Bommarito wrote:
> > > >
> > > > +	size = min_t(unsigned int, size, avail - vi->data_idx);
> > > > +	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
> > > > +	memcpy(buf, vi->data + idx, size);
> > 
> > All the "malicious device" things are confusing. Spectre things -
> > doubly so.
> > 
> > So if an access is speculated then CPU might speculate feeding a kernel
> > secret into RNG. And then the speculated RNG value maybe can be also
> > speculatively be used by some kernel code as an index
> > to trigger a cache access, finally leaking the secret?
> > 
> > Maybe?
> 
> The way Spectre works is if you have an actual instruction using
> idx directly.  I don't see how that translates to memcpy.

I am not sure it has to be direct:

if (malicious_idx > SIZE)
	return;
src += malicious_idx;
memcpy(&value, src, ...)
....
hash = complex_hash_of(value)
....
return p[hash * 512];

is IIUC still a valid spectre v1 gadget leaking a value beyong SIZE, or
did I miss something?


And rng is a kind of a complex hash, but I also think in that "...."
in the kernel is probably large enough to close any transient execution
window.


So sure, we can drop this.




> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

