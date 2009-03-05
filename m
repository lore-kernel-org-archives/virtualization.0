From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH v2 03/15] NULL noise: arch/x86/xen/smp.c
Date: Thu, 05 Mar 2009 12:15:29 -0800
Message-ID: <49B032E1.50303@goop.org>
References: <20090305190954.30062.44759.stgit@f10box.hanneseder.net>
	<20090305191350.30062.68789.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20090305191350.30062.68789.stgit@f10box.hanneseder.net>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Hannes Eder <hannes@hanneseder.net>
Cc: xen-devel@lists.xensource.com, trivial@kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hannes Eder wrote:
> Fix this sparse warnings:
>   arch/x86/xen/smp.c:316:52: warning: Using plain integer as NULL pointer
>   arch/x86/xen/smp.c:421:60: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hannes Eder <hannes@hanneseder.net>
>   
Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

    J
