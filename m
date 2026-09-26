Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D13547063
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790407915; cv=none; b=WKSMn+y6Gq6YrNVMF7T6eLGturz/0VsDqp8CyvWEF5lV13HxtSgonDAJQ8LpeANxoVreQOJSsVgwtdL2lb0ZJhNHrMdVX86qIC7bXGImvo1GwVB2nZHwXblZkGrtUDJKe3YcZaOu/KFiq3sQ9NswFEpaJaLsGk5sebECQJTT7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790407915; c=relaxed/simple;
	bh=kzU8QNWm28e2y70xXRJErhWUPUtjovS2IQKpU+gp4tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV5C1NO1r8a5TlSH6P7wBAfGIMHGuEYgfEMXYa37D2wLGfcl/SJKf+9BFSgrbK7KZT4eixYsYuNKir/7UBGCz8prSBlMyi3CKqv/+fqIU6kBXF9+RWFjvEKXpw+wf2CglxB0cwb1BVSH7HxC88UUmO6lAjkDN6ymkQllleIIGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxnodjwW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxnodjwW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71974de4so922715e9.1
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790407912; x=1791012712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RkvDHiMHE95iZAf8lTowG72tJREbCH/YatR07v+AyBo=;
        b=LxnodjwWivE9BWt41NkHvmfPqR3nTlS0JRI/nm3yusA6MV3JMZXd578dVqqYkt46v2
         AjEyKQi4r4EGT+TbHm1npyGEu5wJfGQ9yUBr8X90T06ztDh5bnVAxQci/eqJNcriJeI+
         2aC1hVo/PRegRD8FdbDksCk/Wyp6DZZF5rxP1haPMl7FROWxHnN6Lo21FKEdvcPhgjNy
         UnOdozR6Lsrlh/Ed4BnBo1VhTJ1Q6qTftYiulABKiqJ8iclufrUK7CXbLsDOr6vx6hxd
         3rNZXP7875SdRezG76kmpEFgHTKibTEZlLaZEquGg1TEaurpHJhfsUAOEefRgX1rETgQ
         wgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790407912; x=1791012712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RkvDHiMHE95iZAf8lTowG72tJREbCH/YatR07v+AyBo=;
        b=JkZjwGNQHOrFoI62yQWR0N/HhREZBe9v9kz3qrkarcKfgXdJyQZKMedwngyUzsAKZG
         YnR9NRgxz30RX1lIV72lEi1IR9ZPBYL4pf/36oyQbwYgmFdWQHGhj4NmYt7ptCSLE7cd
         hl+JW4u0Lyqx34nIUkNvKc26m05LrxL1YnrRCvhqBvUHNCTHMFS+E7O+7eWwqODL2JO6
         uC2t01lWgMFnh1DXiDLwUe6kBkp1hciIChdGwq2I45P181zVUN+cw+WziTN2pr1Dj6Gj
         TR0dX8nANSgyuemHQ6TO28+8y3leZPXEgKL6MxK1PBV3b0ZOJ6kTMmFpynjgm5mF+TQt
         WqAQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8WkFEjpj02OY0ha+QfuTU8BGSs3wcgWqrl2GnfH8kw2d/ls00YilxYOZQLpTLCsn6oeIybq5CiEnCn7CMlg==@lists.linux.dev
X-Gm-Message-State: AFuF++nf/ztwhEvNu8LWlgiBZ2d2HVdznyK/emnfAuYdIdPjMiQyk55C
	OpUV7twFCtemF2mx2EjmKutLkEv3K9EMU9Wb0sijAFAej4Owh1C6ppUt
X-Gm-Gg: AYBFou0SgBtpCsPcRyQP7bxZXigIzGXvrImjVXCBmEC3jXNTKuF+MR4aWhhOtjNK/zy
	IZu2jhaiAVCsK7MN/J+WlIqAzj4vAXa+7thJoOQWqJbgAWW0m5IiY0mEYujCDZam6896htBqBhG
	W1tMiDBcjwW08oWPt50q7Z94wh5JcaNzoK47ybtWMQfLGrOSfm2kJrg1cSHWQMeDdXU1eswCCrl
	jzS/qkkbhziM3GWtnYuaqNRgWV1lXIsCLepetkyVDE2Xh6W1WSsCcdbuZ+WIii3qwlFBvkI8VST
	g6+35GKFb3n2uUscqMmWVfDwXlu353kV7SHNvSrpKWlrMQerxXiymzNOQQTH7lZRuMFp5oLUvQJ
	594j8e51JUJSaeZc/hAMonKj0ZHVxtRQfWNvh6EBC2S7K3y9eurPaKs/ELddqy7LHAvtvZuJnNL
	ekmX7C9OpEKpXGnYeBXT5+MUW7KXzN7vAEnT+WCjtKU7IB8zAJcY9vfYA7lVrldWVv/mxWBi6Dz
	9Bkv4zNfBBz3BS54F1Q84Pu7Q==
X-Received: by 2002:a05:600c:1c2a:b0:49e:7cc6:ec88 with SMTP id 5b1f17b1804b1-49fedddbad9mr107313315e9.1.1790407911686;
        Sat, 26 Sep 2026 00:31:51 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349fa1sm18198789f8f.8.2026.09.26.00.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:31:51 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: sshegde@linux.ibm.com
Cc: arighi@nvidia.com,
	chleroy@kernel.org,
	christian.loehle@arm.com,
	corbet@lwn.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gregkh@linuxfoundation.org,
	hdanton@sina.com,
	huschle@linux.ibm.com,
	iii@linux.ibm.com,
	jgross@suse.com,
	juri.lelli@redhat.com,
	kernellwp@gmail.com,
	kprateek.nayak@amd.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	maz@kernel.org,
	meted@linux.ibm.com,
	mingo@kernel.org,
	pauld@redhat.com,
	pbonzini@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rdunlap@infradead.org,
	rostedt@goodmis.org,
	seanjc@google.com,
	srikar@linux.ibm.com,
	sunlightlinux@gmail.com,
	tglx@kernel.org,
	tj@kernel.org,
	tommaso.cucinotta@gmail.com,
	vincent.guittot@linaro.org,
	vineeth@bitbyteword.org,
	virtualization@lists.linux.dev,
	vschneid@redhat.com,
	ynorov@nvidia.com,
	yury.norov@gmail.com
Subject: Re: [PATCH v13 01/13] sched/cputime: Add kcpustat_field_total helper
Date: Sat, 26 Sep 2026 10:31:46 +0300
Message-ID: <20260926073147.140907-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909135617.871006-2-sshegde@linux.ibm.com>
References: <20260909135617.871006-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Weekends...

> Provide a new helper function which sums up a given type of cpustat
> over a specified cpumask.

> This allows the caller's code to be simpler and avoids duplication.
> For example, subsequent patch in the steal governor use this exact
> same pattern when calculating steal time.

> @@ -207,16 +207,12 @@ static unsigned long hd_calculate_steal_percentage(void)
>  {
>  	unsigned long time_delta, steal_delta, steal, percentage;
>  	static ktime_t prev;
> -	int cpus, cpu;
> +	int cpus;
>  	ktime_t now;
>  
> -	cpus = 0;
> -	steal = 0;
>  	percentage = 0;
> -	for_each_cpu(cpu, &hd_vmvl_cpumask) {
> -		steal += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> -		cpus++;
> -	}
> +	steal = kcpustat_field_total(CPUTIME_STEAL, &hd_vmvl_cpumask);
> +	cpus = cpumask_weight(&hd_vmvl_cpumask);

nit. The cpumask_weight() change is not mentioned in the commit message.

Thanks,
Kayra :>
