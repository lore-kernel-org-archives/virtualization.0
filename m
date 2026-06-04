Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4795353EE0
	for <virtualization@lists.linux.dev>; Thu,  4 Jun 2026 05:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550303; cv=none; b=WJSMpnOIG4D9XflRyzB6vikmAMBCwkWGMGO+JRxpqiJMuApxUddtIhrkXCSmoQoE7J8jHEsISM4gEpvIlKcMlaQ/yaQlanKnpZJ+HRVIpZr5v3TMvxh971XcFF1gKGW5h6ILxngjB++qj8zz4LyaL82SQLSlfh85vn0edor+JMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550303; c=relaxed/simple;
	bh=5zP8QkeIldQR8oeH0HhV4V/mXJJGJNin7wI2cdBzMBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQmb/3wHIPnMry/s5EC1mkeV0sNI0InwtXiikG2fqaLWGtqvcqac0Te8O0V2Edp06j6C0GsDHW35xplDlsrAbfR4SFq9u8oXJXCZwutaBT2zDqhvS1l+IU2qgNY8W/aFkCMSjm8Ool5AMleI5IQh+/YTJZ+1XH1vixv+zwfEQnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGd6tsXw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGd6tsXw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9033d230so150623a91.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 22:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550302; x=1781155102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuBmEOIOOIyUhW5B0cAmum3h3GyphcqhgceqYCZrJ+8=;
        b=qGd6tsXw48JQWsE8OI3QzbP5jiJTZmvxWMMTQn2qK7cdQRFahMAxsEXecIaj7IyaBb
         TehCPFLLbX1yhXES3QuxrD1v7XZaD/2wDQeLL/OXI4wQyYhbSaFjvCzhe7yHJSoGKMjh
         v2wMmbdH3q+N/J6TtDON4X5ik7RrDkS4Rpgkub4LJwfeyxgikE1z9KqEXoY5jtLqfqvU
         xp66Vd2ddX3czITA3XwacOkgGsWFGWv9yRaZNqOEH4GaQ9/972lOXT9ZRx17nHRc8bgi
         UROFZH0h2jbqkpaDLiJdC+PFesBXEyf/cURXRjnvlO+erUH7kiwMW6LkE/+RFwv65wgi
         mFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550302; x=1781155102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuBmEOIOOIyUhW5B0cAmum3h3GyphcqhgceqYCZrJ+8=;
        b=g7GjLvd8Ho8FjgWF5EAmvf17u1fuir0ihEctYk+bV7tLDpFoNXTmOHc0egnbJSkQKJ
         LWsxdhnQJXXjJte1CoVxoTYVCIpwTiBqaMEDTohqFlfWEbuT6pSf5+i7s2UaqfVy0Ek5
         6QIC2ZXGQDPDJmH8S7Z/keOUpZ7InhHtP2l5aORLdNGJIozFVLFqxDwLN29VbcU42ke6
         I61LaDMRUAVu+u8GNdt7xecEIkDqBIsn6zrc4DO/KolwHRhanc4saNjX+qM3PgsHFtRr
         gck84wFoI26f1S03eHRR8NvluPoNpixU2gLP62UACtwzemqqJ/yRq8yIIzsTwrsO9kHV
         sklw==
X-Forwarded-Encrypted: i=1; AFNElJ9ln1tbkjU/LZ5VvMk4Jc2iknnMmA/EqCbchMsVpgpm79myqtPQqvOPhyA1aIa6zRx2SQAt4lSubHEXpa01ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT1RU/oJxeqoa1x+4QnZPz1CJUj+VME0JO3rN0rHzDn2HDNguw
	WSr7oFovld+gX35Pm9XvlD/LsxOfpSpbCMj5yLUFtrKu2Nm6SMAxRNeN
X-Gm-Gg: Acq92OGaCDkiHZn5m5QN1p0ZztWwAI4HkPVRHxjTfnRKVfuVe/Bp7XH730Ow5JrePwt
	NcGXRci7+c/aDBz0q19Ch0ktQT2NZ86e69lAWlBkpaZh7Y2sGvyhQqzcqlhQ2TXB8lX0ojRlDpU
	UiLwu9BBurb2GVsZEl+xpVs3Mkui7naKV2zAUQuR6k9QKL8Z2xNo4pxETuduDOC+bWSD/b812ik
	XYqZm5rpPHhxXDf+dEOZcA2CNJikKlClnffqOBrvoqsvmOYaOTI5QBgu/JJq2+PJHcB0P4LuDWy
	bLEEXnMOjK+ecQwFsTc8rnQ+LFkl9UGxJNs5iHrwXq108E4Idpgqcjer24kP2YUZOjiof3Vum6u
	TUpjovAm3+hl66g9wtCuxwEDnX+bmnAvKh1WLzjjLkUK6deO+qRwe/elyaEsV1NTTGDxWCbsHjs
	MCZYX9WPODYOCYw3kU3ZduCsXLrfer5eqPfrS4KX+XRpmQBLkshSxmpkcD6Gc=
X-Received: by 2002:a17:90b:1d82:b0:35f:c493:cac5 with SMTP id 98e67ed59e1d1-36f782b56b8mr1727051a91.16.1780550301842;
        Wed, 03 Jun 2026 22:18:21 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm2009262a91.1.2026.06.03.22.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:18:21 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jpb@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH 0/2] iommu: avoid using list iterators past the loop in resv region insertion
Date: Thu,  4 Jun 2026 13:18:14 +0800
Message-Id: <20260604051816.2976221-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows up the inquiry at [1], where Will and Robin agreed that the
two list iterator sites in drivers/iommu/ that run past the loop end are
worth fixing.

Both loops only walk a list to find a list_head to insert before, not to
operate on the entries. Per Robin's suggestion, rather than tracking an
explicit insert_before pointer, each loop now iterates with list_for_each()
and keeps the list_entry() dereference inside the loop body. There is no
functional change in either patch.

[1] https://lore.kernel.org/all/CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com/

Maoyi Xie (2):
  iommu: Avoid using the list iterator past the loop in
    iommu_insert_resv_region()
  iommu/virtio: Avoid using the list iterator past the loop in
    viommu_add_resv_mem()

 drivers/iommu/iommu.c        |  7 +++++--
 drivers/iommu/virtio-iommu.c | 10 +++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
--
2.34.1

