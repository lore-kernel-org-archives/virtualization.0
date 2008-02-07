From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: XenLinux/IA64 domU forward port
Date: Thu, 7 Feb 2008 17:50:42 +0900
Message-ID: <20080207085042.GB4842%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-ia64-owner@vger.kernel.org
To: xen-ia64-devel@lists.xensource.com
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, linux-ia64@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi.
I forward ported XenLinux/IA64 domU portion and put it at
http://people.valinux.co.jp/~yamahata/xen-ia64/20080207/xen_ia64-20080207.patch
This patch is for 551e4fb2465b87de9d4aa1669b27d624435443bb of
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git
It boots as domU and disk/network work.

This patch is for those who are interested in XenLinux/IA64 upstream
merge activity. Many people asked me to publish it as soon as possible
(Thank you very much for your patience) so that I decided to publish it.
Sorry it is single jumbo patch yet, and not very clean.
My next step is to split this patch down into many smaller
patches (Especially portability part and dom0 part) and clean them up,
then repost.

Some cautions for those who will give it a try:
- Console is hvc. (not xvc, tty, ttyS)
- Disk is xvd. (not hd, sd)
- One bug fix patch to xen is necessary.
  I will sent it to xen-ia64-devel soon.

-- 
yamahata
