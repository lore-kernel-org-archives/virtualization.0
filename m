From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2 0/2] virtio-balloon: tweak config_changed
Date: Fri,  4 Jan 2019 15:11:51 +0800
Message-ID: <1546585913-34804-1-git-send-email-wei.w.wang__49220.1883499094$1546587894$gmane$org@intel.com>
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
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Since virtio-ccw doesn't work with accessing to the config space
inside an interrupt context, this patch series avoids that issue by
moving the config register accesses to the related workqueue contexts.

v1->v2 ChangeLog:
    - add config_read_bitmap to indicate to the workqueue callbacks about
      the necessity of reading the related config fields.

Wei Wang (2):
  virtio-balloon: tweak config_changed implementation
  virtio-balloon: improve update_balloon_size_func

 drivers/virtio/virtio_balloon.c | 86 +++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 29 deletions(-)

-- 
2.7.4
