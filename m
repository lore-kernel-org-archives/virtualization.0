From: Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a
	PT_NOTE segment in vmlinux II
Date: Tue, 22 Aug 2006 16:26:48 +0100
Message-ID: <1156260408.5091.101.camel@localhost.localdomain>
References: <1156256777.5091.93.camel@localhost.localdomain>
	<200608221659.18896.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <200608221659.18896.ak@suse.de>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 16:59 +0200, Andi Kleen wrote:
> On Tuesday 22 August 2006 16:26, Ian Campbell wrote:
> > This patch updates x86_64 linker script to pack any .note.* sections
> > into a PT_NOTE segment in the output file.

> Sorry I tried to apply it, but at least 2.6.18rc4 mainline (which my tree
> is based on) doesn't have a NOTES macro so it doesn't link
> 
> I dropped the NOTES addition for now, presumably it will need to be readded
> later.

Sorry, I should have been clearer about the dependency on the i386 patch
which is currently in -mm. 

Ian.
