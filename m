From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: paravirt_ops queue rebased
Date: Sun, 06 May 2007 10:21:17 -0700
Message-ID: <463E0E8D.3050806@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: Andi Kleen <ak@suse.de>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I just rebased my paravirt_ops patch queue to current git.  Looks like
almost all the pre-req patches are now in, which is nice.

The only missing thing from your patches was you sched_clock patches and
the sched_clock paravirt-op.  Are there still problems with either your
sched_clock patch or the paravirt patch?  Should I resubmit the
paravirt-sched_clock patch based on git?

The only other general patches before the Xen series I have left in my
queue are:

    i386-common-smp.patch
    i386-fix-voyager-build.patch
    vsyscall-note-use-elfnote_h.patch

I obviously don't depend the voyager patch, but I tweaked it a bit to
apply to the current git tree.

How is your patch queue looking now?  Is there much left?

    J
