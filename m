Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2023431E5
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058866; cv=none; b=nK9CJGIZsKoMTMK+EiQ7sE/D5CnRNjqRm+nn1ZMRy0N0zvM9rQIuu5NMod8oDdgG6h6hPX3vpcLGhrUjc3OslH4V22tHIQb+FbqIXgmVwmReELii9GgyyHvwg6BLxAv+fNjAiCXyl1I1gaAgfDi2YNBnvyOpa/zeYN3dQg53D7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058866; c=relaxed/simple;
	bh=ulLWxUh8EsRrOFrJv2gdzbq5iaYJxZBYyWiTN0ivhT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HfEgRRLcBZ8npxIxwHpDFMdZkS67+UGSK/ntGza+4T7cLz9b+kgT3HwC7p4KMrJhihacOSROQWRqslf4C73MYGMgzc4u28+mvYL+KNJJK0UYeKaROyTSA5ctOI6UJs6rc50bodPYUNkiTauKWHYb8BYhxYBiDbcTxKD+ICwFVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CceAfLCI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CceAfLCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRubUKoIKZa05nEVw7UJ7l9fUFkh873Slwn5354MkBU=;
	b=CceAfLCIFEelZD7POjrrOdeoSwd790meMBHaXZyuavtDal97ffM1NkGjfM3wmTln6DVq4M
	za4Vfykkm9B6fstWS+FQQk3F0IT8GkeKj1Q2izHHiJcE19UGvL/WMYbSbV+Ao9ZKpI/Z+s
	QB901TkrWiC1NxxM7m7Iu1ExnnJVrRA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-WirOkPntMI6oCOcOYTEAPQ-1; Tue, 21 Oct 2025 11:00:59 -0400
X-MC-Unique: WirOkPntMI6oCOcOYTEAPQ-1
X-Mimecast-MFC-AGG-ID: WirOkPntMI6oCOcOYTEAPQ_1761058857
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4284525aecbso2495056f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 08:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058857; x=1761663657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRubUKoIKZa05nEVw7UJ7l9fUFkh873Slwn5354MkBU=;
        b=foN4aFRAdftHrVeGZ9oZvVuIKRqq1sjnEtVdVyBQOc/xNHYY7DvHuSNnEN5+fKlacZ
         CS8I7JKKCEtUD4ge4c4BW/o0JN0McHmcle+VXi43yrtTr5BxSByV59GFilzHr0dy7+EK
         YoUpndXzEFnRnJ/Pm82er63DiVWf3KZ8y3trpO6sXp28uVLD3k0OFupU2wocXvE6a1eI
         St1iJgVP7h33SJdGeG+BgewhDge7vADepb5ECipEulGGA1jL9mM4qRxMVqADIHyF2awP
         eJQZxCoBv0PK2rHJrg15QowkdaSxx2OpmLzkc6cd+fJ5lG2rYZVfksVvs6EUCZcoQKqB
         EI3w==
X-Forwarded-Encrypted: i=1; AJvYcCWFpEDloFdK6UeMu5VWOCsrT811rACKXeKa+ozJBF7L6eGivn7/F0F/P80kVHkBSXqpt1xA8Ad1IQNdFtdOWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT9p6jtEGHDKXEsoxkOOpVrlhhzx8aWfz00+iRyscCxumCMzCv
	QXYhpFmVJh7GO1LZtfmKW+u/jxH9QJdPgEv/Wszxh4GHs48eN9dTov7KGGVd47tmbcHvEd6Z1HK
	u1ggAE0Afko49DozccQro20mxJ/7dJwyNLyFzBYtQQeGTWt40l0w40KsKy3YONYomj6lZ7QMYvY
	5O
X-Gm-Gg: ASbGncvuyii24M5vnzAfDg7NBtn3xHjnymDZGRoKRZGbuPTq1W5c8FJVzKdbEatVPNi
	GogmuCfhVXcXCkEkP17fuZsJXVut8ti3SVKGfZaA0NFRWjMZF/T40JCKZQR0RV4wsYGMLQSpyB/
	RUqMrS4ijAkuT3koJC6N7rixLbTcik5iy/V/v1J6le99NnsilChN5SBWqlsswAaeDISMiRHUdyD
	YxVk59cRC5qer/5Dp0B/vaSSXnrxLzC6nNc6NebGN37cIwcqGEafy+xXqLP/HHc57Ujd2bHz8MU
	hVEX9teCLVGIZVESVTRsKonrh7YzVNu44c6fdzHlpZ70mIkLv22Oc/2tSMZXrzK7iAEzobyC/b5
	1oxTEEUtuW+4o2L8sQ95q35i276UpFrDHEkMgWOR/tpbEgpyghzE2Tkqd4dBj
X-Received: by 2002:a5d:5d05:0:b0:427:809:eff5 with SMTP id ffacd0b85a97d-4270809f252mr11795568f8f.53.1761058857354;
        Tue, 21 Oct 2025 08:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuNdQq7IEo7xmxPaMqWMcC8QeroaNoRnXCBpBegLE0FB0KNfhJhInOomIlaVikmeTIuzyODg==
X-Received: by 2002:a5d:5d05:0:b0:427:809:eff5 with SMTP id ffacd0b85a97d-4270809f252mr11795534f8f.53.1761058856848;
        Tue, 21 Oct 2025 08:00:56 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a78csm20793541f8f.26.2025.10.21.08.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:00:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 23/23] MAINTAINERS: move memory balloon infrastructure to "MEMORY MANAGEMENT - BALLOON"
Date: Tue, 21 Oct 2025 17:00:40 +0200
Message-ID: <20251021150040.498160-7-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021150040.498160-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xReOEdv4QJE9i_vXloJn53nlJJCT4VZBAqyxL4owkB4_1761058857
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Nowadays, there is nothing virtio-balloon special anymore about these
files, the basic infrastructure is used by multiple memory balloon
drivers.

For now we'll route it through Andrew's tree, maybe in some future it
makes sense to route this through a separate tree.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878e53d0f65ed..17fbf5c1ea2fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16225,6 +16225,16 @@ T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
 F:	mm/
 F:	tools/mm/
 
+MEMORY MANAGEMENT - BALLOON
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	David Hildenbrand <david@redhat.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+W:	http://www.linux-mm.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	include/linux/balloon.h
+F:	mm/balloon.c
+
 MEMORY MANAGEMENT - CORE
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	David Hildenbrand <david@redhat.com>
@@ -27062,9 +27072,7 @@ M:	David Hildenbrand <david@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/virtio/virtio_balloon.c
-F:	include/linux/balloon.h
 F:	include/uapi/linux/virtio_balloon.h
-F:	mm/balloon.c
 
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.51.0

