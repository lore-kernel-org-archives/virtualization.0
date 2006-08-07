From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 7/8] Add a bootparameter to reserve high
	linear address space.
Date: Mon, 7 Aug 2006 09:12:32 +0000 (UTC)
Message-ID: <19700101001522.GA3999__38153.054615441$1154941952$gmane$org__18398.9265163959$1154941952$gmane$org@ucw.cz>
References: <20060803002510.634721860@xensource.com>
	<20060803002518.595166293@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Date: Thu, 1 Jan 1970 00:15:22 +0000
Content-Disposition: inline
In-Reply-To: <20060803002518.595166293@xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: akpm@osdl.org, Zachary Amsden <zach@vmware.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> Add a bootparameter to reserve high linear address space for hypervisors.
> This is necessary to allow dynamically loaded hypervisor modules, which

Dynamically loaded hypervisor? Do we really want to support that?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
