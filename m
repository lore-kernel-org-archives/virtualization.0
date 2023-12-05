Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CEC14F85
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRQB/F1P"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D698140873
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D698140873
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NRQB/F1P
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BddBxdZNWKcz
	for <virtualization@lists.linux-foundation.org>;
	Tue,  5 Dec 2023 07:12:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E166405AE
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Dec 2023 07:12:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E166405AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701760340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8PpRlWVKmBLY4m7WqUdlyiCHNHYVrACDDszq7chrUI=;
	b=NRQB/F1PkpklfQRdJ8H8mF0141uv+4hSnyzRKkh8iMOWXy58yGAqhR7Ims1bCSCY1Gmx1B
	EWwkaOeU9IXd4XwfpB+brL35rNT+ZLCPhwnrAp8cfu+sbzsg8+iSVIamcCOMOvC8lB7QZt
	btAjG6vr60zXD8JKnFx3OpTP3GZjaC8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-7jPrZe0UMpa0cfxAUonCBg-1; Tue, 05 Dec 2023 02:12:19 -0500
X-MC-Unique: 7jPrZe0UMpa0cfxAUonCBg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50be5bdae9fso2148398e87.1
        for <virtualization@lists.linux-foundation.org>; Mon, 04 Dec 2023 23:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701760338; x=1702365138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8PpRlWVKmBLY4m7WqUdlyiCHNHYVrACDDszq7chrUI=;
        b=me45qMD9Y279jUHg/P2NoOXyyWopjAXxpNoBckTCjPlqYxwiiRhGVVGxogEbCb/HmE
         PL0j+iczRXLQnVLg/RpqframNyt5ClBktbv4LoU47KCjw/puuJJMgC/Hv6EF+wIPcxWX
         C1B+psbSpYnrFgnN8R78mMLMvc3/5nRnLndwsgG5fZ+UYI3XBjuGkkU7W4/00ewxA1kX
         8KstTBTdbn4Gl/tmpTQ5IyrGE4aIv03oU5X70WKOEyfpeG57kxaFJomvus0SbioCX3U0
         Gq/HOneSCVnYlcIQa+kct4nAabrBCufZHSHneXkLrUMEOcT++sNlWXpN/pczwzm9AkZ1
         5SSg==
X-Gm-Message-State: AOJu0YyEW2oW5kFHZpE//NlZtnaHhYNIirWPlNIKa74wJEgNhdhkrWCP
	MD+wqCxRmuSgo1QzYgagKWsDGHZU8RAt9kg6hv0kqgck6DeeBpzUACK8qX+hmHx6L8smBbdRh/+
	fERNAFC+4Lm85rgr+E2QJL6tQhkQXtha3GfsoaFYIkvce2wdQ8RlkpQhIxw==
X-Received: by 2002:ac2:4f8c:0:b0:50b:c467:7ca3 with SMTP id z12-20020ac24f8c000000b0050bc4677ca3mr2926339lfs.22.1701760338033;
        Mon, 04 Dec 2023 23:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTG8HDsvKr5bI8NRefMaY04/0J9+UJRo9HdPJYVjyNC1K1x470rRfakiJVJE9ray0L2f1WT8oTnpmXo7Aw14I=
X-Received: by 2002:ac2:4f8c:0:b0:50b:c467:7ca3 with SMTP id
 z12-20020ac24f8c000000b0050bc4677ca3mr2926334lfs.22.1701760337681; Mon, 04
 Dec 2023 23:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com> <20231204072331.73776-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231204072331.73776-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Dec 2023 15:12:06 +0800
Message-ID: <CACGkMEuayLkkZ-6rs3k_WfJAF_yXcWjA-vGiS+Zcgcdaz86geA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce virtqueue_detach_unused_buf_premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> introduce virtqueue_detach_unused_buf_premapped() to collect the dma
> info when get buf from virtio core for premapped mode.

For consistency, shouldn't we call it detach_unused_buf_dma()?

Thanks

