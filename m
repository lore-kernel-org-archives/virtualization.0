From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/5 -v2] Modify lguest32 to make room for lguest64 (version
	2)
Date: Thu, 09 Aug 2007 00:36:26 -0400
Message-ID: <20070809043626.830486783__35387.6724526801$1186635011$gmane$org@goodmis.org>
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

[
  Changes since last version.
  - Move lg.h to include/asm instead (suggested by Rusty Russel)
  - All steps of the series compiles (suggested by Stephen Rothwell)
  - Better ifdef header naming (suggested by Stephen Rothwell)
  - Added Andi Kleen to CC (forgot to on V1)
]

Hi all,

I've been working on lguest64 and in order to do this, I had to move
a lot of the i386 specific out of the way.  Well, the lguest64 port
is still not ready to display, but before Rusty makes too many changes
I would like this in upstream so I don't have to keep repeating my
changes :-)


So this patch series moves lguest32 out of the way for other archs.

-- Steve

-- 
