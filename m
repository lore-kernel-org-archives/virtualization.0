From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 8/9] Guest page hinting: discarded page list.
Date: Fri, 01 Sep 2006 08:56:43 -0700
Message-ID: <1157126203.28577.106.camel@localhost.localdomain>
References: <20060901111117.GI15684@skybase>
	 <1157123836.28577.77.camel@localhost.localdomain>
	 <1157125219.21733.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932125AbWIAP5A@vger.kernel.org>
In-Reply-To: <1157125219.21733.24.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gatech.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 17:40 +0200, Martin Schwidefsky wrote:
> No, unfortunately not. There is a new variable page_discard_list that is
> only defined if CONFG_PAGE_DISCARD_LIST is set. The compiler will
> complain about the absence of the variable, even if the code is never
> reached because PageDiscarded always returns 0.

Ahh.  I see that now.  How about a nice inlined helper function
instead? ;)

-- Dave
