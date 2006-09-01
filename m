From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
Date: Fri, 01 Sep 2006 20:04:01 +0200
Message-ID: <1157133841.21733.79.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157127483.28577.117.camel@localhost.localdomain>
	 <1157127943.21733.52.camel@localhost>
	 <1157128634.28577.139.camel@localhost.localdomain>
	 <1157129762.21733.63.camel@localhost>
	 <1157130970.28577.150.camel@localhost.localdomain>
	 <1157132520.21733.78.camel@localhost>
	 <1157133780.18728.6.camel@localhost.localdomain>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750702AbWIASEF@vger.kernel.org>
In-Reply-To: <1157133780.18728.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 11:03 -0700, Dave Hansen wrote:
> OK.  It comes down to a race between 
> 
>         __remove_from_page_cache()/__delete_from_swap_cache()
> 
> and
> 
>         __page_discard()
> 
> running on the same page at the same time.  Right?

Yes.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.
