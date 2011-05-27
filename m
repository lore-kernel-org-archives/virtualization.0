From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] arch/tile: more /proc and /sys file support
Date: Fri, 27 May 2011 16:23:15 +0200
Message-ID: <201105271623.15735.arnd__18168.0853981108$1306506265$gmane$org@arndb.de>
References: <201105181807.p4II7C5g015224@farm-0002.internal.tilera.com>
	<201105252220.23948.arnd@arndb.de>
	<201105261648.p4QGmNKf001636@farm-0023.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201105261648.p4QGmNKf001636@farm-0023.internal.tilera.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 26 May 2011, Chris Metcalf wrote:
> This change introduces a few of the less controversial /proc and
> /proc/sys interfaces for tile, along with sysfs attributes for
> various things that were originally proposed as /proc/tile files.
> It also adjusts the "hardwall" proc API.

Looks good to me now, except

> Finally, after some feedback from Arnd Berghamm for the previous

typo					^^^^

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
