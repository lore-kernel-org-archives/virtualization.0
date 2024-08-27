Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2414146590
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784986; cv=none; b=UPD5gQHleRr5WysYfMhOXN3ykTdM9OIgLQEC85/+3CiBgnaiNhWt97DZsXT1M6e2FL703tcAyRgpiERsmb5AWAZ+A8ryGDWMSE4FmfjLLWSaW3igOTinYzY1BOeMxydx/qcsyku+Lrkp6XQ2otTs+HAA0fnR4nLEJr8zq0a/bNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784986; c=relaxed/simple;
	bh=LrbzScSKoeO/OuSMvPnyas9t8iaLv9wwkOs1i5Fx+6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BmSIZDS7JBrMwqAqxoPDCkhl6wzu4exROiCMgsERSzl8fQ4Jsz/euG+ZD4izthPbN7ZfUqPpZpLl0lxXZsZ8rIy6wOdDsL1T+PokFlFpUXi8NlwNZysqJNyPp5WFyObAKOWuroNwjfAVcIdkjqFRIzySJGwyiTgtrruoStdZx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=clicWE08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="clicWE08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+guXcsQCtHK0Zw9q0IVqiyr7tZDLCnkq56MSYQg4xFc=;
	b=clicWE08N9pyMy0B2N/30mXc3a1KXY9hGpWOJh8babnhmhHfbKn9e5NZA9XR65radrBYLB
	8o8V9U9hSu1Gfg9i2U+4/zru72JlJSMxTcLyJQGk/8EskJBwDPQaT8qIPlWrvZBjgX6a+H
	YmBYJERmzwuC+sZh4sy+WtJiFwMyHXM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Q5S09Vv9OYej6PqZkLBoRQ-1; Tue, 27 Aug 2024 14:56:22 -0400
X-MC-Unique: Q5S09Vv9OYej6PqZkLBoRQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8685464a7dso482698166b.1
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 11:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784981; x=1725389781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+guXcsQCtHK0Zw9q0IVqiyr7tZDLCnkq56MSYQg4xFc=;
        b=kFcMBW/qzaOiN07RAiYtX7kJiZ8PkBZhVTpt5rhQL38GSHcDlIHV+sJF2/hI7k8v9I
         RFxVhUU3WV6QxwqkmERuS2QBgswe2TUrfR8lTUEUjrmF4/BNKMXyU/LJrh2DJR/vS8vn
         B6j7CYYJxSNoMNuhehT3G1r9my22WJaCUngV8L7LZ/MAM5JDZ2GsV1jCqEoOmEgK0mVb
         ORW6PI6GHcc5OHW9HU+yVTgVLBAUA/08drwfVvOvCguZJEZaghbA2QvxlpwMkgVk/iC+
         97jVMTihKiql1XlMsdPVBNcJI5ta/wVV+6Eu11RhEtgIPUhg1lyLETR3kNXcPY0WqMp6
         gwuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI9wJQahbHvnIrT0ELeJe+PMZeajpILIICTfQZoGWoZzxvojBVT8DSGMBHs2oqvJJbR6HgpzUURyXFhEHJ1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRzhLFJEIbRrDwxNjTi9OXp4ipJJeJSUxcp0P3QCPXnvSDZDJL
	Umm8XqsuPYsKWLprFp2z7OulW6uZM2XtFGrC5wi9ef/UHdMkzARlQdgDXxQXrQCMY0r/ezBUfn/
	z0fcbcx0da/rW1ksbjLCDG7Rn7Tn+/z4O9hSbLK33SKzbERgJGMUkA2HQzteQ0Vsy
X-Received: by 2002:a17:907:7ea1:b0:a86:9ba1:63ac with SMTP id a640c23a62f3a-a86e3988e14mr297769266b.14.1724784980682;
        Tue, 27 Aug 2024 11:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSbDGP3VLJBbRBOwu9OD/wZex1BvcaPqE7Ybh9WpNR4VoxlhFHT2FFoNIIJFNO/012/OwV3Q==
X-Received: by 2002:a17:907:7ea1:b0:a86:9ba1:63ac with SMTP id a640c23a62f3a-a86e3988e14mr297764166b.14.1724784980100;
        Tue, 27 Aug 2024 11:56:20 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:19 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 0/7] PCI: Remove pcim_iounmap_regions()
Date: Tue, 27 Aug 2024 20:56:05 +0200
Message-ID: <20240827185616.45094-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OK, so unfortunately it seems very challenging to reconcile the merge
conflict pointed up by Serge between net-next and pci-devres regarding
"ethernet: stmicro": A patch that applies to the net-next tree does not
apply anymore to pci-devres (and vice versa).

So I actually think that it would be best if we just drop the portation
of "ethernet: stmicro" for now and port it as the last user in v6.13.

That should then be trivial.

Changes in v4:
  - Drop the "ethernet: stmicro: [...] patch since it doesn't apply to
    net-next, and making it apply to that prevents it from being
    applyable to PCI ._. (Serge, me)
  - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
    stimicro" as the last user for now. Perform the deprecation in the
    series' first patch. Remove the Reviewed-by's givin so far to that
    patch.
  - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
  - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet" instead of
    "snet"). (Christophe)
  - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
  - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
  - Apply Reviewed-by's from Andy and Xu Yilun.

Changes in v3:
  - fpga/dfl-pci.c: remove now surplus wrapper around
    pcim_iomap_region(). (Andy)
  - block: mtip32xx: remove now surplus label. (Andy)
  - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
    occurs. (Andy, Christophe)
  - Some minor wording improvements in commit messages. (Me)

Changes in v2:
  - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
    patch, put stable kernel on CC. (Christophe, Andy).
  - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
  - Consequently, drop patch "PCI: Make pcim_release_region() a public
    function", since there's no user anymore. (obsoletes the squash
    requested by Damien).
  - vdap/solidrun:
    • make 'i' an 'unsigned short' (Andy, me)
    • Use 'continue' to simplify loop (Andy)
    • Remove leftover blank line
  - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)


Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (7):
  PCI: Deprecate pcim_iounmap_regions()
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  vdpa: solidrun: Fix UB bug with devres
  vdap: solidrun: Replace deprecated PCI functions

 drivers/block/mtip32xx/mtip32xx.c             | 16 +++--
 drivers/fpga/dfl-pci.c                        | 16 ++---
 drivers/gpio/gpio-merrifield.c                | 14 ++---
 .../net/ethernet/cavium/common/cavium_ptp.c   |  6 +-
 drivers/pci/devres.c                          |  8 ++-
 drivers/vdpa/solidrun/snet_main.c             | 59 ++++++++-----------
 include/linux/pci.h                           |  1 +
 7 files changed, 51 insertions(+), 69 deletions(-)

-- 
2.46.0

