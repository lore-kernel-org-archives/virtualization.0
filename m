From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: A proposal - binary
Date: Sat, 05 Aug 2006 12:50:18 +0100
Message-ID: <1154778619.10971.18.camel@localhost.localdomain>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	<44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	<20060804183448.GE11244@sequoia.sous-sol.org>
	<44D3B0F0.2010409@vmware.com>
	<1154726800.23655.273.camel@localhost.localdomain>
	<1154740485.3683.161.camel@mulgrave.il.steeleye.com>
	<44D42E7D.70101@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <44D42E7D.70101@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Christoph Hellwig <hch@infradead.org>, Jack Lo <jlo@vmware.com>, Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org

Ar Gwe, 2006-08-04 am 22:37 -0700, ysgrifennodd Zachary Amsden:
> mentioned earlier.  Is it a license violation for a GPL app to link 
> against a non-GPL library?  Surely, the other way around is a problem, 


Actually the FSF always anticipated that case because its the same as
the GPL app on non-free OS case and the GPL there says

"However, as a special exception, the source code distributed need not
include anything that is normally distributed (in either source or
binary form) with the major components (compiler, kernel, and so on) of
the operating system on which the executable runs, unless that component
itself accompanies the executable."

> interface, which gives it shape.  So I prefer binary redirection 
> interface, or vDSO, or anything without the disparaged word "blob" in it.

Well if you are going to provide the source then its not really a binary
interface, its a jump table.
