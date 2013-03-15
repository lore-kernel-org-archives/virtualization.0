From: Asias He <asias@redhat.com>
Subject: [PATCH 0/2] Fix booting tcm_vhost + seabios
Date: Fri, 15 Mar 2013 09:45:14 +0800
Message-ID: <1363311916-23121-1-git-send-email-asias@redhat.com>
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
To: seabios@seabios.org
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Kevin O'Connor <kevin@koconnor.net>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Asias He (2):
  virtio-scsi: Set _DRIVER_OK flag before scsi target scanning
  virtio-scsi: Pack struct virtio_scsi_{req_cmd,resp_cmd}

 src/virtio-scsi.c | 5 +++--
 src/virtio-scsi.h | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.8.1.4
