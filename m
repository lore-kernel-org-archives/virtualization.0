From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a
	PT_NOTE segment in vmlinux
Date: Tue, 22 Aug 2006 16:48:58 +0200
Message-ID: <200608221648.58080.ak@suse.de>
References: <1156256777.5091.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1156256777.5091.93.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ian Campbell <Ian.Campbell@xensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 22 August 2006 16:26, Ian Campbell wrote:
> This patch updates x86_64 linker script to pack any .note.* sections
> into a PT_NOTE segment in the output file.

Thanks added.

-Andi

P.S.: 2-3 paragraphs description would have been enough, but that is fine
too.
