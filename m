Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAD3126C1
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Feb 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661697; cv=none; b=uy5Zrry5RGjcPodi4+pEc3RK4tinLNw0OML61e4hZGyuUcYxtT6jFD64dNBUrV5hPDr0KTQiGSREf6Avk3ZSlpg6r7yQ/moxQ+cyN1KGxBRF0Y67ojWroIhr8rDq2YxmBcy0Z51SBZBtUZ7rPxwcCqnScgbsIhUthZCYxg+Z6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661697; c=relaxed/simple;
	bh=jPLQs3Hdny0FP3l+/5Ri3BVUh5isgpNkxUZ/B/5gKvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NZYQ9IcWo5c02gfNtxRI11AIOFYVXES0S/vmMHfSUzkNDBRgYD2O9wp8cZOtTTqYweAWys2Q6TGs+VPW/mai6fky5ZsjY93MQ32Fcn7qdJ3M2Wx0Bfugj9pVudb9SoqMKr390+H2f8E492xYLVNpkGjnUSHEys40BPaprSiCpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=airn.giize.com header.i=program@airn.giize.com header.b=DX9gbSYo; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airn.giize.com header.i=program@airn.giize.com header.b="DX9gbSYo"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12C7341C1F
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Feb 2026 18:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.907
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aw-KFrq9W169 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Feb 2026 18:28:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=143.20.185.112; helo=mta0.airn.giize.com; envelope-from=program@airn.giize.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B05A941C18
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=airn.giize.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B05A941C18
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=airn.giize.com header.i=program@airn.giize.com header.a=rsa-sha1 header.s=default header.b=DX9gbSYo
Received: from mta0.airn.giize.com (mta0.airn.giize.com [143.20.185.112])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B05A941C18
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Feb 2026 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=airn.giize.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=program@airn.giize.com;
 bh=LQD0hXllgKXRJZ7cLKh8fnQZqgQ=;
 b=DX9gbSYomoNnKmJ1AxzmFwV6UAEVuSzAqxzV8Llk69DUpbE6TBlJl1EkBTjvzIVzRpqJpiVRwSa5
   iuxw3ZhoD6g4+eYQ0lYcBBcJ05LNVF/gf3ui62BTT0ZGdrAqQ9Tvn4UEQvKjNi+RXHGjyc3mZ16W
   FIw7onnpOwtvAZEkp/A=
Reply-To: sales@sslootah.cam
From: S.S. Lootah Trading <program@airn.giize.com>
To: virtualization@lists.linux-foundation.org
Subject: RE: Inquiry for Product Information
Date: 9 Feb 2026 10:28:13 -0800
Message-ID: <20260209102812.85746FB0E055D605@airn.giize.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sir,
Good day.

We are currently reviewing manufacturers for upcoming projects=20
and would like to request your latest product catalog or=20
brochure, including key specifications, pricing details, payment=20
terms, and estimated delivery timelines.

Kindly send the requested information to sales@sslootah.cam at=20
your earliest convenience.

Thank you for your time. We look forward to your response.



Best regards,

Mohamed El-Sayed | Head of projects
S.S. Lootah Trading Building Material Division LLC
P.O. Box: 33919, Dubai =E2=80=93 UAE
T +971 4 775 4880
F +971 4 775 4881
M +971526792040
E sales@sslootah.cam
