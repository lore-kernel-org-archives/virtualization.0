Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A545FFD3
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776757; cv=fail; b=ebiS+9Zl0zuLCvUN/PyrNvZdtWvWeOIHMIlCYtXEi/2KVJ2uaqWp8LZs1Jn+NSxakdxZthS3j9YCGCkcbiciVuDYRlucsIB0Hhufd7ZawDDZ8EM2J2NzvQusEwPdo5vazgav4MykUnazY3QCQErTXl1yXZLWRM8yho5jPRC861M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776757; c=relaxed/simple;
	bh=odSsB/u5yBK0p7NUXbxRT6g1aXnxRYVHZujTKirCCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JPCNaxSCCcheU57gMHnAKqz+lq2XOgfQA2+2q9thy/xpWBpyI6AegyQactjh3d/dMg9b/EOvPBonKw0o/8dI6rF3g+ShZzAcaES3qUVTH/uLdhubeXuCEWKmtKPvnET2HLgOdFiEpNcTZoIDzsWEYhdRRt2JCzq1A1a+Yk0LAj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7XKJepA; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7XKJepA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5ADAA400F5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.763
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOyS-Z2x8bTI for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2026 10:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 43AC6400D5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788776755;
	b=ZBWmqO9dw0WhLsWwkjQ1wx8CM9LtcXK2nyViGs36+vcnW9AopfH1x0PlYT2zGQz4Vkjv
	 DDdcZ7+R1njvc0QOXp/3O7xMSBMebgctBlEX7/JToQ5uG4aTH7FooqpOjhTDLV7i1GSQ0
	 HK1JuW581f8YaBgI6ryUchEmqTcx43ryD6lzf/D7T1no7gjxh2gFoFrggkct1e8eniETk
	 jxq0BHPcK1JJhhuBuCfMcgLdTa6C5UJxybW+F2RJn3QOhBXSV5KZ3zuf4y6k5QHfqcHQD
	 oufYdtCI9rW5I+UPWth7MtyG3+vFeR1PqeAhmdDKRJZKIulpsQBnr11s3iKIANmDDgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788776755;
	h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=RojMlcyBo8KXKoX/Gtly8ZtzkjtceoUdIGXGbeR2hGw=;
	b=Gu5vwiXGk3gb26gFmAKAdDWWU4cEzjRsFb9nPE3sEnIbVjts+4bE/qPgkKqvKj2mvjL4
	 pFDuEW/RqJ6Zyj11uibiG+lPva0cNRaL9gmFh7YMOZC9XoX5xi2jRFhO9QAfU2QUs9xO8
	 mTnigQKdIGlvs3kE7KXSZsh6m5Odf+Wfw5ijntItTTR4VkyJBQUEfs/x1Ya+eIGqjOsOA
	 /fOmul9JAej6XDntt7F4lrVFr7uHvybZpDVfCrLNjy1xX8KIyRbdqyFJH5eSpEQJLR2Vo
	 +13TgFmYI8Jn34mFYY/Nx0jpi224uV3qgFoUzJua2wMxbJ2lNTnZuKFmeVfKY1Qv9xg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7XKJepA;
	arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K7XKJepA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43AC6400D5
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Sep 2026 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788776751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RojMlcyBo8KXKoX/Gtly8ZtzkjtceoUdIGXGbeR2hGw=;
	b=K7XKJepACoVAIu1jiUMiWOd4cdtC1eGk1hcQnrLwiFU/ThC3sq5jGIhai1t61WjqdOYEm1
	13yCUtVD0Gs1676LeDJ3Vi04j/uzodt/cnlL4OaCTL7tOlSYcusvHGpJLP5Xr4VtA48/35
	3Tksllc/3uJxSeQ0d0cgFBGMRDccGFU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Ew4ajm4dN06QB5ewenKusQ-1; Mon, 07 Sep 2026 06:25:50 -0400
X-MC-Unique: Ew4ajm4dN06QB5ewenKusQ-1
X-Mimecast-MFC-AGG-ID: Ew4ajm4dN06QB5ewenKusQ_1788776749
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cc954a3edso26744885e9.2
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Sep 2026 03:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788776749; x=1789381549;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RojMlcyBo8KXKoX/Gtly8ZtzkjtceoUdIGXGbeR2hGw=;
        b=gRklNXScqCoPI9lhT8mAau3X0xUMh2rBBjzoZpYKu0mwbLXkyDKBbbmpXp3AApbe06
         dmGroiUTKDqKShWVlWHZiuqp4voDCcMYMBhyOQwopkn6drh2+TFYoDFAG/T5zv30Y572
         nBHKywK5Dnd1ldSiM5cDUf59qZjSKkxfBJYuvhZwrevSS05TEBpYepzUQXWQCSFig2aO
         t3TKcxFQssoDiJyB5o3dG2/qfvmu/biz3HMZeOwvZEZvsNAKyLkSn0RKbiBhX7JW6KRk
         Z23H4+do21BAJKq2q0vLCDnembMKeUs8VvhbdWGmvXAK2XBvDMsfoNgt1M4LHPMwFG2y
         e6nA==
X-Forwarded-Encrypted: i=1; AKwUvBy1DtlZEBo7UqafO1q7sEonAdXD0b41mfhC5tyVmlTkiesbMzBSbXVLVQZS0rZqxB6xyEtLJ0JxtqlkxdV0QA==@lists.linux-foundation.org
X-Gm-Message-State: AFuF++nxUJZDCml0bte4o98/1I4gAoA2oB8hfhtIcZkNi7V4pAWzs+Jq
	sl2do41M8lKRsnRg8grdat/uVyUTQbksQlmGqBK4T39uGfBSdgMDDOB6YNJ2sfy5yCfFP/t4gdr
	8Z5DoT0ZPl5Y5Y0ZOc4PXMJdyGOhUhP6Jf1JNdhDBGINm6wlCiqzLuVsUVfBOndRHUkXm8BLpiw
	sVJk1EmPc=
X-Gm-Gg: AYBFou26Sk+gHG9gW/Sc3NCe5FdELu6UXS8YAfYJjzjPW8ZEqbsKNC2UHL0zFLjMS4L
	Xp8gY4vjtkvq/4+r4HXaKTLkvrSm6HE/e5VtA32WV74OSrKdubpwHJCyya3pEpSmUotKbucwII5
	XoB9FJMuzFYtgiAJhZEOcZOv/dcfA1TzEfQqD2/GIUKVQocJsyJ2fzYsTGc+oKt2QTm/fMabo1f
	Eh2T3L256nP1Z1ASMpBUXoe5DCahQ3QKoxObFFSLDfQNapG4w0C3slsjdQRlDrqNKOgM8udxDNU
	bTg0dejigJDm4CxLM4833ZuECpQMNNq2fwPXYhNXjF1NJFeuk2e/LFxG13yyRKRKGFDfIBMuH+3
	A3empJW9iC0GXaP48nlVSbkY=
X-Received: by 2002:a05:600c:4e49:b0:49c:fa20:cc05 with SMTP id 5b1f17b1804b1-49cfa20ccd2mr198545435e9.28.1788776748835;
        Mon, 07 Sep 2026 03:25:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4e49:b0:49c:fa20:cc05 with SMTP id 5b1f17b1804b1-49cfa20ccd2mr198544945e9.28.1788776748301;
        Mon, 07 Sep 2026 03:25:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm407611205e9.5.2026.09.07.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:25:47 -0700 (PDT)
Date: Mon, 7 Sep 2026 06:25:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, Chris Mason <clm@fb.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	virtualization@lists.linux-foundation.org, ksummit@lists.linux.dev
Subject: Re: How is sashiko bot deciding whom to Cc?
Message-ID: <20260907062516-mutt-send-email-mst@kernel.org>
References: <20260907055646-mutt-send-email-mst@kernel.org>
 <ap6Nwf94aq2dk3WD@ninjato>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ap6Nwf94aq2dk3WD@ninjato>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9mtQNo5fVLP1jeeYTlYaMIowtdimJfbDCmrzhzt_jos_1788776749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2026 at 12:11:17PM +0200, Wolfram Sang wrote:
> 
> > So it picked some mailing lists but not others, and some specific people.
> > 
> > Is that opt-in somehow? I'll be happy to get Cc'd on the auto-review email.
> 
> To get me CCed with Renesas specific topics I sent a PR to modify this
> file:
> 
> https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.toml
> 

Got it, thanks! Sent a PR.

-- 
MST

