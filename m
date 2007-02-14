From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/21] Xen-paravirt: Add code into head.S to
 handle being booted by Xen
Date: Wed, 14 Feb 2007 12:42:45 -0800
Message-ID: <45D37445.50306@goop.org>
References: <20070213221729.772002682@goop.org>	<20070213221830.707197267@goop.org>
	<m1sld8pjhy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m1sld8pjhy.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>
> There need to be alignment directives for the page aligned chunks.
>   

OK.

> Placing the page aligned chunks in a special section is nice in that
> it ensures the linker packs everything tightly but should be
> completely unnecessary if the alignment is correct.
>   
Yes, I made the extra section to get better packing.

    J
