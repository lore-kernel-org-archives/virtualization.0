From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 00/13] vhost: format independence
Date: Tue, 2 Jun 2020 09:05:54 -0400
Message-ID: <20200602130543.578420-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We let the specifics of the ring format seep through to vhost API
callers - mostly because there was only one format so it was
hard to imagine what an independent API would look like.
Now that there's an alternative in form of the packed ring,
it's easier to see the issues, and fixing them is perhaps
the cleanest way to add support for more formats.

This patchset does this by indtroducing two new structures: vhost_buf to
represent a buffer and vhost_desc to represent a descriptor.
Descriptors aren't normally of interest to devices but do occationally
get exposed e.g. for logging.

Perhaps surprisingly, the higher level API actually makes things a bit
easier for callers, as well as allows more freedom for the vhost core.
The end result is basically unchanged performance (based on preliminary
testing) even though we are forced to go through a format conversion.

The conversion also exposed (more) bugs in vhost scsi - which isn't
really surprising, that driver needs a lot more love than it's getting.

Very lightly tested. Would appreciate feedback and testing.

Michael S. Tsirkin (13):
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched version by default
  vhost: batching fetches
  vhost: cleanup fetch_buf return code handling
  vhost/net: pass net specific struct pointer
  vhost: reorder functions
  vhost: format-independent API for used buffers
  vhost/net: convert to new API: heads->bufs
  vhost/net: avoid iov length math
  vhost/test: convert to the buf API
  vhost/scsi: switch to buf APIs
  vhost/vsock: switch to the buf API
  vhost: drop head based APIs

 drivers/vhost/net.c   | 173 +++++++++----------
 drivers/vhost/scsi.c  |  73 ++++----
 drivers/vhost/test.c  |  22 +--
 drivers/vhost/vhost.c | 375 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  46 ++++--
 drivers/vhost/vsock.c |  30 ++--
 6 files changed, 436 insertions(+), 283 deletions(-)

-- 
MST
