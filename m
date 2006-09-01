From: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [patch 4/9] Guest page hinting: volatile swap cache.
Date: Fri, 01 Sep 2006 07:58:33 -0700
Message-ID: <1157122713.28577.71.camel@localhost.localdomain>
References: <20060901111006.GE15684@skybase>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750881AbWIAO6t@vger.kernel.org>
In-Reply-To: <20060901111006.GE15684@skybase>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2006-09-01 at 13:10 +0200, Martin Schwidefsky wrote:
> +#if defined(CONFIG_PAGE_STATES)

This is a bit odd.  Why not use an #ifdef like the rest of the kernel?
 
-- Dave
