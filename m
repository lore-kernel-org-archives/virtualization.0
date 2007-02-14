From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/21] Xen-paravirt: Add code into head.S to
 handle being booted by Xen
Date: Wed, 14 Feb 2007 12:41:46 -0800
Message-ID: <45D3740A.4080600@goop.org>
References: <20070213221729.772002682@goop.org>	<20070213221830.707197267@goop.org>
	<20070213235424.GA1908@muc.de>	<45D35ABE.1050504@goop.org>
	<m1zm7gpkjh.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <m1zm7gpkjh.fsf@ebiederm.dsl.xmission.com>
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
> Well I did a little by hand parsing and the not I parsed looked ok.
>
> How does the output differ from a what you get when xen-head.S is
> included?
>   
Ah!

The .notes section gets SHT_NOTE in vmlinux when xen-head.S is included;
PROGBITS when linked.  I tried putting @note on the .section in
linux/elfnote.h, but that didn't seem to help (xen-note.o got a SHT_NOTE
entry, but it didn't make it into vmlinux).  I couldn't see any way of
forcing the section type in vmlinux.lds; my experiments all ended with
ld dumping core.

    J
