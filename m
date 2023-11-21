Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C64776B
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dysk79we"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B85610C0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 15:56:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46B85610C0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dysk79we
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.958
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D4BnpDz6y9Xn
	for <virtualization@lists.linux-foundation.org>;
	Tue, 21 Nov 2023 15:56:55 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C2688610BD
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 15:56:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C2688610BD
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c10f098a27so4616260b3a.2
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Nov 2023 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700582214; x=1701187014; darn=lists.linux-foundation.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSv0+6q5saFNWf2ERrz/p1oE/dZjM3zh5BeNMvxR1eY=;
        b=dysk79we7yoGvkx5w02dDG/O9uFVZweZJNLX9MBCZ1bHArbXHtqzuIMoXsOEm++CL2
         XRakwindiTLTSuqKIvij+O6ZdkS7sb/kb/TmLLOm0TfQ24rSYJXmfrQIAgLEv9QohO5d
         1ED32KNCTfqjVllc4zYYV3NzKad5WLSyenckjHDkRTF+NFDCtvkFkNGmVCrRqocghIMn
         rRUnuoutiQRd6jLKps5bOHdr0pZDnNAAfs4l+8TPi2TPK/NNxEZpzbvqeXHst6y3ChIN
         ZgsD3OJzGmGkNYIMwztZVdhSRqC9BSugiSLlznfEX9Ndw31MLCZzFE5sbPaCjWtc4E7B
         04FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582214; x=1701187014;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSv0+6q5saFNWf2ERrz/p1oE/dZjM3zh5BeNMvxR1eY=;
        b=fSyT2rHuszQ+zWvje8GK9Q0VcMkRO8WAO5kM+A2PZ8M8bGCekgDqaLnndZZGnyc/oQ
         BbS73Z8Ty1rNCSAGgUt/Ncq9LI8zwIvyWla86VzpXqApCjbvPIPi488vzTsjrP69qH6M
         G/Xsw4D/cN4ZlfLt/t/XPXzZL/bXqetjvVX9plxNQtv6zIrbmubjKzmUB7WfAKwdFZmX
         Y3qTutamH+E4fVgCOG3EAC5l/bqLfBwr+KGOJcTm1tVm6Kk1Sh7L4KZ6899ZypFkSnZ1
         awIIEVsfUyXUa1H4XNCenEqUdOE6gHw3xNXumZwdWr1zGOV2E6tMIvFsurx+Sgvx/GmQ
         mxWA==
X-Gm-Message-State: AOJu0YzLgXlmGiOzz3DoOcmRMOX1zSl9p8D1bO+nggbfmQE8WYU7EBdJ
	ZEkOB8NkkNbTq7JnQR3n9RbD1EaPBsQ=
X-Google-Smtp-Source: AGHT+IE/pAdlHyIQafFzxERiNqK8iSmRUfcAsUwYjL8hWHElmpMWh/jFwKAh/6tVRrndOWpbfTD8ZQ==
X-Received: by 2002:a05:6a20:8e14:b0:18a:d8ba:ca4c with SMTP id y20-20020a056a208e1400b0018ad8baca4cmr2877890pzj.52.1700582214179;
        Tue, 21 Nov 2023 07:56:54 -0800 (PST)
Received: from [198.135.52.44] ([198.135.52.44])
        by smtp.gmail.com with ESMTPSA id o73-20020a62cd4c000000b006930db1e6cfsm8477226pfg.62.2023.11.21.07.56.53
        for <virtualization@lists.linux-foundation.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 07:56:53 -0800 (PST)
From: Peter Wilson <gilesokware@gmail.com>
X-Google-Original-From: Peter Wilson <info@alrigga.com>
Message-ID: <0382e5b3375c66df7d69edef200db49dacd6f0e0bff9c56ec2a1ff1920b64e98@mx.google.com>
Reply-To: loansmanager@alriggainvestments.com
To: virtualization@lists.linux-foundation.org
Subject: :once again
Date: Tue, 21 Nov 2023 07:56:52 -0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello virtualization,

Are you Thinking of starting a new project or expanding your business? We can fund it. Terms and Conditions Apply.

Regards,
Peter Wilson
