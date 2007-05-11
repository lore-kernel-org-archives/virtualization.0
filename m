From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch 02/28]xen: Add nosegneg capability to the vsyscall page notes
Date: Fri, 11 May 2007 13:07:44 -0700 (PDT)
Message-ID: <20070511200744.4BC1A1F8512@magilla.localdomain>
References: <20070511001156.003375000@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763302AbXEKUIf@vger.kernel.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Thursday, 10 May 2007 17:06:45 -0700 <20070511001156.003375000@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Xen-devel <xen-devel@lists.xensource.com>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Zachary Amsden <zach@vmware.com>, Ulrich Drepper <drepper@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> + * It should contain:
> + *	hwcap 0 nosegneg
> + * to match the mapping of bit to name that we give here.

This comment still needs s/0/1/ to match the code.  Given that the actual
bit is now defined in the macro in another file, perhaps the comment should
say more about it than just a magic 1.


Thanks,
Roland
