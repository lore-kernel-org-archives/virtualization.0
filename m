From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] More lguest massage.
Date: Thu, 17 Jan 2008 22:35:50 -0200
Message-ID: <12006165841070-git-send-email-gcosta__35835.0200964653$1200616914$gmane$org@redhat.com>
References: <1200616550283-git-send-email-gcosta@redhat.com>
	<12006165571406-git-send-email-gcosta@redhat.com>
	<1200616561270-git-send-email-gcosta@redhat.com>
	<12006165651341-git-send-email-gcosta@redhat.com>
	<12006165701019-git-send-email-gcosta@redhat.com>
	<12006165743557-git-send-email-gcosta@redhat.com>
	<12006165781954-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12006165781954-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

urrently, lguest module can't be compiled without the PARAVIRT flag being
on.This is a fake dependency, since the module itself shouldn't need any
paravirtoverride. Reason for that is the reference to pv_info structure
ininitial loading tests.

his patch removes it in favour of a more generic error message.

Signed-off-by:Glauber de Oliveira Costa <gcosta@redhat.com>
---
drivers/lguest/core.c |    2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff--git a/drivers/lguest/core.c b/drivers/lguest/core.c
indexbb42fd0..97b76d6 100644
---a/drivers/lguest/core.c
+++b/drivers/lguest/core.c
@@-255,7 +255,7 @@ static int __init init(void)

	/* Lguest can't run under Xen, VMI or itself.  It does Tricky Stuff. */
	if (paravirt_enabled()) {
-		printk("lguestis afraid of %s\n", pv_info.name);
+		printk("lguestcan't run under another hypervisor");
		return -EPERM;
	}

--
1.5.0.6
