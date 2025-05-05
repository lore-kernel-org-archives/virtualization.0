Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9C25B67E
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455283; cv=none; b=p+FlDwfbwH4q3G1hACLxXbnmZ9vzDG3MR0nKw/nD2cgCxBfbGwT/5QdEiC6Dcm0kjxy/MQPcq+HkrR7q8gM/7/2UNodxpkYqEcaq/G7lO4ImS4SlScP5t3cwmQpu/YAy8iOP9hmb+hLuqGrryvT6lzAQcSlUv7GR21Lb0qXvGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455283; c=relaxed/simple;
	bh=8bG+q9cvIxNRKMt+IdST9BOBQGsJ4SSG4cIoMmhVp70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJwjckHW/jxscnYQ0qK/Rv5zge4qhS36oJxsig0bYnQyHJkZ1D9yw+N+zF6QZALZ7athMMALgXchkDigweWbI7fAm9t8A433jSrMaYOzEN71cHI/vyZGbFvOIZ7Mf3jRFTGA1qc4CkdmmAEsB/3uB7kpvI2Lcn0C2x/L2tmKbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FozA6eZ4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FozA6eZ4"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso8325533a12.3
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746455278; x=1747060078; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBzMpH2jBdczGJAGi07riCizg5SErgbDrt1biXSYE6I=;
        b=FozA6eZ47e7hrM/bseFq5UEl/h42IaYtSkUn4lAcdVhSc+NI7c4AYGxRnh93P4vxAb
         n29IjM3hvRuVErXe9SnrHoF1+9+OhRd9AYU4u32x5ufnVeLoT4pe4BmZmX3j8OkWl6r1
         MgdIMCxHEJg4dl3AmDGerkoaG9xo9AqhomGvPE7LVIYQnh8kF99ADsS/iUU8gJTTEgOx
         gyMdO91CtsrNabNNFbD/W79dbvSnnHPOa6MvcsRo/tSfITzAOjw52O+/QdvbZnkV5SI1
         cr4vLiAsVJwLnyQ8aHaNMN+Yxc5ePbUsqkOEXBMLC4cQS3rDJrm0rIj3BSkHH7FmAIhp
         2Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455278; x=1747060078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBzMpH2jBdczGJAGi07riCizg5SErgbDrt1biXSYE6I=;
        b=U0et9B4WJBhp4Zwv9WW+2wQOrOE6UvivEI0glb3BinPk16gTqBIYQlXFachVVWcGHA
         /X9+dXx3nwrHMJf9Q/bmkEfXN8j5LFFXfW/NNVWBj+4+fJdOqC4lSYcR5GUf0t6TAjt9
         2XM9ASa6ntqy2+g78f7yGnJRxsSl8JaUYEyVQSgiw2XS0Upb+zWv8or/bUfsG5ycgVRN
         x7QaTDGf9O6T98pLPmbojTdLYEgnAYKtIhhtke5JbK6i/9rD46a3KZyzklFjICuhMJ6e
         FGq70W+GzJzvj9md8Y262McS56Wc8fooOrOPhCEfOaiNRnHnECErrBz0WMewjnvpnW3r
         6k/A==
X-Forwarded-Encrypted: i=1; AJvYcCVpFrymCgBgwc/xozj+S1ENnIyYg0HVotparWszMaLzqxz8dnWxtlkAiu0Txw9OElsqGOHeV4j8Utkr0nLieQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDzxxePvPKoP3RPjYTq1cGlEggFblh4fudkkyf7jUYuq1hsHqA
	skoulUrlQDPNJpkFSNTv4yTYPHGG9qjMGUiRXi9PlDda6zsYJQt1BrD0YatB7ZI=
X-Gm-Gg: ASbGncvbeFLEo+HHkVrUvH8btDF8MVkNj5cjsfU8uKvtAEjjqAuHUJ7p75I8tRzuY23
	5s/ysC2ab1XCvKPRz1De3vafpXyNbF8sRpTf7JdBMGfJicqs4OHv0ZuEerQ/ED3fi3g5AewePLJ
	QRSDrtvuPOpx2TFQID+zfz6DUkKKYNrqzmxJEPnhi9+ulT2ChkvJbGaUtd5nEnIfeHm6SbPr3xn
	GD4amYu8WZ9c4GLz4UGntqS4TzKZBVMS8/nNLnF0Kdl2YgfxBcFu5V/cX0e3OH5/Yss67HKtOP1
	XTWItlYRwiazomkqf/FFNonADnTnqAO+8UKxgsXJlXMLKJrriLeefg==
X-Google-Smtp-Source: AGHT+IExfE0hcX78gw0nn1iPLAnLmMN0HdxWQnnSN8VNB89rL2yQ8NHWy4t+WCuJ1B8DNVSnVHuwAg==
X-Received: by 2002:a17:906:c115:b0:ad0:c6ae:c0c9 with SMTP id a640c23a62f3a-ad1a4ab7f0dmr731420066b.40.1746455277537;
        Mon, 05 May 2025 07:27:57 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a1f2dsm498974566b.40.2025.05.05.07.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 07:27:57 -0700 (PDT)
Message-ID: <68e762ec-d320-4077-b321-63eefefe6d7d@suse.com>
Date: Mon, 5 May 2025 16:27:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/25] module: Remove outdated comment about text_size
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Nicolas Saenz Julienne <nsaenz@amazon.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Naveen N Rao <naveen@kernel.org>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>, Rong Xu <xur@google.com>,
 Rafael Aquini <aquini@redhat.com>, Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Brian Gerst <brgerst@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Randy Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20250429113242.998312-1-vschneid@redhat.com>
 <20250429113242.998312-23-vschneid@redhat.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250429113242.998312-23-vschneid@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 13:32, Valentin Schneider wrote:
> The text_size bit referred to by the comment has been removed as of commit
> 
>   ac3b43283923 ("module: replace module_layout with module_memory")
> 
> and is thus no longer relevant. Remove it and comment about the contents of
> the masks array instead.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

This comment cleanup is independent of the rest of the series. I've
picked it separately on modules-next.

-- 
Thanks,
Petr
