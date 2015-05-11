From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: locking/pvqspinlock, x86: undefined CONFIG_QUEUED_SPINLOCKS
Date: Mon, 11 May 2015 09:42:51 +0200
Message-ID: <CAD3Xx4KZUmZCADtrw6bUxdxxgXwFyDoURr6eWu0M4AnrKG+Xsg__32206.0351180427$1431358021$gmane$org@mail.gmail.com>
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
To: peterz@infradead.org
Cc: Paul Bolle <pebolle@tiscali.nl>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andreas Ruprecht <andreas.ruprecht@fau.de>, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, hengelein Stefan <stefan.hengelein@fau.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi Peter,

your commit f233f7f1581e ("locking/pvqspinlock, x86: Implement the
paravirt qspinlock call patching") is in today's linux-next tree
(i.e., next-20150511).  The two #ifdef blocks listed below cannot be
compiled at the current state since CONFIG_QUEUED_SPINLOCKS does not
exist:

+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUED_SPINLOCKS)
[...]
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && defined(CONFIG_QUEUED_SPINLOCKS)

It seems that it's just a typo, since QUEUED_SPINLOCK (i.e., without
last S) is defined in kernel/Kconfig.locks.

I detected this issue with scripts/checkkconfigsymbols.py by diffing
today's and the previous next tree.

Kind regards,
 Valentin
