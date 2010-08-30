From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: hv block drivers
Date: Mon, 30 Aug 2010 19:08:51 +0200
Message-ID: <201008301908.51521.arnd@arndb.de>
References: <201008301643.42253.arnd@arndb.de> <4C7BD9A6.1090108@goop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C7BD9A6.1090108@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Hank Janssen <hjanssen@microsoft.com>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 30 August 2010, Jeremy Fitzhardinge wrote:
> Have you investigated making virtio a scsi device?

I doubt that there is much value in changing it now, and it's not something
I'd be interested in working on.

For the HyperV drivers, it probably makes sense because half of it is
trying to look like SCSI anyway, while the other half is trying to look
like ATA. For the ATA driver, the obvious choice would be to make it
a libata backend, though my impression from a brief look at the driver
was that it's better to copy some of the libata code and integrate it
into the hv SCSI driver.

	Arnd
