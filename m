From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 5/7] Change lguest launcher to use asm generic include
Date: Sat, 11 Aug 2007 13:11:33 +1000
Message-ID: <1186801893.30899.49.camel__16070.1107037768$1186802115$gmane$org@localhost.localdomain>
References: <20070809003211.373543702@goodmis.org>
	<20070809003343.829371800@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070809003343.829371800@goodmis.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-08-08 at 20:32 -0400, Steven Rostedt wrote:
> plain text document attachment
> (0005-Change-lguest-launcher-to-use-asm-generic-include-instead-of-explicitly.txt)
> Have the lguest launcher include e820.h via asm/e820.h instead of explicitly
> saying i386.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Applied, thanks,

Rusty.
