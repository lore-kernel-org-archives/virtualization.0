From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/21] Xen-paravirt: Add code into head.S to
 handle being booted by Xen
Date: Wed, 14 Feb 2007 17:52:06 -0800
Message-ID: <45D3BCC6.9020807@goop.org>
References: <20070213221729.772002682@goop.org>	<20070213221830.707197267@goop.org>
	<20070213235424.GA1908@muc.de>	<45D35ABE.1050504@goop.org>
	<m1zm7gpkjh.fsf@ebiederm.dsl.xmission.com>	<45D3740A.4080600@goop.org>
	<m17iukphxr.fsf@ebiederm.dsl.xmission.com>	<45D3A5A4.7080804@goop.org>
	<m1ire4nqqy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m1ire4nqqy.fsf@ebiederm.dsl.xmission.com>
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
> Reasonable and it's probably worth letting the binutils developer know.
> I do agree that it is weird.   It might be that something in binutils
> doesn't like us dropping some of the notes.
>   

What do you mean by "dropping some of the notes"?  I think the only
notes (at least in this case) are the Xen ones, and they're all included.

    J
