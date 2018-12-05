From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/2] virtio-net: interrupt related improvements
Date: Wed, 5 Dec 2018 17:54:09 -0500
Message-ID: <20181205225323.12555-1-mst__13142.5245934681$1544050333$gmane$org@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Now that we have brought the virtio overhead way down with a fast packed
ring implementation, we seem to be actually observing TCP drops
indicative of bufferbloat. So let's try to enable TSQ.  Note: it isn't
clear that the default pacing is great for the virt usecase. It's worth
trying to play with sk_pacing_shift_update to see what happens.

For this reason, and for a more important one that I didn't
have time to test it yet, sending as an RFC.

Michael S. Tsirkin (2):
  virtio-net: bql support
  virtio_net: bulk free tx skbs

 drivers/net/virtio_net.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
MST
