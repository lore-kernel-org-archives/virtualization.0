From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 0/8] do not export kernel integer types to userspace
Date: Mon, 01 Apr 2013 19:55:43 +0200
Message-ID: <1364838943.21627.60.camel__21210.2906815291$1364838990$gmane$org@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, Krishna Kumar <krkumar2@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, Chris Mason <chris.mason@fusionio.com>, Trond Myklebust <Trond.Myklebust@netapp.com>, Amit Shah <amit.shah@redhat.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cris-kernel@axis.com, linux-btrfs@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This short series was triggered by a compile error I ran into when trying to
build the lguest tool (see PATCH 1/8). After fixing that error I decided to attempt to
solve all related problems.

Paul Bolle (8):
  virtio_net: do not export "u16" to userspace
  headers_check: add check for kernel integer types
  virtio: do not export "u16" and "u64" to userspace
  headers_check: check kernel types inside #define
  btrfs: do not export "u64" to userspace
  nfsd4: do not export "u64" to userspace
  virtio: do not export "u32" to userspace
  cris: do not export "u8" and friends to userspace

 arch/cris/include/uapi/arch-v10/arch/sv_addr_ag.h | 20 ++++++++++----------
 include/uapi/linux/btrfs.h                        |  2 +-
 include/uapi/linux/nfs4.h                         |  2 +-
 include/uapi/linux/virtio_balloon.h               |  4 ++--
 include/uapi/linux/virtio_console.h               |  2 +-
 include/uapi/linux/virtio_net.h                   |  2 +-
 scripts/headers_check.pl                          | 21 +++++++++++++++++++++
 7 files changed, 37 insertions(+), 16 deletions(-)

-- 
1.7.11.7
