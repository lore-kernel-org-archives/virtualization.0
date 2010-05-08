From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Patch to auto-load MSFT PV NIC driver
Date: Sat, 08 May 2010 16:02:17 -0700
Message-ID: <4BE5ED79.9080008@goop.org>
References: <4BE453510200003000084906@sinclair.provo.novell.com>	<8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100508142716.GA32133@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20100508142716.GA32133@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>, Ky Srinivasan <ksrinivasan@novell.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/08/2010 07:27 AM, Greg KH wrote:
> How would you do that?  The symbol resolution will not allow hv_netvsc
> to be loaded without hv_vmbus being around.
>
> Now I do think that just adding the same pci/dmi ids to all of the
> modules is a bit odd, and that something else needs to be done here, but
> at the moment, I can't think of anything better.
>   

Could you make hv_vmbus a real bus implementation, which knows how to
enumerate and probe devices hanging off it?

    J
