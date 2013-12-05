From: Andrey Vagin <avagin@openvz.org>
Subject: [PATCH 0/2] virtio-net: Fix two bugs on unloading the module
Date: Thu,  5 Dec 2013 18:36:19 +0400
Message-ID: <1386254181-17257-1-git-send-email-avagin__5588.58203371546$1386255815$gmane$org@openvz.org>
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
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Andrey Vagin <avagin@openvz.org>
List-Id: virtualization@lists.linuxfoundation.org

They can be easy to reproduce, if you try to unload virtio-net

Andrey Vagin (2):
  virtio-net: determine type of bufs correctly
  virtio: delete napi objects from netdev before releasing memory

 drivers/net/virtio_net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
-- 
1.8.3.1
