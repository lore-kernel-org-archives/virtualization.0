From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v4 0/5] vhost: ring format independence
Date: Sun, 13 Oct 2019 07:41:55 -0400
Message-ID: <20191013113940.2863-1-mst__40452.8927918122$1570967664$gmane$org@redhat.com>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds infrastructure required for supporting
multiple ring formats.

The idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

This seems to perform exactly the same as the original
code already based on a microbenchmark.
Lightly tested.
More testing would be very much appreciated.

To use new code:
	echo 1 > /sys/module/vhost_test/parameters/newcode
or
	echo 1 > /sys/module/vhost_net/parameters/newcode

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


Michael S. Tsirkin (5):
  vhost: option to fetch descriptors through an independent struct
  vhost/test: add an option to test new code
  vhost: batching fetches
  vhost/net: add an option to test new code
  vhost: last descriptor must have NEXT clear

 drivers/vhost/net.c   |  32 ++++-
 drivers/vhost/test.c  |  19 ++-
 drivers/vhost/vhost.c | 328 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  20 ++-
 4 files changed, 385 insertions(+), 14 deletions(-)

-- 
MST
