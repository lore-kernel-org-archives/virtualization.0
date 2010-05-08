From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: Patch to auto-load MSFT PV NIC driver
Date: Sat, 8 May 2010 13:52:01 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5621AFFB3F9@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <4BE453510200003000084906@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <4BE453510200003000084906@sinclair.provo.novell.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Ky Srinivasan <ksrinivasan@novell.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Virtualization@lists.osdl.org" <Virtualization@lists.osdl.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



>From: Ky Srinivasan [ksrinivasan@novell.com]  -  Friday, May 07, 2010 4:52 PM
>
> I am attaching a patch to auto-load hv_netvsc.

I am not sure if this is the right approach. hv_netvsc takes a dependency on hv_vmbus.
hv_vmbus does have the same DMI detection logic in it. But unless hv_vmbus has loaded
up competely, hv_netvsc will fail on loadup. And I do not think we can guarantee that
hv_vmbus has loaded yet.

It would be better to have netvsc check to make sure hv_vmbus is loaded.

Thanks,

Hank.
