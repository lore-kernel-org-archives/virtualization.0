From: Dmitry Fleytman <dmitry@daynix.com>
Subject: [PATCH 0/2 V3] virtio-spec/net: dynamic network offloads configuration
Date: Tue,  2 Apr 2013 14:38:58 +0300
Message-ID: <1364902740-24948-1-git-send-email-dmitry@daynix.com>
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
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Ronen Hod <rhod@redhat.com>, Dmitry Fleytman <dfleytma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Dmitry Fleytman <dfleytma@redhat.com>

V3 changes:
  1. Compat macro added
  2. Feature name beautification

V2 changes:
  1. _GUEST_ added to command and feature names
  2. Live migration logic fixed

Reported-by: Michael S. Tsirkin <mst@redhat.com>

One of recently introduced Windows features (RSC)
requires network driver to be able to enable and disable
HW LRO offload on the fly without device reinitialization.

Current Virtio specification doesn't support this requirement.
The solution proposed by following spec patch is to add
a new control command for this purpose.

The same solution may be used in Linux driver for ethtool interface
implementation.

Patch for QEMU mainline that implements this specification change
attached as well.

-- 
1.8.1.4
