From: Asias He <asias@redhat.com>
Subject: [PATCH v6 0/3] tcm_vhost hotplug
Date: Sat, 13 Apr 2013 11:20:23 +0800
Message-ID: <1365823226-27242-1-git-send-email-asias@redhat.com>
References: <1365808250.26011.68.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365808250.26011.68.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Rebase + small argument pass change

Asias He (3):
  tcm_vhost: Introduce tcm_vhost_check_feature()
  tcm_vhost: Add helper to check if endpoint is setup
  tcm_vhost: Add hotplug/hotunplug support

 drivers/vhost/tcm_vhost.c | 237 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/tcm_vhost.h |  10 ++
 2 files changed, 243 insertions(+), 4 deletions(-)

-- 
1.8.1.4
