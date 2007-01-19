From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 16/20] XEN-paravirt: Add the Xen virtual console driver.
Date: Fri, 19 Jan 2007 15:11:36 +1100
Message-ID: <45B044F8.1080904@goop.org>
References: <20070113014539.408244126@goop.org> <20070113014648.767777869@goop.org> <20070115130314.GA4272@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964819AbXASELp@vger.kernel.org>
In-Reply-To: <20070115130314.GA4272@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Pavel Machek wrote:
> You have drivers/xen... so maybe arch/i386/xen is easier to type?
> arch/i386/paravirt/xen would make some sense, too, but it looks too
> deep to me.

I think the exact placement of these files needs a bit of work.  I don't
much care about xen/ vs paravirt/xen vs paravirt-xen/, but placement of
headers needs a bit more thought.  lhype, er, lguest and vmi are in
kernel/, but I think it would be nice to put them near Xen.

    J
