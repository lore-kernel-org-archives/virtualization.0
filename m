From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 0/2] virtio-balloon: tweak config_changed
Date: Thu,  3 Jan 2019 13:31:00 +0800
Message-ID: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
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
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pasic@linux.ibm.com, dgilbert@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Since virtio-ccw doesn't work with accessing to the config registers
inside an interrupt context, this patch series avoids that issue by
moving the config register accesses to the related workqueue contexts.

Wei Wang (2):
  virtio-balloon: tweak config_changed implementation
  virtio-balloon: improve update_balloon_size_func

 drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

-- 
2.7.4
