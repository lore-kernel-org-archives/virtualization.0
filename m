From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 0/2] virtio-balloon spec: silent deflation
Date: Tue, 28 May 2013 19:40:16 +0200
Message-ID: <1369762818-8787-1-git-send-email-pbonzini@redhat.com>
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
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Here is the series, split in two patches, with small edits and new
commit messages.

Paolo Bonzini (2):
  virtio-balloon spec: rewrite description of
    VIRTIO_BALLOON_F_MUST_TELL_HOST
  virtio-balloon spec: reintroduce "silent deflation" feature

 virtio-spec.lyx | 238 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 233 insertions(+), 5 deletions(-)

-- 
1.8.2.1
