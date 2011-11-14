From: Sasha Levin <levinsasha928@gmail.com>
Subject: [RFC 3/5] iomap: Don't ignore offset
Date: Tue, 15 Nov 2011 01:43:15 +0200
Message-ID: <1321314197-5265-4-git-send-email-levinsasha928@gmail.com>
References: <20111114181854.GA24953@redhat.com>
	<1321314197-5265-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321314197-5265-1-git-send-email-levinsasha928@gmail.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, penberg@kernel.org, Sasha Levin <levinsasha928@gmail.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Offset was ignored for start calulcations, making all mappings start at
offset 0 always.

Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 lib/iomap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/iomap.c b/lib/iomap.c
index f28720e..93ae915 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -272,6 +272,7 @@ void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 	if (len <= offset || !start)
 		return NULL;
         len -= offset;
+	start += offset;
         if (len < minlen)
 		return NULL;
 	if (maxlen && len > maxlen)
-- 
1.7.8.rc1
