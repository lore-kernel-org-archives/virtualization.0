From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for mergeable
	buffer
Date: Thu,  1 Mar 2018 11:19:03 +0800
Message-ID: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
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
To: mst@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.fastabend@gmail.com, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This series tries to re-enable XDP_REDIRECT for mergeable buffer which
was removed since commit 7324f5399b06 ("virtio_net: disable
XDP_REDIRECT in receive_mergeable() case"). Main concerns are:

- not enough tailroom was reserved which breaks cpumap
- complex logic like EWMA and linearizing during XDP processing

Fix those by:

- reserve enough tailroom during refill
- disable EWMA and use fixed size of rx buffer
- drop linearizing logic and offload it to generic XDP routine, this
  could happen only when the buffer were refilled before XDP set, so
  we could simply ignore the negative performance impact.

Please review.

Thanks

Jason Wang (2):
  virtio-net: re enable XDP_REDIRECT for mergeable buffer
  virtio-net: simplify XDP handling in small buffer

 drivers/net/virtio_net.c | 186 ++++++++++++++++++-----------------------------
 1 file changed, 70 insertions(+), 116 deletions(-)

-- 
2.7.4
