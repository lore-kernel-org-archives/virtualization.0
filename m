Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256365F54F
	for <virtualization@lists.linux-foundation.org>; Sat,  3 Feb 2024 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977126; cv=none; b=VIAA41valC1BH4a2auKCokzE/JeqfQYsWviT+bVLp84CcwaF8RE9hRQ2tT7G+wxTA4gE4rQkclKvW1B0619WDQp2AW5AEBp8zZpjxRRaXgPPO4KT+AInM5KdBoejCWi5USvKlZ6UdNjXa+AWXXqw85sdhjRY4uoJU6EQosoZfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977126; c=relaxed/simple;
	bh=yubN9w37erpD5QdX9ENnWkGbfu9RHa9i+RMXdu16hwE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T4hQX8wB9wDnl6wxsFVQWEQeT7fHMFnDer6o17PcWD8VS4EDTeCaYzB2QD2BrpDGFVCjDUPFeH4Qk/3lLiIZdfxMmZSdu/txG21H3dG1/Yf4BIlls1iD9fbTquFlDJfoay7q1Y+9yR77Ej5esXCpIXUFkHyJmLNh6hSVnBqfJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=uOr/r+r1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="uOr/r+r1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1F96834B6
	for <virtualization@lists.linux-foundation.org>; Sat,  3 Feb 2024 16:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.097
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDshGPyWny1A
	for <virtualization@lists.linux-foundation.org>;
	Sat,  3 Feb 2024 16:18:42 +0000 (UTC)
X-Greylist: delayed 309 seconds by postgrey-1.37 at util1.osuosl.org; Sat, 03 Feb 2024 16:18:41 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 306178348C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 306178348C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=devzero@web.de header.a=rsa-sha256 header.s=s29768273 header.b=uOr/r+r1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.3; helo=mout.web.de; envelope-from=devzero@web.de; receiver=<UNKNOWN> 
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 306178348C
	for <virtualization@lists.linux-foundation.org>; Sat,  3 Feb 2024 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706977117; x=1707581917; i=devzero@web.de;
	bh=yubN9w37erpD5QdX9ENnWkGbfu9RHa9i+RMXdu16hwE=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=uOr/r+r1AMZsuH+xOs1tWaku5badyuplHXRowVqCKagoFBygWsNy7SZjvkDpfg0f
	 69uNbTYywsP8NOP3/nO/w/AMlbDFsTXigRtPZgBp/iZBZjnQcpPzsJSAPvIR5M+r/
	 pq3BrDGafPP4HLtpywD2ypx/w5Weka2dBZQ6VjLyhi3esUqgcQEYgHBs5+WGaZCB0
	 RZ9loAp+8Q9Wshl9obkQCf7fxjTIeXbVnfKMxFsESUmqGmdJSjhzwMs3nduaJiYxv
	 95Sn5HnUqbfpUtU7SYBH/nHY4BM50TgUInaytu2g0YcDh8B1DInDWtthqEBDW4aJ+
	 Z1GJ68YAeWt+dbkPJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [172.20.35.190] ([37.24.118.138]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX17-1qnZtC2NDp-00jW9x; Sat, 03
 Feb 2024 17:13:27 +0100
Message-ID: <fdb38cde-099b-429c-8993-b4a16ccdf017@web.de>
Date: Sat, 3 Feb 2024 17:13:25 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: virtualization@lists.linux-foundation.org
Cc: kraxel@redhat.com, tzimmermann@suse.de, tiwai@suse.de
From: Roland <devzero@web.de>
Subject: screen unblanking problem in qemu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J1C1Irhj9Qo8s2Nu8ZfkBjUfmEl2crWecVZTlZ1mQrJEzEhOZwe
 DUiWhn5AiWB6N7quew3A/Drbsfuy/vlx3Ipr17OmqVgRs35+biXczHXEGpPmLpvwnOx+VlO
 5sczaZVStWiY2GvaWyqOTHtVp085w2pDxQgiXv9r3F1t8XYBq+Rynjkj49sVT0gHYidJ5VK
 zeRO/MH91n2DA2r0ABY3g==
UI-OutboundReport: notjunk:1;M01:P0:wMz1aL0A7kU=;32RCCPPXPrn5phna7gfLFsXY3ai
 gw72iZ9XQuENjGWaSWnvDwEwD7I9QunnXHCj9F3ai3ZMpgGHYBN7QApqD67lZ6j/Y50VH2Fwj
 YMcjlluYJJMhVqRVuwnLIrrYmfWybw7mBlLqyxpgQv8xUOG3rOj2NySmxrF+TAlIlTL3IHID/
 v+F9jCMMLZ4gRNSUvuF3YiVXCoD8ERfDLFHId8jktTGs3AIPGRIBzUe5Z3VvaAKAS/uigbWrT
 5hHpo3gXqoUucqt2+Pq2jhNypg0mLTbakyOLvLiA/N4Jh7YrFM0b0bTrAxAVWHPeX5VuFyEqD
 p5i/1gCjwjmEsoBqjWf9fGIrRcaHhBvN7kqNoSonK/gig91JQp6cbsic36jzZPEVvwmJMRHCb
 o9wkbdhidc1XmSCqew9TtiY2zAYICbw7dc5RK7R99/Fm/ePbFPRcfKWdjhEEUdGJpdn9bpcNy
 4KtKKKBLpW9LdfgBsNR1zD9W3jnGqJ7fxKoc6nGGOH2gAsS37hN3+Rkn7KbIUTiuK3freC3BC
 hVEa0sQCNionEfbySQbrsTfJg8TLtzECgD16fKmkuFAJ4c6ujDhgJkT6p56zDeXDm1SmFliFV
 xzpZTRsgQ33fOHUYqTrOWWrB1PvOvtFRkTlUkdEV8YsttJ4mqPjA0C1i5L/j4d2KIywYoJbjB
 xHx5nHInS72uoJiAo11urADTrOClZ9bnv7iYy+KNI6fugXY/TQGWEyfP/Vm2ve7oZQIxTg68e
 lW4XKl/RDdBGH0yTUXELUeuhjHG6yef9ira8nlgnokXx8vBLjuQ5iyUtGqSEJpORpVXgHheGT
 04IqO5NW2jlVjpp3bTVWNghlDkh2NkhAXxmnac187jr7Q=

hello,

i have problems with unblanking in console and x11 in qemu based
hypervisors.

the screen does not unblank as a whole on mouse move or when typing to
console.

https://gitlab.com/qemu-project/qemu/-/issues/2067
https://bugzilla.proxmox.com/show_bug.cgi?id=3D4786

first stumbled on this in debian 12 installer, and since then, it
rendered quite some installations unusable, as you get stuck when you
can't refresh the screen anymore.

it's a little bit weird that nobody seems to complains besides me, but i
can easily reproduce this on debian 12.

going back to kernel 5.15 does not show the problem, as there is no
screenblanking support in there.

not sure if this is related to the builtin vnc in qemu/proxmox or if
it's the driver itself. but it's annoying, as you cannot leave debian
installation alone for a while, as you need start from scratch after
blanking.

regards
roland
sysadmin



https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MA=
INTAINERS?h=3Dv6.8-rc2

DRM DRIVER FOR BOCHS VIRTUAL GPU
M:=C2=A0=C2=A0=C2=A0 Gerd Hoffmann <kraxel@redhat.com>
L:=C2=A0=C2=A0=C2=A0 virtualization@lists.linux.dev
S:=C2=A0=C2=A0=C2=A0 Maintained
T:=C2=A0=C2=A0=C2=A0 git git://anongit.freedesktop.org/drm/drm-misc
F:=C2=A0=C2=A0=C2=A0 drivers/gpu/drm/tiny/bochs.c


there has been blanking added here:
https://lists.freedesktop.org/archives/dri-devel/2021-April/303933.html

and there was this fix
https://lists.freedesktop.org/archives/dri-devel/2022-September/370781.htm=
l

