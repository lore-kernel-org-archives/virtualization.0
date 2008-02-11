From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 0/5] Make vsmp a paravirt client
Date: Mon, 11 Feb 2008 17:09:42 -0200
Message-ID: <1202756982-18244-1-git-send-email-gcosta__17872.8979699828$1202768872$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, shai@scalemp.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This series of five patches turns the vsmp architecture support in
x86_64 into a paravirt client. If PARAVIRT is on, the probe
function vsmp_init() is run unconditionally, patching the necessary
irq functions accordingly if running ontop of such box.
