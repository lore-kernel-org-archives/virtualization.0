From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 07/21] Xen-paravirt: remove ctor for pgd
	cache
Date: Thu, 15 Feb 2007 22:04:08 -0800
Message-ID: <45D54958.40405@vmware.com>
References: <20070216022449.739760547@goop.org>
	<20070216022531.047039320@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070216022531.047039320@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Remove the ctor for the pgd cache.  There's no point in having the
> cache machinery do this via an indirect call when all pgd are freed in
> the one place anyway.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>   

Acked-by: Zachary Amsden <zach@vmware.com>

This does introduce a bug for us, but that is trivially fixed, and I 
would like to inspect final merged code to make sure bugfix is proper.

Zach
