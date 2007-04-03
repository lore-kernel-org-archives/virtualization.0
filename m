From: Christian Borntraeger <borntrae@de.ibm.com>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 10:29:06 +0200
Message-ID: <200704031029.06819.borntrae@de.ibm.com>
References: <4611652F.700@zytor.com> <46116E12.5070206@goop.org> <200704022312.39195.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933012AbXDCI3M@vger.kernel.org>
In-Reply-To: <200704022312.39195.ak@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Monday 02 April 2007 23:12, Andi Kleen wrote:
> 
> > How would that work in the case where virtualized guests don't have a
> > visible PCI bus, and the virtual environment doesn't pretend to emulate
> > a PCI bus?
> 
> If they emulated one with the appropiate device 
> then distribution driver auto probing would just work transparently for
> them. 

Still, that would only make sense for virtualized platforms that usually have 
a PCI bus. Thinking about seeing a PCI device on ,lets say, s390 is strange.

Christian
