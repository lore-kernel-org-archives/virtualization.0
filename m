From: Arnd Bergmann <arnd@arndb.de>
Subject: hv block drivers
Date: Mon, 30 Aug 2010 16:43:42 +0200
Message-ID: <201008301643.42253.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: linux-kernel@vger.kernel.org, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Hank,

I wanted to follow up on the block device driver discussion we had at
LinuxCon, based on some other input I got.

What most people recommended was to make both the hv scsi and the
hv ata code scsi device drivers, *not* make them standalone block
drivers as I originally recommended.

The main reason for this is consistent naming of the devices. We
have a lot of user code that can deal with /dev/sd* devices, but
introducing the /dev/vd* devices for virtio caused a lot of pain
that you probably shouldn't have to go through.

I'm not sure whether the two should be one or two drivers. My
feeling here is that it might be nice to have a single scsi
host driver for both that has two modes of driving the device,
one sending the SCSI commands down the virtual bus, the other
one interpreting the SCSI commands in the same way that libata
does.

	Arnd
