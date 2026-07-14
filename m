Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F01A3C872A
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052328; cv=pass; b=UxcqaB2Ckpecj0bMXS+oBb5ytrk0f/R0NZlsuYcw0bVzn2UlApf+k2JmeFQ6dlaPNjZjOFvTyzy2c9bfkehe8xL5Nt7vk9xAabnl94+/30cSlp0xiWc2x/X5rPEGumZe/Dg4S2BwxPMsnTJYq2aNuZ+M/1zuuzBK6Q79TLw2YsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052328; c=relaxed/simple;
	bh=bMqv6qMH/Xe06iopa2RDT3Ru0gHSO0znvKQJMuoe1f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH+dLeLhvFfPuV+S2JH2HXa+Fh+qjHsTePF3Y+rSMuTY9nlnl11VxEQQRw6d9lQwywDAepSaE4Poffad2XdIciSEa2l9y/Ifw9Fp4on0snGstLltpPDl0hthq4OJ1uGvjgpX8Zh2lvyTdNPBc4DV1S//KZfsSK/2PaaG6VBAyfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLGfXEF/; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLGfXEF/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacef7d299so171565ad.1
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 11:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784052326; cv=none;
        d=google.com; s=arc-20260327;
        b=NJ9yHHUfSGix0fWJUJek51Q3xcIo8enpMawh2mdO5eCTh3U62jU3lLTOef54Jr2z63
         SXl5ecXmYyjqJe5ogJJwER3/4ZjVR7HnxE6gcJs/A+ZD1Bt2qV0YiueNmEr7v8lSvA4V
         X1hYxN39W22oKLo52vTP9MEvcF1jFWCT1Y7QjvAzInqgL2z7Bva72CZKNIbBlfJoOn6+
         rd0rQ4xRHbKaHgEygBmXIlHAfc6H+tHK0jizoNtk0KLGJ8HmObVMHFSGSDpUvBFm6uWo
         lRQSw81oVNQYOZGrGw4n47xcwrcGpXEzv5Qwm/+BI0dHI8mL31wFUVRqF1KGppsno9d9
         LzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uqRkl63C710v7jj++AXCujyuoY1ta/1fvK0KnGvJPsM=;
        fh=SuE0NOduTpGle2MT4PgrgaAw4qwXjhsMM4JUgFzJvlY=;
        b=KygF9eGRUjpzY6eu2erPpAbyhCsYy6rfTCZ1t10Gmteg6wYIUw5zxkX+a9KMi9PYV2
         il/ZMKbLsnf5R715Y/qVUiImwRB12+AtIakHEhEdAnDeOSZj0ZNqpLwClz7LmE/HZgVG
         pmLSUc+/YNLjHS8wclylqjDkdf8Ihga3UgdwrlNUJhJw5h6ZruYu8T+5Up5S9VD3+mNp
         B77BZkM/YgUHskDWscY4eMVOo+ZMnN2oEXxnAyIYvbdXbpTDczGxoTUxBZnOv7ZjUDsT
         81SDozKZaTwqNoX47Xu6AsHIHVjAvBkfpUnvs909pCvI/2fgfaPBD35EmVfM1noUnlOk
         fPaw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784052326; x=1784657126; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uqRkl63C710v7jj++AXCujyuoY1ta/1fvK0KnGvJPsM=;
        b=QLGfXEF/Thk9nuP0T1a7Y/7HV9PsyshfkLp6X9GHlGXeqAI9Y9STfO9kFYL6+tHskt
         hSC9eDHfS9Kmxtd5TNSsTn7dHwWk68I7D4TRw1xYvx9KDQDVXX1ltAYd1xnpPfYFLcIn
         RxR6y4Iz+YSI0lwwfS2WeQPXPoat6jDgDLu7l5x6Jx8zyscF1vVnpkceUZkUdwKwxOCB
         MBYRCl3c8iJ7J96k7DUfCjN+9yrHYfqcRZorffYNX5F5Srz+bOJZ9EVQy2sfzfFuGBYn
         KH2/Hsm6E6ZwGZQbbI5hJ9ECkiqH/BMgPj6JFP3l51wmFLsF13l4N2pMCEbpEv/CTko4
         mySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052326; x=1784657126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uqRkl63C710v7jj++AXCujyuoY1ta/1fvK0KnGvJPsM=;
        b=qPrrvx+3BHmkPwBd6bEnSzXfVx7a+JJSOok+CknPe0Id+y9lGTK7wKtNaoAA5u2ymc
         nJU/7fmBQCw9AsZHUlJR6nH0fC0B8LIEXOHBw5LSZxRnSChcc9mW9V4RIwci3EMl5gFu
         1lZC5d18NctNZG4KzuzN8hGXD2hWtWUoVaQ1C3+7WNF4dYKfEIFaJ/LTpzlaJEmXWDfK
         1bJtPQe9kDyah6c5q9QEcBhyFWIdT9hGub0oxQiF01EJCS0blIa1CvCZQSB6GUdvEShD
         idVxUATkxd2Zv2qa6SMKtWy4iZ/1TPKliy7IwDvvMsFwlJd0uuvbq9t4o4nGSwhOlNt0
         haMw==
X-Forwarded-Encrypted: i=1; AHgh+RprEvFJgOwkduY7Ri6LB1KrRXDCwx5XmiIn4VWQxsK4s/7QVVOahooU2yowiyEiKtI4rm0f2SgbFA87AydJ1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YywD9feuup77LmhnRBkIFKvq3OlHMjL33Etly0d4BBTUJfqSAAu
	2ypHH1uXBVg2YYQtnZDF8Yy1yofhuN6JNVVcWz4QzIUFKEJudx+wmJuMknNNz5t00bL5MtYLGuf
	ICcMAbL02ZeXjUzd2gjWGV1MmK3o+/kD094brHNZt
X-Gm-Gg: AfdE7cm+K3xyAkjOPPt7vmeE78I7BN+9iqlGVTkHMZSujst5epwGUGLXDt3lkVie9s7
	By7j0fE7dvqsXjjqRIjVXth28kVtGY4Q2gimzTyUFGQpn+hGuKJBXuGNN1ZohnMz1DSHyzQmXqb
	oEFoPihV8cRo5lObbInMuPmhSMp3/3uUBKUCOW2Uub80cWpR8ft56l/X1mrrAUIlJ93jXQikga0
	UTKgkDBiZmzSva5rqfyhq2TsgfHtiKeY4tZom9KL2ZTJoEFLCmszn0nHehmOHai2++vVOKM1XNz
	jwJ9BgvRsIeYZ9iw1XDLqrYW1w==
X-Received: by 2002:a17:902:c40a:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2cee166107dmr5050295ad.6.1784052325956; Tue, 14 Jul 2026
 11:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709224330.946683-1-linkl@google.com> <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
 <20260714092146-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260714092146-mutt-send-email-mst@kernel.org>
From: Link Lin <linkl@google.com>
Date: Tue, 14 Jul 2026 11:05:13 -0700
X-Gm-Features: AUfX_mx5k9DBPXvby8jHd85RScNqoUx2Mk5ySUSPxdCd7MSrVwbUj5pXe7nTaQQ
Message-ID: <CALUx4KSxjpHhgkHZ5p1khLSe7+-cDHd+ZtBEJS1HytWSo5WbHQ@mail.gmail.com>
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 13, 2026 at 6:17 AM David Hildenbrand wrote:
> I assume that workqueue is not frozen yet because ... it's not freezable :)
> So could we queue to system_freezable_wq instead, or define our own freezable
> workqueue there? Then a driver doesn't have to worry about that.

Exactly. As noted in the RFC, the root cause is indeed that system_wq
lacks the WQ_FREEZABLE flag, leaving it active during suspend.

Switching the worker over to system_freezable_wq is a brilliant idea.
It's a much cleaner abstraction that solves the problem at the core,
saving individual drivers from having to micromanage this lifecycle
and handle failure unwinding during freeze/restore.

On Mon, Jul 13, 2026 at 6:26 AM Michael S. Tsirkin wrote:
> +1.  Just system_freezable_wq will do the trick.

Thanks, David and Michael. I will drop the virtio-balloon specific
unregister logic and adopt this approach.

Per the earlier feedback to keep these fixes independent, I'll format
v2 as a 3-part patch series:
  [PATCH v2 1/3] mm/page_reporting: use system_freezable_wq
  [PATCH v2 2/3] virtio_balloon: fix shrinker UAF during PM freeze
  [PATCH v2 3/3] virtio_balloon: fix OOM notifier UAF during PM freeze

I'll send that out shortly.

Thanks,
Link
