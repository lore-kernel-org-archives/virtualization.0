Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82342F49F0
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Feb 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196877; cv=fail; b=P1BlYtLX2hNN9NDJVl4Q6NfBtDruOkMZNmV1euN5ig/wUXqHBNMWWV6rVgjYnOWRm0i6e2mbK3D73A9hyvptjJJ+dM4GnkCOwc36rsrb7qeSgR8WZHxgDLMURzYR3l84lSaKZ4QrVZRZ6Z/LvrxOqCI/FzdCs0gzBUBYPOwxdoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196877; c=relaxed/simple;
	bh=bL5TwZjXmiDlQH5CzuRnxdzusYuhFmXZYQttvOAjxbs=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=YCg9q9jN15Wx1V2FZGx4wL5U1Z+ulVqkknqX+zmmL7zyKrHEjf0+3t+024ZDZzhpajZJ38Jc9IwbD28952KMsgSHY4y6hdmEvkyfkjRPEEUmaRdZSGUN9aj0mv/zkl3AzeiXED36EWaq+mFkg7lzz/aPv8ZRwsKjtA3w1g4UhQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1FCCF40423
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Feb 2026 09:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 0.444
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mzOWlgBDwQk for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Feb 2026 09:21:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.77.231.86; helo=mail.stratx.pl; envelope-from=wiktoria.rungel@stratx.pl; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EA21D4021A
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=stratx.pl
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA21D4021A
Received: from mail.stratx.pl (mail.stratx.pl [51.77.231.86])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA21D4021A
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Feb 2026 09:21:15 +0000 (UTC)
Authentication-Results: factro.pl; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; d=factro.pl; s=default; a=rsa-sha256; cv=none; t=1770196599;
	b=O+wJz61cRMZJn+B0CnraqszBg+c/lO6FMnMYsP5Jenyf+SDecVivdnvk2lR+4Lx9Uxd8
	 czvLU4V2n/R/HZcLvZjiSTt5yFRivoVUygz+2RQHMGIsz6UUhdvQEqd4tmJi4gSEHEmp8
	 DGy73C9MpE4JwIiTgau1a6xWWIUxpZp8Ba+xRCXDep5djFRIwU3KwzQ0psgUshuE/PRuF
	 gM5p3Rj82VM+VKAnPwDoIBPOwjRkquPP+E89dHJNnTht5Jq+ShkWZYt1bzj98zMUvtOEI
	 gw4Ys4nDfnQXzJ4l7HCRbGVlGADFDBE1f8gcjfafHvxMF8ydmlGnh+YRXAtKFS+YV0w==
ARC-Message-Signature: i=1; d=factro.pl; s=default; a=rsa-sha256;
	c=relaxed/simple; t=1770196599;
	h=Message-ID:Date:From:Subject:From;
	bh=bL5TwZjXmiDlQH5CzuRnxdzusYuhFmXZYQttvOAjxbs=;
	b=MC61cmlrjTCg77u70V+Z9/nysjNbedZ9fJg+vZPd73p1MKETRZnSH6R7fn8Sruzutxpf
	 wUpnXfinTYk4aBZIgPJtfDkemqivJrnNOtZd+5HiZoqPY0gkMc2JcwLnV7dxeMPERlYIr
	 n+cNc898JrVKj5w/e/Kj2REGzKr7SFazxzoF7eDJkjvHw7HZq6RtiwizDugowDrGMjg2q
	 vEahq7hF87HB9bGRJuvMcGSp0yQcwoW9YGghCILF973Cm/1hQUatBZ+JbeHc2dNwaAC+B
	 n24b1rLjRBIKNqd7V/KLIs5WxWbcGH43nD8s8VUmTuCY0hAAgpxc4dOzdRKK/AylU2Q==
ARC-Authentication-Results: i=1; factro.pl; arc=none smtp.remote-ip=127.0.0.1
Received: by mail.stratx.pl (Postfix, from userid 1002)
	id 6AA9B26A85; Wed,  4 Feb 2026 09:16:05 +0000 (UTC)
Received: by mail.stratx.pl for <virtualization@lists.linux-foundation.org>; Wed,  4 Feb 2026 09:15:44 GMT
Message-ID: <20260204074500-0.1.7q.34pja.0.irjbqj2103@stratx.pl>
Date: Wed,  4 Feb 2026 09:15:44 GMT
From: "Wiktoria Rungel" <wiktoria.rungel@stratx.pl>
To: <virtualization@lists.linux-foundation.org>
Subject: Kandydat do pracy
X-Mailer: mail.stratx.pl
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

delegujemy sprawdzone osoby ze Wschodu do pracy w firmach produkcyjnych d=
o prostych prac przy produkcji, na magazynie, przy pakowaniu towaru czy k=
ontroli jako=C5=9Bci.=20

Nasza firma organizuje wszelkie formalno=C5=9Bci oraz zakwaterowanie, co =
pozwala zmniejszy=C4=87 koszty po Pa=C5=84stwa stronie.

Czy mog=C4=99 przedstawi=C4=87 szczeg=C3=B3=C5=82y?


Pozdrawiam
Wiktoria Rungel
