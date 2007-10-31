From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/7] (Re-)introducing pvops for x86_64 - Real pvops work part
Date: Wed, 31 Oct 2007 16:14:45 -0300
Message-ID: <1193858101367-git-send-email-gcosta__18535.7443326668$1193869050$gmane$org@redhat.com>
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
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


Hey folks,

This is the part-of-pvops-implementation-that-is-not-exactly-a-merge. Neat,
uh? This is the majority of the work.

The first patch in the series does not really belong here. It was already
sent to lkml separetedly before, but I'm including it again, for a very
simple reason: Try to test the paravirt patches without it, and you'll fail
miserably ;-) (and it was not yet included).

Other than that, I thank you all in advance for the review.

Have fun!
