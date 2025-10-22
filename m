Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DE3337B88
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132119; cv=none; b=WO66ISGi8utQhyITydF+LJA7hFmbzZvDO4pqWE22YD56KKbWJGUsPmRsMVF3VOR9EMZuONg4X9PiOR3+6Xdse518H34HDp5wXN8wozbgmYrgsvoGWhs8KWQrGrDe+e1VTj0HKHkAcz1SXGDo1EBkQEl3bCZN5A14ANdrNG8G0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132119; c=relaxed/simple;
	bh=Q3P0mngqw+MxTDjBMsYVbpSuJ1RVSamK1Hlisc8kzxY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l0FhMCVLr+GtBKA4LrVNZaUkmRIZkEsm3h0MtSrlbbZL32F0KvXdXsyzIm6alR4yO5ieW09agMGWKMyaUdyBLrIlTz//4igA7XifuMO819U1q92/TGZHApAbqxHUt8l0u6ZhfdiqbXI9jPqg/FJu7+XxpdMN4zldRnD/VPoUWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ORh0YEFT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ORh0YEFT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso6017683a91.0
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761132117; x=1761736917; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3P0mngqw+MxTDjBMsYVbpSuJ1RVSamK1Hlisc8kzxY=;
        b=ORh0YEFTrj/9G0B1jjFWzAr4Q7Ujhzz5H+lPvtFE/FhYdXCKfhDWFCSV+ZoDQX1OQm
         4pQYVtZiPw0gvUTVtC4H54ipTIDFbHmccnvhGxEh1FiptMBYP+d0K8U9KHFGWWze1VsU
         St9ebGkjoWHwunv+nRSGc8dkuxuY+/U/hjCN6flzLyTct3OrzwrTZNQSVwPqQQDztclh
         fwUb+lkRy3L8VZB3hI6z8V1QP1zP7b3/MsSartppwRR/3xE9ugWzckM8zyGuUqRmzxbC
         8d3Q6zJtDfGLO+HTiMLoiiwdjJYeN+bLyDYVemSz6f9bKXFsK8xxkEAFtxbuPPhKnGYH
         r5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132117; x=1761736917;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3P0mngqw+MxTDjBMsYVbpSuJ1RVSamK1Hlisc8kzxY=;
        b=qlLGagLE8RCm63k+4LVUndH/ZQd4u90K0FywXyToOuPwZ9ZFnXx7oK4noVlT89nm5s
         HOZ3JnGkXi83ySW8oHCBkVzGmO7fxBzo7u5HQRXaEBKjt9AdKIVghIqFUfLdsg2w0jZs
         OQn7aP4ND1e/Cibi+E6BZSbcX3VnIj+TGFvJ5ujJrpl6N2nrLPidaeObaJeC71npmWea
         rJKAH+WNfbyR69/UmkLYjjDCuYQK9By81N0/q4Yo6+75sozZoVJuhPsi0GeFieYZcpV1
         b8mnGdgXcoYf8DO8FWO6pyYK1D6cmc5OvaRagTKrk9o7sIxwQKakhbc+13ai/OQpdVLP
         /hsA==
X-Forwarded-Encrypted: i=1; AJvYcCUz5ZYcTiS73T3ibFpA2Vy42KS61k90kN6PISULxMGhhUTxo9jOLBTTIQvgrdBf0RzgljUdK09clGMx3OJjKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKCHQdffx14Xeh3vBY3azWgaeJJiMraPs9rtgugEo6tnMLWElL
	k74bnNdtYdTFEP9mMfGJ+1VH5q6fIc4JHjkgLzVukMuI7/npX50vNinCJJb25gqakYBDuuXaxua
	IkkGmzMZtiwd42PO3yW6l54UhVgbEo2B3J1TMz/wldg==
X-Gm-Gg: ASbGncvRe1s+e/TF/lGv3dw+CSwxVZ3iIWNjkhdr2/5TmDshzqiUHVgio8iJprmLIwn
	oBXWx2InWpViVqo1Nwlu22dAnIFestPzDlrel1+n1u3Lhdf0idC+9yeBcj1vDF+hkFYMeVxOlqy
	IBKI9indme2KD+cFm3vcCjjGPFrPBxjCzSkLC5RBZhyutY9edpK5T4/aBLFGz33okGyfP62tcuT
	y7kph51oPYpt8D4nBUOMMvGqnApOyIdbuTOkcEfc03ugGZswcC98tmnC3wKiACq8ZoNrabY5TEh
	F4NYxUejMB5D
X-Google-Smtp-Source: AGHT+IHa3wuQcTjExPPSJzBPMBJ9g70Q8AQa0d+5QYkQmMMhHayVLpv/U1M9+eHHI9hx/eIZ6uXoC9hl3g/zY297f+g=
X-Received: by 2002:a17:90a:ec8b:b0:33b:afd4:efaa with SMTP id
 98e67ed59e1d1-33bcf85ce9fmr23869847a91.2.1761132116888; Wed, 22 Oct 2025
 04:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 22 Oct 2025 19:21:45 +0800
X-Gm-Features: AS18NWCP0By6IcndygV40Ld3pziTkKzfEZ4ZYdcFuv-yvJad0zApo8-zeoKaUHM
Message-ID: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
Subject: virtio_pci: Question about virtio_pci kernel module refcnt
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev
Cc: xieyongji@bytedance.com, =?UTF-8?B?5aSp6LWQ5byg?= <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi,
I noticed that the reference count of the virtio_pci kernel module
in the VM is always 0, even though there are at least two
virtio block devices and one virtiofs device in the VM.

Using rmmod virtio_pci can unload the virtio_pci module,
but this renders the virtio block devices unusable.

I wonder if this result is expected? Why don't the virtio block devices
and virtiofs device hold a reference count to the virtio_pci kernel module?
