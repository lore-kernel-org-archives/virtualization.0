Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477576;
	b=VVANZqyKm4fx9FxVUPl+cLlNirpQUXOxi/NpltzGAByr7qyJA9opFeG4LlnEQl5o/m7Y
	 4tLG1LYsIkfY/MUVHkKhfEUNUgpVTnfnZmTd+ed1bqQrbdZxVPsxCDOobPI61AD7S5FlJ
	 siduq4uGobngmA2DImNzNUOeccbNAV9yzL3AuLF643laQrapKejuewyxtb8hSQ4hIbwMe
	 2kMn57Q/A6f3GXN8q7Zkl81qIqFT1J+sReaatHC/tvgZlXIv+sMFzUpMgMISOY38tEKBb
	 IXgD2EGqE9Nn6xIAgwWqdnjDMHaTPmnu6RNuPYhnckDcIUNJmeRz/HTnjJRCxv8oPzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477576;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=QW2v1rbRcBcXiGETe7ORF7SmQ8ayMndDkPMesbNu3qg=;
	b=Nol5CLsNUnV/JV2hLhqcYIzZcEL95FwsUJ0FqOLTqlYQHa93zxJQBXDnnaiPPuwX+QE4
	 eUEtlLgtxs7x4djpQa1qyec8ZuKiM+EoyJ0XFoRqm0dJjf9hcA1ViVsHyE/YLOL8zykwT
	 d5kd5iyrM+T6Ij0Zb5u2+bzD/1nK40+xFQa/VmuEIMsnVGYITkgaXNXv5cSxkO+pepDIr
	 a6hTV8M9RPS7ZdzMmLLVlqKcKr3E+0/foWVYC1N1oo5CgNYl6HrQfZ625RUjxpfFkF/jS
	 H/B4NBd86+/tKamtP6FXS0TJ0Wm9l0Z5VZDx7WhEp4A2nI4l5a2RWV7C6bFiwjpcaVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Wb2M2k4U;
	arc=none smtp.remote-ip=209.85.222.226
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C0606A326
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 23:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E66C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Wb2M2k4U
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-949b0d32315so334534985a.1
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 15:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795477575; x=1796082375;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QW2v1rbRcBcXiGETe7ORF7SmQ8ayMndDkPMesbNu3qg=;
        b=Qwzwh8BUEJcu5bfp6sr9ekm0OhL1dwzOS2s//NHSRxlNImvoIdAmTHxJTLu+2fSJo8
         muTJr1k5HIsN+zHdqPEWr5j3pltoQgBctvKt/kojSSWKBnKaQdhBLtdGNtT6CABJhjlu
         +vuFao14qYXvJ0EtfVhWkFm8TYtroLHvCc8QPa6ckKVBdbzP7dXeKj+xxXjx4Y7IEgIe
         KRBqL8i77Q/meGVkVsrTdCjW36b15kvnSXyUS+1o11zKvu19UiIGvmpoL7jppHIti/2W
         CVJ76+5/tw6GnsO1EyGaajJvuwWyBFuZ+j+XhqI1C8EnmLHGdX3l0seIZim8ZA9c1/tT
         zTeQ==
X-Forwarded-Encrypted: i=1; AL+hErHO5K4pVmSzmJKCUiFtDZWxFTWGgIJWlZS+NbrbgVxclKrNPZYuPbCNts8wqG6nDsqwxjc7X+92V+iWp1GuVA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Mh9+Yhg25yX2gFmyoT8dZbR/fDWWzPx45kd50ELqTvaGTnl9b
	23SEgGTFORT137JTy6hA/b1eLY3eWLHBAqt2T71s/AYmCqvygOkM4d+Jg0bjidySXzNXAYsTiWn
	pDE2UzkzM8wvDCn4sku9KymcfvJLX0yEaKT78uicLXohFSo8NFseIN9Nsqz+ARbJf4ZpRNQgY8r
	MYd/J73AGE97je15pKD/9CU6sZPQNX5sb9/fseFx9bkUWrhqDoYFppeA6uS2+L0nFP9mSYkI0Hd
	yYHDX1Vay5HPbkOKJ6Pj089kHdGWn4=
X-Gm-Gg: AZFdTZd/cBeUvaKbd9QkQicWT/N34IMUKBdEb73+XmZCLCg3flGTTMdZpdNcc19N/uJ
	g+IXZO6PAYUMttNbTMe3LAqMRGD9APmZiheEMh5fP+X4rqboTHquVt5ovyVrFXybCZq36X/rxv1
	SwYU2uY6p7rmqnPJqgvYe8k1KuqXkcBGAXw3y+jC9pla0WmJpIIhAAM7NNKEVqzz7sqTiOo6Tc2
	uLEsdoLlDRLLUdERYogUJyRZUJ80AT+YNpPnpJY2ylQJUu0KuJhNSwUpIOsuPb1vijlNF+Ppa3k
	VpsiNoFiW0fMm8dlt/dIfP/Z+AIzRxHtO4jEiAwCQvDBFi/uFCSF8gCcvonmoeswSWiOXykFowt
	OwVVYXhVJbSOJtb7vrVGIwiiQ1JaBVt8mzKGWv9QZRlwRsIy1anvwRJzvJ/zvt2bYJV5gKR1GjD
	BtKEz8GxmLPi2HqZmq9jYbonxQV5MpCTUzyExpih8tl2YnnBc=
X-Received: by 2002:a05:620a:3715:b0:949:a139:2f2a with SMTP id af79cd13be357-949ba7ccbe4mr2189006585a.9.1795477574584;
        Mon, 23 Nov 2026 15:46:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-949bb224c9csm71239785a.3.2026.11.23.15.46.14
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2026 15:46:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7d304016194so2523734137.3
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795477574; x=1796082374; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QW2v1rbRcBcXiGETe7ORF7SmQ8ayMndDkPMesbNu3qg=;
        b=Wb2M2k4UwF9ETM/0zYLprrwERUxV53CkXby0ZJH4GzuUSPUebdXOL/qt+qCbbfB6nY
         QwYNyVAFjtCOuNfKfVoXw+eMX/8yJbBvkcq0nrw/FC/OZgdIm7xE4W6YZVHIvwlS7mhh
         Mg1NP6/H/wC4Mtx7RS1BlTCozGb0zA/Td01XI=
X-Forwarded-Encrypted: i=1; AL+hErFKnfGdqrRxL+yta0HMa9FKbnkxEF5MtOWLK62vVn6pmZneirYGz8hfX8P9fdmQ6i/3A52FsVgctZ6vLbWiFQ==@lists.linux.dev
X-Received: by 2002:a05:6102:1610:b0:7d2:8dd0:2eb with SMTP id ada2fe7eead31-7d7393ff1d8mr5969329137.8.1795477574036;
        Mon, 23 Nov 2026 15:46:14 -0800 (PST)
X-Received: by 2002:a05:6102:1610:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d7393ff1d8mr5969322137.8.1795477573649; Mon, 23 Nov 2026
 15:46:13 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120-b4-balloon_nr_pages-v1-0-d8944b587819@kernel.org> <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
In-Reply-To: <20261120-b4-balloon_nr_pages-v1-2-d8944b587819@kernel.org>
From: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Date: Mon, 23 Nov 2026 15:45:47 -0800
X-Gm-Features: Aa3M54o9To1m2Mt4frhSqoy_chjBpgWQHpG9-FBy-A8uiNdhJvZ87Cw0sfMLCGk
Message-ID: <CACKNADXLUOdqtJLWdqy1OPEeEmj+XnPk8usqRHcssOYjt+8yeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vmw_balloon: account 2 MiB pages in NR_BALLOON_PAGES
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nico Pache <nico.pache@linux.dev>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000053ed60660fa33b8"

--000000000000053ed60660fa33b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:34=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> vmw_balloon keeps 2 MiB balloon-inflated pages on its own list, not
> using balloon core that takes otherwise care of updating NR_BALLOON_PAGES
> for base pages.
>
> So far we didn't account 2 MiB pages under the "Balloon" counters, so
> /proc/meminfo etc. would not reflect them.
>
> Fix it by updating NR_BALLOON_PAGES when enqueuing and dequeuing for
> these pages manually.
>
> This has low urgency.
>
> Fixes: 4d689474e1b2 ("balloon_compaction: update the NR_BALLOON_PAGES sta=
te")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/misc/vmw_balloon.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>

--000000000000053ed60660fa33b8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGczCCBFug
AwIBAgIMP8k3oYr9dy0fawOFMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDc1N1oXDTI2MTEyOTA2NDc1N1owgbcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEcMBoGA1UEAxMTSmVycmluIFNoYWppIEdlb3Jn
ZTEvMC0GCSqGSIb3DQEJARYgamVycmluLnNoYWppLWdlb3JnZUBicm9hZGNvbS5jb20wggEiMA0G
CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC97H4mZ7IND/iMuoaowZaUcFWQmAEUROR90vJqkzU3
4ljaKHGMed2anb74NFJ+ij38btvWCdWlqUCs4umStciFyeOshWgBWlZO3bpE9BkonLzG9DGwSz5v
Ve2coDRxUIjXbcXgys1z+HiIaZVEBEtpGgBz/Y6KeJr6HHOLq3+1VA6HZ887DMaJ0BygdtOm/g/o
6d185nbusa6X1Si3WqQQEGq9/dHdVg/ScOBl4Hu/sEyY5dYEtIS6+wJOfeWq7PnJwK/ebKrmDXRl
CPyPFwCghdN64vwTIJ+z21krDj9mv3w4e/ow2NiOI82oVpFYCmR7NQAYn+zR+9ZMebTTtUR/AgMB
AAGjggHhMIIB3TAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAC
hjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMu
Y3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVj
YTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQw
MgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1Ud
EwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCsGA1UdEQQkMCKBIGplcnJpbi5zaGFqaS1nZW9yZ2VAYnJvYWRjb20u
Y29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCS
MB0GA1UdDgQWBBRPHRKFeJNRjFAKjHRo2iVVbhmbHzANBgkqhkiG9w0BAQsFAAOCAgEAZ1qrS6Fb
dv9hzcer2Yv+uU29P/iOOBMMIkRHYE2il+wClTPJMmcqRAmTu8S2az2h8XpMkKoWDTHwcj2KUfaQ
UlkMc5m9wMxAVDrklB1uE25jWKnE2X3NQn62oxIMbATya2F6ev8p59kLh2xo0GVxotVnapnbuAaH
2D6xevthNq3e2akPKltISCI38CVOcC7rWuBZrLgdR8dEDLyZW6UMPwJLk7v4ZPyn8E5pMKc0fI5V
ZaWzs68PnkVmKNbpx1cECaQjsrBrXo/HNOQ/DGhHXNIF2k71laGetuCwhewrSdiLQZ3g+oAAvfKU
/FZV1kxiUVet5SmPA02BCW5yz80uHPemLT8KW8un9H15UXd+axLYqKEgr0nzl9stxbsC3vC4pbXQ
688Xqj7ZDCj3LGVbFWcdQ6bPAcxDwLm2z6A7PJdV4xDPTYhsK4io5/ZfaHOC8DqKT3klVZIo+Heg
5NMaydZ2ZiuKonE1AwMVn0KLV7r+vs/l8mIxwHLrNuWu501u2FYtMLcau6ZT0KbjwCKmMVqpvqMk
Wybe9jF+aZWzjNutxjSJGP5oSmrUpNP3UzAio93FKeLiweQ6L7E6GTBIrWNKHEog46OpVY865QPD
v1r5jLUYELDXa/NsznnUxWljMsYK9Qa4a9MUkQn+FF0b1xE5XuFm3mncJgGAsbZeN8kxggJXMIIC
UwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQD
Ex9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgw/yTehiv13LR9rA4UwDQYJYIZIAWUD
BAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHHwhlLmK+lPSjnvL0KJHTVkI4kBzkdH2IHR6pHEdN9L
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MTEyMzIzNDYxNFow
XAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJXc
BfmrWXFo69xOCkcKAonrEpIu5YNuIdsEaxRC5r7BR21kWFGz6i7JUyYx5bfAjtjl8OfdVzh9kxMH
kBw2aGvpq2DZgbbXRDf1A2JoH07VhvbtaWnsCxpoM9vGreNMdwJZQvgieBUAfrFjwVH5XrFkK3UZ
UXn8TNNq/xPBDvrNRVUvq44ZS5LDXikxAs5LZwtb9Pyo2vve6N0Glo+UuPlH46UaFKTXxQ/m8XWP
Hyi4L0pE3AfjHT1r6uA++/IjuklgTR8WwKFp40O7USavYut9YyFI/DKwdFMTaHIPAMgtq8GCCM+v
+lRG/dDMsLbHxK8FR1f9/VzdsLRaGZoIkUs=
--000000000000053ed60660fa33b8--
