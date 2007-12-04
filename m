From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/10] Integrate msr.h
Date: Tue,  4 Dec 2007 09:09:54 -0200
Message-ID: <11967666042130-git-send-email-gcosta__12455.7526586161$1196776581$gmane$org@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Hello,

This series of patches integrates msr.h header.
What it really does, is a series of steps to allow us
to get rid of duplicate code between i386 and x86_64 versions

With this done, achieving paravirt for x86_64 gets really easy,
just a couple of extra code.

The first patch was already sent a while ago, but was not yet pushed
to any tree , to my knowledge. So it is sent again. Also, 
patches 9 and 10 relies on b02f15537b3bf43e347214cf14bad80aeaef1caf,
already in the x86 tree.

Other than that, it should apply fine ontop of linus today git.

Comments are welcome
