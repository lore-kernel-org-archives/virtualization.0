From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 0/3] VMI hotfixes
Date: Thu, 4 Jan 2007 20:35:07 -0800
Message-ID: <200701050435.l054Z7Zv005529@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030316AbXAEEfe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Hotfixes for VMI code from -rc2-mm1.  This fixes several critical
problems, a compile fix for +PARAVIRT+VMI-SMP, a bogus indirect
call to a VMI function on native, and corrects the FS/GS startup
state for SMP to match the new FS/GS PDA changes.
