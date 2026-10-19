Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447702;
	b=Fk26rdFaca/Ntff7DddzTyOEgp3GY/904W/P75hOn8XzueB2uNqGdJhnGluyw7eVmWMg
	 t0oK9pcjCMRhAVRVH1VhXOcw8MIcFGxfb+2Ie36I9+mTXdWRDKbD7yfGREc4mulBK2zhP
	 pHZQcVeWAm5k69DPkQV75nmZ3J36+F+0y3FpGIwD92q1kI/qMVSzUpPvhPcSUx2RzmOKo
	 qPDxze0venAsD5CaXYLHTwts/hetex01p7Ps1UMmAnMk/k5DT7sEON45322QvrP8nujhi
	 p6jm1NVbGOAXI8h7WSQr6wFr0Vx65BK9b7MSBrmcojq+Gjd5OfpbT5fn3RN+oNWGjGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447702;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=quSCbZZ7Mq3acy8cy5BNYZd6wRzHmwo845Fz4abnb/A=;
	b=5rTSFR0TmMufi7ARe5GSTfXED5r5TM81/FxolwrSVHjz7CjCoYq9hDRMYwX4V6jXrftu
	 Gj+9LLhd2s8495cMZRyZljgBPwg4zpYswseibOfuO2Pf5oGk/oq1h3cVKhZvOSAyjYlnb
	 1HHK6Cv2we7DUGQxwEXjuAmCqa69oZiOwLfUxXcaXj51M/buMa32qwVHfen0NTKAlsLHQ
	 P+3JEmHj6yBPrgdy2nETcbD+1ArglMUZLoqXcnCptK5j7ulCpHRSaGVfh+9TBKqFlyrkn
	 NH/003ZNE3GM2OtBCFclF+a8OuOq5itQM0BG9Yyr6oezY46k8bd7Ya1KhIzHgCfpgIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="AB7itP/F";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1E606A324;
	Mon, 19 Oct 2026 22:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C1E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AB7itP/F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=quSCbZZ7Mq3acy8cy5BNYZd6wRzHmwo845Fz4abnb/A=; b=AB7itP/Fnc1oPYnH5pd4YSH42o
	2OY2m5EgkaQnfXK0/3PmNPIU1DjOHBAryL3MUewZ5eykRJ74om7LFh0usOxBn8u6osDqFIavDj7CQ
	gx6WCXTpe6bnGYQ7zn6VVbcbGLvQC/BumAliiMSGK5a7baOU7JR13kmW2s/CyZej4JkN9LgFzL0ig
	k0yoWzQcahjgjPUW76eQs8ofehz8dtgF8QC7mWzfdGwIPz4+tT+r1UcignhPisvESnru+Z2+izyVz
	j6UNVO8oMNmimLr3j74WHCsE799kWxWjmKmxEz1rycK/5Sm+xDxAH1O/PDx5zXL8tfb33LoT/fHtc
	C0M4XrmA==;
Received: from [177.189.74.83] (helo=[192.168.15.93])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xIvWX-003vJs-Sr; Tue, 20 Oct 2026 00:08:06 +0200
Message-ID: <609273bd-83d2-7a58-7c88-7e4e01461c1a@igalia.com>
Date: Mon, 19 Oct 2026 19:07:56 -0300
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Baoquan He <baoquan.he@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Dave Young <ruirui.yang@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>,
 Michael Kelley <mhklinux@outlook.com>, Ian Forbes <ian.forbes@broadcom.com>,
 Petr Mladek <pmladek@suse.com>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2026 14:55, Zack Rusin wrote:
> Provide an escape hatch for debugging kdump failures that may involve
> pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
> invocation in crash core without consuming the once-only guard.
> 
> When enabled, the chain runs before kdump only when
> crash_kexec_post_notifiers is also enabled. Leave the late panic call
> unchanged so callbacks remain eligible if that path is reached.
> Skipping the callbacks may prevent hypervisor crash handling.
> 
> Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: optional postponement policy suggested by Guilherme.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  include/linux/panic_notifier.h                  |  1 +
>  kernel/crash_core.c                             |  3 ++-
>  kernel/panic.c                                  |  2 ++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 

Thanks for implementing this! It makes sense to me...though I have some
"conflicting" comments in patch #2 heh

Cheers,


Guilherme

