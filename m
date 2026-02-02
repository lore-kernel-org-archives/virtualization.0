Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791D3563D1
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026514; cv=none; b=llfKK6qsYIwYNrdihz5HqE7hVlfkn0hC0a+9q9Dtwf1mhTF5e9Tqu9puVkvsVx8KaKu6vdee0+H+gYJFH2wlKXHFNZMt9P1H7CKQRGNzj0IKp3jBXPhwR8AFbcHueVsh5sDFIIBlOdPP4cPpjs2KJOdbtiCTtSw5f59PgTAbPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026514; c=relaxed/simple;
	bh=WGBqeRf3m3q38dcFfIzoZC7KITAdIHJXG+fCWgOOD40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AdsCfNbvPWUvM5bBpnKD2jJ1x68Ghw9urMstdX1YiBWiS9vu1k9xJEdYOCXLWZA5onWis7Wqyhj1EFG/RO0pDKDAdISLLxygY54nzE2BfSracXdwC24y3d+TeIhdh3C2hEyur/M3U7O05yjm23OALiDg/SnvdvyWp67bWNvg//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=YBO6/r95; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="YBO6/r95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1770026513; x=1801562513;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GI9OPx+uxZW/9+u+5es0pePWKf46Zy6n4IWktANHhfk=;
  b=YBO6/r95No/EEep/Aw4S11bj4awfD3Ir5r00dQJWXKSfiR+i2lWCwYw9
   LsYaJpE0WXZFwTdoBiu5PZ9aWPPLBA5AUvtFfqHob3idbgzbW73pZSRM5
   /FdUlatXmTPAzwImzVzYTQjHq2by0+eacePu3iZZ+8QMuiMTnkaN67oVU
   qq3SX9Vrr4Z40coS4QdG2MkSIi6wVi8W2ADTn0E3ul9anUz28DOX7/EYN
   SaAMyic4IyxOwl+DdxRGbh6NtVSjHW9tOO5CbqXIWcrNZsp258/92GjZ8
   VQFZvFlgRH8rJRqf0O9/eHiJX7l2Ql7QhqBwzWDKutJi+cKW54ll8qMiT
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 18:51:38 +0900
X-IronPort-AV: E=Sophos;i="6.21,268,1763391600"; 
   d="scan'208";a="607384937"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 02 Feb 2026 18:51:38 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Mon, 02 Feb 2026 18:51:03 +0900
Subject: [PATCH 2/3] x86/defconfig: add CONFIG_IRQ_REMAP
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-x2apic-fix-v1-2-71c8f488a88b@sony.com>
References: <20260202-x2apic-fix-v1-0-71c8f488a88b@sony.com>
In-Reply-To: <20260202-x2apic-fix-v1-0-71c8f488a88b@sony.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Suresh Siddha <suresh.b.siddha@intel.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Ajay Kaher <ajay.kaher@broadcom.com>, 
 Alexey Makhalov <alexey.makhalov@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Rahul Bukte <rahul.bukte@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>, 
 Daniel Palmer <daniel.palmer@sony.com>, Tim Bird <tim.bird@sony.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=897;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=WGBqeRf3m3q38dcFfIzoZC7KITAdIHJXG+fCWgOOD40=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhsyG4hWJ5ZPesy10dLqdVPT13NLfdzYoem+Z+6FTrppr+
 3YRUxvJjlIWBjEuBlkxRZZSpepfe1cELek581oRZg4rE8gQBi5OAZiI71yG/3G5dneW7G7keJnx
 4Wd+z+9zOUtZjcKVjm+qm6rqVBCX9Jnhf+n3kx2OkYsNn+1Qe6/XFrn9pXSWzssdU98b3/BZ2S2
 XyAQA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

Interrupt remapping is an architectural dependency of x2apic, which is already
enabled in the defconfig. Enable CONFIG_IRQ_REMAP so that a defconfig kernel on
bare metal actually uses x2apic.

Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 arch/x86/configs/x86_64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 7d7310cdf8b0..269f7d808be4 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -230,6 +230,7 @@ CONFIG_EEEPC_LAPTOP=y
 CONFIG_AMD_IOMMU=y
 CONFIG_INTEL_IOMMU=y
 # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
+CONFIG_IRQ_REMAP=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y

-- 
2.43.0

