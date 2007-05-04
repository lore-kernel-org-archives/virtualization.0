From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RELEASE] linux-2.6.21 backport: 269 version
Date: Sat, 05 May 2007 00:09:05 +1000
Message-ID: <1178287745.23670.80.camel__3431.41525886512$1178287818$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Thanks to everyone who sent bug reports.  I've backported all the fixes
and tweaks.

Changes since last 2.6.21 release (254):

1) Method for building launcher with out-of-tree build (patch from Tony Breeds)
2) SIOCBRADDIF definition for older libc headers (report by Wang Cong)
3) Warning suppression for put_user/get_user (Wang Cong report again)
4) Numerous typo fixes (Jeremy Fitzhardinge's eyes)
5) Rework of networking documentation (Glauber de Oliveira Costa's whining)
6) Block documentation includes new love scene.

Heroic hacking!
Rusty Russell <rusty@rustcorp.com.au>
