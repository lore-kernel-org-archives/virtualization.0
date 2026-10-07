Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B220D4FC
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791410846; cv=none; b=Ep2xw6CCFkk2dJtzA7EfUbNLgRzBRBHbAA9OE+WPYsFzaAq9jgDgEaKBae9NS1CWgfWBAEbuBJUGtb52jXWYu7pjQYKfDOJMxd844A7qg9ycZWCy1LhBf2ph9KA7RpuRMe0APmdzn2phc9MVJXiYf8UBq34yI9q8RJgqG8ubfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791410846; c=relaxed/simple;
	bh=pzcU6DRrnPP2DBnNwpaFuVjPLcGW2IMFoch8YJke0x0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=ILf2xbdlOr7rB9FDTbeGNP5mpyhSdsW2bZWU/R2CiEpw1/XAwSkPL1lnrii0E5m4kAh/MT5ni1CAt3JadPr54sc7/eBR0tZPgmaFB6wo2HVrr0grCuwjRhX15DYuTK1bvKY1bRgGGtI45Qa2jZJ8Ban28ieeBASGxTQABxX0S70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYhHGM54; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYhHGM54"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4f66bb2ab57so1056685b6e.3
        for <virtualization@lists.linux.dev>; Wed, 07 Oct 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791410843; x=1792015643; darn=lists.linux.dev;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :content-type:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzcU6DRrnPP2DBnNwpaFuVjPLcGW2IMFoch8YJke0x0=;
        b=cYhHGM543yRRyiyqfeeN11LQAM4q8PV+zVfGNB2/N5COllarsbpBxnzUn322useDb/
         LxHlg1xhsxd+gAYTAJ3VnXEwdAmjED+YGBm58tD8JbzXPd1FzZWIjHST6Yb4RbIvIox8
         2NMty5frEHInAvpn+tkH2JuE2tLNVuw2C0dPIVeUMbRMCjoN/mZrywGECNLs0wkNANKC
         1WGkCWxxS3JV2Gf+7v9C/7azqyImTzsBompW2NVlTj1r6WCaTSCl0kP/CYVvWZIg6i55
         JmoWcw+b9AF8ImcyYmdegnO1enb1m5OSCMSALl3aWvrxB6uB1DFDU7jWreK6lrEh54Rs
         gzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791410843; x=1792015643;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :content-type:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pzcU6DRrnPP2DBnNwpaFuVjPLcGW2IMFoch8YJke0x0=;
        b=aE4GuFgvFHLxHxCnLKBTSQVL/tUxpaJpBw5uN85neP8yhMyz+J5teOsShuFsoCFrno
         VQn2Z+7Pp4nNxwir1Y8y1HrAW2OhyXLriPO18lxPm7+6q/7KFe2HWbyIt1kpOwVus/j2
         hQ10oEtGM0SfyMbBbxu2jGlBMRQ2PM/DighUJmUOCYMJ/7JjEOPRLJv2OUbm6XBF/5Kf
         2swQ+lG+qsIohj1wUUl070GmqCM5IFDYpYZf01a9Ney75rFnoFbx+qmkjDNAeWDV0R4f
         InEBoTzjCEDMUKkLh3La+PAJWe+u0A3t3FyvxQRSQ11ESd3qPa1eYvIYdI+U+sen1HAC
         uwBQ==
X-Forwarded-Encrypted: i=1; AKwUvBx50ugv2E4I1k0ICQUo46SkCxLxin3GdKN0h/RbWmB1aEw4Ixs2k+CTKu8t21ZLDiXkryBvfV3xYWIS5GJecg==@lists.linux.dev
X-Gm-Message-State: AFuF++lo2FAyvKnusVMtJIySaq/iLRI8FCMTaLrbN+PABt7TlJmwPVLB
	JcF+vtICjA+fTjvOpc0mVTKkoDcP6TtojbF96b95PE1ESQ+I1v22hyGJ
X-Gm-Gg: AYBFou1iq7lNqyIUTDn7aG/qf9VDtielwF+JUyJrVz5cOK3qxm5GvYHbFFm4xyXVuPd
	tUhIz189ANI2p7ILJUGN+EVeq25pByI5RevgmQlN0q5jDE7Pzl3vQrcCxuM1lJvqOxj2aM5Ikoy
	WChWANGqjOcTxErbO2DNhW5qfPwxNjMYXUl4xwYhhjNcEcMQjmrkg6Kp9D18FTdw0AM+NWZVe4t
	L7mU1KTRlspOrLw+Er6twJ1hiCNrfRhhCpXK4SwvmxckBjWl4vMw++Q30TgTf52xB94UHTFshzF
	XwKt/xJntKt7uESEICeW8edpk9daA+XI4SBDVfiRUwnzCni1QlwCRpJh+1dfwZTp4Dki9ePTAby
	BkgAc0yZYXUVVpMVglsijG1Zl7n9AQ2BEleTteI61S13YIt4m5oumtabNhM3B08PIlDDXPt9q8I
	gBQclzQuY3S0OHAlA2N6e1wRKnlilv8OdkEQzjIDj8ze85tMLk4xekP6+d+CRtZa3+c61bs+697
	9uF4RkZS8IVH38zhaiug4reomc=
X-Received: by 2002:a05:6808:1585:b0:4f8:4a95:9b3b with SMTP id 5614622812f47-4fc481c5f12mr3624420b6e.68.1791410843223;
        Wed, 07 Oct 2026 15:07:23 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:220:4650:f501:3b3:565b:2d79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc431ede8fsm3802983b6e.0.2026.10.07.15.07.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 15:07:22 -0700 (PDT)
From: Azadeh Aftahi <aftahi334@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [RFC] virtio-net: AF_XDP zero-copy TX checksum offload
Message-Id: <247B8E70-8100-419A-95C4-71E43361FF73@gmail.com>
Date: Wed, 7 Oct 2026 17:07:12 -0500
To: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi all,

I'm planning to work on single-buffer AF_XDP zero-copy TX checksum =
offload for virtio-net.

Current net-next's virtnet_xsk_xmit_one() does not consume XSK TX =
checksum metadata and uses the shared zeroed virtio header.

I found Xuan's 2021 proposal anticipating separate headers for checksum =
support, and the merged 2024 zero-copy TX series,=20
but I couldn't find a checksum-specific follow-up implementation.

The proposed scope is to map the existing XSK checksum metadata API to =
VIRTIO_NET_F_CSUM,=20
using a DMA-safe per-packet virtio header whose lifetime extends until =
TX completion, with corresponding completion, reset, and unbind cleanup.

I would keep the initial scope limited to single-buffer TX: no =
multi-buffer RX, timestamps, launch time, or GSO.

I'd also add checksum and header-lifetime coverage using the existing =
XSK selftest framework with QEMU/TAP.

Is anyone already working on this? If not, does this scope and =
per-packet-header approach sound reasonable for a follow-up patch?

Thanks,
Azadeh=
