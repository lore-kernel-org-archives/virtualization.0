From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: hv block drivers
Date: Mon, 30 Aug 2010 10:35:35 -0700
Message-ID: <4C7BEBE7.8060502@goop.org>
References: <201008301643.42253.arnd@arndb.de> <4C7BD9A6.1090108@goop.org> <201008301908.51521.arnd@arndb.de> <8AFC7968D54FB448A30D8F38F259C56224274727@TK5EX14MBXC118.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56224274727@TK5EX14MBXC118.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

 On 08/30/2010 10:31 AM, Hank Janssen wrote:
> For a more general question, When/if we make it out of staging, where should these drivers live?
>
> 	drivers/hyper-v or drivers/scsi and drivers/ide.
>
> Is there a standard that is being followed?

If they're not actually scsi/ide subsystem drivers, then drivers/block
would seem like the best place (and drivers/ide is truly ancient stuff,
I think).

    J
