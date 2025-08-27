Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BC308F3A
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280749; cv=none; b=mxvIe0h1djJbrNyeAuZpp85bjMfC78wsRaqD2Q7h6xSVnCId+zFk6ARC7xsF3bd1DPxtJAZxrzGCSf6TqiOiK1NgBDZgYl64etIcqpu7eOcvmy4KojEk8TEds+LAnYYbRumtjLqihSu7UB/6Z8thLGoyVuXNIMEA59/I6UcNjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280749; c=relaxed/simple;
	bh=m1P0jEmqMZWxkTnadh0YZTaGGpaW9MgNFj/scBIbOjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ej/xUL5+s2vVrRGGu1+y44oYN/5NXSR4WQ/3xBnMxvi+dflas6nJTRSWyWcYYZtcHwwLZel8yvQTJhAgR7dZaCmrsh9AVVraFz6sbx0fozTmWgxZP/gfxxdWzTktdi/HkCa/wUB+UVqmBGEq5+X1qBfk1yEbFW7+bkDoXYcmzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gExMxf31; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gExMxf31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756280746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y53iOSeYHWg2rhEwEqFZy9Ri7ZxF7SP7WMmqtTCcABE=;
	b=gExMxf31RiGN6/ZBBxK7C3Td0PIyhcseGySS6fNJPHN/wUXEulBSAimbbphzzapboT0UKt
	heRubZqJiTonRrijKwD0iv1y9Ipy+skxFvu301dlW4v0KRk5G7LIlp07SVlIxfxJIjn1zI
	rBn/srqhX5jtqmLh9omTShedsgVs3Xw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-LPZOE-vDMjS2GriOl4M9qA-1; Wed, 27 Aug 2025 03:45:44 -0400
X-MC-Unique: LPZOE-vDMjS2GriOl4M9qA-1
X-Mimecast-MFC-AGG-ID: LPZOE-vDMjS2GriOl4M9qA_1756280743
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-327706e0642so696509a91.3
        for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 00:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756280743; x=1756885543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y53iOSeYHWg2rhEwEqFZy9Ri7ZxF7SP7WMmqtTCcABE=;
        b=lBghjns9kFgxELDyo/NX5WmwXdTKbCBrjNBHVKEIuUDKxFnrTlawV584XmBHENfZ3Q
         +LfheOrJ4mOcVZ+xdj/bHlBpjzLz6ceEBgi9DBEnSbKj+f8C5ksp5K+24eBw2RM738oI
         NCapOgXCwgGFsDGWbFwvdPPsFH/26XslBil3VLElp7Pw73iYttv3vSdB4VTLcGtAjlc3
         hwas1jpq2VSqKXy6tf8aG+J52dT9LI/FRGYnVB2ArEDq3AI3LdfyASNrAVlEdOE6axbI
         0CW33tGmhVieur+Kt7Ae3iNHPE3lMXdZZF4rgGzXGTx2iXqoDgnuQzNbXmBTycsuAn37
         tsMA==
X-Forwarded-Encrypted: i=1; AJvYcCWYuY6DsnSgFAvn8FQ971J4sseyfsYW9IV+78G3Vm6G1XwaXrsR3JmDdP3pQfeXzEJnfQswfr5ajAV3EqtGnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7k2AJeRhE/KaLhZ20rpq1lOTSd0NoS5SEu4inRF3bnYu0pyzt
	homkhXcmXwZ3Q9Q/2hbxPO3MZfdwbZ4G891YNZQnO7Qo6hr51GZH0gPXUJeObRr22nkjnV0v9tf
	A+TTlhtF46IxuCj220wfzE7sDes9KPwXrTCgALM0qqEca0OL+F7VvapcDaVzpfx4tT2M3R3+yZL
	Z7JOd7PiXg6U5W0HJKdU3u9TlAxwaqi+7quJZCQmAKXRc=
X-Gm-Gg: ASbGncuMtTnv3OLdGriRgc1f9fa1Of1fygzWAyK7DEBnv0Rd98vG5NgQOSY5+mmPvXq
	bZXiVH63EgQYmDmMZ7h0mVfCDyEXsSl/wezurhfayYrzmMAYtGdAb87XlSc11rZOYi9vzIT2OwV
	jNjVwtPJbKdjvJocqM1TGR
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id 98e67ed59e1d1-325c492175cmr10781696a91.28.1756280742876;
        Wed, 27 Aug 2025 00:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL3QfOtkpTlqmDLyFPBToqiAGSTr07AvdWHQ5KB4MsCwD8hJyLgmML29/RVKHu2TWMxv7zu22lFBW97rccbXQ=
X-Received: by 2002:a17:90b:3b43:b0:325:c492:1541 with SMTP id
 98e67ed59e1d1-325c492175cmr10781671a91.28.1756280742428; Wed, 27 Aug 2025
 00:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250812040115.502956-1-liaoyuanhong@vivo.com>
 <aJt91SSkBO486bg5@MacBook-Air.local> <a161ad99-8941-4213-95e3-86c5ef948215@vivo.com>
In-Reply-To: <a161ad99-8941-4213-95e3-86c5ef948215@vivo.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 27 Aug 2025 09:45:30 +0200
X-Gm-Features: Ac12FXyh6ecdn9TGNfNWZ5a4yYKMaOQgjIgTEY1tLxy6zfw-_ib0DMy_7VZaP-E
Message-ID: <CAGxU2F4f+Ks6hUNuqvfAJ_kLzjf4sy5CfLkzPJ=Whn7n67-Szw@mail.gmail.com>
Subject: Re: [PATCH] vsock/test: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Joe Damato <joe@dama.to>, Paolo Abeni <pabeni@redhat.com>, 
	Konstantin Shkolnyy <kshk@linux.ibm.com>, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>, 
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XYTGiRFaRF5p--0zZolch0orgDQpBuvy3I7SoEWFbbk_1756280743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 08:57, Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
>
> On 8/13/2025 1:45 AM, Joe Damato wrote:
>
> > [You don't often get email from joe@dama.to. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On Tue, Aug 12, 2025 at 12:01:15PM +0800, Liao Yuanhong wrote:
> >> Remove unnecessary semicolons.
> >>
> >> Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
> >> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> >> ---
> >>   tools/testing/vsock/util.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> >> index 7b861a8e997a..d843643ced6b 100644
> >> --- a/tools/testing/vsock/util.c
> >> +++ b/tools/testing/vsock/util.c
> >> @@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
> >>   fail:
> >>        fprintf(stderr, "%s  val %llu\n", errmsg, val);
> >>        exit(EXIT_FAILURE);
> >> -;
> >>   }
> > This isn't a fixes since it doesn't fix a bug; it's cleanup so I'd probably
> > target net-next and drop the fixes tag.
>
> Do you need me to resend the v2 version without the fixes tag?

Yes, please.

Also target net-next:
https://docs.kernel.org/process/maintainer-netdev.html#indicating-target-tree

Thanks,
Stefano

>
>
> Thanks,
>
> Liao
>

