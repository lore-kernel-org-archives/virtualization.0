Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719AE30C169
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417089; cv=none; b=M2ub7uxNUmO8gIRQt+ALszmGBkS8NILUntm/yWpCdcKR8O1fNXrmzWtruRibWsFsbecHeJp7TW5lucjLbNUOfRH+fPPNz3Sa8UekFytV4573LQTXDg4eRZoTAWxBFBn0LE+WtrrUokYPJEd/Xn/7YjtDB9n4wvszMYe//p/TPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417089; c=relaxed/simple;
	bh=tU5N0r9FwtfHpj+P6tjN7upqCW876wDEEdAUbaE16vE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HU455p+6g2CO2eM8Y/Mr5LmuNJPH04iWQUmW/g+9qJyY6I3+uPIUKGGtJ/R1Zy46RuU5YX2gr9XR4kxmIXrQJd7PYsfQr6Mf0lycx18wY0flciF+hIJe0885zf0YXYpS0kFHi3AflwCS7WhI0AhRsmHcefCYi+RcaUDMCF8Avf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQQcmPNv; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQQcmPNv"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5178aed25baso2527011cf.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782417087; x=1783021887; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEl+dvrlA/1BaXCnW68WdI8mPtRNezx6QmmM4W52rZs=;
        b=AQQcmPNv6XBBRJKhcuAy+LLJ0+VipslrZXSOvazM0qaOVPdaRExk5Ov6P8lOWTk3nD
         Rk8cSMGOEpk7Nr9EMId4tOrQIN5XhWSRNPnMOvQ5rOZfJC8kqSMuBTFQpPEfQyZkpNXC
         rnTk38dc8PkiVNn7Y71FUyjbNMChPdzWKPsqFutWMLmAkqPFChuslR6MaAvT1QNOsg8Y
         50oNFbIgn6+4OwVja4aqfSp4YFpmN5T+AywTHzfKA2oXvWTZdwNYgY9d5buqKBYJ1s/6
         c/yQ/TBdVEpyc7cZMx8qvuWdzNvCyaOY1t4J4KunX00MRWHbpG0/CEwBNylLmN1xwjkN
         AWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417087; x=1783021887;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEl+dvrlA/1BaXCnW68WdI8mPtRNezx6QmmM4W52rZs=;
        b=FD+Kumy5j6ronnRBAxA3NYXlinJ3QhtAqLqYD8X/4NdukZ90UyUx28pckjnAqQzUA0
         95UE0WstF+iBx7ZcaXD/uRKeZKRXwiXkHksF1Fq/KKTr2cLeiLGQZ+uWCsASG0k5s8x6
         WDWW0O234TmXIodpQ5Z/7FAYH/Lmgb1sGRqXfKRfjMRTBxtOuYgVh1cjBNffZGma1Mvx
         v8omNqe4f72Mq33/ah5OWkZcSyjlMDziIAuOX80ZyGI+29bsGgBwmNas8kcWqM21/cuB
         bvHZSmApQ4wFhlbodVn0f+xKjzNdnv6OIgeomncKFJ6OftkaOJlL/gheLmq6SDiGdIQq
         kaWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cqxZAnH2xxiuv/uiiqpugWhk42drQNPTZzQnc7U35ut/DhG4KnCtI6sqVDLzj5ybMICF+Wy6oBL19SMirvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH86/3SwRvJJK3I3kn5IpjqAh2CypL9V0TG49hvwUD7jnMTxKQ
	+a7vWrUo3r5Bw27ntLGTqSGFzJfpgnDMP3QddwbwDDOO4/i84Xg+3iysZtDFB1Nx3AD1+BYlAhC
	OKDl0EQsP8Sxq+/goHijJ/ySRtwwS
X-Received: from qvx15.prod.google.com ([2002:a05:6214:ccf:b0:8dc:38bc:a342])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7d56:0:b0:50f:6415:1eb4 with SMTP id d75a77b69052e-51a727f83ccmr49259841cf.49.1782417086818;
 Thu, 25 Jun 2026 12:51:26 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:50:15 -0400
In-Reply-To: <20260622170054-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625195031.2959766-1-briandaniels@google.com>
Subject: Re: [PATCH v4 1/8] media: virtio: Add protocol
From: Brian Daniels <briandaniels@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Brian Daniels <briandaniels@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, 
	adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

> > From: Alexandre Courbot <gnurou@gmail.com>
> > 
> > Add the identifiers and structs used to implement the virtio interface
> > as described in section 5.22 of version 1.4 of the virtio spec:
> > 
> > https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01-diff-from-v1.2-cs01.html#x1-82200022
> > 
> > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > Signed-off-by: Brian Daniels <briandaniels@google.com>
> 
> 
> Please put this under include/uapi/linux/virtio_media.h
> 
> we treat guest/host ABI similar to kernel/user ABI,
> and tools know how to find it there.

Staged in v5
