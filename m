From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: linux-next: Tree for June 18 (XEN build error)
Date: Wed, 18 Jun 2008 22:08:08 -0700
Message-ID: <4859E9B8.9040406@goop.org>
References: <20080618175753.2a519b71.sfr@canb.auug.org.au> <20080618124331.04e27900.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080618124331.04e27900.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, jeremy@xensource.com, chrisw@sous-sol.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> linux-next-20080618/drivers/xen/manage.c: In function 'xen_suspend':
> linux-next-20080618/drivers/xen/manage.c:66: error: too few arguments to function 'device_power_up'
> linux-next-20080618/drivers/xen/manage.c: In function 'do_suspend':
> linux-next-20080618/drivers/xen/manage.c:115: error: too few arguments to function 'device_resume'
> make[3]: *** [drivers/xen/manage.o] Error 1
>   

What argument(s) do device_power_up() and device_resume() want now?

    J
