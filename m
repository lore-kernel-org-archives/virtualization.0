From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: hv block drivers
Date: Mon, 30 Aug 2010 09:17:42 -0700
Message-ID: <4C7BD9A6.1090108@goop.org>
References: <201008301643.42253.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201008301643.42253.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hank Janssen <hjanssen@microsoft.com>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

 On 08/30/2010 07:43 AM, Arnd Bergmann wrote:
> Hi Hank,
>
> I wanted to follow up on the block device driver discussion we had at
> LinuxCon, based on some other input I got.
>
> What most people recommended was to make both the hv scsi and the
> hv ata code scsi device drivers, *not* make them standalone block
> drivers as I originally recommended.
>
> The main reason for this is consistent naming of the devices. We
> have a lot of user code that can deal with /dev/sd* devices, but
> introducing the /dev/vd* devices for virtio caused a lot of pain
> that you probably shouldn't have to go through.

We're having the same kind of problem with the Xen xvdX device naming. 
For a fully PV system it doesn't matter to much, but when you've got PV
drivers taking the place of a regular emulated hardware device it would
be nice to have a similar device name.

But there isn't a lot of similarity between the Xen block interface and
SCSI beyond the basic block transfer bits, so I was wondering how good a
match it would really be.

Have you investigated making virtio a scsi device?

    J
