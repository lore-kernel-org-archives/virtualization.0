From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
Date: Sun, 14 Jan 2007 12:05:13 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
References: <20070113014539.408244126@goop.org> <20070113014649.256179743@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751235AbXANLNH@vger.kernel.org>
In-Reply-To: <20070113014649.256179743@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org


On Jan 12 2007 17:45, Jeremy Fitzhardinge wrote:
>
>The block device frontend driver allows the kernel to access block
>devices exported exported by a virtual machine containing a physical
>block device driver.

Is this significantly different from ubd/hostfs that it actually warrants a
reinvention?

>+	(void)xenbus_switch_state(info->xbdev, XenbusStateConnected);

Cast remove, if xenbus_switch_state does not have __must_check.
Also elsewhere.


	-`J'
-- 
