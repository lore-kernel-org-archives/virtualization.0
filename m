From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 17:29:40 +0200
Message-ID: <1157124580.21733.10.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122479.28577.64.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751565AbWIAP3z@vger.kernel.org>
In-Reply-To: <1157122479.28577.64.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 07:54 -0700, Dave Hansen wrote:
> Are all of the un/likely()s in here really needed?

Well, no un/likely is really needed. But they do help the compiler to
generate better code. It IS unlikely that a page is discarded.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
