From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/2] vhost: convert get_user_pages() --> pin_user_pages()
Date: Sun, 31 May 2020 22:26:33 -0700
Message-ID: <20200601052633.853874-3-jhubbard@nvidia.com>
References: <20200601052633.853874-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200601052633.853874-1-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Souptick Joarder <jrdr.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>
List-Id: virtualization@lists.linuxfoundation.org

This code was using get_user_pages*(), in approximately a "Case 5"
scenario (accessing the data within a page), using the categorization
from [1]. That means that it's time to convert the get_user_pages*() +
put_page() calls to pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 21a59b598ed8..596132a96cd5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1762,15 +1762,14 @@ static int set_bit_to_user(int nr, void __user *add=
r)
 	int bit =3D nr + (log % PAGE_SIZE) * 8;
 	int r;
=20
-	r =3D get_user_pages_fast(log, 1, FOLL_WRITE, &page);
+	r =3D pin_user_pages_fast(log, 1, FOLL_WRITE, &page);
 	if (r < 0)
 		return r;
 	BUG_ON(r !=3D 1);
 	base =3D kmap_atomic(page);
 	set_bit(bit, base);
 	kunmap_atomic(base);
-	set_page_dirty_lock(page);
-	put_page(page);
+	unpin_user_pages_dirty_lock(&page, 1, true);
 	return 0;
 }
=20
--=20
2.26.2
