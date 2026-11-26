Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661111;
	b=gZs3QXuswwa8uRrTbch0TNKDyz1oM4UchQJUcZScv8us38/dvco/vrzN8bz9Op2Svb0l
	 Y4yCpWeV48lgnnaBCo39ib/FjVjeQ3A1zKgCR42Uw0x2WW6mzzyfVaZXSG6gojL1GkdtZ
	 DzbQH3Vmegd8ygaNBt6Bn5TG+2Ol3QpA4zclEiXS+Zvx+zw7or2KfPYG8xjWVZiw1Wq15
	 FHtVfOS0PIH+ExGa1vr9vc2Lic9/5EI5ka3uwNO7TgJg9PYyJHarm9Jf3Z3J92eMrjjlr
	 1EQD4canCSCaFb6omam0dwnC/I6fNMHnzo+09wXJUCtq+9FQMxWkB6KwwwEoXcojobA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
	b=ry/Bbv7f08J96+EdWwAYOqX8/foxWPytmaObL/Z7PO69UNb0wseiJudlvNmMGpPjhWFC
	 hBPJNrCYfEI9d0K0hQKi30qQ+xeJ+tzYTgB4an9DaPIUmMUrNXgCRVAHFkSNi6IfzTEK7
	 tJBUIDEzjkvJ02PDI7ONNxd3tGr0PiZ4Sz8JLFlpakwHz34HnandslrjwtTcmbsyfgDoz
	 OjDukFnRA44xwfLBEe1ZP5rUc1FUAm3gIcBhnYaah08Cau5zud3ezm2Knism7yF6IlV+q
	 6Gm1PW5ZifUVP4iwDuzllHQcTpr3R695Nd5h+f8zbodLLtviQHKxB/oLAFCVAGT44rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HNFUSoLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0184606A336
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0184606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=HNFUSoLa
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0d126f631so57283457b3.2
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 18:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661110; cv=none;
        d=google.com; s=arc-20260327;
        b=KfZSDW7nogocSl+r2gyguo25B9YM5F2jTYPrfoZRskIex5YHp5h/3aOsWV8KYNl2Kc
         tQ14QtaSRUUp6ei4bGsmyrKSaQ/yYI2bYVsGEB5wL5BsdxtF437xSk8qDldLFre7EZuv
         rd7b9c1Y2Fau48LaAjqX7HE/7A/3H2UAH39HLRQkaotEaL7+EQHILHV6goNca0y0WVwt
         hfo7ajjtvmKIrzPunZLB+66XeFPZ+6nTlw+zpiYrEc8VjFlX0tDFFLQs33NmK3W4XPlL
         VOWHnwCUBAKhBigx7DzC6zvCkJjUdJNo8yT2ACEaEth9CKo8M5onG5uW0Dwo9hb58Py0
         PiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
        fh=eIH6xwEXgousoXP4k6lE8Qi5eRtlY4NqKj/jHMJ7ezo=;
        b=qILmlqSybN/r0x0ajWjXupsyGUJifoBr7l6so+aUUBTekKmDrxQt/kVApkV99K7vSb
         GZR8xBdmwKCThzpPBgRt85BG/bJbddRedEGlGy41gMT/xbfkJ6IuYSuBBRLYEkU2mYTh
         yq/ROstQddqx7jmjqumob1VY3680Pr9+6SujMrWcB955gm+2nU12hBLt5D6SzXNY30Q0
         PZ4vrYzxcGzrk1ORbmuYJr3WJWJJmsPmZwQj5edKV6jSFBx9U2+M45jSVkYlDRff4OnT
         6rMmqyS7n88Dcm3rdL/4QPc/4IBRbdMWFLVJmK3u9abb9G3t5Ga2ZRCcieybRF7oCJIk
         0HPA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795661110; x=1796265910; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
        b=HNFUSoLaEc8XZboWdGnaajE1nBpjKZyyIpqPp9qWcvpqXBN6WHnWXyNnGuLr1cDv41
         0p1OAuvsuwKeZr2L8GwrqtgseTlrFjKT8yMOHMd0+zlj1esEESQ5zvzf6qfFxLWKgcmQ
         PFdRRC+D8KXv6IpI7058JShwVOaM0zIOe5XxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661110; x=1796265910;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IxmkvXMkgQnOwD/l5V13TcFkz6M1bjc0D3MhK7eHCco=;
        b=JGGFW95+l+yHYG1s36kf371dMj6fa0aLL4otMZk6Rz0puCVvSLVlCKK/JbS838x8eS
         ICQZ3KYcqjsuazZ4gp5ELK8w83xSoD8vO3tgCkBHt21wZgA8n08VbhdEJXeGRiEDq3rO
         K9tOypDLwYL+b8pCY8NqpyL7BYIODzYyFxLAHW6wyedZIdeO4cFfrSvhM0c5ygeZAzwr
         YeJabom/aTZvg2ojx3KUk90GsL+yUSlVVx8s8/wTncV4syBWSy/K67xvfE/+h4yOFrR8
         4FKUi1TdNHFYq8+eR5Jaw24/7qce+E2Jj44r+87KFUOEebpuhYOfyFAWjHAvg8jERPEH
         pOOA==
X-Forwarded-Encrypted: i=1; AL+hErGD96RVzjoIQNoH2T8J8VZztnUzgCWBtBcer6yuS1SbX7Is3RoK0N2qSXe0VVLoqjhY/ZBrRb9XZANnqsRaKw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Oe+7enj15HGyhgaRutZBeNJ25T9xG/GPMEyr9HD/oropl0daT
	UkztUYfwAeMYTOituT+pfjsH0l0TD99CNAkxgaEQ7wAPQ8x7uVy9WupKh39l3e9yMe5/OKfFqBN
	TVeSq26+eag5MTOI40IPB1rIJHvS3CB0Eqw7dHqXwFA==
X-Gm-Gg: AZFdTZd7FrHk46e1vuuOwKBBQ+chE3Gn7bwCwRaYpRnjids7BX08rk4vF9q3bp2qEsP
	7Fis8D/wxOJlnUYBKIUQuYaVCZdELuWelg1aR8g3PRG+IJofPRuH36zprPuj5bT+V6iGSB5+SjX
	69Gud/RkZ9DaCIj5jswdRDAIoBFcZdUQKtsFosSPT56ULcIStRuoOa0qsrlYBgQgperSnmzlmI7
	5gMglI4i7tFpe2t9m7q7YsET6v+8qB3R2Xy7ZC5MhtBHGZ6s4i/+4i3WO2961b/sZpDUFNzPsjB
	+fmO1t3yM8xuk9g1jdZl+gL709sr4vvlTSs91aDAMrd4423/l7bxi6NcrP/nmCFciw1dRIfIHy/
	BQ1OrXZQz1mG72QJ2r826vYsdRuqr9MX9+6abSCDj0Cu+UVK7KiHtUMmUsoMmYcW0H4V3KHVivJ
	r5dw9yZw0Pfqpb/T8KkeqCcXucKio2VPU/FajBNACRq9L87dWeP53i8LESInDTXABttshnk5Cdp
	SrXh7/1Ax43Uk+N13h+HsEqUqhhOlswxwt/
X-Received: by 2002:a05:690c:4a05:b0:8b4:f721:fd62 with SMTP id
 00721157ae682-8b5204e1c88mr77562447b3.48.1795661109957; Wed, 25 Nov 2026
 18:45:09 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:45:09 -0600
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
From: Dickson Wu <dickson.wu@certik.com>
Date: Wed, 25 Nov 2026 20:45:09 -0600
X-Gm-Features: Aa3M54o5fUDzNBLlbkpaC0Tp4I12r9OHBhk4IL8Av0uSQDqS6MfOSLPwSMIrhQE
Message-ID: <CAFaZ9erbsK1NBL42AdhkATgGz1Ko9Cqweu4Mzcn1xCf0+NSTRw@mail.gmail.com>
Subject: [PATCH 6.12.y 0/4] virtio_balloon: quiesce balloon work before device shutdown
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Eric Auger <eric.auger@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

This backports the fix for CVE-2026-90129 to 6.12.y, the same four
commits 6.18.y has:

  183a08715af1 virtgpu: don't reset on shutdown
  0d8aebe089b4 virtio: add virtio_device_shutdown() helper
  29536a923a94 virtio_balloon: factor out virtballoon_quiesce()
  7e17eef04600 virtio_balloon: quiesce balloon work before device shutdown

Since 8bd2fa086a04 the generic virtio shutdown breaks and resets the
device while the balloon's work items can still be running against it.
Patch 4 quiesces that work first. Patches 1-3 are what it builds on.

3 and 4 are clean picks. 1 and 2 needed small changes. 6.12 has no
reset_prepare/reset_done in struct virtio_driver, so patch 1 adds only
the .shutdown member. 6.12 has no virtio_irq_get_affinity(), so patch 2
puts the new helper right above virtio_dev_shutdown(). The function
bodies match upstream.

Tested on v6.12.119:
- x86_64 allmodconfig W=1 build of the touched objects, base vs
  patched, no new warnings
- x86_64 defconfig plus the touched virtio options boots and powers off
  under QEMU/KVM
- The race needs a balloon with free page reporting plus a reboot or
  kexec while it's busy. I didn't reproduce that.

6.1.y and 6.6.y need this too. I'll follow up for those once they're
tested.

The four patches follow as separate mails with the same "6.12.y n/4"
subjects. My mail setup can't thread them under this one, sorry about
that.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

Thanks,
Dickson
