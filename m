From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/4] paravirt_ops-64 compile fixes
Date: Mon, 21 Jan 2008 19:48:49 -0200
Message-ID: <1200952133-31581-1-git-send-email-ehabkost__45059.9203155891$1200952576$gmane$org@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This series contain fixes to make the paravirt_ops code compile and boot
on x86_64.

This is a follow-up for the previous series from Glauber.
