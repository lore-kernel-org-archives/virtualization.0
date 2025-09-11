Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5E3570B9
	for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609578; cv=none; b=hOLQSPjy9YXbMn7cWs6n81z/m1Ps15v5Z+gFRea5EFvRoyf5fTBYue8ZOZLKkIUazK3HMrvqsJQ6r6uWd/SkylCsqJ/RkJJbFwDzH48n/j+d0QvfSvb00id1c3BAL/pbQPVu+gp26dfQ3g2tukXzH+Z/BufuWsfbtQIuhFkVe9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609578; c=relaxed/simple;
	bh=vhQUP9l+thvJMtD1/dYEHgvswHhptDCdg+aveWF0Vyk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oS9UIVeBZ8dos2ihddqeXRREZJNkh4X8vC2LdQTAc/fFOmJ0ovYodPIluadQLa4PvkrnyVSXHy6n8bCfWqU1H+HCuQgryLwiAFHarNY+go6bE3cmi2i00DFOoS8MnhOvXRUwOIpprUzh8gdxMLTR+po5xOq3kXoIWyJS8cEs0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s84HNcvb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s84HNcvb"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so968670e87.1
        for <virtualization@lists.linux.dev>; Thu, 11 Sep 2025 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757609575; x=1758214375; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vhQUP9l+thvJMtD1/dYEHgvswHhptDCdg+aveWF0Vyk=;
        b=s84HNcvbsSImDE6bBX/Dw45Csl2QhweDtCYZ15bjyqfKgN6R7IaI+03liW9AzDIoEy
         I9zQFLjfeAr37jIr4rmNmaykCoUcmtnCi0FoW4yQ8NsKsd+Hs0AUsWzKpsBQ6CUdsFfA
         Venhqd/jL+Yz7Kv0cAY+z5yPl6ONTvgSZ9+THP+qkyaSzLJ9cymdnVkxtUyUMYidt/F0
         uIDz8ZNg7bm+IVdJ7zFtKZctdMZpXaQHowW+iujQcdBAcHGOnurImGzIWsWqqg5dCxeB
         c96nEKOr+EQvL6KbyVrLlfblux7zFDzz7qzjgq6HSV9JQmo/qPQGacA4U11UbpiNKN+F
         VLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609575; x=1758214375;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhQUP9l+thvJMtD1/dYEHgvswHhptDCdg+aveWF0Vyk=;
        b=fP4/a5JCHFtaRwZxEdj/PTQdxC7Ny4dk7PEqtUvlXojD+N8q90rzDXKEB1E99f5Aqc
         16Nzx628GfuKQaZwcEVsx7xj9SKEyCha78Qe6YJAH7dd1+fUN6Sq6gxZOpOOX5H5XIuB
         DtyjfC0dScvcW+i5w5VO+vo08qc/gzVFNRIHi5VsxyIHUKekmeMQCVhCRYcakLeFjL0T
         ooeOpZ7z3btejhaGpysQGd3oopRNAEvohXKNmdJCgZjd6geielKfuY+6eq8sahf17meC
         heg79LLMCyOdJMfIGpUAeooDz6Gv2TuJ1TD4Z7g/xp+6sBDWcx7mLPMh+/lfW0ggTC6r
         7rHw==
X-Forwarded-Encrypted: i=1; AJvYcCU1wwtsZ+SgGFwPjs1XYfAzRZByAsjocTovBrKeNVd4N5z2aZtRa41Ixse1LzPFa96n5wXFZTi3/eo36lFqtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzijGY03pDfFfTTiVGyLUBGbowV0uq0Ow0zwppKNJLOkixGFsl
	iEFiedZ+WQ/yYKmITJxfnFTMuhX718Mo3UsV2leSLOSteGDIAvo2NExkg54RjJLAEzCYWiFzHMG
	qareHJ5lE4JTwbJleO7Pu4Q3xmnGLC0+cRUSHaPk=
X-Gm-Gg: ASbGncvZGKuLdPrnbnRBDRxpIeog19VpKKTA3GLCe+O+pIPVuZ4qkcwG1sbFntdBvXT
	pPPEtl2QdD9/i2d82fGOtUHcKLHQfx4OE8yxNlWp3q1XO5/pS00wBhsT6AI2XLHU/2jAP4/QBb0
	WybU7n/UyG0bdXk2uNjWi/m7CJuc6jSx5RVt8JQp8p4lSto1PRfiSmTKLxSJIHRtcs+oUXzzmuB
	CB61RLQYHzsHLHZXuzabqS3x5Zy6GArPEDQowpbQu4=
X-Google-Smtp-Source: AGHT+IFHQ6718ttGuQ+Iyu+zPqHoUtHQuv1/myXFw5IFAruLpx8z+mzrnsVyXUH0IbgU0OlhLF0hrCR132KJ1dtMLng=
X-Received: by 2002:a05:6512:3c95:b0:55f:56e4:a698 with SMTP id
 2adb3069b0e04-570489fc8c0mr49932e87.2.1757609574407; Thu, 11 Sep 2025
 09:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Viet Nguyen <nguyenlienviet@google.com>
Date: Thu, 11 Sep 2025 09:52:17 -0700
X-Gm-Features: Ac12FXwT1Wuu-xhAvqGxy5a_Qp_iOhd-f5nqEhIjKF-CEzx_emjZT_aWTO_Ut5E
Message-ID: <CAO4PGyoiGiUR0LbRJ_6=YDKrnFO2yriH-M7bSLcpKzjvLe-mtw@mail.gmail.com>
Subject: BIG TCP support for virtio
To: virtio-dev@lists.linux.dev, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi all,

Is anyone working on BIG TCP support for the virtio-net driver and
vhost backend? We're trying to do a POC for this and would be
interested to know how much more throughput we could get with BIG TCP
for the same amount of CPU spent on vhost-net threads.

Best,
Viet
