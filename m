From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/2] virtio-scsi spec: event improvements
Date: Mon, 16 Jul 2012 16:24:35 +0200
Message-ID: <1342448677-7453-1-git-send-email-pbonzini@redhat.com>
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
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, rusty@rustcorp.com.au
Cc: qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

This makes some changes to the virtio-scsi event specification, so that
it is now possible to use virtio-scsi events in the implementation of
the QEMU "block_resize" command.

Thanks to Cong Meng for finally implementing virtio-scsi hotplug, which
made me look at block_resize again!

Paolo Bonzini (2):
  virtio-scsi spec: unify event structs
  virtio-scsi spec: add configuration change event

 virtio-spec.lyx |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 160 insertions(+), 4 deletions(-)

-- 
1.7.10.4
