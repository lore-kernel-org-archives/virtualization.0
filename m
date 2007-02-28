From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 06/26] Xen-paravirt_ops: paravirt_ops:
 allocate a fixmap slot
Date: Wed, 28 Feb 2007 12:09:39 -0800
Message-ID: <45E5E183.6050809@goop.org>
References: <20070227081337.434798469@goop.org>
	<20070227081631.122933982@goop.org>
	<20070227101143.GC10827@elte.hu> <45E47E95.2060803@goop.org>
	<45E4D1B1.7030903@goop.org> <20070228083055.GA8866@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070228083055.GA8866@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> fair enough. Please rename it to FIX_PARAVIRT_BOOTUP - you can still 
> rely on it being available later on too, but we'd like to give everyone 
> the right fundamental idea about this: it's meant to be a limited, 
> inflexible interface for bootstrap only.
>   

Will do.

    J
