From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/21] Xen-paravirt: Add code into head.S to
 handle being booted by Xen
Date: Wed, 14 Feb 2007 16:13:24 -0800
Message-ID: <45D3A5A4.7080804@goop.org>
References: <20070213221729.772002682@goop.org>	<20070213221830.707197267@goop.org>
	<20070213235424.GA1908@muc.de>	<45D35ABE.1050504@goop.org>
	<m1zm7gpkjh.fsf@ebiederm.dsl.xmission.com>	<45D3740A.4080600@goop.org>
	<m17iukphxr.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m17iukphxr.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Ian Campbell <Ian.Campbell@XenSource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Ok.  If that is all this may be a difference that makes no difference.
> binutils has a bad habit of looking at sections (which are fully
> optional) instead of segments on ET_EXEC and ET_DYN objects.  Only
> ET_REL objects (.o files) are required to have sections.
>   

The Xen domain loader will have to be changed to deal with that, which
isn't too much of a problem.

My main concern is the randomness of it, and whether it will fail in
some more harmful way on other versions of binutils.

> So I recommend for testing write a 100 line program that includes
> elf.h and reads out the note segment.  If all is well we can split
> this code out.
>   

The Xen readnotes utility is essentially that.  I'll hack it.

    J
