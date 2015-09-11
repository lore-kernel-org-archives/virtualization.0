From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 0/2] virtio-ccw: new status accessor in device
Date: Fri, 11 Sep 2015 15:58:13 +0200
Message-ID: <1441979895-36990-1-git-send-email-cornelia.huck__11130.3086080172$1441979940$gmane$org@de.ibm.com>
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
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

These patches implement the new read status command in qemu and bump
the revision to 2 (as this ccw is currently the only thing new with
that revision).

Patches are on top of v2 of "virtio-1/virtio-ccw related patches".

Pierre Morel (2):
  s390x/virtio-ccw: respond to READ_STATUS command
  s390x/virtio-ccw: set revision 2 as maximum revision number

 hw/s390x/virtio-ccw.c | 20 ++++++++++++++++++++
 hw/s390x/virtio-ccw.h |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.3.8
