From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: system call time increase when turning on CONFIG_PARAVIRT
Date: Fri, 02 Mar 2007 13:54:03 -0800
Message-ID: <45E89CFB.4090905@goop.org>
References: <1172866274.4898.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1172866274.4898.14.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: tim.c.chen@linux.intel.com
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Tim Chen wrote:
> With CONFIG_PARAVIRT turned on, I've found that time invoking
> system_call jumped up quite a lot.  Using TCP streaming test as a
> workload and running on 32-bit 2.6.20 kernel, system_call goes up from
> 0.00025% all the way to 1.6% in the oprofile data.  There is a drop of
> about 4% in overall throughput for this particular workload. =

>
> With lmbench's null system call test, the call time goes up from 0.10
> usec to 0.225 usec.
>
> I'm testing on dual socket Intel core 2 processor running at 2.67 GHz
> with 4 GB RAM.
[ I assume you're talking about running on native hardware. ]

In the current paravirt changes in the kernel, many of the
paravirtualized operations are implemented as (expensive) indirect calls
via paravirt_ops.  Among the changes in the paravirt patches I posted
yesterday is an enhanced patching mechanism which inlines a lot of the
common operations, and converts the rest into direct calls.

I haven't done any detailed measurements on what effect this will have,
but it does bring the actual executed instruction stream much closer to
the !CONFIG_PARAVIRT case, and so I would hope it would recover most or
all of the performance loss you've noticed.

    J
