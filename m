From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC/PATCH LGUEST X86_64 06/13] lguest64 Kconfig
Date: Fri, 09 Mar 2007 14:55:53 +1100
Message-ID: <1173412553.32234.110.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
	<1173375536.32170.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173375536.32170.8.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 12:38 -0500, Steven Rostedt wrote:
> +config LGUEST
> +	tristate "Lguest support"
> +	depends on PARAVIRT
> +	help
> +	  Enable this is you think 32 bits are not enough fur a puppie.

8)

I think this deserves "&& EXPERIMENTAL" here 8)

Rusty.
