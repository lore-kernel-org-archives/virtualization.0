From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/7] Modify lguest32 to make room for lguest64
Date: Wed, 08 Aug 2007 20:32:11 -0400
Message-ID: <20070809003211.373543702__1050.82638697258$1186619749$gmane$org@goodmis.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

I've been working on lguest64 and in order to do this, I had to move
a lot of the i386 specific out of the way.  Well, the lguest64 port
is still not ready to display, but before Rusty makes too many changes
I would like this in upstream so I don't have to keep repeating my
changes :-)


So this patch series moves lguest32 out of the way for other archs.

-- Steve
