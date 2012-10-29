From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] Some virtio-ccw clarifications.
Date: Mon, 29 Oct 2012 14:02:37 +0100
Message-ID: <1351515758-22295-1-git-send-email-cornelia.huck@de.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

here are some clarifications for virtio-ccw: feature bit endianess
and how setting the indicator location works (with the channel
data address only being 32 bit wide).

Cornelia Huck (1):
  virtio-ccw: Clarifications.

 virtio-spec.lyx |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.5.4
