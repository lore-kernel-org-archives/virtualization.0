From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: Xen paravirt frontend block hang
Date: Mon, 28 Jan 2008 20:04:36 -0500
Message-ID: <479E7BA4.5050306@theshore.net>
References: <4772AC8E.7010007@theshore.net> <47758352.5040504@goop.org>
	<479E71B7.7060207@theshore.net> <479E75E3.6030601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479E75E3.6030601@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xming <xmingske@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Hm.  xming reported similar symtoms to your report, which turned out to 
> be a result of problems with events getting lost.  This patch - which is 
> in 2.6.24 - resolved the issue.  Stock 2.6.24 still has this problem for 
> you?  Can you also reproduce it with lots of console output?

Looks like my tree has this changeset already (stock 2.6.24), so that's 
not it :/ ... I'll try flooding the console with output.

For what it's worth, it does it on both non-smp and smp compiled domU 
kernels.  smp kernels continue to function after triggering the hang, 
however one CPU gets stuck in iowait -- but I am able to continue to 
read from the xvd device.

Are you able to reproduce it with the shell script I provided?  It takes 
maybe 3 or 4 times through the loop to trigger.

-Chris
