From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: system call time increase when turning on CONFIG_PARAVIRT
Date: Fri, 02 Mar 2007 15:11:51 -0800
Message-ID: <1172877111.8383.4.camel@localhost.localdomain>
References: <1172866274.4898.14.camel@localhost.localdomain>
	 <45E89CFB.4090905@goop.org>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992780AbXCCADN@vger.kernel.org>
In-Reply-To: <45E89CFB.4090905@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-03-02 at 13:54 -0800, Jeremy Fitzhardinge wrote:

> [ I assume you're talking about running on native hardware. ]
> 
That's correct.

> I haven't done any detailed measurements on what effect this will have,
> but it does bring the actual executed instruction stream much closer to
> the !CONFIG_PARAVIRT case, and so I would hope it would recover most or
> all of the performance loss you've noticed.
> 
I also hope that the performance can be recovered as this option could
enabled in distributions' kernels in future.

Tim
