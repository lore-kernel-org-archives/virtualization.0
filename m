From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 0/8] staging: hv: clean up forward declarations and camel
	cases in netvsc.c
Date: Thu, 21 Apr 2011 12:30:39 -0700
Message-ID: <1303414247-22118-1-git-send-email-haiyangz__3581.5165531405$1303413585$gmane$org@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
Cc: haiyangz <haiyangz@hz-dev.msft.interop.novell.com>
List-Id: virtualization@lists.linuxfoundation.org

From: haiyangz <haiyangz@hz-dev.msft.interop.novell.com>

This patch series cleans up forward declarations and the
remaining camel cases in netvsc.c

Haiyang Zhang (8):
  staging: hv: move netvsc_initialize() to clean up forward declaration
  staging: hv: move netvsc_receive_completion() to clean up forward
    declaration
  staging: hv: move netvsc_send_recv_completion() to clean up forward
    declaration
  staging: hv: move netvsc_destroy_recv_buf() to clean up forward
    declaration
  staging: hv: move netvsc_destroy_send_buf() to clean up forward
    declaration
  staging: hv: move netvsc_device_add() to clean up forward declaration
  staging: hv: clean up unused forward declarations
  staging: hv: convert function name NetVscDisconnectFromVsp to lower
    case

 drivers/staging/hv/netvsc.c |  686 +++++++++++++++++++++----------------------
 1 files changed, 328 insertions(+), 358 deletions(-)
