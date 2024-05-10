Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B92168AE2
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335643; cv=none; b=V4ZYZmp65GQGA8m1MPIzBl6Y5nP+txzqSj8aBAUpqYI+yufFhSt8qruKAfC1KjnNx+AMm7MbN1bO8fWVERIC8ipXGe9TGtzW18iWdFY1SsXH13oOpHdhRctf4LUe33M0GZWm5of9ibuxhaOSgFgA+sohkg1MycLx9wl7GmUkeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335643; c=relaxed/simple;
	bh=ifYU/c+8V7OWSd9aaCKHF7gpCqv7cSdHzl7rv5oFs0w=;
	h=MIME-Version:Content-Type:Date:Message-ID:Subject:From:To:CC:
	 References:In-Reply-To; b=uduIBGJgDU2LektEjl74N89etFVSwcBsrB7BX8EqSnQdgTrk0TL8Tg0rVxluRcbXJyWInkkUe6giWJLX/sdqeMDzjrZqA6TQFzoYVVSWLy42hOT2RYt+qRWXRAxsfOOl5+V0DUOTUTWYA3GpLvIVPiehuDKDeKGMWHSbxeDXz+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=srCcEsP8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="srCcEsP8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D965615D2
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 10:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.049
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80EEw-m4cViG for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 10:07:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=99.78.197.220; helo=smtp-fw-80009.amazon.com; envelope-from=prvs=8538b48ee=nsaenz@amazon.es; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 40F61615EE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40F61615EE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazon201209 header.b=srCcEsP8
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 40F61615EE
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715335640; x=1746871640;
  h=mime-version:content-transfer-encoding:date:message-id:
   subject:from:to:cc:references:in-reply-to;
  bh=ODj1UcfgLsilkOJ93AaBzpY+nLn2txKitmtJHEr2EDY=;
  b=srCcEsP82fTwwumE+0CjGUWuDlfSeB+m343HVOYqsEzWOd24KIhsmt6h
   Rrt96Gt//NwyyE80cRksnxjItGWO9Y48dgXFp24NyhKKVmhD5JTMdMimZ
   W59GCl8l2j0HniOIr3evl2M/G23PsUoWgDofHp9bZT2YRJw3q4FFyLEAk
   I=;
X-IronPort-AV: E=Sophos;i="6.08,150,1712620800"; 
   d="scan'208";a="88359429"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 10:07:15 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:54770]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.131:2525] with esmtp (Farcaster)
 id 0c298036-b7a6-49e7-b4ba-4e0b449ad4e5; Fri, 10 May 2024 10:07:14 +0000 (UTC)
X-Farcaster-Flow-ID: 0c298036-b7a6-49e7-b4ba-4e0b449ad4e5
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 10 May 2024 10:07:13 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 10 May
 2024 10:07:03 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 May 2024 10:07:00 +0000
Message-ID: <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Sean Christopherson <seanjc@google.com>,
	=?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
CC: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kees
 Cook" <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>, Rick P Edgecombe
	<rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, Angelina Vu
	<angelinavu@linux.microsoft.com>, Anna Trikalinou
	<atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>,
	"Forrest Yuan Yu" <yuanyu@google.com>, James Gowans <jgowans@amazon.com>,
	James Morris <jamorris@linux.microsoft.com>, John Andersen
	<john.s.andersen@intel.com>, "Madhavan T . Venkataraman"
	<madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>,
	=?utf-8?q?Mihai_Don=C8=9Bu?= <mdontu@bitdefender.com>,
	=?utf-8?q?Nicu=C8=99or_C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>, Thara
 Gopinath <tgopinath@microsoft.com>, "Trilok Soni" <quic_tsoni@quicinc.com>,
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, Yu Zhang
	<yu.c.zhang@linux.intel.com>, =?utf-8?q?=C8=98tefan_=C8=98icleru?=
	<ssicleru@bitdefender.com>, <dev@lists.cloudhypervisor.org>,
	<kvm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <qemu-devel@nongnu.org>,
	<virtualization@lists.linux-foundation.org>, <x86@kernel.org>,
	<xen-devel@lists.xenproject.org>
X-Mailer: aerc 0.16.0-127-gec0f4a50cf77
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net> <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
In-Reply-To: <ZjpTxt-Bxia3bRwB@google.com>
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

On Tue May 7, 2024 at 4:16 PM UTC, Sean Christopherson wrote:
> > If yes, that would indeed require a *lot* of work for something we're n=
ot
> > sure will be accepted later on.
>
> Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM=
 support
> is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible=
 to
> design KVM support such that much of the development load can be shared b=
etween
> the projects.  And having 2+ use cases for a feature (set) makes it _much=
_ more
> likely that the feature(s) will be accepted.

Since Sean mentioned our VSM efforts, a small update. We were able to
validate the concept of one KVM VM per VTL as discussed in LPC. Right
now only for single CPU guests, but are in the late stages of bringing
up MP support. The resulting KVM code is small, and most will be
uncontroversial (I hope). If other obligations allow it, we plan on
having something suitable for review in the coming months.

Our implementation aims to implement all the VSM spec necessary to run
with Microsoft Credential Guard. But note that some aspects necessary
for HVCI are not covered, especially the ones that depend on MBEC
support, or some categories of secure intercepts.

Development happens
https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
branch, but I'd advice against looking into it until we add some order
to the rework. Regardless, feel free to get in touch.

Nicolas
