From: Andi Kleen <ak@suse.de>
Subject: Re: A set of "standard" virtual devices?
Date: Mon, 2 Apr 2007 23:12:39 +0200
Message-ID: <200704022312.39195.ak@suse.de>
References: <4611652F.700@zytor.com> <46116E12.5070206@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965888AbXDBVM7@vger.kernel.org>
In-Reply-To: <46116E12.5070206@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org


> How would that work in the case where virtualized guests don't have a
> visible PCI bus, and the virtual environment doesn't pretend to emulate
> a PCI bus?

If they emulated one with the appropiate device 
then distribution driver auto probing would just work transparently for them.

-Andi
