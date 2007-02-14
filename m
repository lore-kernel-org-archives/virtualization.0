From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 10/21] Xen-paravirt: Name: dont export
 paravirt_ops structure, do individual functions
Date: Tue, 13 Feb 2007 17:44:13 -0800
Message-ID: <45D2696D.9030706@goop.org>
References: <20070213221729.772002682@goop.org>
	<20070213221830.238235953@goop.org>
	<45D260A2.4010200@vmware.com> <45D262DC.2020008@goop.org>
	<45D2635D.9070205@vmware.com> <45D267E8.7090506@goop.org>
	<45D2692D.1070505@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D2692D.1070505@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> No, it needs to be part of the general patch list first, which is
> still hand listed rather than just any op being patchable.  Then it
> can be up to the backend. 

Ah, right, yes.  We need to add all (most? some?) of the pte operations
to that list too.

    J
