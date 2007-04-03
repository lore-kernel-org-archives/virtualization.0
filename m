From: Andi Kleen <ak@suse.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 10:30:36 +0200
Message-ID: <200704031030.36473.ak@suse.de>
References: <4611652F.700@zytor.com> <200704022312.39195.ak@suse.de> <200704031029.06819.borntrae@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933115AbXDCIaw@vger.kernel.org>
In-Reply-To: <200704031029.06819.borntrae@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntrae@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007 10:29:06 Christian Borntraeger wrote:
> On Monday 02 April 2007 23:12, Andi Kleen wrote:
> > 
> > > How would that work in the case where virtualized guests don't have a
> > > visible PCI bus, and the virtual environment doesn't pretend to emulate
> > > a PCI bus?
> > 
> > If they emulated one with the appropiate device 
> > then distribution driver auto probing would just work transparently for
> > them. 
> 
> Still, that would only make sense for virtualized platforms that usually have 
> a PCI bus. Thinking about seeing a PCI device on ,lets say, s390 is strange.

If it gets the job done surely you can tolerate a little strangeness?

-Andi
