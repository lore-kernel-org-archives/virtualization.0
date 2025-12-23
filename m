Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4F3148B3
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506941; cv=none; b=Xt+onQJ5xvbBVCalbSXh/ZKBVRvfmHzgSvmi9hPbMD4PL6MP9N2zNX2oc1a+NJnliZQiHKUoxVygpizZnuzq6D5dgoyd9IiSHmtZw7vzAIm5/2zPODgoZWnsVuhA93fXvyws/PC0HfLL0m7iOk6IPwADmlOn/3E+wGaugOv4fFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506941; c=relaxed/simple;
	bh=/0xYbPL616qbJH7DAEtPJytxbsCIUKJ6b4pgntLCSRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=e7/L9k/oessi5yt7A29QADeGTJje1HyE9JFTxVJu/Ei5ZlhEauFITKPcmWFpl8aKMq7C2pfEdlnY2TUOyB4N+xYV2GppFD4hYM2VpAGUD8PDpj7/D2+B1F3DlAIeQHsIC6e15Tfmou3E39WMrH/2WTBk1DRwyRyAbBxGKWDllMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emWlOgpy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emWlOgpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766506938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K4/UC+SmvFgSpwuzCxbdSjOFAReaxeGhgnIyBtkiDoY=;
	b=emWlOgpyS68R9I5hKaZNBCAQ/hRY9GNQ9QOAD4AeJ2xBX8UMf0JxJoX8Rf8nWhvVSdrCwa
	kL9KzsnQhJsvstBVJCZ8SuOsOrFjZ6nZRCNMo61LjI6E3/8wcu9C8NsXxL7tL8OwOHtyuy
	6cafJjsevqiksa2BF4EKScd2fC2JLpc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-ZiNcI3MxPCyH_LF-tzHKvQ-1; Tue, 23 Dec 2025 11:22:16 -0500
X-MC-Unique: ZiNcI3MxPCyH_LF-tzHKvQ-1
X-Mimecast-MFC-AGG-ID: ZiNcI3MxPCyH_LF-tzHKvQ_1766506935
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b79fcc35ab2so73309066b.2
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 08:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506935; x=1767111735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4/UC+SmvFgSpwuzCxbdSjOFAReaxeGhgnIyBtkiDoY=;
        b=tnifgBXmSkMaxKqQzmXfQd8HsIWSz3YC10A62TbxNEjg17sU5/RI1ct6ZjRgB3rHW4
         hRu3phgNOoL3GNvvijtGdC3lQaNkxRqbnnQm8XUd8q+tzNFN6VKcJod7iH47VaxcB0cY
         EKcCDlGiGU6EvtEjX97fkpDbsyBPd4QKT2PRtihrE6rMDvsMzYjFKvprd6ZETQ6j8GsT
         H6gAG5qdg5jV0PFh2phEP8Q7HW6z7iCdVjvj/S1RFgvQ4nLX3Nt5O+w6wlA+Cakb84NC
         su5Q8TdcMjVegDH9tzl5aLrbzsHrqa9VoOAR3OTghmS7vLhKAl0MJuz38OQmK7eLxOp9
         scpw==
X-Gm-Message-State: AOJu0YwMdyRS8bIEgVWdZrq6d6N5WlYBtCI9OJB0RWHDRCuS2Ejw2hKY
	VvmNHTqe9rcyTTF6Br4qQr/gJzS19KxPStmc5wRDugFGr1jXSDrLd7c0DgAz0qDt1Bp0WQ7jlmq
	nRlTijyq/9IJ4WvTMnHO2lAfvJ0QYMy+RadxeKeRp9WSlunm8LLXOv2l9RaA5NHkg8pQw
X-Gm-Gg: AY/fxX57FcDIWwwcjLj9qmx4zTreU716eALeKA60aUw/C5kGkl7sjhkcRnRY+UjbMtj
	ic8ia5XUYig2fCIiSlQInIn+jQ6V3FeSCgxsrxt5vjjK5svPv7ZTxlhONp+NKljyRq2ewiwjyml
	jKn7lxxUnezhUzU9wIM8jmIwc1ghlw4oZr5jcWRAvtVDyF3lN+p3SO8oR4a4r2zpeVYZO7sAPAC
	J8LlOFuZNt8nSe8nFmjkeeodgnR/9/LI3Y+VohNmyyu9esMWuFFcqbz24s7PFoSTKKmjUCoj9nX
	2AJS3uHrPJ0exnzVqm2lzlTK6cwZ3HNpe6fNiAKD940NF9Vo2QWOkzLs7onhWWo6ztU4MS6XNRV
	1Wqg=
X-Received: by 2002:a17:906:4fd0:b0:b73:7715:ac83 with SMTP id a640c23a62f3a-b80371d345bmr1471768466b.44.1766506935457;
        Tue, 23 Dec 2025 08:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDgtKwDEeqrVZ92+4oKCndyc9wVzJFED1Ykvg3bZfeGJ2owsbM3Hp1YtZvXRag/anoxgIQeQ==
X-Received: by 2002:a17:906:4fd0:b0:b73:7715:ac83 with SMTP id a640c23a62f3a-b80371d345bmr1471765766b.44.1766506934984;
        Tue, 23 Dec 2025 08:22:14 -0800 (PST)
Received: from stex1 ([193.207.129.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f7bsm1449868866b.18.2025.12.23.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:22:14 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next] vsock/test: add a final full barrier after run all tests
Date: Tue, 23 Dec 2025 17:22:10 +0100
Message-ID: <20251223162210.43976-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AixS0irrd_3MDs7KoddZ0QkvMpaohsRfUsA688z94JU_1766506935
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

If the last test fails, the other side still completes correctly,
which could lead to false positives.

Let's add a final barrier that ensures that the last test has finished
correctly on both sides, but also that the two sides agree on the
number of tests to be performed.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index d843643ced6b..9430ef5b8bc3 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -511,6 +511,18 @@ void run_tests(const struct test_case *test_cases,
 
 		printf("ok\n");
 	}
+
+	printf("All tests have been executed. Waiting other peer...");
+	fflush(stdout);
+
+	/*
+	 * Final full barrier, to ensure that all tests have been run and
+	 * that even the last one has been successful on both sides.
+	 */
+	control_writeln("COMPLETED");
+	control_expectln("COMPLETED");
+
+	printf("ok\n");
 }
 
 void list_tests(const struct test_case *test_cases)
-- 
2.52.0

