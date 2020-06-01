From: John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] vhost, docs: convert to pin_user_pages(), new "case 5"
Date: Sun, 31 May 2020 22:26:31 -0700
Message-ID: <20200601052633.853874-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, Souptick Joarder <jrdr.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>
List-Id: virtualization@lists.linuxfoundation.org

This is based on Linux 5.7, plus one prerequisite patch:
   "mm/gup: update pin_user_pages.rst for "case 3" (mmu notifiers)" [1]

Changes since v1: removed references to set_page_dirty*(), in response to
Souptick Joarder's review (thanks!).

Cover letter for v1, edited/updated slightly:

It recently became clear to me that there are some get_user_pages*()
callers that don't fit neatly into any of the four cases that are so
far listed in pin_user_pages.rst. vhost.c is one of those.

Add a Case 5 to the documentation, and refer to that when converting
vhost.c.

Thanks to Jan Kara for helping me (again) in understanding the
interaction between get_user_pages() and page writeback [2].

Note that I have only compile-tested the vhost.c patch, although that
does also include cross-compiling for a few other arches. Any run-time
testing would be greatly appreciated.

[1] https://lore.kernel.org/r/20200527194953.11130-1-jhubbard@nvidia.com
[2] https://lore.kernel.org/r/20200529070343.GL14550@quack2.suse.cz

John Hubbard (2):
  docs: mm/gup: pin_user_pages.rst: add a "case 5"
  vhost: convert get_user_pages() --> pin_user_pages()

 Documentation/core-api/pin_user_pages.rst | 18 ++++++++++++++++++
 drivers/vhost/vhost.c                     |  5 ++---
 2 files changed, 20 insertions(+), 3 deletions(-)


base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
--=20
2.26.2
