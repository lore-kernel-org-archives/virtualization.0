Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8882D98
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174723; cv=none; b=mOX1P8IewIR9bU+qt3capSL1TgvGlWuSBp7YC1kq/l+LEvEn2dgVkVhbpSU9RyszNQ8i/aiyGb31x5X+9HSeMZVkvr9LeTqV1Fpgfc05Al/u86T2BPYOddeGVgIIQZDzs2STsTOPtpIH+vKAFcEnQpko2jnVFz+1tF3WT/TnsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174723; c=relaxed/simple;
	bh=z2j4KcJQv7zmf0c5iq2uhZ0gNgD/LlN6plFD8qvMa68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hF0TgPERo2DtG2GRQAxpni2r72sWrmk4GfwT/bxJaZemhORPUnz/MHipH7662M8cy839DUM/rQ/hBjmxPxPo0pG+kBMUv/lc8LYKuQsxfVN0hCSpXqT4OF7zsHqGpMxDLCWhhdW0pgoT4UcQOLMa8qQV+YO9bgriOpsq1V49gBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICzomQ58; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICzomQ58"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DADC640DAE
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OoNze_CfUy8S for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Mar 2025 01:25:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0D06840CE4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D06840CE4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ICzomQ58
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D06840CE4
	for <virtualization@lists.linux-foundation.org>; Mon, 17 Mar 2025 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742174719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2j4KcJQv7zmf0c5iq2uhZ0gNgD/LlN6plFD8qvMa68=;
	b=ICzomQ58MBgRwCTb4onufFl5uy0tSdeRRLR32yV5VdC7lFQHc7JVkYooX5NOaqK2mS1tlJ
	rpeiJuGO9Hd0QogC6HyWe0yQ6kUSXYoVYLPS9Pe/sJibqPWk8jhjGtjeFokKnHZ6NQDO3j
	HGRH1LdQvG5IWpMmemL95tGOK0rfVWY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-gyx-6uAgP2WM2NEJnO_ulA-1; Sun, 16 Mar 2025 21:25:18 -0400
X-MC-Unique: gyx-6uAgP2WM2NEJnO_ulA-1
X-Mimecast-MFC-AGG-ID: gyx-6uAgP2WM2NEJnO_ulA_1742174717
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so2114014a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 16 Mar 2025 18:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174717; x=1742779517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2j4KcJQv7zmf0c5iq2uhZ0gNgD/LlN6plFD8qvMa68=;
        b=JUqXU2Ql+VQQo1mKvNcygAsfZ4RA+Zf40kDV9d4Ml9dSt48sqgIpAAMpSQBra/I/+X
         4pNgK5BNTNRTnV+VHieQy5dwZvwg2dpj91Db+i5f/ppCcZWHsp26i3Bm3hoJUC04nNC9
         Lptk2FZy8AVROiJr1//oWlj4/u2zHOPGI6YF0rzyxnSuOHyQICMVBYSLVL4nKvODFRmH
         vVvBtbfWOji3Ue7ApWytyrBqd4PYbYw4sYbAkWQF+51lsV/uBJNpIjgC0bPvIBXgQOCc
         4eV8AiAWLCT0Y7AWLB5a0JA6cMN5NScJbTWxhdYbPox+6dATJc75ql3IlukOkPNLw+XI
         UwYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKVV4iNXfjMk0Gf+x3BeHTaXqQok8xIZ9UazSagz3dhhA8Lytr0cktWT87gbs+HQ+0Ca8rWjk+GistA5UiKQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwkS3SXrLsS3cTDp7W0gudbaFdChvVsLPpJ18E2TcoJcwdx7MbF
	TRz/Xiph3HW/q2ROywR93fkNo3IaXr2gFAl3TGWb3jMW/1Q0JSBqI9AzZ1EwiYF9vYiakkJ0LBN
	UDwf1453bXlOY10gaLDlQx9ksmvqN4nPOk6xyZrIenOg5HZsyycveP/dv9wHsYL7TEmHaNwd+lI
	iWYgKdVB0nFINB4MAuHmUGdJirWUreQo972iEbT9+Eogi7XacEC/qn+w==
X-Gm-Gg: ASbGncsg+mVEakPez9CJHUFJWpNi8IYn9NJKp81rFfbq81nPd2j/YwIHI+e52B4L4hz
	0BPcxTY5UNjut+md0WV9XnsadsQ1WTDv8Zgmdwnt7qpfcJkfUtVVxrzxLcJ72EpuwSivHzjxBYw
	==
X-Received: by 2002:a17:90b:1f90:b0:2ff:4e8f:b055 with SMTP id 98e67ed59e1d1-30151d820f1mr12979535a91.35.1742174717400;
        Sun, 16 Mar 2025 18:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhY7Q6CEBtn6gSdQV7+N48LRSWSFUwUYTebXNWN8iyFQF0YN/QWMy1GYMr8eTv0NQFETp81q/gb2zZs+fo6Uo=
X-Received: by 2002:a17:90b:1f90:b0:2ff:4e8f:b055 with SMTP id
 98e67ed59e1d1-30151d820f1mr12979510a91.35.1742174717010; Sun, 16 Mar 2025
 18:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com> <20250313-rss-v10-3-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-3-3185d73a9af0@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:25:05 +0800
X-Gm-Features: AQ5f1JpE0rK7CwWDqP6FbtvINFxO-X4ILccNQzNMTQCiB6CvQEMSnvUz3v4UdcU
Message-ID: <CACGkMEv8g6JNvGCy95x9jRD893qBvhztkCzBy9sFz+9N6A69Bw@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/10] tun: Allow steering eBPF program to
 fall back
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yb6CSPeDbIsxQxzmbamvlQoaFOejAvCphGVn_LajwM0_1742174717
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> This clarifies a steering eBPF program takes precedence over the other
> steering algorithms.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

I think we should elaborate more on the advantages of *not* making
this implicit.

Or what's the advantages of having RSS has a priority than eBPF.

Thanks

