Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C628F926
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334185; cv=none; b=mtm+8iS9HXPkFwh9cV7zHJcF5oa2BLoH+QJ1bxH53QwhQYxdzInpDK2nx77FKNcRS1wQ5ArR8UhlFDx2KU7Maq+3x/60T2epPUOjSzByC/R/i5QM15iFyG35ZS8KfiCkqkIThNkRc8Kg44aqGl/C2QVGSRNRuAIuRHsZNAQMhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334185; c=relaxed/simple;
	bh=a9oHiuIRd+Lat23wgyOLQVKu0davNOYNyV1lqgu94Hc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aPqEeTV4eLCudbxLMvU8No/l9810Z+FXTF9QYvvfHuyA7KEoOXi9wcBGzzmzR71S/1ncBcxe9A3hq1cNrFvCF631wvRaCYxVBLSDOO7lqpvAkn8PxRnt2ucoioaiN5IWsXxcjLSqSH8aiG3wwM/yjE2imnJvaDPHz4bYf460UoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2SiYVKg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2SiYVKg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-308677f7d8cso4887713a91.1
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745334183; x=1745938983; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR743ev6ExzRYE8cINx+AM9cywgAmFfoIc+SqezuNJU=;
        b=B2SiYVKg1LETiIQHZVzWFSHhsE2xkioRmlDZ/17U9me87k6OHETMjjdwG070mF5wq2
         /TToh45cA2IIxu/VXSzjfxcJgPLzBCXfqSaevaY/dJo32mzxjJA8nniScuhUWzwmSo0q
         Bg2D6+mTMLb1WaAtFvD7Snin0WZ9Es+V81SkUICn0wqUawvJ8Rt48w8UNtbE70Y+8g+j
         lWeurRi0FyjXABwTk2YGzDjzAlqBjw/Qug2ahWvpkL3im53viA2L4RiiFeXIGbca0oBv
         DAbkbQSmt82NsxiXPDG4P1gIObQLj8ceatLqsQ8SqSLGE17oqde+42OEmA40Y4gNg8uK
         RGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745334183; x=1745938983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR743ev6ExzRYE8cINx+AM9cywgAmFfoIc+SqezuNJU=;
        b=syU+fILup7WKHMo4GPsF793TxUBcy8oqa/QBVDyn+K8GnkIC8s4W+c/hgKhSttHakJ
         RlmO5UXefnp+JR/AIkoTa2oWeNH3yAB/dVkmURJT6lV/wCqKGuoX0YQusndIMVVTl9hz
         JhkFHekmQlkjmmQQDPHX5bWlUS9ZKky3kAMP9ak9nbILl/W+h0p0L4f48iZ0qSmcqmgx
         iDOHDq0w+9wp4tbG+mYU87Bp2hF2lBuEZ2gRDe+QCl06iYo2o8VTBZqLdc/RU7Y9WzTT
         7Hqt3giUXutGSKjGQQOi0AQvP+ynYSINuLdOA3zUXeatcB+I4h3IIWP339KurF0DBz/c
         XWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWElg2j9LGR4nPUnUDXKBBEJZAfz//Sa7LIfcUtd39G1yYvqfMohJYaVX5TCqEj7pbRDSxhHQb1tj0Jrz+WLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY1IIlwnKvz6vKrAXEqqUlX+5IbAzR28ZDBf6kFFWV04x9l5iS
	U7hBopnuEI9PTstIlMOBudqnuT2AaWvDonc7yxkCxJXWQVOTjpiESX7PTzdRTbWB6aH8xVry5vM
	6Dg==
X-Google-Smtp-Source: AGHT+IEIapJZJRM9UWSGs3HX5eEFDXXhucM1QTXJfnPOK/9YTrDfsNmQubNfg9xjcSY4LHTjaYmG0pXn5/g=
X-Received: from pjbsn11.prod.google.com ([2002:a17:90b:2e8b:b0:308:861f:fddb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a0c:b0:2ef:31a9:95c6
 with SMTP id 98e67ed59e1d1-3087bb56439mr25794718a91.14.1745334182926; Tue, 22
 Apr 2025 08:03:02 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:03:01 -0700
In-Reply-To: <20250422082216.1954310-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com>
Message-ID: <aAevpauKYWwObsB7@google.com>
Subject: Re: [RFC PATCH v2 00/34] MSR refactor with new MSR instructions support
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, 
	jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com, 
	pbonzini@redhat.com, vkuznets@redhat.com, luto@kernel.org, 
	boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Xin Li (Intel) wrote:
> base-commit: f30a0c0d2b08b355c01392538de8fc872387cb2b

This commit doesn't exist in Linus' tree or the tip tree, and the series doesn't
apply cleanly on any of the "obvious" choices.  Reviewing a 34 patches series
without being able to apply it is a wee bit difficult...
