Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468766;
	b=EVLE2i4302GFSWSY8TjdKtlBYFAMUk1WmXyQgr2otflDy3zfnQ3d9L99OIETT4DYN/Sl
	 KPP4HYQEAPN8hFig6M/VyD4bhzAK+pWZx99996BvC8qNoprpWogtj3F7EFI5+pWerWm3F
	 qAzNhC9eRj8EzVe57QQ3cF7WvQGKvPaExyhWY9cGjtiBfDG4bTzELNVNvYG/Gp7+6KJg+
	 AbPbi5oBGy4Klkw0qR89oTgZkqH/kl1+Y1LWQ9N92+akRN2R7H1TyaPtEB0mM1Bf8X0R/
	 ihZ1rbPrODqYOnwvY1oTAbTaq8fLTz63C46k7mTW3j0dLswbTwPuYUvYd9oI8M8yzRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468766;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
	b=3FslT0Lg2x2TiLNtC4k2DYkxzKKl6AvJu1oYXqclfIxhNFLM6ndQ8pm91hhWFnNKFWAy
	 pyfZQYCtTIA/Kq/R1T2cbT9t584nc9hwRnlzYz+2CuNn7qtHsb/P1VNVODRB0ps9nKpY5
	 V7RWr3+Jl21RMdqJNJzVWr1iQqSk+PTd81ksYsXWlPyngq9xZ4fQoRemO69XYEoLFXauZ
	 cgiZtKBpbJWjP+ArXTuzeHj7F1cM2TsUuHyH8CiF8oqBQQTbnYwxLGQxFHv6hKoSNdywA
	 5eRqQntqwDEgpf6iNOYgbgnjNrafd2YHP961HYu8B47jRuFWItgT38av5yY3UeNo1iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="23hR/Xrq";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4660A260B
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 17:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABA4660A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=23hR/Xrq
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDkH9C637113
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 13:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=12TO2e0T31cSdEte/htfI+5i3s
	mqp4TVqWraSxvTy3w=; b=jrv2nOZ1hp7gZbhO1vM3/PcfFfO2Eo+JrSCQRcC1ob
	JZIOAFdqM7Cv70L7PuIETHnhd9trPMvIE4Vhr5Ze645lh6+3Z3Yyu4d6HgjnPR+W
	LnQeSKOap9tnbXCFr2Yu+24s9nG4SHxLCy42p6uCdErv6i+HSk+zX7/YTMo7Mmyo
	X56d+LUijffqg2f4G3pQC6yxJs/PWK5DGOYbNI1t2gXcFbRO6bSo1OdlXPsvhW1J
	dRz2RdOGf5rWwSJFVdPkSwT6YDcnZiNKaiOWQrdff+vERJPAujUGw0u8QERN1//v
	tFTTHhwz6oVCE1EidtJ61Jgic9T/tAcuIp2psuzp8EXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hnc7ajfjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 13:45:54 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ce7a85f04so357289385a.0
        for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468754; x=1794073554; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=23hR/XrqcOeZyDqdB89kK+ajVFa0Ttw7PVExMyiKr2Fp4lQNByxg4CI5ImcMeDvxMv
         WJTCmg2w14m9nXnJSuQytf+mQiW+y94YmuNk06uvkdxF/mecJTbl1rhZgJiABQU6hO3+
         d8cH6Dp145kLQonxfI19w+jvAol0Cp6TSe9qQvoiqAFFRIPnFuwB/QQsCCFRCT9XJdzA
         EVu9cmq1AO4LylSqyNPOsmOjnNQEi5Q66K2y3A0PIiJvLKoyXSedhpau1reu3KTiIAke
         rUL4Ln++qAh8GXt595eM5XkWOZ0fo57jqBMnZdmNv6SH+s89LgiLFagv1gS4vovMkl0+
         kFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468754; x=1794073554;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=w5Z1uVZPd3vzghZW9MxNQzzirbgQj+9+aMp1rxV/KcXybVK1B+z5yYWkU70qVuhWSw
         Mn0nWcv/3TEln20x8jCLi/LIexoO/umUBp8W7N2kY6EMvS21Mluk6NBTbjwJJe03Q47D
         jwnnoxhILjyWcFcNcGe6jN4jPvJmbsltttljzrTNVfntki0qMAQmS2HQENUzqPUj8Rll
         uIGccyn8/Y+DFiO/mVhrz7BMQ3MSpgzQ/3QYSrTUhV5G6WhTcohQH4TDYm6y2MIb5PTE
         2FJmQ/TXk30tu1Vf9DHUyZjMqx926Vm+Ael92+mVVTjk1ynveiW0NGplGfWV20YLgsyf
         BQYA==
X-Forwarded-Encrypted: i=1; AKwUvBxprwYYg/KXwR3izeXdgxpl1rxg68W1zRtL8b0A3E0fO0ErD8fD0FLBKY+p8IxnVkMnA7kTpj7vkJvrcwiYkQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJsRR5HlwSFPoYPNyx50iJqiETyF4BgVlC56of8w8CZ9FEI1MG4
	4EgLgcCfIuPioKfOt2XTBdtNDiSDUk5EIYa5/hPAMJkX2VJXRWBmkM7cnvdKKjZ6WihB81aRxf8
	dxZzBap0wCeYAc+ry6XjcOPGz4kGkJBe6IT8lLKdgK1vbcyrChZp6UtK7W2Uvzj2d
X-Gm-Gg: AYBFou0eKV8ZWS4Ti0zhEc/G3UyIyWBi1GIlVGQhlHrFToS0pX0XZmmpvwRnMwgECn9
	RhzQ2DVtbtY+4XVmRcWAkvp7aQo62vH6++O0M9gvbvfnM5NT33KTw3bSPM5XQLBY7SkxD9+IRf4
	E23BzXXJ8AAzvRt4n3btKv71vnw0VYoVK6+0l09S0lYbGCqYMIvHKCQj1NikpClEHFvUuq17gc+
	x8ndtDcFWgSEOs3gCmZpenb7tqc6HdzItGXwV2pH/qejIKxRRA2BBMAEFZmsR1lPAOQ1IuoP5Z3
	5EKPq3wgBOUSgl1FKXCcu18tRDcPuTDZ/aZzwQ6DSdlWgzfrTir1DwvtbBfNYEemZ7CPqwzSODw
	3Fdg0xUobRKRYJuRLY8GEfY8sNBLsrdZpuqZvG3s5Bf4/0QyiylbroG9qiQ==
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882365585a.65.1793468753917;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882361285a.65.1793468753266;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] vhost-vdpa: fix a pin leak and unpin mappings by range
Date: Sat, 31 Oct 2026 13:45:33 -0400
Message-Id: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0p5moC/yXMTQ5AMBBA4avIrE3SSvxeRSyKwVhU06GRiLsrl
 t/ivQuEPJNAk1zgKbDwZiN0msCwGDsT8hgNmcoKrXSOYdlkxzA6g4d1bLGoiMoqN0rXBmLmPE1
 8fsu2+y1Hv9Kwvx+47wdX36AmdAAAAA==
X-Change-ID: 20261015-vhost-vdpa-unpin-68ee785a019a
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=yEsTLW5bz4gADvidYrxq5nthN1/BGAv4JgsFze3VSmg=;
 b=jeyY9hiphQ8blprG87I1oONkrIN8Q7ZL/IGjRLJbSRY/hU0x0AZTh7Gso9PmhW412uIWzzlh+
 JxQxyJSbDs9CNUNDmGS7lxZEUsybN2nVwItY57qixt33KLSfa4cYQmD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: ETuP4ks9ibEAeFj9o5U5WBctK0iKvB1g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX1jKot3qi7aW0
 WNtBHVOk64cz9gOogiU/OXvC12WX5CI8wyOPJCpRpugzq/KYk7YvlAYs3lmMenMcZ9+rPbvraeA
 GmGi/oW+fd79S8OYC6obPKYzS/OgHT9FI+vEhebVx+uzf/9Ja0ec
X-Proofpoint-GUID: ETuP4ks9ibEAeFj9o5U5WBctK0iKvB1g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX1vRmN7ZPJ2fv
 5XyzeCn1nIdrYPTIWOQLhejAk+/E4nS6A8VtKu1Yds+BKJfe7PVH7urGnhJMJuQodCp7KbRs14s
 RJ0ztRqhtaJHYM9geAeIEEkKOP7NE9mfsfEn+J9/4cQsaJNKJqUKEuZeKch92EhpHQzm/2Y7ebQ
 s3ZG2RQVCDeqwBtJKmYAwN3bsDy4vjoUD8D1m+5bOMdMYCts67Wlycij0Mujnk9pzJ/pKEM9EMv
 BbGUWxCZD/i1bgtsHi45OsXrjI+GUziU4Dmthc0BMO9JsVe/9juAhjJ7LESQ3fC8atxpXaq8h+F
 GpgZtD2BcOpZx7ELn4boJhXlE8sAwaDMILP+t/LWWS1JkG6x1kpCPHwk2euCW/Bf01UDkOTZpMi
 c5xc3NkFQiQsjTr/H+vx7Nn4VrVCK5bK3Ver8Y2T3H4oqBfgHf/ZVJZ4rCy/K9NKhy6CiIVuBNL
 v5Nf7IOFVB0TSRLcI3w==
X-Authority-Analysis: v=2.4 cv=St8Fe/O0 c=1 sm=1 tr=0 ts=6ae62952 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=mS1D9im87lyf6bhA-bcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 malwarescore=0 bulkscore=10 priorityscore=1501
 impostorscore=10 adultscore=0 suspectscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

While testing the second patch I ran into a pinned page leak in the
vhost_vdpa_pa_map() error path. The first patch fixes that and is
tagged for stable.

The second patch unpins each IOTLB mapping as a range with
unpin_user_page_range_dirty_lock(), which marks each folio dirty once
and drops its pins in one go, instead of a set_page_dirty_lock() and
unpin_user_page() per page. It removes the last use of
set_page_dirty_lock() in vhost.

---
Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      vhost-vdpa: unpin mappings by range

 drivers/vhost/vdpa.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)
---
base-commit: c69023b5e16e5ffe9368603dca76d85bd544ee57
change-id: 20261015-vhost-vdpa-unpin-68ee785a019a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

