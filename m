From: Christoph Hellwig <hch@lst.de>
Subject: improve use_mm / unuse_mm
Date: Sat,  4 Apr 2020 11:40:55 +0200
Message-ID: <20200404094101.672954-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, Felipe Balbi <balbi@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

this series improves the use_mm / unuse_mm interface by better
documenting the assumptions, and my taking the set_fs manipulations
spread over the callers into the core API.
