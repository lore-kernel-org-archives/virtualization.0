From: Andi Kleen <ak@suse.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 11:26:52 +0200
Message-ID: <200704031126.52750.ak@suse.de>
References: <4611652F.700@zytor.com> <200704031030.36473.ak@suse.de> <20070403111731.52f2102a@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964813AbXDCJ07@vger.kernel.org>
In-Reply-To: <20070403111731.52f2102a@gondolin.boeblingen.de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntrae@de.ibm.com>, virtualization@lists.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

> 
> On s390, it would be more than strangeness. There's no implementation
> of PCI at all, someone would have to cook it up - and it wouldn't have
> any use beyond those special devices. Since there isn't any bus type
> that is available on *all* architectures, a generic "virtual" bus with
> very simple probing seems much saner...

You just have to change all the distribution installers then. 
Ok I suppose on s390 that's not that big issue because there are not
that many for s390. But for x86 there exist quite a lot. I suppose
it's easier to change it in the kernel.

-Andi
