From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
Date: Sun, 14 Jan 2007 12:35:19 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0701141230580.26276@yvahk01.tjqt.qr>
References: <20070113014539.408244126@goop.org> <20070113014649.256179743@goop.org>
 <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr> <20070114112412.GA32719@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751247AbXANLoe@vger.kernel.org>
In-Reply-To: <20070114112412.GA32719@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org


On Jan 14 2007 13:24, Muli Ben-Yehuda wrote:
>On Sun, Jan 14, 2007 at 12:05:13PM +0100, Jan Engelhardt wrote:
>
>> >+	(void)xenbus_switch_state(info->xbdev, XenbusStateConnected);
>> 
>> Cast remove, if xenbus_switch_state does not have __must_check.
>> Also elsewhere.
>
>Hmm, why? this way you know that the programmer isn't checking the
>return value *on purpose*. More information is good.

Then I'd prefer a comment. Plus, you don't do (void) on every
xenbus_switch_state, so I have to assume (1) you either forgot to check the
return value or (2) you don't follow your own "on purpose" policy. If you
really want to enforce to use the return value and explicitly not in some
places, then please tag it __must_check. http://lkml.org/lkml/2006/12/21/282
might be something to read.


	-`J'
-- 
