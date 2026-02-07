Received: from mail2.anonaddy.me (mail2.anonaddy.me [185.70.196.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71A23EAB7
	for <virtualization@lists.linux.dev>; Sat,  7 Feb 2026 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.196.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770490618; cv=none; b=DEWlN0YAqxg3Hve4jSXfD2in2FbHUAeOzvq+QO7a3mN/dAVgVmrqhuaoA80gGmaPwEV892U74djd9CNgMRFCF4VHNjS1yXwqlVHemO0IlYImYiZde1BxB2HL9ksMx2ztiA+tIZD6QcWByJS1fBx2m3XXmwlwgaTwENYMdXy2y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770490618; c=relaxed/simple;
	bh=1aAyQJcOKpZDGOatk9b9nQPWTt5XNCehrKz9upPAILg=;
	h=From:To:Subject:Message-ID:In-Reply-To:References:Cc:MIME-Version:
	 Date:Content-Type; b=LwaqQOQZECnCQVgpZW/h7G+/lMNW27LykvpGAzd5z+PWKg+htdIo4o3v68q3fETofullVJlXxENpux999kRvGOGjxqSXmE8besl45i5AsOU9qpzGlM81BLUvgSdoqHTeaUvbSQXQJM5UqNWlN5RivS9XnP3p7jMmi1WdVqTyt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me; spf=pass smtp.mailfrom=anonaddy.me; dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b=I5C/JwPj; arc=none smtp.client-ip=185.70.196.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=anonaddy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anonaddy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anonaddy.me header.i=@anonaddy.me header.b="I5C/JwPj"
Received: from mail2.anonaddy.me (mail2.anonaddy.me [127.0.0.1])
	by mail2.anonaddy.me (Postfix) with ESMTPS id B987AFB0CF
	for <virtualization@lists.linux.dev>; Sat,  7 Feb 2026 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anonaddy.me; s=default2;
	t=1770490610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aAyQJcOKpZDGOatk9b9nQPWTt5XNCehrKz9upPAILg=;
	b=I5C/JwPjPPG76p5JQbsx092Ppfn0mw9xwoKtd45pZBUPBHk2kBvaLBXoz4/uicXm9BcKVn
	5ZW7ZjImdgs9CGeu8yv4VmD8gmislYm6Ju8UGPCo86tERPae0/Wn8sQkVHJ2h+Zofx2Vzz
	XeotgT26lVOFjrHjQN9tJRe7Czd36TLuf0v806+oyUkluZjEOHJRJ1RPFns0f11WbPFSdJ
	Gj/Dy/pHAIxnWU3P5IcD93sjeXG753iwnuSPA6pB7BSfvDiwD7zr1TOlDYxvrhhAQ9CEah
	YHrwhV/AkgxYm5wftr6TpCLpaminVY4g7gtLCyfecEBKkszEi/c1+U9QSicEbQ==
From: agpn1b92@anonaddy.me
To: sgarzare@redhat.com
Subject: Re: [BUG] vsock: poll() not waking on data arrival, causing
 multi-second SSH delays
Feedback-ID: R:d17f588e-5717-4190-ab1e-7db474f4dce6:anonaddy
Message-ID: <e1037ba961431847ebfe4bbba310958f@anonaddy.me>
In-Reply-To: <aYYTder4-zvgOfV7@sgarzare-redhat>
References: <f3a801a1a32670294d5d703cad8ab609@anonaddy.me>
 <aYYTder4-zvgOfV7@sgarzare-redhat>
X-Complaints-To: abuse@help.addy.io
X-Report-Abuse: abuse@help.addy.io
X-Report-Abuse-To: abuse@help.addy.io
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Sat, 07 Feb 2026 18:56:50 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Stefano and all,

Thank you Stefano for your response and skepticism=
 about whether this was
a kernel issue - you were absolutely right to que=
stion it!

After extensive debugging with strace on both guest and host=
, I've
determined this was NOT a kernel bug at all, but rather an OpenSSH=
 issue
specific to vsock connections.

Root Cause:
-----------
Th=
e 10-20 second delay was caused by OpenSSH's sshd attempting DNS lookups
=
on the literal string "UNKNOWN" (the placeholder hostname used for vsock
=
connections where no IP address exists). This triggered two 5-second DNS
=
timeouts during login recording and audit subsystem operations, totaling
=
~10 seconds of delay.

The strace showed:
 =C2=A0 17:11:14.465 sendmm=
sg(13, DNS query for "UNKNOWN")
 =C2=A0 17:11:14.465 poll([{fd=3D13, even=
ts=3DPOLLIN}], 1, 5000) =3D 0 (Timeout)=20
<5.005s>
 =C2=A0 17:11:19.472 =
sendmmsg(13, DNS query for "UNKNOWN") [RETRY]
 =C2=A0 17:11:19.472 poll([=
{fd=3D13, events=3DPOLLIN}], 1, 5000) =3D 0 (Timeout)=20
<5.005s>

Why =
I Initially Thought It Was a Kernel Issue:
------------------------------=
----------------
- bpftrace showed ppoll() timeouts while data appeared t=
o be queued
- The pattern looked like a classic lost wakeup race conditio=
n

However, the vsock kernel modules were working perfectly. The delay=

happened in userspace during sshd's session setup, specifically when
m=
m_record_login() tried to resolve the peer hostname for logging.

The F=
ix:
--------
OpenSSH 10.1 and 10.2 include fixes to prevent passing "UN=
KNOWN" to
subsystems that would attempt DNS resolution:

- 10.1: Skip=
 audit logging for UNKNOWN hostnames
- 10.2: Don't set PAM_RHOST when rem=
ote host is "UNKNOWN"

References:
- https://github.com/openssh/opens=
sh-portable/pull/388
-=20
https://gitlab.archlinux.org/archlinux/packagin=
g/packages/openssh/-/issues/16
- https://www.openssh.org/releasenotes.htm=
l

Workaround for older OpenSSH versions:
Add to /etc/hosts: 127.0.0.=
1 UNKNOWN

Apologies for the noise on netdev - the vsock kernel impleme=
ntation is
working correctly. The misleading symptoms (PTY-specific, ppol=
l timeouts,
state between connections) made it appear kernel-related when=
 it was
actually sshd's login recording code hitting DNS timeouts.

T=
hanks again for your help and for maintaining the vsock subsystem!

Bes=
t regards,
[Your name - don't forget to update it this time or you'll loo=
k even=20
more stupid]


