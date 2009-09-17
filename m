From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 0/2] mm: use_mm/unuse_mm
Date: Thu, 17 Sep 2009 10:20:57 +0300
Message-ID: <20090917072056.GA18115__29550.2499830492$1253172230$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, linux-mm@kvack.org, akpm@linux-founda
List-Id: virtualization@lists.linuxfoundation.org

This moves use_mm/unuse_mm from aio into mm, and optimizes atomic usage
there. Original patchset also exported use_mm/unuse_mm to modules, for
use by vhost, that bit will come in later when vhost is posted for
inclusion.

Michael S. Tsirkin (2):
  mm: move use_mm/unuse_mm from aio.c to mm/
  mm: reduce atomic use on use_mm fast path

 fs/aio.c                    |   47 +----------------------------------
 include/linux/mmu_context.h |    9 ++++++
 mm/Makefile                 |    2 +-
 mm/mmu_context.c            |   58 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/mmu_context.h
 create mode 100644 mm/mmu_context.c
