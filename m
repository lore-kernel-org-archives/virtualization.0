From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 0/25 -v2] paravirt_ops for x86_64, second round
Date: Fri, 10 Aug 2007 16:12:12 -0300
Message-ID: <1186773157329-git-send-email-gcosta__27891.0046829425$1186783416$gmane$org@redhat.com>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Here is an slightly updated version of the paravirt_ops patch.
If your comments and criticism were welcome before, now it's even more!

There are some issues that are _not_ addressed in this revision, and here
are the causes:

* split debugreg into multiple functions, suggested by Andi:
  - Me and jsfg agree that introducing more pvops (specially 14!) is
    not worthwhile. So, although we do can keep one pvops function and turn
    the set/get debugreg macros into multiple ones, this is a general kernel
    issue, and can be addressed by a later patch.

* 2MB pages, and other functions that lives in pgalloc.h in the i386 version
  - As xen is the main user of it (i.e., lguest does not), we'd prefer to
    see an implementation of it from xen folks, or any other that understand
    it better. This way we don't delay the merge process of the
    already-written chunk. On the contrary, it will be easier to get that,
    as it will be smaller

If you addressed some concern before that is _not_ covered in this revision,
so it is my fault. Please fell free to voice it

Have fun!
