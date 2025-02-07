Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0A18FC72
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948790; cv=none; b=UjRkTvjtjd6fLGy3J20RHIWqBzYYOaewP1Gf3+psKRrOJzlRTcAYQNJl2Lkby/1G8sANHaNm/mwHEAV3NBgAyFMcIQ/jm5upwNI1HgKQaqVKYo4syw47KF4JLfo4s9NK3PcLQXAKPEvKTYc55ksVASiQ2HgUGJ/MSDeU49ZKUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948790; c=relaxed/simple;
	bh=KknBGthfIwIloSehzsP5jhPIk3SsdQVuqe7yf1GkJqg=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sSq3KCnySnuvJL0dV1vWChj1PHIkU22nHWNTzwgDDk/utkq609bQ+3QI6ooV98wXPU0C8hlDcyy+AilwZQtM3iLDFXR4RBbDXtsWRqk8PWQvhZ728Sar3UexsCTbsjFUj1mbL4Vv/S8gne/ekgwx9R/4lsF2OlHo1Jhih9A7oFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbRKh4HP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbRKh4HP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D746942A35
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 17:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDjFic0on8cV for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 17:19:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0503640627
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0503640627
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GbRKh4HP
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0503640627
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 17:19:47 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6dd43aa1558so17649826d6.0
        for <virtualization@lists.linux-foundation.org>; Fri, 07 Feb 2025 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738948786; x=1739553586; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu2IDIgslPffNDxLhX3CkoTnVctGZeUEdbbs5k8JxN8=;
        b=GbRKh4HPLj/iZsJSvObpVYj3cLAxJPkMP2DJrzY1llWF2UuYFnkH52Q0Gb+ECa0i82
         jH6Q/3Cw88N8AIc6c3UeUjzIND8rrlHXwOlcGAbE51QnAin4RizPaV6Zhqn33PW72LTS
         PlMJhqcpNKcSHda/MjX06v8gCZl7JDzR3zpVHG63XCvYvvw7075yWEMq1OCGrRQ2i8Sd
         3RAVTSoEhhWqZFmt0JXc4TTeURRb5NgUW0UR+2I7V+HftsEbvg0bbEN52WhV4N6Mhczv
         hpguUUlSyfmRoK9kAdWPChxFNiRJIoB2G81KX0yY5tqitLarC3J+YR8W3uMczrzSck3D
         oGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948786; x=1739553586;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu2IDIgslPffNDxLhX3CkoTnVctGZeUEdbbs5k8JxN8=;
        b=PTOk8JMoOCvoS3aCJjgffHz5Cou4IH4Yn+q+hgdK9VnNkXQpTfAKTXUDwADDpg9gGB
         gQlpcM/E60qS838he2oRdKOEMsIeVbNSDw67WwVFWkYmI2g+F1RC6NFpjs9K344rbWcy
         Oc7KPdjFx0LIePduIwUms4R8PjA865KoneY7aLyBnc1PevhGL4HQjxXSF7CRhPuVa116
         PIxUeyllvIfvhxSgzSxS4rZlVW8VF3Tey++13P5IwVS5GtHoHHrjXN3418AVfifRWfLy
         rkb9pEKc+6gxnLBpSoIUfrbamakcv6WCyhX/5oteS1ZgVXY0hY+ADlWLixi8EXhG1oL+
         alxg==
X-Forwarded-Encrypted: i=1; AJvYcCXWuKnohSw/Q5C6pJ8bapYAFyrFhdWIVzZk1wI8yrW/XtfUdDTTukibEfMIYa0XVovGGd54NWDm3kGvR9kHBA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx2vrhRLX6R+DqOilHSA4yLji4CvcOMIApCZBnrfQdlJGZ6L7wL
	9cKMAWdmgxYEXgIU5tOdqnZWaJCYHtTRBplFt+zeMzlFcMV6Qwzx
X-Gm-Gg: ASbGncspRBetFSYujJaP8g9ncmMnTAJhm7raISTwRYWhHwQU5ClT/T/uqZ+c20KoI9i
	NEnQq95CcoHifFhu8dgovaY2lB+YDIpzuhVxl/Cxn2ChCMI7xSB+7M8/SLrv2ax43tDLM5QR/kE
	nV0Q2cj83PcX50Dlj8BwOUfxfr2Ssw32oQqLpXR4zgop9nCIP3/44S8sTEFF+wioBpR8EV7MM59
	UmBnJm6BhnAl//KbmSypmRjw7WB0Hf4FQefWRQcFey2Qo9AkgrVUtP6gOA0VwgVooaM1ZO5mp2X
	Dl2lYunw2bRlpa7WlWvMBnuqgPVpzBPJviWPJWOvZnYASCssayCAYbJzMlpG7f8=
X-Google-Smtp-Source: AGHT+IEWWq0ne0VYd5AXzSqkGgD5OOExH8N8UKeXB3TjUiJ6pdDgPBC+XCdszHjQfw5Q5kLUTvrTcw==
X-Received: by 2002:ad4:5ce8:0:b0:6d8:7ed4:336a with SMTP id 6a1803df08f44-6e4456fb76amr63078226d6.31.1738948786612;
        Fri, 07 Feb 2025 09:19:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43fd17799sm15637916d6.2.2025.02.07.09.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:19:46 -0800 (PST)
Date: Fri, 07 Feb 2025 12:19:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67a640b1a0855_2b3e7e29470@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250207-tun-v6-5-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
 <20250207-tun-v6-5-fb49cf8b103e@daynix.com>
Subject: Re: [PATCH net-next v6 5/7] tun: Extract the vnet handling code
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> The vnet handling code will be reused by tap.
> 
> Functions are renamed to ensure that their names contain "vnet" to
> clarify that they are part of the decoupled vnet handling code.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
