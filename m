From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [RFC v9 00/11] vhost: ring format independence
Date: Fri, 19 Jun 2020 20:22:51 +0200
Message-ID: <20200619182302.850-1-eperezma@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com
Cc: kvm list <kvm@vger.kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This adds infrastructure required for supporting
multiple ring formats.

The idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

Used ring is similar: we fetch into an independent struct first,
convert that to IOV later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

For used descriptors, this allows keeping track of the buffer length
without need to rescan IOV.

This seems to perform better on UDP stream tests, but a little bit worse on
RR tests and TCP streams, based on a microbenchmark.
More testing would be very much appreciated.

changes from v8:
        - fixes fetch_descs returning "no descriptors available" when
          only few descriptors were available, stalling the communications.
        - minor syntax errors in intermediate commits.
        - skipping checking for sane max_descs if vhost device is not going to
          use worker like vDPA devices.

changes from v7:
        - squashed in fixes. no longer hangs but still known
          to cause data corruption for some people. under debug.

changes from v6:
        - fixes some bugs introduced in v6 and v5

changes from v5:
        - addressed comments by Jason: squashed API changes, fixed up discard

changes from v4:
        - added used descriptor format independence
        - addressed comments by jason
        - fixed a crash detected by the lkp robot.

changes from v3:
        - fixed error handling in case of indirect descriptors
        - add BUG_ON to detect buffer overflow in case of bugs
                in response to comment by Jason Wang
        - minor code tweaks

Changes from v2:
        - fixed indirect descriptor batching
                reported by Jason Wang

Changes from v1:
        - typo fixes

Michael S. Tsirkin (11):
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched get_vq_desc version
  vhost/net: pass net specific struct pointer
  vhost: reorder functions
  vhost: format-independent API for used buffers
  vhost/net: convert to new API: heads->bufs
  vhost/net: avoid iov length math
  vhost/test: convert to the buf API
  vhost/scsi: switch to buf APIs
  vhost/vsock: switch to the buf API
  vhost: drop head based APIs

 drivers/vhost/net.c   | 174 ++++++++++----------
 drivers/vhost/scsi.c  |  73 +++++----
 drivers/vhost/test.c  |  22 +--
 drivers/vhost/vhost.c | 372 +++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h |  44 +++--
 drivers/vhost/vsock.c |  30 ++--
 6 files changed, 435 insertions(+), 280 deletions(-)

-- 
2.18.1
