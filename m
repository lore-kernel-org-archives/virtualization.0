From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: hv block drivers
Date: Mon, 30 Aug 2010 21:18:59 +0200
Message-ID: <201008302119.00069.arnd@arndb.de>
References: <201008301643.42253.arnd@arndb.de> <8AFC7968D54FB448A30D8F38F259C56224274727@TK5EX14MBXC118.redmond.corp.microsoft.com> <4C7BEBE7.8060502@goop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C7BEBE7.8060502@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Hank Janssen <hjanssen@microsoft.com>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 30 August 2010 19:35:35 Jeremy Fitzhardinge wrote:
>  On 08/30/2010 10:31 AM, Hank Janssen wrote:
> > For a more general question, When/if we make it out of staging, where should these drivers live?
> >
> >       drivers/hyper-v or drivers/scsi and drivers/ide.
> >
> > Is there a standard that is being followed?
> 
> If they're not actually scsi/ide subsystem drivers, then drivers/block
> would seem like the best place (and drivers/ide is truly ancient stuff,
> I think).

Agreed, although I was suggesting to make them SCSI drivers, so they
would go to drivers/scsi/ or a subdirectory of it in that case.

	Arnd
