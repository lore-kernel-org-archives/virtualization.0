Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4B184
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752451520; cv=pass; b=BHzWVU6thXnD9XbQOFGbPCmVF5xvOTJjvOoQPd9f1Mch5dshQv1EqgScpYPTnhNDM3BYbRZK8OoS+qa4NZcHL/Yw7AJTlzumyAXB4Xr2CEiFkWgiDzqehJ/6P7ptDD/duX51hXkuFcfeCuTu4MvqNqxgsr1bvdl/gQ2EMgV0ykU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752451520; c=relaxed/simple;
	bh=oyVaRut4FAEfUhD4YEWwvSHGtQCo0FrwoB/Rz8rlK4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1eK+rBF60P8wNH26mle24ul+NFQaEfDXYwaTetdDNe97Xu3oCG82qIId2J2iwLH2EnDUWaqdUt/jOt/0muUXo3LMUSD8BvmhQjLK9iqvKm/AXmwqqFKWgNJHA6G5+eY47NE/c2EBhiXz3T8i+r24w1A+OgMjaAsWcDc8jkfKmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=GumDboUH; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="GumDboUH"
ARC-Seal: i=1; a=rsa-sha256; t=1752451508; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZeWnGQ+sl/JpsDcV6E7PdRa+4zMlRZnmUCJNz3FxQM3v4oAndbLfbe9ke9Hmm7qssrC8wXM2nF6zEIPZp2YZNOAJvXXBJiqPbzNOYRPNdbQoQgkRO8SjpAltq3sxDrQy3vcdohpJFzTsgVb06XHPynwz3pGmRc9VgDbGc7qM9JQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752451508; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oyVaRut4FAEfUhD4YEWwvSHGtQCo0FrwoB/Rz8rlK4c=; 
	b=YsUttEttI0R314edaRHwKY6Aqclsasl3BpdVWSifaOQ+jI/jmwe2AKBIQA7c7GjGDoo8qRwWPTe/uHkcvUtutWdcDnUZXjwynP4hZSeZqN05XrAedXVmA3AIKyNXADBGZuB7TAjuwiZb9OKerIwD0X9IfKfxNDVP79slI8NS8Ho=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752451508;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=oyVaRut4FAEfUhD4YEWwvSHGtQCo0FrwoB/Rz8rlK4c=;
	b=GumDboUHwBbQoS1/lksEgDwPc8nwK2ic/TtfRQvxeoHmImkWM5Ycd94BLn1eKrOA
	GIUn/C+YvuP0iM3G6BoJdWx22a8PLZVsUfdAF4D/aRZQdV7UXzayETqZjUtG3ZJLV2a
	Vb6n3rp64GVwC1IprGiIqVXC2vcUAIgDdGzFODRI=
Received: by mx.zohomail.com with SMTPS id 1752451505632151.41518657558117;
	Sun, 13 Jul 2025 17:05:05 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: ryasuoka@redhat.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	jfalempe@redhat.com,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	virtualization@lists.linux.dev
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
Date: Mon, 14 Jul 2025 03:04:56 +0300
Message-Id: <20250714000456.14-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250613132023.106946-1-ryasuoka@redhat.com>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227cae78222e5608424e7d23a7a0000ee312201a42be3a6c8c301f2cc67bdd579d09386f1395f25bb:zu080112272569fa9f85039b91f1d6e4ad00009739d396ded1a8e780e7fc362b6b8e7de17c082c4128df7ac0:rf0801122cde5ec2bf4f8a7fcaa033275600007851220b8154e5f9651282473cb1276cc830cf9885e60d8a8ecbbc4b3e19:ZohoMail
X-ZohoMailClient: External

Are normal panics (i. e. not drm panics) still supposed to work with bochs?

If yes, then I want to point out that they, in fact, don't work since 2019.
I. e. panics are not shown in Qemu if:
1) bochs is used
2) we use "normal" panics (not drm panics)

I already reported this here: https://lore.kernel.org/regressions/197f290e30b.eaadc7bc7913.7315623184036672946@zohomail.com/T/#u ,
but nobody answered.

--
Askar Safin
