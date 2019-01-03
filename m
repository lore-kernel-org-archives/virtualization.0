From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 0/2] virtio: virtio_config_ops documentation
Date: Thu,  3 Jan 2019 17:08:02 +0100
Message-ID: <20190103160804.21438-1-cohuck__46735.8872331262$1546531570$gmane$org@redhat.com>
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
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

After the latest virtio-balloon changes, it became clear that
it is not obvious that some of the virtio operations (e.g.
reading or writing the config space) cannot be done from an
atomic context for all transports.

At least try to document that, and also fix some inconsistencies
I noticed along the way.

Cornelia Huck (2):
  virtio: fix virtio_config_ops description
  virtio: document virtio_config_ops restrictions

 include/linux/virtio_config.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.17.2
