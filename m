Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365E35E555
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485018; cv=none; b=BM45rGxBTu4ExUGvQabqnGr5H7ElOEtHqVry0+DY0rzYJelr9+CYLxLMLgrjs9tUsjRtAWuGNlUw9p0B8P/0jUoHCKmxEms0+svmb1AQH7e09vKBhU/UmYVAtrXQJCVeXUqYTO0GFojGXLswu+7WSK78pqbrtCNkXs5YDyIM5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485018; c=relaxed/simple;
	bh=5V7GiE6xtZks7l89G9tTxWFWQSrdthsihabtJ0mENe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlmmbvKHqGzup9NUcSpFJVWQ//1kcTDxugKYbji4CWCINlqwi7jMYv8XtAFvmCI693EZNSWlecEi3k5SnjLi5nJ5GhMWwcHjvbk/3AIIPT8ipsmFbJTJC73gSRmGtI27QeIdua8/eCFnJsr0QWAhhhFd/vO5q/qiuJr7M1asSj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnmcS8jy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnmcS8jy"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so10729134a12.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485015; x=1764089815; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5V7GiE6xtZks7l89G9tTxWFWQSrdthsihabtJ0mENe4=;
        b=CnmcS8jystbFxNMa+AA54gjtHQ+7Kj2lav4XCDTfF9+Yfy+HWe4NFcUrggfzuT4YFF
         R72olL4vjUNjQy8jRLWahHT9hozGwmjNYRTeZ8KvOK8Kj/r5efTqhTSiBDnPNqJR0+LG
         n7UoEBBo9HGlC9rS14/vj0sq0GbyYqR1JwiYA0h7PS++p4lvyy8oWOe8QBTKQDufjA3o
         oMiO9eZjoCB20vAj8Nmaq95Z8RFOkpwwHszY2lOZPdRl6JZfH9sy0xEaQwJ5MYd5m8ic
         4pVW61A4S+EdO3xkYfw6PaNJERbQMSGGxXRCtt2N5/BqvuoFwkY/+PpwyWW/hqWEJ9/e
         PTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485015; x=1764089815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V7GiE6xtZks7l89G9tTxWFWQSrdthsihabtJ0mENe4=;
        b=q5pMWDFfQmNydO8Hxl99NdkDdC0VKNLxLQ6hcD1INj5Do7jVzeCJ+PjWFdcrRsXSzA
         q6ehDXw49Invqo0RF14Ugjg9pyLcEhsgr2ZWHop7uO5s9EFbrNkW9X+Rzrr24tPkrh2t
         IkArsHP8qvFPLXz0jq3flg6lKOmnM1twLNgagQbHuv2OmG+elSFNTueEnibyEPvGi3Gj
         arOMYS3r77UEAHyi3xR4Z+dUe/IX5p4V8Zbc4WttRy1HMHRgxTW0uxgHcssmd5Jy9exz
         yde6UzDkiluGTFKAKnxm7dHpv+/kCJ/wVH3gmxSFjOWZiTceoZMLoqU1liMHpqMdG9j4
         6R5Q==
X-Gm-Message-State: AOJu0YzHFJw4tD7ziaWKTarQh6yegt7bufFsXzevxHAGloyeNnPNpIZ/
	qbuYNhQVZ8H8n6UoGw0SP/dof1kRV7rlA9Ra3yY99bKkRwqHOZXBOf39sQ6ujmRdfrDi2/134md
	o4kWhgpvw/4dCQ63+NGmZngPaHOr/UXY=
X-Gm-Gg: ASbGncuVP5brzvYswLl0cV1G+U2uskiG3FNkuXnC0mSmCeEz22dZ/J3QvdbMf2KRAMF
	YvTTps2LHPOTdWr34J/KS50HfvhrkEacrgva2xTDK+V+4qwuzLQzArvdLQ8A0M44s34ElE7pKD3
	bdr3zXLe6oK2y8KIDmxruI2WGvj5GI0FInZqmmWkWAvWdl9WWHOGrsmUwIcvijnSm6fBoZ8K02w
	Vc99C/KHxpGDW9ABENK3BasGXelSnxqjDG7pHc/7T2ZhNighT2Pq36dm+/DIKeWSxx4W52n0ztI
	txsD9y8=
X-Google-Smtp-Source: AGHT+IFs1ML/yGQuC8YS4/Iv0wOMlGo1jVem3rfZFTTCm2g0aNVw9IUXkatjMzTKAnormtovEcs5dn1ta7eT+xhuG8Q=
X-Received: by 2002:a05:6402:2111:b0:641:3d64:b120 with SMTP id
 4fb4d7f45d1cf-64350e89f50mr14361293a12.18.1763485014376; Tue, 18 Nov 2025
 08:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 18 Nov 2025 22:26:42 +0530
X-Gm-Features: AWmQ_bl01hvmKDelrUqTiwPIOlLTUnTAKXqeUslzZwhDZ8PPWJwRB4NxkgNyhqM
Message-ID: <CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com>
Subject: Re: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	sdf@fomichev.me, kuniyu@google.com, skhawaja@google.com, 
	aleksander.lobakin@intel.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I am sorry that it is broken. I will submit a v5 as soon as possible
