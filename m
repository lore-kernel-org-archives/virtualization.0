From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/2] docs: mm/gup: pin_user_pages.rst: add a "case 5"
Date: Sun, 31 May 2020 22:26:32 -0700
Message-ID: <20200601052633.853874-2-jhubbard@nvidia.com>
References: <20200601052633.853874-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20200601052633.853874-1-jhubbard@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Souptick Joarder <jrdr.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>
List-Id: virtualization@lists.linuxfoundation.org

There are four cases listed in pin_user_pages.rst. These are
intended to help developers figure out whether to use
get_user_pages*(), or pin_user_pages*(). However, the four cases
do not cover all the situations. For example, drivers/vhost/vhost.c
has a "pin, write to page, set page dirty, unpin" case.

Add a fifth case, to help explain that there is a general pattern
that requires pin_user_pages*() API calls.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core=
-api/pin_user_pages.rst
index 4675b04e8829..6068266dd303 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -171,6 +171,24 @@ If only struct page data (as opposed to the actual mem=
ory contents that a page
 is tracking) is affected, then normal GUP calls are sufficient, and neithe=
r flag
 needs to be set.
=20
+CASE 5: Pinning in order to write to the data within the page
+-------------------------------------------------------------
+Even though neither DMA nor Direct IO is involved, just a simple case of "=
pin,
+write to a page's data, unpin" can cause a problem. Case 5 may be consider=
ed a
+superset of Case 1, plus Case 2, plus anything that invokes that pattern. =
In
+other words, if the code is neither Case 1 nor Case 2, it may still requir=
e
+FOLL_PIN, for patterns like this:
+
+Correct (uses FOLL_PIN calls):
+    pin_user_pages()
+    write to the data within the pages
+    unpin_user_pages()
+
+INCORRECT (uses FOLL_GET calls):
+    get_user_pages()
+    write to the data within the pages
+    put_page()
+
 page_maybe_dma_pinned(): the whole point of pinning
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
--=20
2.26.2
