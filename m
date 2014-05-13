From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v1] vhost: avoid large order allocations
Date: Tue, 13 May 2014 10:35:32 +0200
Message-ID: <1399970133-46783-1-git-send-email-mimu__44789.026809349$1400095226$gmane$org@linux.vnet.ibm.com>
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
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: borntraeger@de.ibm.com, mimu@linux.vnet.ibm.com, ddongch@cn.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

A test case which generates memory pressure while performing guest administration
fails with vhost triggering "page allocation failure" and guest not starting up.

After some analysis we discovered the allocation order of vhost to be rensponsible
for this behaviour. Thus we suggest patch 1/1 which dynamically allocates the
required memory. Please see its description for details.

Thanks,
Michael 

Dong Dong Chen (1):
  vhost: avoid large order allocations

 drivers/vhost/net.c   | 4 ++--
 drivers/vhost/scsi.c  | 4 ++--
 drivers/vhost/test.c  | 2 +-
 drivers/vhost/vhost.c | 6 +++++-
 drivers/vhost/vhost.h | 2 +-
 5 files changed, 11 insertions(+), 7 deletions(-)

-- 
1.8.3.1
