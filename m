From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Tue, 18 Sep 2007 22:20:26 +0200
Message-ID: <200709182220.27311.ak__19518.8255784617$1190146943$gmane$org@suse.de>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<200709181257.41530.ak@suse.de> <46F02F50.5000001@thewybles.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F02F50.5000001@thewybles.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Charles N Wyble <charles@thewybles.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



> 	Why is making something default y a bad idea? 
> Those most likely to care can turn it off. Is there a harmful effect
> from leaving it on if its not being used?

Running yes "" | make oldconfig to upgrade kernel configs is standard practice
and you definitely don't want to have all kinds of random new unnecessary features
be turned on then.

Besides paravirt by itself is pretty useless; you need typically quite
complex other options set to do any meaningfull virtualization.

The only reason to use default y is in options that are not user visible
and have a reasonable default or things that cause direct boot failures
when upgrading old configurations. That all doesn't apply here.

Besides it's bad taste and taste is very important.

-Andi
