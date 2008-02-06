From: xming <xmingske@gmail.com>
Subject: Re: Xen paravirt frontend block hang
Date: Wed, 6 Feb 2008 13:37:53 +0100
Message-ID: <519a8b110802060437k70c099b7y7faefe63dd82039@mail.gmail.com>
References: <4772AC8E.7010007@theshore.net> <47758352.5040504@goop.org>
	<479E71B7.7060207@theshore.net> <479E75E3.6030601@goop.org>
	<479E7BA4.5050306@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <479E7BA4.5050306@theshore.net>
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
To: "Christopher S. Aker" <caker@theshore.net>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Jan 29, 2008 2:04 AM, Christopher S. Aker <caker@theshore.net> wrote:
> Jeremy Fitzhardinge wrote:
> > Hm.  xming reported similar symtoms to your report, which turned out to
> > be a result of problems with events getting lost.  This patch - which is
> > in 2.6.24 - resolved the issue.  Stock 2.6.24 still has this problem for
> > you?  Can you also reproduce it with lots of console output?
>
> Looks like my tree has this changeset already (stock 2.6.24), so that's
> not it :/ ... I'll try flooding the console with output.
>
> For what it's worth, it does it on both non-smp and smp compiled domU
> kernels.  smp kernels continue to function after triggering the hang,
> however one CPU gets stuck in iowait -- but I am able to continue to
> read from the xvd device.
>
> Are you able to reproduce it with the shell script I provided?  It takes
> maybe 3 or 4 times through the loop to trigger.
>
> -Chris

I cannot trigger this neither with my tests
(http://marc.info/?l=linux-kernel&m=120066005505315&w=2)
nor with your test after 12 loops:

Wed Feb  6 13:20:41 CET 2008
Wed Feb  6 13:21:31 CET 2008
Wed Feb  6 13:22:39 CET 2008
Wed Feb  6 13:23:46 CET 2008
Wed Feb  6 13:24:53 CET 2008
Wed Feb  6 13:26:04 CET 2008
Wed Feb  6 13:27:13 CET 2008
Wed Feb  6 13:28:19 CET 2008
Wed Feb  6 13:29:31 CET 2008
Wed Feb  6 13:30:40 CET 2008
Wed Feb  6 13:31:52 CET 2008
Wed Feb  6 13:33:02 CET 2008

But I do have one problem after I upgraded to xen 3.2, the 2.6.23.x domU do
not boot any more and 2.6.24 does boot but will hang after cpufreq changes
the frequency.

x.
