From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH -next] xen: fix header export to userspace
Date: Mon, 15 Nov 2010 10:23:48 +0000
Message-ID: <alpine.LSU.2.00.1011151017570.8553@hermes-2.csi.cam.ac.uk>
References: <20101112130547.c2a3c2c1.sfr@canb.auug.org.au> <20101113084439.d21bd0f0.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20101113084439.d21bd0f0.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 13 Nov 2010, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> scripts/headers_install.pl prevents "__user" from being exported
> to userspace headers, so just use compiler.h to make sure that
> __user is defined and avoid the error.
>
> unifdef: linux-next-20101112/xx64/usr/include/xen/privcmd.h.tmp: 79: Premature EOF (#if line 33 depth 1)

I suggest the following slightly more informative message

> scripts/headers_install.pl strips "__user" when exporting headers to
> userspace and can introduce a syntax error (detected by unifdef) if
> "__user" appears in an unexpected place. Simplify by using compiler.h to
> make sure that __user is defined and avoid the error.
>
> unifdef: linux-next-20101112/xx64/usr/include/xen/privcmd.h.tmp: 79: Premature EOF (#if line 33 depth 1)

In any case,

Acked-By:	Tony Finch <dot@dotat.at>

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
HUMBER THAMES DOVER WIGHT PORTLAND: NORTH BACKING WEST OR NORTHWEST, 5 TO 7,
DECREASING 4 OR 5, OCCASIONALLY 6 LATER IN HUMBER AND THAMES. MODERATE OR
ROUGH. RAIN THEN FAIR. GOOD.
